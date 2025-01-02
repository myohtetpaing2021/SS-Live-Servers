#!/bin/bash

plain='\033[0m'

#စာလုံးအရောင်များ(Server Message)
red='\e[31m'    #အနီရောင်
yellow='\e[33m' #အဝါရောင်
gray='\e[90m'   #မီးခိုးရောင်
green='\e[92m'  #အစိမ်းရောင်
blue='\e[94m'   #အပြာရောင်
magenta='\e[95m'#ပန်းခရမ်းရောင်
cyan='\e[96m'   #စိမ်းပြာရောင်
none='\e[0m'    #အရောင်မရှိ

#SSH USER LIMIT သတ်မှတ်ရန်
#sshlimiter="300"

#ရက်ကန့်သက်ရန်(Qwiklab အတွက်မို့ 2-DAY ပုံသေထားရပါသည်)
#dias="2"
# $1: username, $2: password, $3: limit, $4: day, $5: message, $6: token

# check root
[[ $EUID -ne 0 ]] && echo -e "${red}Error: ${plain} You must use root user to run this script!\n" && exit 1

if [[ -n $6 ]] && [[ $(($(date +%s) - $6)) -lt 120 ]] && [[ $(($(date +%s) - $6)) -ge 0 ]]; then

sed -i 's/#\?AllowTcpForwarding .*/AllowTcpForwarding yes/' /etc/ssh/sshd_config && sed -i 's/#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config && sed -i 's/#\?Banner .*/Banner \/etc\/ssh\/gcp_ssb/' /etc/ssh/sshd_config && /etc/init.d/ssh restart;
echo "$5" | tee /etc/ssh/gcp_ssb >/dev/null
sizepass=$(echo ${#2})
[[ $sizepass -lt 3 ]] && {
	echo -e "\n${cor1}Short password!, use at least 3 characters${scor}\n"
	exit 1
}
final=$(date "+%Y-%m-%d" -d "+$4 days")
gui=$(date "+%d/%m/%Y" -d "+$4 days")
pass=$(perl -e 'print crypt($ARGV[0], "password")' $2)
useradd -e $final -M -s /bin/false -p $pass $1 >/dev/null
echo "$2" >/etc/$1
echo "$1:$2" | chpasswd
echo "$1 $3" >>/root/usuarios.db
IP=$(wget -qO- ipv4.icanhazip.com)
echo ""
echo -e "\033[1;32m===================================="
echo -e "\033[1;32m   🌺ㅤONLY/:FORYOU&ALLㅤ🌺  " 
echo -e "\033[1;32m===================================="
echo ""
echo -e "\033[1;37m◈─────⪧ SSH ACCOUNT ⪦─────◈"
echo ""
echo -e "\033[1;32m◈ Host / IP   :⪧  \033[1;31m$IP"
echo -e "\033[1;32m◈ Port        :⪧  \033[1;31m22"
echo -e "\033[1;32m◈ Username    :⪧  \033[1;31m$1"
echo -e "\033[1;32m◈ Password    :⪧  \033[1;31m$2"
echo -e "\033[1;32m◈ Login Limit :⪧  \033[1;31m$3"
echo -e "\033[1;32m◈ Expire Date :⪧  \033[1;31m$gui"
echo ""
echo -e "\033[1;37m◈────⪧ ✿ ✿ S▪S▪B ✿ ✿ ⪦────◈"
echo ""

else
echo -e "${red}Token is invalid or expired. Contact the developer https://t.me/shayshayblack for more information.${plain}"
fi

echo ""
echo -e "${yellow}------------------------------------${plain}"
printf "Developed the script by \n"
echo -e "${yellow}------------------------------------${plain}"
echo ""

echo -e "${yellow}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ ${plain}"
echo -e "${cyan} ____    ____    ____  								 ${plain}"
echo -e "${cyan}/ ___|  / ___|  | __ ) 								 ${plain}"
echo -e "${cyan}\___ \  \___ \  |  _ \ 								 ${plain}"
echo -e "${cyan} ___) |  ___) | | |_) |								 ${plain}"
echo -e "${cyan}|____/  |____/  |____/								 ${plain}"
echo -e "${green}Contact the developer https://t.me/shayshayblack for more information              ${plain}"
echo -e "${yellow}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ ${plain}"

echo -e "${cyan}i Am SSB 😎 ${plain}"
