class NotificationStatus < ApplicationRecord
  belongs_to :push_subscription
  belongs_to :notification_campaign
  enum status: {
    in_flight: 0,
    success: 1,
    failed: 2
  }

  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      title
      body
      status
      failure_reason
      clicked_at
      sent_at
      created_at
      updated_at
      push_subscription_id
      notification_campaign_id
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[
      push_subscription
      notification_campaign
    ]
  end
end