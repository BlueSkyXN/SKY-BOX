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



#宝塔面板 官方版·一键安装
function btnew(){
wget -O "/root/install.sh" "http://download.bt.cn/install/install_panel.sh" --no-check-certificate -T 30 -t 5 -d
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
curl -sSO https://download.fenhao.me/ltd/install/install_panel.sh && bash install_panel.sh
}

#莉塔面板·一键更新（安装后需要更新一下）
function lt-new(){
curl https://download.fenhao.me/ltd/install/update6.sh|bash
}

#莉塔面板·CentOS专用（安装后需要更新一下）
function ltc(){
wget -O install.sh https://download.fenhao.me/ltd/install/install_6.0.sh && sh install.sh
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
    green " 1. 宝塔面板 官方版·一键安装"
    green " 2. 宝塔面板 官方版·一键更新"
    green " 3. 宝塔面板 5.9开源免费版·一键安装"
    green " 4. 宝塔面板 Hostcli 破解版·一键安装·可能仅支持CentOS"
    green " 5. 宝塔面板 Hostcli 破解版·一键转移"
    green " 6. 莉塔面板·一键安装（安装后需要更新一下）"
    green " 7. 莉塔面板·一键更新（安装后需要更新一下）"
    green " 8. 莉塔面板·CentOS专用（安装后需要更新一下）"
    green " =================================================="
    green " 0. 退出脚本"
    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in

	1 )
           btnew
	;;
	2 )
           btrenew
	;;
	3 )
           btold
	;;
	4 )
           bthostcli
	;;
	5 )
           bthostcli-new
	;;
	6 )
           lt
	;;
	7 )
           lt-new
	;;
	8 )
           ltc
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
