ActiveAdmin.register Recurring do

  permit_params :title,
                :body,
                :icon,
                :image,
                :action_title,
                :action_url,
                :active

  form do |f|
    f.inputs "Recurring Notification" do
      f.input :title
      f.input :body
      f.input :icon
      f.input :image
      f.input :action_title
      f.input :action_url
      f.input :active
    end

    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :body
    column :active
    column :last_sent_at
    column :created_at

    actions
  end

end