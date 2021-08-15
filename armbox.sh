#! /bin/bash
# By BlueSkyXN
#https://github.com/BlueSkyXN/SKY-BOX

#彩色
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}

#IPV.SH ipv4/6优先级调整一键脚本·下载
function ipvsh(){
wget -O "/root/ipv.sh" "https://cdn.jsdelivr.net/gh/BlueSkyXN/ChangeSource@master/ipv.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/ipv.sh"
chmod 777 "/root/ipv.sh"
blue "下载完成"
blue "输入 bash /root/ipv.sh 来运行"
}

#IPT.SH iptable一键脚本·下载
function iptsh(){
wget -O "/root/ipt.sh" "https://cdn.jsdelivr.net/gh/BlueSkyXN/ChangeSource@master/ipt.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/ipt.sh"
chmod 777 "/root/ipt.sh"
blue "下载完成"
blue "输入 bash /root/ipt.sh 来运行"
}

#Speedtest for Linux·下载
function speedtest-linux(){
wget -O "/root/speedtest" "https://cdn.jsdelivr.net/gh/BlueSkyXN/ChangeSource@master/speedtestarm" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/speedtest"
chmod 777 "/root/speedtest"
blue "下载完成"
blue "输入 /root/speedtest 来运行"
}

#获取本机IP
function getip(){
echo  
curl ip.p3terx.com
echo
}


#安装最新BBR内核·使用YUM
function bbrnew(){
wget -O "/root/bbr.sh" "https://cdn.jsdelivr.net/gh/BlueSkyXN/ChangeSource@master/bbr.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/bbr.sh"
chmod 777 "/root/bbr.sh"
blue "下载完成，开始运行"
bash "/root/bbr.sh"
blue "BBR内核安装结束，开始修复grub"
yum install -y grub
grub-mkconfig -o /boot/grub/grub.conf
yum install -y grub2
grub2-mkconfig -o /boot/grub2/grub.cfg
blue "修复grub完成，显示内核参数如下"
echo " =================================================="
yellow "当前正在使用的内核"
uname -a
echo " =================================================="
yellow "系统已经安装的全部内核"
rpm -qa | grep kernel
echo " =================================================="
yellow "可使用的内核列表"
awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg
echo " =================================================="
yellow "当前默认内核启动项"
echo
grub2-editenv list
echo " =================================================="
yellow "请自行重启后启动BBR加速"
echo " =================================================="

}


#启动BBR FQ算法
function bbrfq(){
remove_bbr_lotserver
	echo "net.core.default_qdisc=fq" >> /etc/sysctl.d/99-sysctl.conf
	echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.d/99-sysctl.conf
	sysctl --system
	echo -e "BBR+FQ修改成功，重启生效！"
}

#系统网络配置优化
function system-best(){
	sed -i '/net.ipv4.tcp_retries2/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_slow_start_after_idle/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_fastopen/d' /etc/sysctl.conf
	sed -i '/fs.file-max/d' /etc/sysctl.conf
	sed -i '/fs.inotify.max_user_instances/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_syncookies/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_fin_timeout/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_tw_reuse/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_syn_backlog/d' /etc/sysctl.conf
	sed -i '/net.ipv4.ip_local_port_range/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_tw_buckets/d' /etc/sysctl.conf
	sed -i '/net.ipv4.route.gc_timeout/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_synack_retries/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_syn_retries/d' /etc/sysctl.conf
	sed -i '/net.core.somaxconn/d' /etc/sysctl.conf
	sed -i '/net.core.netdev_max_backlog/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_timestamps/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_orphans/d' /etc/sysctl.conf
	sed -i '/net.ipv4.ip_forward/d' /etc/sysctl.conf

echo "net.ipv4.tcp_retries2 = 8
net.ipv4.tcp_slow_start_after_idle = 0
fs.file-max = 1000000
fs.inotify.max_user_instances = 8192
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_tw_reuse = 1
net.ipv4.ip_local_port_range = 1024 65000
net.ipv4.tcp_max_syn_backlog = 16384
net.ipv4.tcp_max_tw_buckets = 6000
net.ipv4.route.gc_timeout = 100
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_synack_retries = 1
net.core.somaxconn = 32768
net.core.netdev_max_backlog = 32768
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_max_orphans = 32768
# forward ipv4
#net.ipv4.ip_forward = 1">>/etc/sysctl.conf
sysctl -p
	echo "*               soft    nofile           1000000
*               hard    nofile          1000000">/etc/security/limits.conf
	echo "ulimit -SHn 1000000">>/etc/profile
	read -p "需要重启VPS后，才能生效系统优化配置，是否现在重启 ? [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
		echo -e "${Info} VPS 重启中..."
		reboot
	fi
}

