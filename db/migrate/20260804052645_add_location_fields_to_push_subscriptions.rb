class AddLocationFieldsToPushSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :push_subscriptions, :country, :string
    add_column :push_subscriptions, :state, :string
    add_column :push_subscriptions, :city, :string
    add_column :push_subscriptions, :latitude, :decimal
    add_column :push_subscriptions, :longitude, :decimal
    add_column :push_subscriptions, :timezone, :string
    add_column :push_subscriptions, :platform, :string
    add_column :push_subscriptions, :device_type, :string
  end
end
