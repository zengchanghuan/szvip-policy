# 威尔派法律协议文档 (szvip-policy)

## 模块职责
本项目用于托管 KKGimbal 应用及其相关服务的隐私政策、用户协议等法律文档。

## 目录结构
- `privacy-policy-cn.html`: 隐私政策 (中文)
- `privacy-policy-en.html`: 隐私政策 (英文)
- `user-agreement-cn.html`: 用户协议 (中文)
- `user-agreement-en.html`: 用户协议 (英文)
- `nginx-policy.conf`: 协议文档专属 Nginx 配置 (policy.szvip.vip)
- `deploy-policy.sh`: 协议文档同步脚本

## 访问链接
- 隐私政策: https://policy.szvip.vip/privacy-policy-cn.html
- 用户协议: https://policy.szvip.vip/user-agreement-cn.html

## 更新流程
修改 HTML 文件后，运行 `./deploy-policy.sh` 同步到静态服务器即可。