#MT.SH 流媒体解锁测试
function mtsh(){
        #安装JQ
	if [ -e "/etc/redhat-release" ];then
	yum install epel-release -y -q > /dev/null;
	yum install jq -y -q > /dev/null;
	elif [[ $(cat /etc/os-release | grep '^ID=') =~ ubuntu ]] || [[ $(cat /etc/os-release | grep '^ID=') =~ debian ]];then
	apt-get update -y > /dev/null;
	apt-get install jq > /dev/null;
	else 
	echo -e "${Font_Red}请手动安装jq${Font_Suffix}";
	exit;
	fi

        jq -V > /dev/null 2>&1;
        if [ $? -ne 0 ];then
	echo -e "${Font_Red}请手动安装jq${Font_Suffix}";
	exit;
        fi

wget -O "/root/mt.sh" "https://cdn.jsdelivr.net/gh/BlueSkyXN/ChangeSource@master/mt.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/mt.sh"
chmod 777 "/root/mt.sh"
blue "下载完成"
blue "你也可以输入 bash /root/mt.sh 来手动运行"
bash /root/mt.sh
}

#Rclone官方原版&Fclone·下载
function clonesh(){
wget -O "/usr/bin/rclone" "https://cdn.jsdelivr.net/gh/BlueSkyXN/ChangeSource@master/rclonearm" --no-check-certificate -T 30 -t 5 -d
wget -O "/usr/bin/fclone" "https://cdn.jsdelivr.net/gh/BlueSkyXN/ChangeSource@master/fclonearm" --no-check-certificate -T 30 -t 5 -d
chmod +x "/usr/bin/rclone"
chmod +x "/usr/bin/fclone"
chmod 777 "/usr/bin/rclone"
chmod 777 "/usr/bin/fclone"
}

#ChangeSource Linux换源脚本·下载
function cssh(){
wget -O "/root/changesource.sh" "https://cdn.jsdelivr.net/gh/BlueSkyXN/ChangeSource@master/changesource.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/changesource.sh"
chmod 777 "/root/changesource.sh"
blue "下载完成"
echo
green "请自行输入下面命令切换对应源"
green " =================================================="
echo
green " bash changesource.sh 切换推荐源 "
green " bash changesource.sh cn  切换中科大源 "
green " bash changesource.sh aliyun 切换阿里源 "
green " bash changesource.sh 163 切换网易源 "
green " bash changesource.sh aws 切换AWS亚马逊云源 "
green " bash changesource.sh restore 还原默认源 "
}

#Besttrace 路由追踪·下载
function gettrace(){
wget -O "/root/besttrace" "https://cdn.jsdelivr.net/gh/BlueSkyXN/ChangeSource@master/besttracearm" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/besttrace"
chmod 777 "/root/besttrace"
blue "下载完成"
blue "输入 /root/besttrace 来运行"
}

#Lemonbench 综合测试
function Lemonbench(){
curl -fsL https://ilemonra.in/LemonBenchIntl | bash -s fast
}

#UNIXbench 综合测试
function UNIXbench(){
wget -O "/root/unixbench.sh" "https://cdn.jsdelivr.net/gh/BlueSkyXN/ChangeSource@master/unixbench.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/unixbench.sh"
chmod 777 "/root/unixbench.sh"
blue "下载完成"
bash "/root/unixbench.sh"
}

