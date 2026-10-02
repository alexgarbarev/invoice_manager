#!/usr/bin/env bash
# Build the web app for offline-capable deployment (GitHub Pages).
#
#   tool/build_web.sh [base-href]
#
# Then deploy as usual:
#   flutter pub run github_pages -d build/web
set -euo pipefail
cd "$(dirname "$0")/.."

BASE_HREF="${1:-/invoice_manager/}"

# --no-web-resources-cdn bundles CanvasKit locally instead of loading it
# from gstatic.com (required for offline use).
flutter build web --base-href "$BASE_HREF" --no-web-resources-cdn

python3 tool/generate_service_worker.py build/web
