#! /bin/bash
# By BlueSkyXN

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
wget -O "/root/ipv.sh" "https://raw.githubusercontent.com/BlueSkyXN/ChangeSource/master/ipv.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/ipv.sh"
chmod 777 "/root/ipv.sh"
blue "下载完成"
blue "输入 bash /root/ipv.sh 来运行"
}

#IPT.SH iptable一键脚本·下载
function iptsh(){
wget -O "/root/ipt.sh" "https://raw.githubusercontent.com/BlueSkyXN/ChangeSource/master/ipt.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/ipt.sh"
chmod 777 "/root/ipt.sh"
blue "下载完成"
blue "输入 bash /root/ipt.sh 来运行"
}

#Speedtest for Linux·下载
function speedtest-linux(){
wget -O "/root/speedtest" "https://raw.githubusercontent.com/BlueSkyXN/ChangeSource/master/speedtest" --no-check-certificate -T 30 -t 5 -d
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
wget -O "/root/bbr.sh" "https://raw.githubusercontent.com/BlueSkyXN/ChangeSource/master/bbr.sh" --no-check-certificate -T 30 -t 5 -d
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

wget -O "/root/mt.sh" "https://raw.githubusercontent.com/BlueSkyXN/ChangeSource/master/mt.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/mt.sh"
chmod 777 "/root/mt.sh"
blue "下载完成"
blue "你也可以输入 bash /root/mt.sh 来手动运行"
bash /root/mt.sh
}

#Rclone&Fclone·下载
function clonesh(){
wget -O "/usr/bin/rclone" "https://raw.githubusercontent.com/BlueSkyXN/RcloneX/master/rclone" --no-check-certificate -T 30 -t 5 -d
wget -O "/usr/bin/fclone" "https://raw.githubusercontent.com/BlueSkyXN/RcloneX/master/fclone" --no-check-certificate -T 30 -t 5 -d
chmod +x "/usr/bin/rclone"
chmod +x "/usr/bin/fclone"
chmod 777 "/usr/bin/rclone"
chmod 777 "/usr/bin/fclone"
}

#ChangeSource Linux换源脚本·下载
function cssh(){
wget -O "/root/changesource.sh" "https://raw.githubusercontent.com/BlueSkyXN/ChangeSource/master/changesource.sh" --no-check-certificate -T 30 -t 5 -d
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
wget -O "/root/besttrace" "https://raw.githubusercontent.com/BlueSkyXN/ChangeSource/master/besttrace" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/besttrace"
chmod 777 "/root/besttrace"
blue "下载完成"
blue "输入 bash /root/besttrace 来运行"
}

#Lemonbench 综合测试
function Lemonbench(){
curl -fsL https://ilemonra.in/LemonBenchIntl | bash -s fast
}

#UNIXbench 综合测试
function UNIXbench(){
wget -O "/root/unixbench.sh" "https://raw.githubusercontent.com/BlueSkyXN/ChangeSource/master/unixbench.sh" --no-check-certificate -T 30 -t 5 -d
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
wget -O "/root/superbench.sh" "https://raw.githubusercontent.com/BlueSkyXN/ChangeSource/master/superbench.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/superbench.sh"
chmod 777 "/root/superbench.sh"
blue "下载完成"
bash "/root/superbench.sh"
}

#Memorytest 内存压力测试
function memorytest(){
yum install wget -y
yum groupinstall "Development Tools" -y
wget https://raw.githubusercontent.com/FunctionClub/Memtester/master/memtester.cpp
blue "下载完成"
gcc -l stdc++ memtester.cpp
./a.out
}

#NEZHA.SH哪吒面板/探针·下载
function nezha(){
wget -O "/root/nezha.sh" "https://raw.githubusercontent.com/naiba/nezha/master/script/install.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/nezha.sh"
chmod 777 "/root/nezha.sh"
blue "你也可以输入 bash /root/nezha.sh 来手动运行"
blue "下载完成"
bash "/root/nezha.sh"
}

#Aria2 最强安装与管理脚本
function aria(){
wget -O "/root/aria2.sh" "https://raw.githubusercontent.com/P3TERX/aria2.sh/master/aria2.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/aria2.sh"
chmod 777 "/root/aria2.sh"
blue "你也可以输入 bash /root/aria2.sh 来手动运行"
blue "下载完成"
bash "/root/aria2.sh"
}

#MTP&TLS 一键脚本
function mtp(){
wget -O "/root/mtp.sh" "https://raw.githubusercontent.com/sunpma/mtp/master/mtproxy.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/mtp.sh"
chmod 777 "/root/mtp.sh"
blue "你也可以输入 bash /root/mtp.sh 来手动运行"
blue "下载完成"
bash "/root/mtp.sh"
}

#V2UI 一键脚本
function v2ui(){
echo
red "根据相关法律法规，本脚本不提供直接安装"
echo
blue " 请自行输入 bash <(curl -Ls https://blog.sprov.xyz/v2-ui.sh) 来手动运行"
echo
}

