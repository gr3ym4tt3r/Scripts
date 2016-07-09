#!/bin/bash
# Just a simple script that downloads a sites index.html, scrapes it for urls, and tries to resolve hosts and ip's


REGEX="grep -o '[A-Za-z0-9_\.-]*\.*cisco.com'"
HTTP="http://www."
COM="$DOM.com"

############ COLORZ ###################################
BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
PINK="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"
NORMAL="\033[0;39m"
WHITEN=$(echo -e "\e[0;37m")

f_geturl(){

printf $CYAN
read -p "Enter Domain (*.com): "    DOM    
    
}

f_getindex(){

wget $HTTP$DOM.com

printf "$WHITE ########################## $RED Scraping Index From $CYAN $HTTP$DOM.com $WHITE ########################"
echo
echo
echo
sleep 2

}

#f_geturis(){

#grep "href=" index.html | cut -d "/" -f3 | grep "$DOM\.com" | cut -d '"' -f1 | sort -u > $DOM.txt

#}

f_regex(){

grep -o '[A-Za-z0-9_\.-]*\.com' index.html | grep $DOM | sort -u > $DOM.txt

printf "$WHITE ######################### $RED Getting URL's $WHITE ########################"
echo

printf "$YELLOW"
echo
cat $DOM.txt
echo
echo

}

f_getips(){

for url in $(cat $DOM.txt);do
host $url | grep "has address" | cut -d " " -f4 >> ips.$DOM.txt
done

printf "$WHITE ####################### $RED Resolving IP's $WHITE ########################"
echo
echo
sort -u ips.$DOM.txt | awk '{print "\033[36m" $1,"\033[37m" $2}'

}

f_getalias(){

printf "$WHITE ######################## $RED Analyzing Redirects $WHITE ########################"
echo
printf $YELLOW
echo

for url in $(cat $DOM.txt);do
host $url | grep "alias" >> alias.$DOM.txt
done

sort -u alias.$DOM.txt | awk '{print "\033[33m" $1,"\033[31m" $2,$3,$4,$5,"\033[33m" $6}'
echo
echo
sleep 1

}

f_getmail(){

printf "$WHITE ####################### $RED Resolving Mail Servers $WHITE ########################"
echo
printf $YELLOW
echo

for url in $(cat $DOM.txt);do
host $url | grep "mail" >> mail.$DOM.txt
done

sort -u mail.$DOM.txt | awk '{print "\033[33m" $1,"\033[31m" $2,$3,$4,$5,"\033[33m" $6,$7}'
echo
echo
sleep 1

}

f_getawk(){

printf "$WHITE ####################### $RED Resolving IP's $WHITE ########################"
echo
echo

for url in $(cat $DOM.txt; cat alias.$DOM.txt; cat mail.$DOM.txt);do
host $url | grep 'has address' | awk '{print $1,$4}' >> ips.$DOM.txt
done

sort -u ips.$DOM.txt | awk '{print "\033[36m" $1,"\033[37m" $2}'

}

f_print(){

printf "$WHITE ########################## $RED Scraping Index From $CYAN $HTTP$DOM.com $WHITE ########################"
echo
echo
echo

printf "$WHITE ######################### $RED Getting URL's $WHITE ########################"
echo

printf "$YELLOW"
echo
cat $DOM.txt
echo
echo
sleep 3

printf "$WHITE ######################## $RED Analyzing Redirects $WHITE ########################"
echo

printf $YELLOW
echo
sort -u alias.$DOM.txt | awk '{print "\033[36m" $1,"\033[33m" $2,$3,$4,$5,"\033[36m" $6}'
echo
echo
sleep 3

printf "$WHITE ####################### $RED Resolving Mail Servers $WHITE ########################"
echo

printf $YELLOW
echo
sort -u mail.$DOM.txt | awk '{print "\033[36m" $1,"\033[33m" $2,$3,$4,$5,"\033[36m" $6,$7}'
echo
echo
sleep 3

printf "$WHITE ####################### $RED Resolving IP's $WHITE ########################"
echo
echo
sort -u ips.$DOM.txt | awk '{print "\033[36m" $1,"\033[37m" $2}'

}

f_cleanup(){

rm -rf index.html
rm -rf $DOM.txt
rm -rf alias.$DOM.txt
rm -rf mail.$DOM.txt
rm -rf ips.$DOM.txt

}

f_geturl
f_getindex
f_regex
f_getalias
f_getmail
f_getawk
#f_print
f_cleanup
#cat ips.$DOM.txt | sort -u | awk '{print "\033[36m" $1,"\033[37m" $2}'
