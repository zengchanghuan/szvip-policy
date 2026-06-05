#!/bin/bash
# policy.szvip.vip 海外版协议 一键部署脚本
# 使用方法：./deploy-foreign.sh

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
REMOTE_PATH="/var/www/policy"

echo -e "\n-- 海外版 -- 部署目标：${SERVER_USER}@${SERVER_IP}:${REMOTE_PATH}"

echo -e "\n确保远端目录存在..."
sshpass -e ssh -o StrictHostKeyChecking=no "${SERVER_USER}@${SERVER_IP}" "mkdir -p ${REMOTE_PATH}"

echo -e "\n上传协议文件..."
sshpass -e rsync -avz --progress \
    -e "ssh -o StrictHostKeyChecking=no" \
    "$LOCAL_PATH/privacy-policy-cn.html" \
    "$LOCAL_PATH/privacy-policy-en.html" \
    "$LOCAL_PATH/user-agreement-cn.html" \
    "$LOCAL_PATH/user-agreement-en.html" \
    "${SERVER_USER}@${SERVER_IP}:${REMOTE_PATH}/"

echo -e "\n设置权限并重载 Nginx..."
sshpass -e ssh -o StrictHostKeyChecking=no "${SERVER_USER}@${SERVER_IP}" \
    "chown -R nginx:nginx ${REMOTE_PATH} && chmod -R 755 ${REMOTE_PATH} && systemctl reload nginx && echo 'nginx reloaded'"

echo -e "\n部署完成！\n"
echo "  海外版中文隐私政策: https://policy.szvip.vip/privacy-policy-cn.html"
echo "  海外版英文隐私政策: https://policy.szvip.vip/privacy-policy-en.html"
echo "  海外版中文用户协议: https://policy.szvip.vip/user-agreement-cn.html"
echo "  海外版英文用户协议: https://policy.szvip.vip/user-agreement-en.html"
echo ""