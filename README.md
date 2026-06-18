# 法律协议文档 (szvip-policy)

## 模块职责
本仓库托管两套相互独立的协议：

- **大陆版**（威尔派科技 / Gimbal View）：在仓库根目录，**不部署到 dualistic-polarities.com**，需要时另行部署到大陆侧域名（如 szvip.vip）。
- **iGimbal 国际版**（Dualistic Polarities, LLC / Google Play）：放在 `igimbal/` 子目录，由 `deploy-policy.sh` 部署到 dualistic-polarities.com。

两套协议互不影响，可独立维护。

## 目录结构

```
szvip-policy/
├── privacy-policy-cn.html         # 大陆版隐私政策（中文）
├── privacy-policy-en.html         # 大陆版隐私政策（英文）
├── user-agreement-cn.html         # 大陆版用户协议（中文）
├── user-agreement-en.html         # 大陆版用户协议（英文）
├── igimbal/                       # iGimbal Google Play 版（dualistic-polarities.com）
│   ├── privacy-policy-en.html     # 隐私政策（英文，主用，填 Play Console）
│   └── privacy-policy-cn.html     # 隐私政策（中文）
├── nginx-policy.conf              # dualistic-polarities.com 的 Nginx 配置
├── nginx-policy-bootstrap.conf    # 首次签发 Let's Encrypt 证书使用的临时配置
├── deploy-policy.sh               # 同步 igimbal/ 到 dualistic-polarities.com
├── deploy-privacy-to-ec2.sh       # 备用：将 igimbal 隐私政策同步到 AWS EC2
└── DEPLOY-README.md               # AWS EC2 备用部署链路说明
```

## 访问链接

### iGimbal · Google Play（主用）
- 隐私政策（英文，填 Play Console）：https://dualistic-polarities.com/privacy-policy-en.html
- 隐私政策（中文）：https://dualistic-polarities.com/privacy-policy-cn.html

> 旧的 `/privacy-policy-googleplay-*.html` 路径已在 Nginx 中 301 重定向到新地址，不会 404。

### 大陆版（不在 dualistic-polarities.com 下）
- 仓库根目录文件，部署目标暂未配置。如需托管到 szvip.vip 等大陆侧域名，请另行编写部署脚本，**不要走 `deploy-policy.sh`**。

## 更新流程

### 更新 iGimbal Google Play 协议
1. 修改 `igimbal/` 下的 HTML 文件。
2. 运行 `./deploy-policy.sh`（仅同步 `igimbal/` 子目录到 dualistic-polarities.com）。

### 更新大陆版协议
- 修改仓库根目录的相应 HTML 文件。
- 大陆版的部署当前不在本仓库范围内，请按你大陆侧的部署流程处理。
