#!/usr/bin/env bash
# 隐私政策一键部署到 https://privacy.veryplace.net
# 首次使用：将 .ec2-deploy.env.example 复制为 .ec2-deploy.env 并填写 EC2_KEY_PATH

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ---------- 配置（按需修改）----------
EC2_HOST="${EC2_HOST:-3.137.52.189}"
EC2_USER="${EC2_USER:-ubuntu}"
PRIVACY_HTML="${PRIVACY_HTML:-${SCRIPT_DIR}/privacy-policy-googleplay-en.html}"
REMOTE_PATH="/var/www/html/privacy/index.html"

# 密钥：优先用环境变量，其次用同目录下的 .ec2-deploy.env
if [[ -z "${EC2_KEY_PATH}" && -f "${SCRIPT_DIR}/.ec2-deploy.env" ]]; then
  source "${SCRIPT_DIR}/.ec2-deploy.env"
fi

# ---------- 检查 ----------
if [[ ! -f "$PRIVACY_HTML" ]]; then
  echo "错误: 找不到隐私政策文件: $PRIVACY_HTML"
  exit 1
fi

SSH_OPTS=()
if [[ -n "$EC2_KEY_PATH" ]]; then
  if [[ ! -f "$EC2_KEY_PATH" ]]; then
    echo "错误: 找不到密钥文件: $EC2_KEY_PATH"
    echo "请编辑 ${SCRIPT_DIR}/.ec2-deploy.env 填写正确的 EC2_KEY_PATH"
    exit 1
  fi
  SSH_OPTS=(-i "$EC2_KEY_PATH")
else
  echo "提示: 未设置 EC2_KEY_PATH，将尝试使用 SSH Agent。"
  echo "否则请: cp .ec2-deploy.env.example .ec2-deploy.env 并填写 EC2_KEY_PATH=..."
fi

REMOTE="${EC2_USER}@${EC2_HOST}"
TMP_FILE="privacy-policy-googleplay-en.html"

echo ">>> 上传 $PRIVACY_HTML 到 ${REMOTE} ..."
scp "${SSH_OPTS[@]}" "$PRIVACY_HTML" "${REMOTE}:~/${TMP_FILE}"

echo ">>> 在 EC2 上部署到 $REMOTE_PATH ..."
ssh "${SSH_OPTS[@]}" "$REMOTE" "sudo mv ~/${TMP_FILE} ${REMOTE_PATH} && sudo chown www-data:www-data ${REMOTE_PATH} && sudo chmod 644 ${REMOTE_PATH}"

echo ">>> 部署完成。请访问 https://privacy.veryplace.net 查看。"
