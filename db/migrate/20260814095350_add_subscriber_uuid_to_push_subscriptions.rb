class AddSubscriberUuidToPushSubscriptions < ActiveRecord::Migration[7.1]
  def change
    add_column :push_subscriptions, :subscriber_uuid, :string
    add_index :push_subscriptions, :subscriber_uuid, unique: true
  end
end