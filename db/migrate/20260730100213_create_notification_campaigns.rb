class CreateNotificationCampaigns < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_campaigns do |t|
      t.string :title
      t.text :body
      t.text :icon
      t.text :image
      t.string :action_title
      t.text :action_url
      t.integer :total_sent
      t.integer :success_count
      t.integer :failed_count
      t.integer :in_flight_count
      t.integer :clicked_count

      t.timestamps
    end
  end
end
