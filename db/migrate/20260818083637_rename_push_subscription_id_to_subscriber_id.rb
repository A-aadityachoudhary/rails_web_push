class RenamePushSubscriptionIdToSubscriberId < ActiveRecord::Migration[7.1]
  def change
    rename_column :notification_statuses,
                  :push_subscription_id,
                  :subscriber_id
  end
end