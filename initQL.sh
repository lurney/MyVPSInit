service iptables stop
#清除原有规则
iptables -F        #清除预设表filter中的所有规则链的规则
iptables -X        #清除预设表filter中使用者自定链中的规则
iptables -Z		#清空计数器
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
#设定预设规则：禁止进，禁止转发，允许出，允许回环网卡
iptables -P INPUT DROP          #注意，此命令执行完，远程SSH会掉线！！
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -A INPUT -i lo -j ACCEPT
#开启SSH端口
iptables -A INPUT -p tcp -m tcp --dport 16291 -j ACCEPT

# 开启Shadowsocks端口
# iptables -A INPUT -p tcp -m tcp --dport 3389 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 40000:41000 -j ACCEPT
#iptables -A INPUT -p udp -m udp --dport 40000:41000 -j ACCEPT
#允许DNS
iptables -A INPUT -p tcp -m tcp --dport 53 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 53 -j ACCEPT
#允许http和https
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
#允许ping，不允许删了就行
iptables -A INPUT -p icmp -j ACCEPT
#允许ftp
iptables -A INPUT -p tcp -m tcp --dport 20 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 21 -j ACCEPT
#允许ftp&Transmission被动接口范围，在ftp配置文件里可以设置
iptables -A INPUT -p tcp --dport 20000:30000 -j ACCEPT
#邮件服务器,开启25,110端口.
iptables -A INPUT -p tcp --dport 110 -j ACCEPT
iptables -A INPUT -p tcp --dport 25 -j ACCEPT
#开启Transmission管理端口
iptables -A INPUT -p tcp -m tcp --dport 9696 -j ACCEPT
#开启Seafile管理端口
#iptables -A INPUT -p tcp -m tcp --dport 8000 -j ACCEPT
#iptables -A INPUT -p tcp -m tcp --dport 8082 -j ACCEPT
#iptables -A INPUT -p tcp --dport 12001 -j ACCEPT
#iptables -A INPUT -p tcp --dport 10001 -j ACCEPT

#允许状态检测
iptables -A INPUT -p all -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p all -m state --state INVALID -j DROP

#保存修改
 /etc/init.d/iptables save
 service iptables restart
