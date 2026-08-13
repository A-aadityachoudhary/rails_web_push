class AddPushSubscriptionIdToArchives < ActiveRecord::Migration[7.1]
  def change
    add_column :archives, :push_subscription_id, :bigint
  end
end
