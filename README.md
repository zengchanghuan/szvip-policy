# 威尔派法律协议文档 (szvip-policy)

## 模块职责
本仓库托管 **iGimbal**（Google Play 国际版，由 Dualistic Polarities, LLC 发布）及历史 **Gimbal Master**（中国大陆上架版，威尔派科技）的隐私政策与用户协议。

## 目录结构
- `privacy-policy-en.html` / `privacy-policy-cn.html`：iGimbal **Google Play 主版本**隐私政策（中英文，无 ICP、无公司主站、零数据收集表述）
- `mainland/`：中国大陆上架使用的旧版协议（保留备查）
  - `privacy-policy-cn.html` / `privacy-policy-en.html`
  - `user-agreement-cn.html` / `user-agreement-en.html`
- `nginx-policy.conf`：dualistic-polarities.com 站点 Nginx 配置（含旧 URL 301 重定向）
- `nginx-policy-bootstrap.conf`：首次签发 Let's Encrypt 证书时使用的临时 HTTP 配置
- `deploy-policy.sh`：协议文档同步脚本（rsync + reload nginx）
- `deploy-privacy-to-ec2.sh` / `DEPLOY-README.md`：备用 AWS EC2 部署链路

## 访问链接

### Google Play 上架（主用）
- 隐私政策（英文，填 Play Console）：https://dualistic-polarities.com/privacy-policy-en.html
- 隐私政策（中文）：https://dualistic-polarities.com/privacy-policy-cn.html

### 中国大陆上架（备查）
- 隐私政策（中文）：https://dualistic-polarities.com/mainland/privacy-policy-cn.html
- 隐私政策（英文）：https://dualistic-polarities.com/mainland/privacy-policy-en.html
- 用户协议（中文）：https://dualistic-polarities.com/mainland/user-agreement-cn.html
- 用户协议（英文）：https://dualistic-polarities.com/mainland/user-agreement-en.html

> 旧的 `/privacy-policy-googleplay-*.html` 路径已在 Nginx 中 301 重定向到新地址，不会 404。

## 更新流程
修改 HTML 文件后，运行 `./deploy-policy.sh` 同步到 dualistic-polarities.com。
