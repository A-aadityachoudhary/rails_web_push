class ArchivePushSubscriptionService
  def self.call(subscription)
    Archive.create!(
      browser: subscription.browser,
      country: subscription.country,
      country_code: subscription.country_code,
      continent: subscription.continent,
      asn: subscription.asn,
      ip: subscription.ip,
      endpoint: subscription.endpoint,
      p256dh: subscription.p256dh,
      auth: subscription.auth
    )

    subscription.destroy!
  end
end