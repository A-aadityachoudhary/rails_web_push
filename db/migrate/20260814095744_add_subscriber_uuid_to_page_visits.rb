class AddSubscriberUuidToPageVisits < ActiveRecord::Migration[7.1]
  def change
    add_column :page_visits, :subscriber_uuid, :string
    add_index :page_visits, :subscriber_uuid
  end
end