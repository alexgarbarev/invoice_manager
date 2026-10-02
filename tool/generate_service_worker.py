#!/usr/bin/env python3
"""Generate an offline-first service worker for the Flutter web build.

Flutter 3.35+ ships a no-op self-unregistering flutter_service_worker.js
(the built-in PWA caching was removed). flutter_bootstrap.js still registers
that file, so we overwrite it with a real precaching service worker.

Usage: python3 tool/generate_service_worker.py build/web
"""

import hashlib
import json
import re
import sys
from pathlib import Path

SW_NAME = "flutter_service_worker.js"

# Not needed at runtime: debug symbols and renderer variants unused by a
# dart2js + canvaskit build.
EXCLUDE_SUFFIXES = (".symbols", ".map", ".last_build_id")
EXCLUDE_PREFIXES = (
    "canvaskit/skwasm",
    "canvaskit/wimp",
    "canvaskit/experimental_webparagraph",
)

SW_TEMPLATE = """'use strict';

const CACHE_NAME = 'invoice-manager-%(version)s';
const RESOURCES = %(resources)s;

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
"""


def main() -> None:
    build_dir = Path(sys.argv[1] if len(sys.argv) > 1 else "build/web")
    if not (build_dir / "index.html").exists():
        sys.exit(f"error: {build_dir}/index.html not found — run `flutter build web` first")

    resources = ["./"]
    digest = hashlib.sha256()
    for file in sorted(build_dir.rglob("*")):
        if not file.is_file():
            continue
        rel = file.relative_to(build_dir).as_posix()
        if rel == SW_NAME or rel.endswith(EXCLUDE_SUFFIXES) or rel.startswith(EXCLUDE_PREFIXES):
            continue
        # Dotfiles (.DS_Store, .last_build_id) aren't served by GitHub Pages;
        # a single 404 makes cache.addAll() fail and kills the whole install.
        if any(part.startswith(".") for part in rel.split("/")):
            continue
        resources.append(rel)
        digest.update(rel.encode())
        digest.update(file.read_bytes())

    sw = SW_TEMPLATE % {
        "version": digest.hexdigest()[:16],
        "resources": json.dumps(resources, indent=2),
    }
    (build_dir / SW_NAME).write_text(sw)

    # Strip Flutter's deprecated service worker registration from the
    # bootstrap: it registers the same script under a different URL
    # (?v=...), which races with the registration in index.html and keeps
    # invalidating the active worker.
    bootstrap = build_dir / "flutter_bootstrap.js"
    code = bootstrap.read_text()
    stripped = re.sub(
        r"serviceWorkerSettings:\s*\{[^{}]*\},?", "", code, count=1
    )
    if stripped == code:
        print("warning: serviceWorkerSettings not found in flutter_bootstrap.js")
    bootstrap.write_text(stripped)
    total = sum((build_dir / r).stat().st_size for r in resources[1:])
    print(f"{SW_NAME}: {len(resources)} resources, {total / 1024 / 1024:.1f} MB precached")


if __name__ == "__main__":
    main()
