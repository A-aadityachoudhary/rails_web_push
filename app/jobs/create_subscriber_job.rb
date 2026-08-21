class CreateSubscriberJob < ApplicationJob
  queue_as :default

  def perform(subscription_data)
    subscriber = Subscriber.find_or_initialize_by(
      endpoint: subscription_data["endpoint"]
    )

    subscriber.p256dh = subscription_data["p256dh"]
    subscriber.auth = subscription_data["auth"]
    subscriber.browser = subscription_data["browser"]

    subscriber.ip = subscription_data["ip"]
    subscriber.country = subscription_data["country"]
    subscriber.country_code = subscription_data["country_code"]
    subscriber.continent = subscription_data["continent"]
    subscriber.continent_code = subscription_data["continent_code"]
    subscriber.asn = subscription_data["asn"]
    subscriber.as_name = subscription_data["as_name"]
    subscriber.as_domain = subscription_data["as_domain"]

    subscriber.save!
  end
end