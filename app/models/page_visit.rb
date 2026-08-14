class PageVisit < ApplicationRecord
  belongs_to :push_subscription, optional: true

  def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "page",
      "started_at",
      "left_at",
      "duration_seconds",
      "push_subscription_id",
      "created_at",
      "updated_at"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    [
      "push_subscription"
    ]
  end
end