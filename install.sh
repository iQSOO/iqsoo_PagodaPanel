#!/usr/bin/env bash
# iqsoo_PagodaPanel compatibility launcher
# Main installer has been moved to: scripts/install.sh
# Website: https://www.iqsoo.com

set -Eeuo pipefail

PROJECT_NAME="iqsoo_PagodaPanel"
MAIN_INSTALLER_URL="https://raw.githubusercontent.com/iQSOO/iqsoo_PagodaPanel/main/scripts/install.sh"
TMP_DIR="$(mktemp -d "/tmp/${PROJECT_NAME}.launcher.XXXXXX")"
TMP_FILE="${TMP_DIR}/install.sh"
trap 'rm -rf "$TMP_DIR"' EXIT

if command -v curl >/dev/null 2>&1; then
  curl -fsSL --proto '=https' --tlsv1.2 --connect-timeout 20 --retry 2 -o "$TMP_FILE" "$MAIN_INSTALLER_URL"
elif command -v wget >/dev/null 2>&1; then
  wget -q --timeout=20 --tries=2 -O "$TMP_FILE" "$MAIN_INSTALLER_URL"
else
  echo "ERROR: curl or wget is required." >&2
  exit 1
fi

[ -s "$TMP_FILE" ] || {
  echo "ERROR: failed to download main installer." >&2
  exit 1
}

chmod +x "$TMP_FILE"
bash "$TMP_FILE" "$@"
