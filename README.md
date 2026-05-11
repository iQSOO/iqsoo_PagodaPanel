# iqsoo_PagodaPanel

<p align="center">
  <b>BT Panel CN + aaPanel Global · Official One-Click Selector · Powered by iQSOO</b>
</p>

<p align="center">
  <a href="https://www.iqsoo.com">www.iqsoo.com</a> ·
  <a href="#简体中文">简体中文</a> ·
  <a href="#english">English</a> ·
  <a href="#繁體中文">繁體中文</a>
</p>

<p align="center">
  <img alt="Shell" src="https://img.shields.io/badge/Shell-Bash-4EAA25">
  <img alt="Platform" src="https://img.shields.io/badge/Platform-Linux-blue">
  <img alt="License" src="https://img.shields.io/badge/License-MIT-green">
  <img alt="Sources" src="https://img.shields.io/badge/Sources-Official-orange">
</p>

---

## 简体中文

`iqsoo_PagodaPanel` 是一个面向新手、站长和服务器运维用户的 **宝塔 Linux 面板 / aaPanel 一键选择安装器**。

它不会修改宝塔或 aaPanel 官方安装包，也不会替换为第三方镜像源；它只是把两个官方安装入口合并到一个更清晰、更适合 SSH 执行的交互菜单里，让用户自由选择安装国内中文版或海外国际版。

| 选项 | 面板 | 适合场景 | 官方脚本来源 |
| --- | --- | --- | --- |
| 1 | 宝塔 Linux 面板国内中文版 | 国内服务器、中文环境、国内用户 | `https://download.bt.cn/install/install_panel.sh` |
| 2 | aaPanel 海外国际版 | 海外服务器、英文环境、国际用户 | `https://www.aapanel.com/script/install_panel_en.sh` |

> 默认安装官方当前最新版，实际版本以官方安装脚本实时发布为准。

### 一条命令安装

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/iQSOO/iqsoo_PagodaPanel/main/install.sh)
```

兼容方式：

```bash
curl -fsSL -o iqsoo-pagoda-panel.sh https://raw.githubusercontent.com/iQSOO/iqsoo_PagodaPanel/main/install.sh && sudo bash iqsoo-pagoda-panel.sh
```

使用 `wget`：

```bash
wget -O iqsoo-pagoda-panel.sh https://raw.githubusercontent.com/iQSOO/iqsoo_PagodaPanel/main/install.sh && sudo bash iqsoo-pagoda-panel.sh
```

### 指定安装

```bash
# 宝塔国内中文版
bash <(curl -fsSL https://raw.githubusercontent.com/iQSOO/iqsoo_PagodaPanel/main/install.sh) --bt

# aaPanel 海外国际版
bash <(curl -fsSL https://raw.githubusercontent.com/iQSOO/iqsoo_PagodaPanel/main/install.sh) --aapanel
```

### SSH 执行界面

```text
╔════════════════════════════════════════════════════════════╗
║                                                            ║
║        BT Panel / aaPanel Official One-Click Selector       ║
║             宝塔 / aaPanel 官方一键选择安装器                 ║
║                                                            ║
╚════════════════════════════════════════════════════════════╝
Powered by iQSOO  https://www.iqsoo.com
GitHub: https://github.com/iQSOO/iqsoo_PagodaPanel
────────────────────────────────────────────────────────────
官方源 / Official sources / 官方來源
  1. BT Panel CN     : https://download.bt.cn/install/install_panel.sh
  2. aaPanel Global  : https://www.aapanel.com/script/install_panel_en.sh
────────────────────────────────────────────────────────────
请选择安装版本 / Select edition / 請選擇安裝版本

  1) 宝塔面板 国内中文版    BT Panel CN
  2) aaPanel 海外国际版      aaPanel Global
  0) 退出                    Exit
