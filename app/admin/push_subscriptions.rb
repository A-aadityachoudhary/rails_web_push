ActiveAdmin.register PushSubscription do
  permit_params :endpoint, :p256dh, :auth

 action_item :send_browser_notification, only: :index do
  browser = params.dig(:q, :browser_eq)

  if browser.present?
    link_to(
      "Send Notification To All #{browser} Users",
      send_browser_notification_admin_push_subscriptions_path(browser: browser)
    )
  end
end

  action_item :send_notification_to_all, only: :index do
    unless params.dig(:q, :browser_eq).present?
      link_to(
        "Send Notification To All",
        send_notification_all_admin_push_subscriptions_path
      )
    end
  end

  index do
    selectable_column
    id_column
    column :browser
    column :endpoint
    column :p256dh
    column :auth
    column :created_at
    actions defaults: true do |subscription|
    item "Send",
           send_notification_admin_push_subscription_path(subscription),
           class: "member_link" 

    item "Unsubscribe",
         unsubscribe_admin_push_subscription_path(subscription),
         method: :delete,
         data: { confirm: "Remove this subscriber?" },
         class: "member_link"

    
    end
  end
  filter :browser
  filter :endpoint
  filter :created_at

  show do
    attributes_table do
      row :id
      row :browser
      row :endpoint
      row :p256dh
      row :auth
      row :created_at
      row :updated_at
    end
  end

  member_action :send_notification, method: :get do
  end

# for singular subscriber
  member_action :send_notification_submit, method: :post do

  title = params[:notification][:title]
  body = params[:notification][:body]
  icon = params[:notification][:icon]
  image = params[:notification][:image]
  action_title = params[:notification][:action_title]
  action_url = params[:notification][:action_url]

  campaign = NotificationCampaign.create!(
    title: title,
    body: body,
    icon: icon,
    image: image,
    action_title: action_title,
    action_url: action_url,
    total_sent: 1,
    success_count: 0,
    failed_count: 0,
    in_flight_count: 1,
    clicked_count: 0
  )

  status = NotificationStatus.create!(
    notification_campaign: campaign,
    push_subscription: resource,
    title: title,
    body: body,
    status: :in_flight
  )

  begin

    PushNotificationService.send_notification(
      resource,
      title,
      body,
      icon,
      image,
      action_title,
      action_url
    )

    status.update!(
      status: :success,
      sent_at: Time.current
    )

    campaign.increment!(:success_count)
    campaign.decrement!(:in_flight_count)

  rescue => e

    status.update!(
      status: :failed,
      failure_reason: e.message
    )

    campaign.increment!(:failed_count)
    campaign.decrement!(:in_flight_count)

  end

  redirect_to admin_push_subscriptions_path,
                        notice: "notification sent successfully."
end
# for all subscribers
  collection_action :send_notification_all, method: :get do
  end
#for browser one
  collection_action :send_browser_notification, method: :get do
    @browser = params[:browser].presence || params.dig(:q, :browser)
    if @browser.blank?
      redirect_to admin_push_subscriptions_path, alert: "Please select or filter by a browser first."
    end
  end

  collection_action :send_browser_notification_submit, method: :post do

  browser = params.dig(:notification, :browser).presence || params[:browser]
    Rails.logger.info "Sending notifications for Browser = #{browser}"

    if browser.blank?
      redirect_to admin_push_subscriptions_path, alert: "Browser parameter was missing."
      return
    end

  title = params[:notification][:title]
  body  = params[:notification][:body]
  icon  = params[:notification][:icon]
  image = params[:notification][:image]
  action_title = params[:notification][:action_title]
  action_url   = params[:notification][:action_url]

  subscribers = PushSubscription.where(browser: browser)

  total = subscribers.count

  campaign = NotificationCampaign.create!(
    title: title,
    body: body,
    icon: icon,
    image: image,
    action_title: action_title,
    action_url: action_url,
    total_sent: total,
    success_count: 0,
    failed_count: 0,
    in_flight_count: total,
    clicked_count: 0
  )

  success = 0
  failed = 0

  subscribers.find_each do |subscription|

    notification_status = NotificationStatus.create!(
      notification_campaign: campaign,
      push_subscription: subscription,
      title: title,
      body: body,
      status: :in_flight
    )

    begin

      PushNotificationService.send_notification(
        subscription,
        title,
        body,
        icon,
        image,
        action_title,
        action_url
      )

      notification_status.update!(
        status: :success,
        sent_at: Time.current
      )

      campaign.increment!(:success_count)
      campaign.decrement!(:in_flight_count)

      success += 1

    rescue => e

      notification_status.update!(
        status: :failed,
        failure_reason: e.message
      )

      campaign.increment!(:failed_count)
      campaign.decrement!(:in_flight_count)

      failed += 1

      Rails.logger.error "Failed for #{browser} Subscription ##{subscription.id}: #{e.message}"

    end

  end

  redirect_to admin_push_subscriptions_path(
    q: { browser_eq: browser }
  ), notice: "#{success} notification(s) sent successfully to #{browser} users. #{failed} failed."

end


  collection_action :send_notification_all_submit, method: :post do
  title = params[:notification][:title]
  body  = params[:notification][:body]
  icon = params[:notification][:icon]
  image = params[:notification][:image]
  action_title = params[:notification][:action_title]
  action_url   = params[:notification][:action_url]

  total = PushSubscription.count

  campaign = NotificationCampaign.create!(
    title: title,
    body: body,
    icon: icon,
    image: image,
    action_title: action_title,
    action_url: action_url,
    total_sent: total,
    success_count: 0,
    failed_count: 0,
    in_flight_count: total,
    clicked_count: 0
  )

  success = 0
  failed = 0

  PushSubscription.find_each do |subscription|

    # Create a tracking record for this subscriber
    notification_status = NotificationStatus.create!(
      notification_campaign: campaign,
      push_subscription: subscription,
      title: title,
      body: body,
      status: :in_flight
    )

    begin
      PushNotificationService.send_notification(
        subscription,
        title,
        body,
        icon,
        image,
        action_title,
        action_url
      )

      notification_status.update!(
        status: :success,
        sent_at: Time.current
      )

      success += 1
      campaign.increment!(:success_count)
      campaign.decrement!(:in_flight_count)

    rescue => e

      notification_status.update!(
        status: :failed,
        failure_reason: e.message
      )
      campaign.increment!(:failed_count)
      campaign.decrement!(:in_flight_count)

      failed += 1

      Rails.logger.error "Failed for Subscription ##{subscription.id}: #{e.message}"
    end
  end

  redirect_to admin_push_subscriptions_path,
              notice: "#{success} notification(s) sent successfully. #{failed} failed."
end

  # for unsubcribering individuals
  member_action :unsubscribe, method: :delete do
    resource.destroy
    redirect_to admin_push_subscriptions_path, notice: "Subscriber removed successfully."
  end 
end