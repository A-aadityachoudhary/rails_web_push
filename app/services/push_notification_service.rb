class PushNotificationService
  def self.send_notification(
    subscription:,
    notification_status:,
    title:,
    body:,
    icon: nil,
    image: nil,
    action_title: nil,
    action_url: nil
  )

    WebPush.payload_send(
      message: {
        status_id: notification_status.id,
        title: title,
        body: body,
        icon: icon,
        image: image,
        url: action_url,
        actions: [
          {
            action: "open_url",
            title: action_title
          }
        ]
      }.to_json,

      endpoint: subscription.endpoint,
      p256dh: subscription.p256dh,
      auth: subscription.auth,

      vapid: {
        subject: "mailto:admin@example.com",
        public_key: "BOvHJNqfb9MgmzR96e49QKLP9tzIELYaSQPuj5n9K-kh24byeHYtwrE-7V7wdRN3a2PlxWj6xkV1sAE0jahJDm0=",
        private_key: "8xcrfmRSqTW9kS5GnAOa5LsHl506cwGZ9o5au5guhtk="
      }
    )

  rescue WebPush::ExpiredSubscription
    subscription.destroy
  end
end