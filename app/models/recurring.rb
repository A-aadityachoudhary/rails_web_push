class Recurring < ApplicationRecord
  scope :active, -> { where(active: true) }

  
  def self.ransackable_attributes(auth_object = nil)
    ["action_title", "action_url", "active", "body", "created_at", "icon", "id", "id_value", "image", "last_sent_at", "title", "updated_at"]
  end
end