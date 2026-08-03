class UpdateNotificationCampaignCounters < ActiveRecord::Migration[7.0]
  def change

    remove_column :notification_campaigns,
                  :success_count,
                  :integer

    remove_column :notification_campaigns,
                  :in_flight_count,
                  :integer

    add_column :notification_campaigns,
              :delivered_count,
              :integer,
              default: 0,
              null: false

  end
end
