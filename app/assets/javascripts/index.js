console.log("JS Loaded");

const PUBLIC_VAPID_KEY =
  "BOvHJNqfb9MgmzR96e49QKLP9tzIELYaSQPuj5n9K-kh24byeHYtwrE-7V7wdRN3a2PlxWj6xkV1sAE0jahJDm0=";
const geo_api = "https://api.ipinfo.io/lite/me?"

const geo_api_key = "69722c98d1cbc2"
const API_URL = "/push_subscriptions";

function checkSupport() {
  if (!("serviceWorker" in navigator)) {
    throw new Error("Service Worker not supported");
  }

  if (!("PushManager" in window)) {
    throw new Error("Push API not supported");
  }

  if (!("Notification" in window)) {
    throw new Error("Notification API not supported");
  }
}

function urlB64ToUint8Array(base64String) {
  const padding = "=".repeat((4 - (base64String.length % 4)) % 4);

  const base64 = (base64String + padding)
    .replace(/-/g, "+")
    .replace(/_/g, "/");

  const rawData = window.atob(base64);

  const outputArray = new Uint8Array(rawData.length);

  for (let i = 0; i < rawData.length; ++i) {
    outputArray[i] = rawData.charCodeAt(i);
  }

  return outputArray;
}

async function registerServiceWorker() {
  const registration = await navigator.serviceWorker.register("/service.js");

  await navigator.serviceWorker.ready;

  console.log("Service Worker Registered");

  return registration;
}

async function requestPermission() {
  const permission = await Notification.requestPermission();

  if (permission !== "granted") {
    throw new Error("Notification permission denied");
  }

  console.log("Permission Granted");
}

async function subscribeUser(registration) {

  let subscription = await registration.pushManager.getSubscription();

  if (subscription) {
    console.log("Already Subscribed");
    return subscription;
  }

  subscription = await registration.pushManager.subscribe({
    userVisibleOnly: true,
    applicationServerKey: urlB64ToUint8Array(PUBLIC_VAPID_KEY),
  });

  console.log("New Subscription Created");

  return subscription;
}


async function saveSubscription(subscription, geo_data) {
   const ua = navigator.userAgent;

  let browser = "Unknown";

  if (ua.includes("Firefox")) {
    browser = "Firefox";
  } else if (ua.includes("Edg")) {
    browser = "Edge";
  } else if (ua.includes("Chrome")) {
    browser = "Chrome";
  } else if (ua.includes("Safari")) {
    browser = "Safari";
  }
  const geo_data = await geo_location()
  const response = await fetch(API_URL, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      endpoint: subscription.endpoint,
      keys: subscription.toJSON().keys,
      browser: browser,
      location: geo_data
    }),
  });

  if (!response.ok) {
    throw new Error("Failed to save subscription");
  }

  return response.json();
}

async function geo_location(){
  try{
    const response = await fetch(`https://api.ipinfo.io/lite/me?token=${geo_api_key}`)
    const data = await response.json();
    console.log("data : ", data);
  return data;
}
  catch(err){
  console.log("error occuring in geo_location",err)
}}
async function main() {
  try {

    checkSupport();

    const registration = await registerServiceWorker();

    window.onload = () => {
        requestPermission();
      }
    const subscription = await subscribeUser(registration);

    console.log(subscription);
    
        console.log("gio data");


    const result = await saveSubscription(subscription);

    console.log("Saved Successfully");

    console.log(result);

    registration.showNotification("Welcome", {
      body: "Notifications are enabled successfully.",
    });

  } catch (error) {
    console.error(error);
  }
}

main();