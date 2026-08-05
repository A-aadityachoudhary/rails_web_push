class AddIpinfoFieldsToPushSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :push_subscriptions, :ip, :string
    add_column :push_subscriptions, :country_code, :string
    add_column :push_subscriptions, :continent, :string
    add_column :push_subscriptions, :continent_code, :string
    add_column :push_subscriptions, :asn, :string
    add_column :push_subscriptions, :as_name, :string
    add_column :push_subscriptions, :as_domain, :string
  end
end
