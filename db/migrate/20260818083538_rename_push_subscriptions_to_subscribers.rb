class RenamePushSubscriptionsToSubscribers < ActiveRecord::Migration[7.1]
  def change
    rename_table :push_subscriptions, :subscribers
  end
end