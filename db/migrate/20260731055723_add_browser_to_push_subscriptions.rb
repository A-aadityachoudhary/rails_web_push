class AddBrowserToPushSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :push_subscriptions, :browser, :string
  end
end
