#!/usr/bin/expect -f
# policy.szvip.vip 一键部署脚本
# 将根目录协议文件同步到服务器，并重载 Nginx
# 使用方法：./deploy.sh

set timeout 60
set server_ip   "8.135.238.203"
set server_user "root"
set server_pass "ZchTristan.123"
set remote_path "/var/www/policy"
set local_path  [file dirname [file normalize [info script]]]

puts "\n部署目标：$server_user@$server_ip:$remote_path"

# 1. 上传文件
puts "\n上传协议文件..."
spawn rsync -avz --progress \
    $local_path/privacy.html \
    $local_path/privacy-policy-cn.html \
    $local_path/privacy-policy-en.html \
    $local_path/user-agreement-cn.html \
    $local_path/user-agreement-en.html \
    $server_user@$server_ip:$remote_path/

expect {
    "password:" { send "$server_pass\r"; exp_continue }
    eof
}

# 2. 设置权限并重载 Nginx
puts "\n设置权限并重载 Nginx..."
spawn ssh $server_user@$server_ip \
    "chown -R nginx:nginx $remote_path && chmod -R 755 $remote_path && systemctl reload nginx && echo 'nginx reloaded'"

expect {
    "password:" { send "$server_pass\r"; exp_continue }
    eof
}

puts "\n部署完成！\n"
puts "  https://policy.szvip.vip/privacy.html"
puts "  https://policy.szvip.vip/privacy-policy-cn.html"
puts "  https://policy.szvip.vip/privacy-policy-en.html"
puts "  https://policy.szvip.vip/user-agreement-cn.html"
puts "  https://policy.szvip.vip/user-agreement-en.html\n"
