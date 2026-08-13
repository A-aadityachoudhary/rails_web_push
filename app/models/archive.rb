class Archive < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "browser",
      "country",
      "country_code",
      "continent",
      "asn",
      "ip",
      "endpoint",
      "p256dh",
      "auth",
      "created_at",
      "updated_at"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

end