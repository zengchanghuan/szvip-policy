# 隐私政策部署说明

## 用途

本仓库中的 **`./deploy-privacy-to-ec2.sh`** 仅用于将 **iGimbal（Google Play）应用的隐私政策** 部署到 **AWS EC2** 上的公网地址，供应用商店与用户访问。

- **部署目标**：AWS EC2（当前为 `https://privacy.veryplace.net`）
- **协议适用范围**：Google Play 上架的 iGimbal 应用对应的隐私政策（英文版）
- **源文件**：`igimbal/privacy-policy-en.html`（iGimbal Google Play 主版本）

该脚本不涉及其他平台或其它协议文件的部署。

---

## 首次使用

1. **配置 EC2 密钥路径**  
   复制配置示例并编辑，填入你的 `.pem` 完整路径：
   ```bash
   cp .ec2-deploy.env.example .ec2-deploy.env
   nano .ec2-deploy.env   # 将 EC2_KEY_PATH 改为你的 .pem 路径
   ```

2. **（可选）设置密钥文件权限**  
   ```bash
   chmod 400 /path/to/your-key.pem
   ```

3. **执行部署**  
   ```bash
   ./deploy-privacy-to-ec2.sh
   ```

---

## 日常更新流程

1. 在本地修改 `igimbal/privacy-policy-en.html`（如更新日期、条款内容）。
2. 在项目根目录执行：
   ```bash
   ./deploy-privacy-to-ec2.sh
   ```
3. 部署成功后，在浏览器访问 **https://privacy.veryplace.net** 确认展示正确。

---

## 可配置项

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `EC2_KEY_PATH` | EC2 密钥（.pem）路径 | 需在 `.ec2-deploy.env` 中配置 |
| `EC2_HOST` | EC2 公网 IP | 3.137.52.189 |
| `EC2_USER` | SSH 用户名 | ubuntu |
| `PRIVACY_HTML` | 本地协议 HTML 路径 | 当前目录下 `igimbal/privacy-policy-en.html` |

可通过环境变量覆盖，例如：
```bash
EC2_HOST=1.2.3.4 ./deploy-privacy-to-ec2.sh
```

---

## 注意事项

- `.ec2-deploy.env` 已加入 `.gitignore`，不会提交密钥路径，请勿移除。
- 脚本通过 SCP 上传文件并在 EC2 上覆盖 `/var/www/html/privacy/index.html`，请确保该实例的 Nginx 已按隐私政策子站配置好。
