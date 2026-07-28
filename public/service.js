console.log("Service Worker Loaded");

// Push Event
self.addEventListener("push", (event) => {
  console.log("Push Received");

  if (!event.data) {
    return;
  }

  let data = {};

  try {
    data = event.data.json();
    console.log("Payload:", data);
console.log("Icon:", data.icon);
console.log("Image:", data.image);
  } catch (e) {
    data = {
      title: "Notification",
      body: event.data.text(),
    };
  }

  const options = {
    body: data.body,
    icon: data.icon,
    image: data.image,
    badge: "/badge.png",
    data: {
      url: data.url || "/",
    },
    actions: data.actions,

      data: {
        url: data.url
      }
  };

  event.waitUntil(
    self.registration.showNotification(data.title, options)
  );
});

// Notification Click
self.addEventListener("notificationclick", (event) => {
  event.notification.close();

  event.waitUntil(
    clients.openWindow(event.notification.data.url)
  );
});