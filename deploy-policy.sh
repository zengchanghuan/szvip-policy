#!/usr/bin/expect -f
# 协议站点独立部署脚本
# 只部署 policy/ 目录下的文件到 dualistic-polarities.com
# 不会影响主站 szvip.vip
# 使用方法：./deploy-policy.sh

set timeout 300
set server_ip "8.135.238.203"
set server_user "root"
set server_pass "ZchTristan.123"
set policy_remote_path "/var/www/dualistic-polarities.com"
set local_path "/Users/zengchanghuan/Desktop/workspace/szvip-policy"

puts "\n🚀 协议站点独立部署脚本"
puts "目标：dualistic-polarities.com\n"

# 1. 上传协议文件
puts "📦 正在上传协议文件到 $policy_remote_path...\n"
spawn rsync -avz --progress --delete \
    --exclude=backup/ \
    --exclude=*.md \
    --exclude=.* \
    --exclude=deploy*.sh \
    $local_path/ \
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
        exp_continue
    }
    eof
}

puts "\n✅ 协议站点部署完成！\n"
puts "🌐 访问链接："
puts "  【中国大陆版】"
puts "  中文隐私政策：https://dualistic-polarities.com/privacy-policy-cn.html"
puts "  英文隐私政策：https://dualistic-polarities.com/privacy-policy-en.html"
puts "  中文用户协议：https://dualistic-polarities.com/user-agreement-cn.html"
puts "  英文用户协议：https://dualistic-polarities.com/user-agreement-en.html"
puts "\n  【Google Play 版】"
puts "  中文隐私政策：https://dualistic-polarities.com/privacy-policy-googleplay-cn.html"
puts "  英文隐私政策：https://dualistic-polarities.com/privacy-policy-googleplay-en.html\n"
