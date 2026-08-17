class CreateArchives < ActiveRecord::Migration[7.1]
  def change
    create_table :archives do |t|
      t.string :browser
      t.string :country
      t.string :country_code
      t.string :continent
      t.string :asn
      t.string :ip
      t.text :endpoint
      t.text :p256dh
      t.text :auth

      t.timestamps
    end
  end
end
