class CreateRecurrings < ActiveRecord::Migration[7.1]
  def change
    create_table :recurrings do |t|

      t.timestamps
    end
  end
end
