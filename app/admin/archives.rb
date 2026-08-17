ActiveAdmin.register Archive do

  menu label: "Archives"

  filter :browser
  filter :country
  filter :country_code
  filter :continent
  filter :asn
  filter :ip
  filter :created_at

  index do
    selectable_column
    id_column

    column :browser
    column :country
    column :country_code
    column :continent
    column :asn
    column :ip
    column :endpoint
    column :created_at

    actions
  end

  show do
    attributes_table do
      row :id
      row :browser
      row :country
      row :country_code
      row :continent
      row :asn
      row :ip
      row :endpoint
      row :p256dh
      row :auth
      row :created_at
      row :updated_at
    end
  end

end