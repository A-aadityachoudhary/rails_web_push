class CreateNotificationStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_statuses do |t|
      t.references :push_subscription, null: false, foreign_key: true
      t.string :title
      t.text :body
      t.integer :status
      t.text :failure_reason
      t.datetime :clicked_at
      t.datetime :sent_at

      t.timestamps
    end
  end
end
