ActiveAdmin.register NotificationCampaign do
  actions :index, :show

  index do
    selectable_column
    id_column

    column :title
    column :body

    column :total_sent
    column :delivered_count
    column :failed_count

    column "In Flight" do |campaign|
      campaign.total_sent - campaign.delivered_count - campaign.failed_count
    end

    column :clicked_count
    column :created_at

    actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :body
      row :icon
      row :image
      row :action_title
      row :action_url

      row :total_sent
      row :delivered_count
      row :failed_count

      row "In Flight" do |campaign|
        campaign.total_sent - campaign.delivered_count - campaign.failed_count
      end

      row :clicked_count
      row :created_at
      row :updated_at
    end
  end
end