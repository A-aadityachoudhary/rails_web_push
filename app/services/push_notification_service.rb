class PushNotificationService
  def self.send_notification(subscription, title, body)
    
    WebPush.payload_send(
      message: {
        title: title,
        body: body
      }.to_json,

      endpoint: subscription.endpoint,
      p256dh: subscription.p256dh,
      auth: subscription.auth,

      vapid: {
        subject: "mailto:admin@example.com",
        public_key: Rails.application.credentials.web_push[:publicKey],
        private_key: Rails.application.credentials.web_push[:privateKey]
      }
    )
  rescue WebPush::ExpiredSubscription
    subscription.destroy
  end
end