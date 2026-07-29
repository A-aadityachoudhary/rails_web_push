ActiveAdmin.register NotificationStatus do

  actions :index, :show

  scope :all
  scope :success
  scope :failed
  scope :in_flight

  index do
    selectable_column
    id_column

    column :push_subscription
    column :title
    column :status
    column :sent_at
    
    column :failure_reason

    actions
  end

end