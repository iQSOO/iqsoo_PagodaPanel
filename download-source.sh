#!/usr/bin/env bash
set -Eeuo pipefail

REPO="https://raw.githubusercontent.com/iQSOO/iqsoo_PagodaPanel/iqsoo-panel-preview"
EXPECTED_SHA256="49e63365d8d6c00c920fab125bb4911da3056cc372b5a7f433e376efc9a3751a"
OUTPUT="${1:-iqsoo-panel-preview-source.tar.gz}"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

command -v curl >/dev/null 2>&1 || { echo "缺少 curl" >&2; exit 1; }
command -v base64 >/dev/null 2>&1 || { echo "缺少 base64" >&2; exit 1; }
command -v sha256sum >/dev/null 2>&1 || { echo "缺少 sha256sum" >&2; exit 1; }

for number in $(seq -w 0 23); do
  curl --fail --silent --show-error --location \
    "$REPO/.bootstrap/part-$number" \
    --output "$TMP_DIR/part-$number"
done

cat "$TMP_DIR"/part-* | base64 --decode > "$OUTPUT"
echo "$EXPECTED_SHA256  $OUTPUT" | sha256sum --check --status || {
  rm -f "$OUTPUT"
  echo "源码包 SHA-256 校验失败，文件已删除。" >&2
  exit 1
}

printf '已生成并校验：%s\nSHA-256：%s\n' "$OUTPUT" "$EXPECTED_SHA256"
