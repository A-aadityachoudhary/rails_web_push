class NotificationStatus < ApplicationRecord
  belongs_to :subscriber
  belongs_to :notification_campaign
  enum status: {
    in_flight: 0,
    delivered: 1,
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
      subscriber_id
      notification_campaign_id
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[
      subscriber
      notification_campaign
    ]
  end
end