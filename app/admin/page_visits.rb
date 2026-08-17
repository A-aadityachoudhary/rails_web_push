ActiveAdmin.register PageVisit do
  permit_params :page,
                :started_at,
                :left_at,
                :duration_seconds,
                :push_subscription_id,
                :subscriber_uuid

  index do
    selectable_column
    id_column
    column :page

    column "Subscriber UUID" do |page_visit|
      page_visit.subscriber_uuid.presence || page_visit.push_subscription&.subscriber_uuid || "Unknown"
    end

    column "Pushsubscription ID" do |page_visit|
      page_visit.push_subscription ? link_to(page_visit.push_subscription.id, admin_push_subscription_path(page_visit.push_subscription)) : "Unknown"
    end

    column :started_at
    column :left_at
    column :duration_seconds

    actions
  end

  filter :page
  filter :subscriber_uuid
  filter :push_subscription
  filter :started_at
  filter :left_at
  filter :duration_seconds

  show do
    attributes_table do
      row :id
      row :page

      row "Subscriber UUID" do |page_visit|
        
        page_visit.subscriber_uuid.presence || page_visit.push_subscription&.subscriber_uuid || "Unknown"
      end

      row "Pushsubscription ID" do |page_visit|
        if page_visit.push_subscription
          link_to(
            "Subscription ##{page_visit.push_subscription.id}",
            admin_push_subscription_path(page_visit.push_subscription)
          )
        else
          "1"
        end
      end

      row :started_at
      row :left_at
      row :duration_seconds
      row :created_at
      row :updated_at
    end
  end
end