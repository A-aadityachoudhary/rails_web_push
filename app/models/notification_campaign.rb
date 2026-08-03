

class NotificationCampaign < ApplicationRecord

  has_many :notification_statuses, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      title
      body
      icon
      image
      action_title
      action_url
      total_sent
      delivered_count
      failed_count
      clicked_count
      created_at
      updated_at
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[
      notification_statuses
    ]
  end
  def in_flight_count
    total_sent - delivered_count - failed_count
  end
end