# 威尔派法律协议文档 (szvip-policy)

## 模块职责
本项目用于托管 Gimbal Master 等应用及其相关服务的隐私政策、用户协议等法律文档。协议按使用场景分为**中国大陆上架**与**Google Play 上架**两套。

## 目录结构
- `privacy-policy-cn.html` / `privacy-policy-en.html`: 隐私政策（中国大陆上架用，含 ICP、返回主站、用户协议链接）
- `user-agreement-cn.html` / `user-agreement-en.html`: 用户协议（中国大陆上架用）
- **`privacy-policy-googleplay-cn.html`** / **`privacy-policy-googleplay-en.html`**: 隐私政策（**Google Play 专用**，Dualistic Polarities, LLC 企业发布、无 ICP、无返回主站、无用户协议链接，含数据共享对象类型等 Play 合规内容）
- `nginx-policy.conf`: 协议文档专属 Nginx 配置 (dualistic-polarities.com)
- `deploy-policy.sh`: 协议文档同步脚本

## 访问链接

### 中国大陆上架
- 隐私政策: https://dualistic-polarities.com/privacy-policy-cn.html
- 用户协议: https://dualistic-polarities.com/user-agreement-cn.html

### Google Play 上架（Dualistic Polarities, LLC）
- 隐私政策（英文，建议填 Play Console）: https://dualistic-polarities.com/privacy-policy-googleplay-en.html
- 隐私政策（中文）: https://dualistic-polarities.com/privacy-policy-googleplay-cn.html

## 更新流程
修改 HTML 文件后，运行 `./deploy-policy.sh` 同步到静态服务器即可。