```

### 项目定位

- 官方安装源聚合器，不是宝塔或 aaPanel 修改版。
- 国内版调用宝塔官方 `download.bt.cn` 安装脚本。
- 国际版调用 aaPanel 官方 `aapanel.com` 安装脚本。
- 让小白也能轻松选择国内版或海外国际版。
- 项目由 [iQSOO](https://www.iqsoo.com) 整理维护。

---

## English

`iqsoo_PagodaPanel` is a clean and beginner-friendly **BT Panel CN / aaPanel Global one-click selector** for Linux servers.

It does not modify BT Panel or aaPanel packages. It only combines the official installation script entries into one polished SSH menu so users can choose the edition they need.

| Option | Panel | Best For | Official Script Source |
| --- | --- | --- | --- |
| 1 | BT Panel CN | Mainland China servers and Chinese UI users | `https://download.bt.cn/install/install_panel.sh` |
| 2 | aaPanel Global | Overseas servers and English UI users | `https://www.aapanel.com/script/install_panel_en.sh` |

The installer uses the latest version provided by the official upstream scripts at runtime.

### One-line install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/iQSOO/iqsoo_PagodaPanel/main/install.sh)
```

Compatible mode:

```bash
curl -fsSL -o iqsoo-pagoda-panel.sh https://raw.githubusercontent.com/iQSOO/iqsoo_PagodaPanel/main/install.sh && sudo bash iqsoo-pagoda-panel.sh
```

Using `wget`:

```bash
wget -O iqsoo-pagoda-panel.sh https://raw.githubusercontent.com/iQSOO/iqsoo_PagodaPanel/main/install.sh && sudo bash iqsoo-pagoda-panel.sh
```

---

## 繁體中文

`iqsoo_PagodaPanel` 是一個面向新手、站長與伺服器維運使用者的 **寶塔 Linux 面板 / aaPanel 一鍵選擇安裝器**。

本專案不會修改寶塔或 aaPanel 官方安裝包，也不會替換為第三方鏡像源。它只是把兩個官方安裝入口整合到一個清楚、適合 SSH 執行的互動選單中，讓使用者自由選擇國內中文版或海外國際版。

| 選項 | 面板 | 適合場景 | 官方腳本來源 |
| --- | --- | --- | --- |
| 1 | 寶塔 Linux 面板國內中文版 | 國內伺服器、中文環境、國內使用者 | `https://download.bt.cn/install/install_panel.sh` |
| 2 | aaPanel 海外國際版 | 海外伺服器、英文環境、國際使用者 | `https://www.aapanel.com/script/install_panel_en.sh` |

預設安裝官方目前最新版，實際版本以官方安裝腳本即時發布為準。

---

## Security / 安全说明

运行前可先查看完整脚本：

```bash
curl -fsSL https://raw.githubusercontent.com/iQSOO/iqsoo_PagodaPanel/main/install.sh
```

脚本只做以下事情：

1. 检查是否为 root 用户。
2. 检查 `curl` 或 `wget`。
3. 显示交互选择菜单。
4. 下载用户选择的官方安装脚本。
5. 使用对应官方参数执行官方安装器。

---

## Official references / 官方参考

- 宝塔 Linux 面板官方文档：`https://docs.bt.cn/getting-started/quick-installation-of-bt-panel`
- 宝塔 Linux 面板官方下载页：`https://www.bt.cn/new/download`
- aaPanel Official Install Page：`https://www.aapanel.com/install.html`
- aaPanel Download Page：`https://www.aapanel.com/new/download.html`

---

## Website

更多服务器、WordPress、网站搭建与运维内容：

**https://www.iqsoo.com**

---

## Disclaimer / 免责声明

This repository is an independent convenience wrapper for official installation scripts. BT Panel and aaPanel are trademarks or products of their respective owners.

本项目只是官方安装脚本的便捷聚合入口，不代表宝塔或 aaPanel 官方项目本身。使用前请自行确认服务器环境、数据备份、安全组与防火墙策略。

---

## License

MIT License
