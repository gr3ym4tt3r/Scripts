#!/bin/bash

WHITE=$(echo -e "\e[0;37m")
NORMAL=$(echo -e "\e[0;39m")
YELLOW="\033[33m"
WHITEN=$(tput setaf 7 && tput bold)
REDBOLD=$(tput setaf 1 && tput bold)

f_range(){

printf $YELLOW
read -p "Please Enter The IP Range (192.168.1.1-254): "          V_RANGE

}

f_getvars(){

V_1=$(echo $V_RANGE | cut -d "." -f1)
V_2=$(echo $V_RANGE | cut -d "." -f2)
V_3=$(echo $V_RANGE | cut -d "." -f3)
V_4=$(echo $V_RANGE | cut -d "." -f4 | cut -d "-" -f1)
V_5=$(echo $V_RANGE | cut -d "-" -f2)


}

f_ping1(){

echo "$WHITEN ####################### $REDBOLD Running A Ping Sweep $WHITEN ################################"
#for ip in $(seq 1 254);do
for ip in $(seq $V_4 $V_5);do
     ping -c 1 $V_1.$V_2.$V_3.$ip | grep "bytes from" | cut -d " " -f 4 | cut -d ":" -f 1 | sort -n &
     echo -n $WHITEN
done
echo -n $WHITEN
sleep 0.2
echo

}

f_range
f_getvars
f_ping1
