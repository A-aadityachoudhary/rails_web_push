class SendPushNotificationJob < ApplicationJob
  queue_as :default

  def perform(notification_status_id)
    Rails.logger.info "========================================"
    Rails.logger.info "SendPushNotificationJob STARTED"
    Rails.logger.info "NotificationStatus ID: #{notification_status_id}"

    notification_status = NotificationStatus.find_by(id: notification_status_id)

    unless notification_status
      Rails.logger.error "NotificationStatus #{notification_status_id} NOT FOUND"
      return
    end

    campaign = notification_status.notification_campaign
    subscriber = notification_status.subscriber

    Rails.logger.info "Subscriber ID: #{subscriber&.id}"
    Rails.logger.info "Campaign ID: #{campaign&.id}"
    Rails.logger.info "Subscriber endpoint: #{subscriber&.endpoint}"

    unless campaign
      Rails.logger.error "Campaign NOT FOUND"
      return
    end

    unless subscriber
      Rails.logger.error "Subscriber NOT FOUND"
      return
    end

    Rails.logger.info "Calling PushNotificationService..."

    PushNotificationService.send_notification(
      subscriber: subscriber,
      notification_status: notification_status,
      title: campaign.title,
      body: campaign.body,
      icon: campaign.icon,
      image: campaign.image,
      action_title: campaign.action_title,
      action_url: campaign.action_url
    )

    Rails.logger.info "PushNotificationService completed successfully"

    notification_status.update!(
      status: "sent",
      sent_at: Time.current
    )

    Rails.logger.info "NotificationStatus #{notification_status.id} marked as SENT"
    Rails.logger.info "SendPushNotificationJob FINISHED"
    Rails.logger.info "========================================"

  rescue WebPush::ExpiredSubscription => e
    Rails.logger.error "EXPIRED SUBSCRIPTION"
    Rails.logger.error e.message

    notification_status&.update!(
      status: "expired",
      failure_reason: e.message
    )

    DeleteSubscriberJob.perform_later(subscriber.id) if subscriber

  rescue StandardError => e
    Rails.logger.error "========================================"
    Rails.logger.error "SendPushNotificationJob FAILED"
    Rails.logger.error "#{e.class}: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    Rails.logger.error "========================================"

    notification_status&.update!(
      status: "failed",
      failure_reason: "#{e.class}: #{e.message}"
    )

    # Temporarily re-raise so Solid Queue also reports the failure
    raise
  end
end