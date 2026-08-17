class AddPushSubscriptionToPageVisits < ActiveRecord::Migration[7.1]
  def change
    add_reference :page_visits, :push_subscription, null: true, foreign_key: true
  end
end