#三网Speedtest测速
function 3speed(){
bash <(curl -Lso- https://git.io/superspeed)
}

#Superbench 综合测试
function superbench(){
wget -O "/root/superbench.sh" "https://cdn.jsdelivr.net/gh/BlueSkyXN/ChangeSource@master/superbench.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/superbench.sh"
chmod 777 "/root/superbench.sh"
blue "下载完成"
bash "/root/superbench.sh"
}

#Memorytest 内存压力测试
function memorytest(){
yum install wget -y
yum groupinstall "Development Tools" -y
wget https://cdn.jsdelivr.net/gh/FunctionClub/Memtester@master/memtester.cpp
blue "下载完成"
gcc -l stdc++ memtester.cpp
./a.out
}

#NEZHA.SH哪吒面板/探针·下载
function nezha(){
wget -O "/root/nezha.sh" "https://cdn.jsdelivr.net/gh/BlueSkyXN/nezha@master/script/install.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/nezha.sh"
chmod 777 "/root/nezha.sh"
blue "你也可以输入 bash /root/nezha.sh 来手动运行"
blue "下载完成"
bash "/root/nezha.sh"
}


#Aria2 最强安装与管理脚本
function aria(){
wget -O "/root/aria2.sh" "https://cdn.jsdelivr.net/gh/P3TERX/aria2.sh@master/aria2.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/aria2.sh"
chmod 777 "/root/aria2.sh"
blue "你也可以输入 bash /root/aria2.sh 来手动运行"
blue "下载完成"
bash "/root/aria2.sh"
}

#MTP&TLS 一键脚本
function mtp(){
wget -O "/root/mtp.sh" "https://cdn.jsdelivr.net/gh/sunpma/mtp@master/mtproxy.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/mtp.sh"
chmod 777 "/root/mtp.sh"
blue "你也可以输入 bash /root/mtp.sh 来手动运行"
blue "下载完成"
bash "/root/mtp.sh"
}

#Rclone官方一键安装脚本
function rc(){
curl https://rclone.org/install.sh | sudo bash
}

#宝塔面板综合安装脚本
function btbox(){
wget -O "/root/btbox.sh" "https://cdn.jsdelivr.net/gh/BlueSkyXN/SKY-BOX@main/btbox.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/btbox.sh"
chmod 777 "/root/btbox.sh"
blue "下载完成"
bash "/root/btbox.sh"
}

#宝塔面板 自动磁盘挂载工具
function btdisk(){
wget -O auto_disk.sh http://download.bt.cn/tools/auto_disk.sh && bash auto_disk.sh
}

#Git 新版 安装
function yumgitsh(){
wget -O "/root/yum-git.sh" "https://cdn.jsdelivr.net/gh/BlueSkyXN/Yum-Git@main/yum-git.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/yum-git.sh"
chmod 777 "/root/yum-git.sh"
blue "下载完成"
blue "你也可以输入 bash /root/yum-git.sh 来手动运行"
bash "/root/yum-git.sh"
}

#BBR一键管理脚本
function tcpsh(){
wget -O "/root/tcp.sh" "https://cdn.jsdelivr.net/gh/BlueSkyXN/ChangeSource@master/tcp.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/tcp.sh"
chmod 777 "/root/tcp.sh"
blue "下载完成"
blue "你也可以输入 bash /root/tcp.sh 来手动运行"
bash "/root/tcp.sh"
}

#SWAP一键安装/卸载脚本
function swapsh(){
wget -O "/root/swap.sh" "https://cdn.jsdelivr.net/gh/BlueSkyXN/ChangeSource@master/swap.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/swap.sh"
chmod 777 "/root/swap.sh"
blue "下载完成"
blue "你也可以输入 bash /root/swap.sh 来手动运行"
bash "/root/swap.sh"
}

#Route-trace 路由追踪测试
function rtsh(){
wget -O "/root/rt.sh" "https://cdn.jsdelivr.net/gh/BlueSkyXN/Route-trace@main/rt.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/rt.sh"
chmod 777 "/root/rt.sh"
blue "下载完成"
blue "你也可以输入 bash /root/rt.sh 来手动运行"
bash "/root/rt.sh"
}

#Yabs.sh测试
function yabssh(){
wget -O "/root/yabs.sh" "https://cdn.jsdelivr.net/gh/BlueSkyXN/ChangeSource@master/yabs.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/yabs.sh"
chmod 777 "/root/yabs.sh"
blue "下载完成"
bash "/root/yabs.sh"
}

#Disk Test 硬盘&系统综合测试
function disktestsh(){
wget -O "/root/disktest.sh" "https://cdn.jsdelivr.net/gh/BlueSkyXN/ChangeSource@master/disktest.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/disktest.sh"
chmod 777 "/root/disktest.sh"
blue "下载完成"
bash "/root/disktest.sh"
}

#TubeCheck Google/Youtube CDN分配节点测试
function tubecheck(){
wget -O "/root/TubeCheck" "https://cdn.jsdelivr.net/gh/BlueSkyXN/ChangeSource@master/TubeCheck" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/TubeCheck"
chmod 777 "/root/TubeCheck"
blue "下载完成"
red "识别成无信息/NULL/未知等代表为默认的美国本土地区或者不可识别/无服务的中国大陆地区"
"/root/TubeCheck"
}

#甲骨文ARM U20 DD Debian 10 
function armddd10(){
red "默认密码blueskyxn"
curl -fLO https://cdn.jsdelivr.net/gh/bohanyang/debi@master/debi.sh
red "默认密码blueskyxn"
chmod a+rx debi.sh
red "默认密码blueskyxn"
./debi.sh --architecture arm64 --user root --password blueskyxn
red "默认密码blueskyxn"
shutdown -r now
}

#RegionRestrictionCheck 流媒体解锁测试
function RegionRestrictionCheck(){
bash <(curl -L -s https://cdn.jsdelivr.net/gh/lmc999/RegionRestrictionCheck@main/check.sh)
}

#F2B一键安装脚本
function f2bsh(){
red "卸载请 运行 wget https://cdn.jsdelivr.net/gh/FunctionClub/Fail2ban@master/uninstall.sh && bash uninstall.sh"
wget https://cdn.jsdelivr.net/gh/FunctionClub/Fail2ban@master/fail2ban.sh && bash fail2ban.sh 2>&1 | tee fail2ban.log
red "卸载请 运行 wget https://cdn.jsdelivr.net/gh/FunctionClub/Fail2ban@master/uninstall.sh && bash uninstall.sh"
}

#主菜单
function start_menu(){
    clear
    red " BlueSkyXN 综合工具箱 ARM Beta"
    red " 部分功能可能不行，请反馈，能用的已经标注" 
    green " FROM: https://github.com/BlueSkyXN/SKY-BOX "
    green " HELP: https://www.blueskyxn.com/202104/4465.html "
    green " USE:  wget -O box.sh https://cdn.jsdelivr.net/gh/BlueSkyXN/SKY-BOX@main/armbox.sh && chmod +x box.sh && clear && ./box.sh "
    yellow " =================================================="
    green " 1. IPV.SH ipv4/6优先级调整一键脚本·下载" 
    green " 2. IPT.SH iptable一键脚本"
    green " 3. SpeedTest-Linux 下载【确认适配】"
    green " 4. Rclone&Fclone·下载【确认适配】" 
    green " 5. ChangeSource Linux换源脚本·下载"
    green " 6. Besttrace 路由追踪·下载【确认适配】"
    green " 7. NEZHA.SH哪吒面板/探针【确认适配】"
    yellow " --------------------------------------------------"
    green " 11. 获取本机IP"
    green " 12. 安装最新BBR内核·使用YUM·仅支持CentOS" 
    green " 13. 启动BBR FQ算法【确认适配】"
    green " 14. 系统网络配置优化【确认适配】"
    green " 15. Git 新版 安装·仅支持CentOS"
    green " 16. 宝塔面板 自动磁盘挂载工具"
    green " 17. BBR一键管理脚本" 
    green " 18. SWAP一键安装/卸载脚本"
    green " 19. F2B一键安装脚本"
    yellow " --------------------------------------------------"
    green " 21. Superbench 综合测试"
    green " 22. MT.SH 流媒体解锁测试"
    green " 23. Lemonbench 综合测试"
    green " 24. UNIXbench 综合测试"
    green " 25. 三网Speedtest测速"
    green " 26. Memorytest 内存压力测试"
    green " 27. Route-trace 路由追踪测试"
    green " 28. YABS LINUX综合测试"
    green " 29. Disk Test 硬盘&系统综合测试"
    green " 210.TubeCheck Google/Youtube CDN分配节点测试"
    green " 211.RegionRestrictionCheck 流媒体解锁测试"
    yellow " --------------------------------------------------"
    green " 31. MTP&TLS 一键脚本"
    green " 32. Rclone官方一键安装脚本"
    green " 33. Aria2 最强安装与管理脚本"
   yellow " --------------------------------------------------"
    green " 99. 甲骨文ARM U20 DD Debian 10"
    green " 00. 宝塔面板综合安装脚本"
    green " =================================================="
    green " 0. 退出脚本"
    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           ipvsh
	;;
        2 )
           iptsh
	;;
        3 )
           speedtest-linux
	;;
        4 )
           clonesh
	;;
        5 )
           cssh
	;;
	6 )
           gettrace
	;;
	7 )
           nezha
	;;
	11 )
           getip
	;;
	12 )
           bbrnew
	;;
	13 )
           bbrfq
	;;
	14 )
           system-best
	;;
	15 )
           yumgitsh
	;;
	16 )
           btdisk
	;;
	17 )
           tcpsh
	;;
	18 )
           swapsh
	;;
	19 )
           f2bsh
	;;
	21 )
           superbench
	;;
	22 )
           mtsh
	;;
	23 )
           Lemonbench
	;;
	24 )
           UNIXbench
	;;
	25 )
           3speed
	;;
	26 )
           memorytest
	;;
	27 )
           rtsh
	;;
	28 )
           yabssh
	;;
	29 )
           disktestsh
	;;
	210 )
	   tubecheck
	;;
	211 )
	   RegionRestrictionCheck
	;;
	31 )
           mtp
	;;
	32 )
           rc
	;;
        33 )
           aria
	;;
	99 )
            armddd10
        ;;
	00 )
            btbox
        ;;
        0 )
            exit 1
        ;;
        * )
            clear
            red "请输入正确数字 !"
            start_menu
        ;;
    esac
}
start_menu "first"
