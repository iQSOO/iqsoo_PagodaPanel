# iQSOO Panel 0.1.0 公开预览版

面向 WordPress 的开源服务器管理增强面板。项目以 1Panel OSS 为系统与容器管理底座，iQSOO Panel 专门负责 WordPress 核心、插件、主题、备份、恢复、安全检查、Cron、用户和日志管理。

> 当前为公开测试版。只能先用于测试服务器或已完成异地备份的测试站，不应直接覆盖唯一生产环境。

## 发布位置

本项目发布在 `iqsoo-panel-preview` 独立分支，不修改仓库原有的宝塔/aaPanel安装器主分支。

- 预览分支：`https://github.com/iQSOO/iqsoo_PagodaPanel/tree/iqsoo-panel-preview`
- Bug反馈：`https://github.com/iQSOO/iqsoo_PagodaPanel/issues/1`
- 公开测试PR：`https://github.com/iQSOO/iqsoo_PagodaPanel/pull/2`

## 已实现功能

- 多 WordPress 站点发现、切换和概览
- 插件安装、启用、停用、删除、更新及自动更新
- 主题安装、启用、删除、更新及自动更新
- WordPress 核心检查、更新和数据库升级
- 更新、安装、删除前自动完整备份
- 文件和数据库完整备份、SHA-256校验、一键恢复和失败回滚
- 维护模式、缓存、固定链接、Cron和用户管理
- 数据库检查、优化、临时缓存清理
- 域名搜索替换预览及带备份执行
- WordPress核心与插件文件校验
- WordPress、PHP、Nginx错误日志和完整操作审计
- PBKDF2-SHA256密码、TOTP、CSRF、Host/Origin校验、登录限速
- 低权限Web服务与root白名单Agent分离
- 不提供网页Shell，不允许拼接任意系统命令

## 一键测试安装

当前公开预览包为源码版本，服务器需要预先安装 Go 1.23 或更高版本。

1Panel网站常见目录：

```bash
curl -fsSL https://raw.githubusercontent.com/iQSOO/iqsoo_PagodaPanel/iqsoo-panel-preview/install-preview.sh | \
sudo env IQSOO_ACCEPT_PREVIEW=1 \
  PANEL_HOST=panel.example.com \
  SITE_PATH=/www/sites/www.example.com/index \
  SITE_DOMAIN=www.example.com \
  SITE_NAME="WordPress测试站" \
  bash
```

宝塔网站通常将 `SITE_PATH` 改成：

```text
/www/wwwroot/www.example.com
```

安装后必须通过 1Panel、宝塔或 Nginx/OpenResty 将 HTTPS 域名反向代理到：

```text
http://127.0.0.1:18080
```

不要向公网开放18080端口。首次登录后立即修改随机初始密码并开启TOTP双重验证。

## 下载和检查源码包

```bash
curl -fsSL https://raw.githubusercontent.com/iQSOO/iqsoo_PagodaPanel/iqsoo-panel-preview/download-source.sh | bash

tar -xzf iqsoo-panel-preview-source.tar.gz
cd iqsoo-panel
```

源码包固定校验值：

```text
SHA-256: 49e63365d8d6c00c920fab125bb4911da3056cc372b5a7f433e376efc9a3751a
```

`.bootstrap/part-*` 是同一个源码 `tar.gz` 的 Base64 分片。`download-source.sh` 下载全部分片、重建源码包并强制验证SHA-256，校验不一致时会删除文件并终止。

## 本地测试

```bash
gofmt -w .
go test -race ./...
go vet ./...
node --check internal/web/static/app.js
shellcheck scripts/*.sh install.sh
```

## 重点测试范围

1. 登录、修改密码、TOTP启用和关闭。
2. 插件、主题和核心更新，以及更新前自动备份。
3. 文件和数据库完整备份、完整性校验、恢复和失败回滚。
4. Cron、数据库检查优化、搜索替换预览和正式执行。
5. 非法路径、越权、CSRF、Host/Origin和重复请求拦截。
6. 1Panel、宝塔以及宿主机/Docker WordPress目录兼容性。
7. 服务器重启后两个systemd服务的自动启动状态。

## 安全报告

普通Bug可提交到公开Issue，但必须删除密码、Cookie、TOTP密钥、SSH私钥、邮箱、数据库内容及其他敏感信息。安全漏洞不要公开披露，应按照源码包中的 `SECURITY.md` 进行私下报告。

任何服务器面板都不能被诚实保证绝对没有Bug或未知漏洞。本预览版采用白名单动作、权限隔离、签名、防重放、自动备份、失败回滚和审计日志降低风险，但公开测试的目的正是继续发现并修复问题。
