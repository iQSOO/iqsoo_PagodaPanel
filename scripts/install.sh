#!/usr/bin/env bash
# iqsoo_PagodaPanel
# Main installer: scripts/install.sh
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
  BOLD="\033[1m"; DIM="\033[2m"; RED="\033[31m"; GREEN="\033[32m"; YELLOW="\033[33m"; CYAN="\033[36m"; RESET="\033[0m"
else
  BOLD=""; DIM=""; RED=""; GREEN=""; YELLOW=""; CYAN=""; RESET=""
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
║             iQSOO PagodaPanel Deployment Kit               ║
║           宝塔 / aaPanel 专业级一键部署选择器                ║
║                                                            ║
╚════════════════════════════════════════════════════════════╝
BANNER
  printf "%b" "${RESET}"
  say "${BOLD}Project:${RESET} ${PROJECT_NAME}"
  say "${BOLD}Website:${RESET} ${PROJECT_SITE}"
  say "${DIM}${PROJECT_GITHUB}${RESET}"
  line
  say "${BOLD}Deployment Profiles / 部署方案${RESET}"
  say "  ${GREEN}1.${RESET} BT Panel CN      ${DIM}宝塔面板国内中文版${RESET}"
  say "  ${GREEN}2.${RESET} aaPanel Global   ${DIM}aaPanel 海外国际版${RESET}"
  line
  say "${BOLD}Features / 特性${RESET}"
  say "  ${GREEN}•${RESET} Unified SSH entry point"
  say "  ${GREEN}•${RESET} Interactive deployment workflow"
  say "  ${GREEN}•${RESET} Beginner-friendly server initialization"
  say "  ${GREEN}•${RESET} Designed for VPS, cloud servers and WordPress deployment"
  line
}

usage() {
  cat <<USAGE
${PROJECT_NAME}

Usage:
  bash scripts/install.sh
  bash scripts/install.sh --bt
  bash scripts/install.sh --aapanel
  bash scripts/install.sh --help

Options:
  --bt        Install BT Panel CN.
  --aapanel  Install aaPanel Global.
  --help     Show this help message.

Website:
  ${PROJECT_SITE}
USAGE
}

require_root() {
  if [ "${EUID:-$(id -u)}" -ne 0 ]; then
    die "请使用 root 权限执行。示例：sudo bash scripts/install.sh"
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
  ok "Network downloader ready: ${DOWNLOADER}"
}

download_file() {
  local url="$1"
  local output="$2"

  info "Preparing deployment package..."

  if [ "$DOWNLOADER" = "curl" ]; then
    curl -fsSL --proto '=https' --tlsv1.2 --connect-timeout 20 --retry 2 -o "$output" "$url"
  else
    wget -q --timeout=20 --tries=2 -O "$output" "$url"
  fi

  [ -s "$output" ] || die "部署包获取失败，请检查服务器网络后重试。"
  chmod +x "$output"
  ok "Deployment package is ready."
}

confirm_install() {
  local edition="$1"
  say
  say "${BOLD}Selected profile / 当前选择:${RESET} ${GREEN}${edition}${RESET}"
  say "${YELLOW}安装过程可能会安装运行环境、开放端口或修改系统配置。${RESET}"
  read -r -p "继续部署？输入 y 确认 / Continue? Type y to confirm: " yn
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
  info "Starting BT Panel CN deployment..."
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
  info "Starting aaPanel Global deployment..."
  line
  bash "$file" "$AAPANEL_ARG"
}

menu() {
  banner
  say "${BOLD}请选择部署方案 / Select deployment profile / 請選擇部署方案${RESET}"
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
