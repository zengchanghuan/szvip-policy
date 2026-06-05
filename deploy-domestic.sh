#!/bin/bash
# szvip.vip 国内隐私政策 一键部署脚本
# 使用方法：./deploy-domestic.sh

# 读取密码配置
LOCAL_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$LOCAL_PATH/.deploy.env" ]; then
    source "$LOCAL_PATH/.deploy.env"
else
    echo "错误：找不到 .deploy.env 文件，请先配置 SERVER_PASS"
    exit 1
fi

export SSHPASS="$SERVER_PASS"
SERVER_IP="8.135.238.203"
SERVER_USER="root"
REMOTE_PATH="/var/www/szvip"

echo -e "\n-- 国内版 -- 部署目标：${SERVER_USER}@${SERVER_IP}:${REMOTE_PATH}"

echo -e "\n上传协议文件..."
sshpass -e rsync -avz --progress \
    -e "ssh -o StrictHostKeyChecking=no" \
    "$LOCAL_PATH/privacy.html" \
    "${SERVER_USER}@${SERVER_IP}:${REMOTE_PATH}/"

echo -e "\n设置权限并重载 Nginx..."
sshpass -e ssh -o StrictHostKeyChecking=no "${SERVER_USER}@${SERVER_IP}" \
    "chown -R nginx:nginx ${REMOTE_PATH} && chmod -R 755 ${REMOTE_PATH} && systemctl reload nginx && echo 'nginx reloaded'"

echo -e "\n部署完成！\n  国内版隐私政策: https://szvip.vip/privacy.html\n"