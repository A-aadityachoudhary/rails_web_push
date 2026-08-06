class CreateDashboardStats < ActiveRecord::Migration[7.0]
  def change
    create_table :dashboard_stats do |t|
      t.integer :subscriber_count
      t.integer :notification_count
      t.integer :campaign_count

      t.timestamps
    end
  end
end
