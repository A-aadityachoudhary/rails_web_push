class AddNotificationCampaignToNotificationStatuses < ActiveRecord::Migration[7.0]
  def change
    add_reference :notification_statuses, :notification_campaign, foreign_key: true
  end
end
