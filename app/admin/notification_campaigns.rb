
ActiveAdmin.register NotificationCampaign do

  actions :index, :show

  index do
    selectable_column
    id_column

    column :title
    column :body
    column :total_sent
    column :success_count
    column :failed_count
    column :in_flight_count
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
      row :success_count
      row :failed_count
      row :in_flight_countt

      row :created_at
    end
  end

end