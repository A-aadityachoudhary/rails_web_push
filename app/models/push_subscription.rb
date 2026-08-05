class PushSubscription < ApplicationRecord
    has_many :notification_statuses, dependent: :destroy
    def self.ransackable_attributes(auth_object = nil)
        ["auth", "country", "country_code", "continent", "created_at", "continent_code", "asn", "as_name", "ip", "endpoint", "id", "p256dh", "browser", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["notification_statuses"]
    end


end
