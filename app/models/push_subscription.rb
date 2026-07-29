class PushSubscription < ApplicationRecord
    has_many :notification_statuses, dependent: :destroy
    def self.ransackable_attributes(auth_object = nil)
        ["auth", "created_at", "endpoint", "id", "p256dh", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["notification_statuses"]
    end


end
