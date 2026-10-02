'use strict';

const CACHE_NAME = 'invoice-manager-a4cd68a22ef3669f';
const RESOURCES = [
  "./",
  "apple-touch-icon-114x114.png",
  "apple-touch-icon-120x120.png",
  "apple-touch-icon-144x144.png",
  "apple-touch-icon-152x152.png",
  "apple-touch-icon-167x167.png",
  "apple-touch-icon-180x180.png",
  "apple-touch-icon-57x57.png",
  "apple-touch-icon-60x60.png",
  "apple-touch-icon-72x72.png",
  "apple-touch-icon-76x76.png",
  "assets/AssetManifest.bin",
  "assets/AssetManifest.bin.json",
  "assets/FontManifest.json",
  "assets/NOTICES",
  "assets/assets/fonts/Roboto-Bold.ttf",
  "assets/assets/fonts/Roboto-BoldItalic.ttf",
  "assets/assets/fonts/Roboto-ExtraBold.ttf",
  "assets/assets/fonts/Roboto-ExtraLight.ttf",
  "assets/assets/fonts/Roboto-Italic.ttf",
  "assets/assets/fonts/Roboto-Light.ttf",
  "assets/assets/fonts/Roboto-Medium.ttf",
  "assets/assets/fonts/Roboto-Regular.ttf",
  "assets/assets/fonts/Roboto-SemiBold.ttf",
  "assets/assets/fonts/Roboto-Thin.ttf",
  "assets/assets/fonts/RobotoMono-Regular.ttf",
  "assets/assets/icons/apple-touch-icon-114x114.png",
  "assets/assets/icons/apple-touch-icon-120x120.png",
  "assets/assets/icons/apple-touch-icon-144x144.png",
  "assets/assets/icons/apple-touch-icon-152x152.png",
  "assets/assets/icons/apple-touch-icon-167x167.png",
  "assets/assets/icons/apple-touch-icon-180x180.png",
  "assets/assets/icons/apple-touch-icon-57x57.png",
  "assets/assets/icons/apple-touch-icon-60x60.png",
  "assets/assets/icons/apple-touch-icon-72x72.png",
  "assets/assets/icons/apple-touch-icon-76x76.png",
  "assets/assets/icons/favicon-16x16.png",
  "assets/assets/icons/favicon-32x32.png",
  "assets/assets/icons/favicon-48x48.png",
  "assets/assets/icons/icon-192x192.png",
  "assets/assets/icons/icon-512x512.png",
  "assets/fonts/MaterialIcons-Regular.otf",
  "assets/packages/cupertino_icons/assets/CupertinoIcons.ttf",
  "assets/shaders/ink_sparkle.frag",
  "assets/shaders/stretch_effect.frag",
  "canvaskit/canvaskit.js",
  "canvaskit/canvaskit.wasm",
  "canvaskit/chromium/canvaskit.js",
  "canvaskit/chromium/canvaskit.wasm",
  "canvaskit/webparagraph/canvaskit.js",
  "canvaskit/webparagraph/canvaskit.wasm",
  "favicon-16x16.png",
  "favicon-32x32.png",
  "favicon-48x48.png",
  "favicon.png",
  "flutter.js",
  "flutter_bootstrap.js",
  "icon-192x192.png",
  "icon-512x512.png",
  "icons/Icon-192.png",
  "icons/Icon-512.png",
  "icons/Icon-maskable-192.png",
  "icons/Icon-maskable-512.png",
  "icons/apple-touch-icon-114x114.png",
  "icons/apple-touch-icon-120x120.png",
  "icons/apple-touch-icon-144x144.png",
  "icons/apple-touch-icon-152x152.png",
  "icons/apple-touch-icon-167x167.png",
  "icons/apple-touch-icon-180x180.png",
  "icons/apple-touch-icon-57x57.png",
  "icons/apple-touch-icon-60x60.png",
  "icons/apple-touch-icon-72x72.png",
  "icons/apple-touch-icon-76x76.png",
  "index.html",
  "main.dart.js",
  "manifest.json",
  "sql-wasm.js",
  "sql-wasm.wasm",
  "version.json"
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => cache.addAll(RESOURCES))
      .then(() => self.skipWaiting())
  );
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys()
      .then((keys) => Promise.all(
        keys.filter((key) => key !== CACHE_NAME).map((key) => caches.delete(key))
      ))
      .then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  event.respondWith(
    caches.match(event.request, {ignoreSearch: true}).then((cached) => {
      if (cached) {
        return cached;
      }
      return fetch(event.request).then((response) => {
        if (response.ok && event.request.url.startsWith(self.location.origin)) {
          const copy = response.clone();
          caches.open(CACHE_NAME).then((cache) => cache.put(event.request, copy));
        }
        return response;
      }).catch((error) => {
        if (event.request.mode === 'navigate') {
          return caches.match('index.html');
        }
        throw error;
      });
    })
  );
});
