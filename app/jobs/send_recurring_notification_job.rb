class SendRecurringNotificationJob < ApplicationJob
  queue_as :default

  def perform(recurring_id)
    recurring = Recurring.find(recurring_id)

    subscribers = PushSubscription.all
    total = subscribers.count

    campaign = NotificationCampaign.create!(
      title: recurring.title,
      body: recurring.body,
      icon: recurring.icon,
      image: recurring.image,
      action_title: recurring.action_title,
      action_url: recurring.action_url,
      total_sent: total,
      delivered_count: 0,
      failed_count: 0,
      clicked_count: 0
    )

    subscribers.find_each do |subscription|

      notification_status = NotificationStatus.create!(
        notification_campaign: campaign,
        push_subscription: subscription,
        title: recurring.title,
        body: recurring.body,
        status: :in_flight
      )

      begin
        PushNotificationService.send_notification(
          subscription: subscription,
          notification_status: notification_status,
          title: recurring.title,
          body: recurring.body,
          icon: recurring.icon,
          image: recurring.image,
          action_title: recurring.action_title,
          action_url: recurring.action_url
        )

      rescue => e
        notification_status.update!(
          status: :failed,
          failure_reason: e.message
        )

        campaign.increment!(:failed_count)

        Rails.logger.error(
          "Recurring notification failed for subscription #{subscription.id}: #{e.message}"
        )
      end
    end

    recurring.update!(
      last_sent_at: Time.current
    )
  end
end