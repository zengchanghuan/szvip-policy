#!/usr/bin/expect -f
# iGimbal Google Play 协议站点独立部署脚本
# 仅将仓库下 igimbal/ 子目录中的协议文件同步到 dualistic-polarities.com
# 大陆版协议（仓库根目录）不会被部署到本域名，需另行处理。
# 使用方法：./deploy-policy.sh

set timeout 300
set server_ip "8.135.238.203"
set server_user "root"
set server_pass "ZchTristan.123"
set policy_remote_path "/var/www/dualistic-polarities.com"
set local_path "/Users/zengchanghuan/Desktop/workspace/szvip-policy/igimbal"

puts "\n🚀 iGimbal 协议站点部署脚本"
puts "本地源目录：$local_path/"
puts "目标域名：dualistic-polarities.com\n"

# 1. 上传协议文件（仅 igimbal/ 下的内容）
puts "📦 正在上传 igimbal/ 下的协议文件到 $policy_remote_path...\n"
spawn rsync -avz --progress --delete \
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

puts "\n✅ iGimbal 协议站点部署完成！\n"
puts "🌐 访问链接（iGimbal · Google Play）："
puts "  英文隐私政策（建议填 Play Console）：https://dualistic-polarities.com/privacy-policy-en.html"
puts "  中文隐私政策：https://dualistic-polarities.com/privacy-policy-cn.html\n"
