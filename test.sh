#配置，禁止进，允许出，允许回环网卡
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -i lo -j ACCEPT
#允许ping，不允许删了就行
iptables -A INPUT -p icmp -j ACCEPT
#允许ssh
iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
#允许ftp
iptables -A INPUT -p tcp -m tcp --dport 20 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 21 -j ACCEPT
#允许ftp被动接口范围，在ftp配置文件里可以设置
iptables -A INPUT -p tcp --dport 20000:30000 -j ACCEPT
#学习felix，把smtp设成本地
iptables -A INPUT -p tcp -m tcp --dport 25 -j ACCEPT -s 127.0.0.1
iptables -A INPUT -p tcp -m tcp --dport 25 -j REJECT
#允许DNS
iptables -A INPUT -p tcp -m tcp --dport 53 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 53 -j ACCEPT
#允许http和https
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
#允许状态检测，懒得解释
iptables -A INPUT -p all -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p all -m state --state INVALID,NEW -j DROP
 /etc/init.d/iptables save
