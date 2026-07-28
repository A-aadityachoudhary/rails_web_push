ActiveAdmin.register PushSubscription do
  permit_params :endpoint, :p256dh, :auth

  action_item :send_notification_to_all, only: :index do
  link_to "Send Notification To All",
          send_notification_all_admin_push_subscriptions_path
  end

  index do
    selectable_column
    id_column
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

  filter :endpoint
  filter :created_at

  show do
    attributes_table do
      row :id
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
      body  = params[:notification][:body]
      icon = params[:notification][:icon]
      image = params[:notification][:image]
      action_title = params[:notification][:action_title]
      action_url   = params[:notification][:action_url]

      PushNotificationService.send_notification(
        resource,
        title,
        body,
        icon,
        image,
        action_title,
        action_url
      )

      redirect_to admin_push_subscriptions_path,
                  notice: "Notification sent successfully."
  end
# for all subscribers
  collection_action :send_notification_all, method: :get do
  end


  collection_action :send_notification_all_submit, method: :post do
    title = params[:notification][:title]
    body  = params[:notification][:body]
    icon = params[:notification][:icon]
    image = params[:notification][:image]
    action_title = params[:notification][:action_title]
    action_url   = params[:notification][:action_url]

    success = 0
    failed = 0

    PushSubscription.find_each do |subscription|
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
        success += 1
      rescue => e
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