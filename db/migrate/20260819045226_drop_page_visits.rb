class DropPageVisits < ActiveRecord::Migration[7.1]
  def change
    drop_table :page_visits, if_exists: true
  end
end