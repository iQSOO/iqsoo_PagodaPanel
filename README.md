# iqsoo_PagodaPanel

<p align="center">
  <b>BT Panel CN + aaPanel Global · One-Click Deployment Selector · Powered by iQSOO</b>
</p>

<p align="center">
  <a href="https://www.iqsoo.com">www.iqsoo.com</a> · 简体中文 · English · 繁體中文
</p>

<p align="center">
  <img alt="Shell" src="https://img.shields.io/badge/Shell-Bash-4EAA25">
  <img alt="Platform" src="https://img.shields.io/badge/Platform-Linux-blue">
  <img alt="License" src="https://img.shields.io/badge/License-MIT-green">
  <img alt="Project" src="https://img.shields.io/badge/Project-iQSOO-orange">
</p>

---

## 简体中文

`iqsoo_PagodaPanel` 是一个面向新手、站长和服务器运维用户的 **宝塔 Linux 面板 / aaPanel 一键选择安装器**。

它把国内中文版和海外国际版的安装流程整合到一个更清晰、更适合 SSH 执行的交互菜单中，让用户通过一个入口完成选择和部署。

### 支持的部署方案

- `1`：宝塔面板国内中文版，适合国内服务器、中文环境和国内用户。
- `2`：aaPanel 海外国际版，适合海外服务器、英文环境和国际用户。
- `0`：退出脚本。

用户必须明确选择部署方案。直接回车不会默认安装，会提示并安全退出。

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
bash <(curl -fsSL https://raw.githubusercontent.com/iQSOO/iqsoo_PagodaPanel/main/install.sh) --bt
```

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/iQSOO/iqsoo_PagodaPanel/main/install.sh) --aapanel
```

### 项目结构

```text
iqsoo_PagodaPanel/
├── install.sh
├── scripts/
│   └── install.sh
├── README.md
├── LICENSE
└── .gitignore
```

### 项目定位

- 统一 SSH 安装入口。
- 支持国内版和海外版自由选择。
- 适合 VPS、云服务器、WordPress 建站环境初始化。
- 保留交互确认逻辑，避免误操作安装。
- 项目由 [iQSOO](https://www.iqsoo.com) 整理维护。

---

## English

`iqsoo_PagodaPanel` is a beginner-friendly deployment selector for Linux servers.

It provides a unified SSH entry point and lets users choose between BT Panel CN and aaPanel Global before deployment.

Supported profiles:

- `1`: BT Panel CN.
- `2`: aaPanel Global.
- `0`: Exit.

Empty input does not start installation. The script exits safely when no profile is selected.

### One-line install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/iQSOO/iqsoo_PagodaPanel/main/install.sh)
```

---

## 繁體中文

`iqsoo_PagodaPanel` 是一個面向新手、站長與伺服器維運使用者的 **寶塔 Linux 面板 / aaPanel 一鍵選擇安裝器**。

它把國內中文版與海外國際版的安裝流程整合到一個清楚、適合 SSH 執行的互動選單中，讓使用者透過一個入口完成選擇與部署。

支援的部署方案：

- `1`：寶塔面板國內中文版。
- `2`：aaPanel 海外國際版。
- `0`：退出腳本。

直接回車不會預設安裝，會提示並安全退出。

---

## Website

更多服务器、WordPress、网站搭建与运维内容：

**https://www.iqsoo.com**

---

## Disclaimer / 免责声明

This repository is an independent convenience project for server panel deployment. BT Panel and aaPanel are trademarks or products of their respective owners.

本项目只是服务器面板部署流程的便捷入口，不代表宝塔或 aaPanel 官方项目本身。使用前请自行确认服务器环境、数据备份、安全组与防火墙策略。

---

## License

MIT License
