class CreatePageVisits < ActiveRecord::Migration[7.1]
  def change
    create_table :page_visits do |t|
      t.string :page, null: false
      t.datetime :started_at
      t.datetime :left_at
      t.integer :duration_seconds

      t.timestamps
    end

    add_index :page_visits, :page
    add_index :page_visits, :started_at
    add_index :page_visits, :left_at
  end
end