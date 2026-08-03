console.log("Service Worker Loaded");

// Receive Push Notification
self.addEventListener("push", (event) => {
  console.log("Push Received");

  let data = {};

  if (event.data) {
    try {
      data = event.data.json();
    } catch (err) {
      console.error("Unable to parse push payload:", err);

      data = {
        title: "Notification",
        body: event.data.text(),
      };
    }
  }

  console.log("Payload:", data);

  const options = {
    body: data.body || "",
    icon: data.icon || "/icon-192.png",
    badge: data.badge || "/badge.png",
    image: data.image || undefined,
    tag: data.tag || undefined,
    requireInteraction: data.requireInteraction || false,
    renotify: data.renotify || false,
    silent: data.silent || false,

    actions: data.actions || [],

    data: {
      url: data.url || "/",
      status_id: data.status_id || null,
    },
  };

  event.waitUntil(
  (async () => {
    await self.registration.showNotification(
      data.title || "Notification",
      options
    );

    if (data.status_id) {
      try {
        await fetch("/notification_delivered", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            status_id: data.status_id,
          }),
        });
      } catch (err) {
        console.error("Delivery callback failed", err);
      }
    }
  })()
);
});

// Notification Click
self.addEventListener("notificationclick", (event) => {
  console.log("Notification Clicked");

  event.notification.close();

  const notificationData = event.notification.data || {};

  // Optional: notify backend
  if (notificationData.status_id) {
    fetch("/notification_clicked", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        status_id: notificationData.status_id,
      }),
    }).catch((err) => console.error(err));
  }

  const targetUrl = notificationData.url || "/";

  event.waitUntil(
    clients.matchAll({
      type: "window",
      includeUncontrolled: true,
    }).then((clientList) => {
      for (const client of clientList) {
        if (client.url === targetUrl && "focus" in client) {
          return client.focus();
        }
      }

      if (clients.openWindow) {
        return clients.openWindow(targetUrl);
      }
    })
  );
});

// Optional: Notification Closed
self.addEventListener("notificationclose", () => {
  console.log("Notification Closed");
});