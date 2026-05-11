#!/usr/bin/env bash
# iqsoo_PagodaPanel
# BT Panel CN / aaPanel Global Official One-Click Selector
# Website: https://www.iqsoo.com

set -Eeuo pipefail

PROJECT_NAME="iqsoo_PagodaPanel"
PROJECT_SITE="https://www.iqsoo.com"
PROJECT_GITHUB="https://github.com/iQSOO/iqsoo_PagodaPanel"

BT_URL="https://download.bt.cn/install/install_panel.sh"
BT_FILE="install_panel.sh"
BT_ARG="ed8484bec"

AAPANEL_URL="https://www.aapanel.com/script/install_panel_en.sh"
AAPANEL_FILE="install_panel_en.sh"
AAPANEL_ARG="ipssl"

TMP_DIR="$(mktemp -d "/tmp/${PROJECT_NAME}.XXXXXX")"
trap 'rm -rf "$TMP_DIR"' EXIT

if [ -t 1 ]; then
  BOLD="\033[1m"; DIM="\033[2m"; RED="\033[31m"; GREEN="\033[32m"; YELLOW="\033[33m"
  BLUE="\033[34m"; CYAN="\033[36m"; RESET="\033[0m"
else
  BOLD=""; DIM=""; RED=""; GREEN=""; YELLOW=""; BLUE=""; CYAN=""; RESET=""
fi

line() { printf "%b\n" "${DIM}────────────────────────────────────────────────────────────${RESET}"; }
say() { printf "%b\n" "$*"; }
die() { say "${RED}${BOLD}ERROR:${RESET} $*" >&2; exit 1; }
ok() { say "${GREEN}✔${RESET} $*"; }
warn() { say "${YELLOW}⚠${RESET} $*"; }
info() { say "${CYAN}➜${RESET} $*"; }

banner() {
  clear 2>/dev/null || true
  printf "%b" "${CYAN}${BOLD}"
  cat <<'BANNER'
╔════════════════════════════════════════════════════════════╗
║                                                            ║
║        BT Panel / aaPanel Official One-Click Selector       ║
║             宝塔 / aaPanel 官方一键选择安装器                 ║
║                                                            ║
╚════════════════════════════════════════════════════════════╝
BANNER
  printf "%b" "${RESET}"
  say "${BOLD}Powered by iQSOO${RESET}  ${PROJECT_SITE}"
  say "${DIM}GitHub: ${PROJECT_GITHUB}${RESET}"
  line
  say "${BOLD}官方源 / Official sources / 官方來源${RESET}"
  say "  ${GREEN}1.${RESET} BT Panel CN     : ${BT_URL}"
  say "  ${GREEN}2.${RESET} aaPanel Global  : ${AAPANEL_URL}"
  line
  say "${BOLD}说明 / Notice / 說明${RESET}"
  say "  - 默认安装官方当前最新版，实际版本以官方安装脚本为准。"
  say "  - This wrapper only downloads and runs official installer scripts."
  say "  - 本脚本只做官方源合并选择，不修改官方安装包。"
  line
}

usage() {
  cat <<USAGE
${PROJECT_NAME}

Usage:
  bash install.sh
  bash install.sh --bt
  bash install.sh --aapanel
  bash install.sh --help

Options:
  --bt        Install BT Panel CN from official bt.cn script.
  --aapanel  Install aaPanel Global from official aapanel.com script.
  --help     Show this help message.

Website:
  ${PROJECT_SITE}
USAGE
}

require_root() {
  if [ "${EUID:-$(id -u)}" -ne 0 ]; then
    die "请使用 root 权限执行。示例：sudo bash install.sh"
  fi
}

require_downloader() {
  if command -v curl >/dev/null 2>&1; then
    DOWNLOADER="curl"
  elif command -v wget >/dev/null 2>&1; then
    DOWNLOADER="wget"
  else
    die "未检测到 curl 或 wget，请先安装其中一个。"
  fi
  ok "Downloader detected: ${DOWNLOADER}"
}

download_file() {
  local url="$1"
  local output="$2"

  info "Downloading official installer..."
  say "${DIM}${url}${RESET}"

  if [ "$DOWNLOADER" = "curl" ]; then
    curl -fsSL --proto '=https' --tlsv1.2 --connect-timeout 20 --retry 2 -o "$output" "$url"
  else
    wget -q --timeout=20 --tries=2 -O "$output" "$url"
  fi

  [ -s "$output" ] || die "下载失败或文件为空：$url"
  chmod +x "$output"
  ok "Official installer ready: $output"
}

confirm_install() {
  local edition="$1"
  say
  say "${BOLD}即将安装 / Ready to install:${RESET} ${GREEN}${edition}${RESET}"
  say "${YELLOW}安装过程将继续调用官方脚本，并可能安装运行环境、开放端口或修改系统配置。${RESET}"
  read -r -p "继续安装？输入 y 确认 / Continue? Type y to confirm: " yn
  case "$yn" in
    y|Y|yes|YES) ;;
    *) say "Cancelled."; exit 0 ;;
  esac
}

install_bt() {
  banner
  require_root
  require_downloader
  confirm_install "BT Panel CN / 宝塔 Linux 面板国内中文版"
  local file="${TMP_DIR}/${BT_FILE}"
  download_file "$BT_URL" "$file"
  line
  info "Executing official BT Panel installer..."
  say "${DIM}bash ${BT_FILE} ${BT_ARG}${RESET}"
  line
  bash "$file" "$BT_ARG"
}

install_aapanel() {
  banner
  require_root
  require_downloader
  confirm_install "aaPanel Global / 海外国际版"
  local file="${TMP_DIR}/${AAPANEL_FILE}"
  download_file "$AAPANEL_URL" "$file"
  line
  info "Executing official aaPanel installer..."
  say "${DIM}bash ${AAPANEL_FILE} ${AAPANEL_ARG}${RESET}"
  line
  bash "$file" "$AAPANEL_ARG"
}

menu() {
  banner
  say "${BOLD}请选择安装版本 / Select edition / 請選擇安裝版本${RESET}"
  say
  say "  ${GREEN}1)${RESET} 宝塔面板 国内中文版    ${DIM}BT Panel CN${RESET}"
  say "  ${GREEN}2)${RESET} aaPanel 海外国际版      ${DIM}aaPanel Global${RESET}"
  say "  ${YELLOW}0)${RESET} 退出                    ${DIM}Exit${RESET}"
  say
  read -r -p "输入序号后回车 [1/2/0]: " choice

  case "$choice" in
    1) install_bt ;;
    2) install_aapanel ;;
    0) say "Exit."; exit 0 ;;
    *) warn "无效选择，请重新输入。"; sleep 1; menu ;;
  esac
}

case "${1:-}" in
  --bt|bt|cn) install_bt ;;
  --aapanel|aapanel|global|en) install_aapanel ;;
  --help|-h|help) usage ;;
  "") menu ;;
  *) usage; exit 1 ;;
esac
