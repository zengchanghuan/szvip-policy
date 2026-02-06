#!/usr/bin/expect -f
# 协议站点独立部署脚本
# 只部署 policy/ 目录下的文件到 policy.szvip.vip
# 不会影响主站 szvip.vip
# 使用方法：./deploy-policy.sh

set timeout 300
set server_ip "8.135.238.203"
set server_user "root"
set server_pass "ZchTristan.123"
set policy_remote_path "/var/www/policy"
set local_path "/Users/zengchanghuan/Desktop/workspace/szvip-web"

puts "\n🚀 协议站点独立部署脚本"
puts "目标：policy.szvip.vip\n"

# 1. 上传协议文件
puts "📦 正在上传协议文件到 $policy_remote_path...\n"
spawn rsync -avz --progress --delete \
    --exclude=backup/ \
    --exclude=*.md \
    $local_path/policy/ \
    $server_user@$server_ip:$policy_remote_path/

expect {
    "password:" {
        send "$server_pass\r"
        exp_continue
    }
    eof
}

# 2. 设置权限并重载 Nginx
puts "\n🔄 设置服务器权限并重载 Nginx...\n"
spawn ssh $server_user@$server_ip "chown -R nginx:nginx $policy_remote_path && chmod -R 755 $policy_remote_path && systemctl reload nginx"
expect {
    "password:" {
        send "$server_pass\r"
    }
}
expect eof

puts "\n✅ 协议站点部署完成！\n"
puts "🌐 访问链接："
puts "  中文用户协议：https://policy.szvip.vip/user-agreement-cn.html"
puts "  英文用户协议：https://policy.szvip.vip/user-agreement-en.html"
puts "  中文隐私政策：https://policy.szvip.vip/privacy-policy-cn.html"
puts "  英文隐私政策：https://policy.szvip.vip/privacy-policy-en.html\n"
