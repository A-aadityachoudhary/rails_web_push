ActiveAdmin.register PushSubscription do
  permit_params :endpoint, :p256dh, :auth

  index do
    selectable_column
    id_column
    column :endpoint
    column :p256dh
    column :auth
    column :created_at
    actions defaults: true do |subscription|
    item "Send",
           send_notification_admin_push_subscription_path(subscription),
           method: :post,
           class: "member_link" 
    
    end
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

  member_action :send_notification, method: :post do
    PushNotificationService.send_notification(resource, "hello", "message from active admin")
    redirect_to admin_push_subscriptions_path, notice: "notification sent"
  end
end