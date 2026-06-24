#!/usr/bin/env bash
set -Eeuo pipefail

if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
  echo "必须使用 root 运行。" >&2
  exit 1
fi
if [[ "${IQSOO_ACCEPT_PREVIEW:-0}" != "1" ]]; then
  echo "这是公开预览版。确认已备份测试站后，请设置 IQSOO_ACCEPT_PREVIEW=1。" >&2
  exit 1
fi
if ! command -v go >/dev/null 2>&1; then
  echo "当前公开包为源码测试版，需要先安装 Go 1.23 或更高版本。" >&2
  exit 1
fi

REPO="https://raw.githubusercontent.com/iQSOO/iqsoo_PagodaPanel/iqsoo-panel-preview"
EXPECTED_SHA256="49e63365d8d6c00c920fab125bb4911da3056cc372b5a7f433e376efc9a3751a"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

for command in curl base64 sha256sum tar; do
  command -v "$command" >/dev/null 2>&1 || { echo "缺少依赖：$command" >&2; exit 1; }
done

mkdir -p "$TMP_DIR/parts" "$TMP_DIR/source"
for number in $(seq -w 0 23); do
  curl --fail --silent --show-error --location \
    "$REPO/.bootstrap/part-$number" \
    --output "$TMP_DIR/parts/part-$number"
done

cat "$TMP_DIR"/parts/part-* | base64 --decode > "$TMP_DIR/source.tar.gz"
echo "$EXPECTED_SHA256  $TMP_DIR/source.tar.gz" | sha256sum --check --status || {
  echo "源码包 SHA-256 校验失败，安装已终止。" >&2
  exit 1
}

tar --extract --gzip --file "$TMP_DIR/source.tar.gz" --directory "$TMP_DIR/source" \
  --no-same-owner --no-same-permissions

cd "$TMP_DIR/source"
exec bash ./install.sh
