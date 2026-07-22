class PushSubscription < ApplicationRecord
    
    def self.ransackable_attributes(auth_object = nil)
        ["auth", "created_at", "endpoint", "id", "p256dh", "updated_at"]
    end


end
