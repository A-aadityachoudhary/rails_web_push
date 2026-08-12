class AddNotificationFieldsToRecurrings < ActiveRecord::Migration[7.1]
  def change
    add_column :recurrings, :title, :string
    add_column :recurrings, :body, :text
    add_column :recurrings, :icon, :string
    add_column :recurrings, :image, :string
    add_column :recurrings, :action_title, :string
    add_column :recurrings, :action_url, :string
    add_column :recurrings, :active, :boolean
    add_column :recurrings, :last_sent_at, :datetime
  end
end