#宝塔面板 官方版·一键安装
function btnew(){
wget -O "/root/install.sh" "http://download.bt.cn/install/install_6.0.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/install.sh"
chmod 777 "/root/install.sh"
blue "下载完成"
bash "/root/install.sh"
}

#宝塔面板 官方版·一键更新
function btrenew(){
curl http://download.bt.cn/install/update6.sh|bash
}

#宝塔面板 5.9开源免费版·一键安装
function btold(){
wget -O "/root/install.sh" "http://download.bt.cn/install/install.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/install.sh"
chmod 777 "/root/install.sh"
blue "下载完成"
bash "/root/install.sh"
}

#宝塔面板 Hostcli 破解版·一键安装
function bthostcli(){
wget -O "/root/install.sh" "http://download.hostcli.com/install/install_6.0.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/install.sh"
chmod 777 "/root/install.sh"
blue "下载完成"
bash "/root/install.sh"
}

#宝塔面板 Hostcli 破解版·一键转移
function bthostcli-new(){
wget -O "/root/update7.sh" "http://download.hostcli.com/install/update7.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/update7.sh"
chmod 777 "/root/update7.sh"
blue "下载完成"
bash "/root/update7.sh"
}

#莉塔面板·一键安装（安装后需要更新一下）
function lt(){
wget -O install.sh https://download.fenhao.me/ltd/install/install_6.0.sh && sh install.sh
}

#莉塔面板·一键更新（安装后需要更新一下）
function lt-new(){
curl https://download.fenhao.me/ltd/install/update6.sh|bash
}

#宝塔面板 自动磁盘挂载工具
function btdisk(){
wget -O auto_disk.sh http://download.bt.cn/tools/auto_disk.sh && bash auto_disk.sh
}

#Git 新版 安装
function yumgitsh(){
wget -O "/root/yum-git.sh" "https://raw.githubusercontent.com/BlueSkyXN/Yum-Git/main/yum-git.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/yum-git.sh"
chmod 777 "/root/yum-git.sh"
blue "下载完成"
blue "你也可以输入 bash /root/yum-git.sh 来手动运行"
bash "/root/yum-git.sh"
}

#BBR管理脚本
function tcpsh(){
wget -O "/root/tcp.sh" "https://raw.githubusercontent.com/BlueSkyXN/ChangeSource/master/tcp.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/tcp.sh"
chmod 777 "/root/tcp.sh"
blue "下载完成"
blue "你也可以输入 bash /root/tcp.sh 来手动运行"
bash "/root/tcp.sh"
}



#主菜单
function start_menu(){
    clear
    red " BlueSkyXN  综合工具箱" 
    red " CentOS·YUM Supported ONLY" 
    green " https://github.com/BlueSkyXN/SKY-BOX "
    green " https://www.blueskyxn.com/202104/4465.html "
    yellow " =================================================="
    green " 1. IPV.SH ipv4/6优先级调整一键脚本·下载" 
    green " 2. IPT.SH iptable一键脚本"
    green " 3. SpeedTest-Linux 下载"
    green " 4. Rclone&Fclone·下载" 
    green " 5. ChangeSource Linux换源脚本·下载"
    green " 6. Besttrace 路由追踪·下载"
    green " 7. NEZHA.SH哪吒面板/探针·下载"
    yellow " --------------------------------------------------"
    green " 11. 获取本机IP"
    green " 12. 安装最新BBR内核·使用YUM" 
    green " 13. 启动BBR FQ算法"
    green " 14. 系统网络配置优化"
    green " 15. Git 新版 安装"
    green " 16. 宝塔面板 自动磁盘挂载工具"
    green " 17. BBR管理脚本" 
    yellow " --------------------------------------------------"
    green " 21. Superbench 综合测试"
    green " 22. MT.SH 流媒体解锁测试"
    green " 23. Lemonbench 综合测试"
    green " 24. UNIXbench 综合测试"
    green " 25. 三网Speedtest测速"
    green " 26. Memorytest 内存压力测试"
    yellow " --------------------------------------------------"
    green " 31. MTP&TLS 一键脚本"
    green " 32. V2UI 一键脚本"
    green " 33. Aria2 最强安装与管理脚本"
    yellow " --------------------------------------------------"
    green " 41. 宝塔面板 官方版·一键安装"
    green " 42. 宝塔面板 官方版·一键更新"
    green " 43. 宝塔面板 5.9开源免费版·一键安装"
    green " 44. 宝塔面板 Hostcli 破解版·一键安装"
    green " 45. 宝塔面板 Hostcli 破解版·一键转移"
    green " 46. 莉塔面板·一键安装（安装后需要更新一下）"
    green " 47. 莉塔面板·一键更新（安装后需要更新一下）"
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
	31 )
           mtp
	;;
	32 )
           v2ui
	;;
        33 )
           aria
	;;
	41 )
           btnew
	;;
	42 )
           btrenew
	;;
	43 )
           btold
	;;
	44 )
           bthostcli
	;;
	45 )
           bthostcli-new
	;;
	46 )
           lt
	;;
	47 )
           lt-new
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
