ActiveAdmin.register PageVisit do
  permit_params :page,
                :started_at,
                :left_at,
                :duration_seconds,
                :push_subscription_id

  index do
    selectable_column

    id_column

    column :page

    column :push_subscription do |page_visit|
      if page_visit.push_subscription
        "Subscription ##{page_visit.push_subscription.id}"
      else
        "Unknown"
      end
    end

    column :browser do |page_visit|
      page_visit.push_subscription&.browser
    end

    column :ip do |page_visit|
      page_visit.push_subscription&.ip
    end

    column :started_at
    column :left_at
    column :duration_seconds

    actions
  end

  filter :page
  filter :push_subscription_id
  filter :started_at
  filter :left_at
  filter :duration_seconds

  show do
    attributes_table do
      row :id
      row :page

      row :push_subscription do |page_visit|
        if page_visit.push_subscription
          link_to(
            "Subscription ##{page_visit.push_subscription.id}",
            admin_push_subscription_path(page_visit.push_subscription)
          )
        else
          "Unknown / deleted subscription"
        end
      end

      row :browser do |page_visit|
        page_visit.push_subscription&.browser
      end

      row :country do |page_visit|
        page_visit.push_subscription&.country
      end

      row :country_code do |page_visit|
        page_visit.push_subscription&.country_code
      end

      row :ip do |page_visit|
        page_visit.push_subscription&.ip
      end

      row :started_at
      row :left_at
      row :duration_seconds
      row :created_at
      row :updated_at
    end
  end
end