ActiveAdmin.register PushSubscription do
  permit_params :endpoint, :p256dh, :auth

  index do
    selectable_column
    id_column
    column :endpoint
    column :p256dh
    column :auth
    column :created_at
    actions
  end

  filter :endpoint
  filter :created_at

  show do
    attributes_table do
      row :id
      row :endpoint
      row :p256dh
      row :auth
      row :created_at
      row :updated_at
    end
  end
end