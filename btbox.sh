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



#宝塔面板 官方版  v7.5.2
#一键安装
#CentOS
function btof1(){
yum install -y wget && wget -O install.sh http://download.bt.cn/install/install_6.0.sh && sh install.sh
}
#Ubuntu&Deepin
function btof2(){
wget -O install.sh http://download.bt.cn/install/install-ubuntu_6.0.sh && sudo bash install.sh
}
#Python3通用版
function btof3(){
curl -sSO http://download.bt.cn/install/install_panel.sh && bash install_panel.sh
}
#升级与更新
function btof4(){
curl http://download.bt.cn/install/update6.sh|bash
}

#宝塔面板 Hostcli 净化版 v7.4.5
#一键安装·Centos
function btcli1(){
yum install -y wget && wget -O install.sh http://download.hostcli.com/install/install_6.0.sh && sh install.sh
}
#一键转移/升级
function btcli2(){
wget -O /home/update7.sh http://download.hostcli.com/install/update7.sh && bash /home/update7.sh
}

#宝塔面板 Fenhao 开心版 v7.5.2
#CentOS
function btfh1(){
yum install -y wget && wget -O install.sh https://download.fenhao.me/ltd/install/install_6.0.sh && sh install.sh
}
#Ubuntu&Deepin
function btfh2(){
wget -O install.sh https://download.fenhao.me/ltd/install/install-ubuntu_6.0.sh && sudo bash install.sh
}
#Python3通用版
function btfh3(){
curl -sSO https://download.fenhao.me/ltd/install/install_panel.sh && bash install_panel.sh
}
#升级与更新
function btfh4(){
curl -sSO https://download.fenhao.me/ltd/install/install_panel.sh && bash install_panel.sh
}
#ARM 定制版
function btfh5(){
curl -sSO https://download.seele.wang/ltd/install/arm/install_panel.sh && bash install_panel.sh
}
#升级与更新ARM定制版
function btfh6(){
wget -O updatearm.sh https://download.seele.wang/ltd/install/arm/updatearm.sh && bash updatearm.sh
}

#主菜单
function start_menu(){
    clear
    red " BlueSkyXN 综合工具箱 Linux Supported ONLY" 
    red " 宝塔面板综合安装脚本合集" 
    green " FROM: https://github.com/BlueSkyXN/SKY-BOX "
    green " HELP: https://www.blueskyxn.com/202104/4465.html "
    green " USE:  wget -O btbox.sh https://raw.githubusercontent.com/BlueSkyXN/SKY-BOX/main/btbox.sh && chmod +x btbox.sh && clear && ./btbox.sh "
    yellow " =================================================="
    red "宝塔面板 官方版 v7.5.2"
    green " 11. CentOS"
    green " 12. Ubuntu&Deepin"
    green " 13. Python3通用版"
    green " 14. 升级与更新"
    red "宝塔面板 Hostcli 净化版 v7.4.5"
    green " 21. 一键安装·Centos"
    green " 22. 一键转移/升级"
    red "宝塔面板 Fenhao 开心版 v7.5.2"
    green " 31. CentOS"
    green " 32. Ubuntu&Deepin"
    green " 33. Python3通用版"
    green " 34. 升级与更新"
    green " 35. ARM 定制版"
    green " 36. 升级与更新ARM定制版【请先卸载NGINX等运行环境和全部插件】"
    green " =================================================="
    green " 0. 退出脚本"
    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in

	11 )
           btof1
	;;
	12 )
           btof2
	;;
	13 )
           btof3
	;;
	14 )
           btof4
	;;
	21 )
           btcli1
	;;
	22 )
           btcli2
	;;
	31 )
           btfh1
	;;
	32 )
           btfh2
	;;
	33 )
           btfh3
	;;
	34 )
           btfh4
	;;
	35 )
           btfh5
	;;
	36 )
           btfh6
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
