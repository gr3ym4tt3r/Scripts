#!/bin/bash
# DNS Enumeration Script Based on the Passive Recon-DNS Enum Section of the PWK Course
# This Script Assumes That You Have a Directory named /usr/share/wordlists 
# And in that directory is a file named dnsmap.txt and also the seclists folder 
# With the Discovery/DNS folder and the folders contents inside
#
# Without the above, it will still work if you choose to use a custom wordlist

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

f_dom(){

printf $YELLOW
read -p "What domain are we enumerating?: "       COM
DOM=$(echo $COM | awk -F "." '{print $1}')

}

f_ns(){

printf "$WHITE ####################################### $RED Getting Nameservers For $CYAN $COM $WHITE ###################### $NORMAL"
printf $YELLOW
echo

host -t ns $COM
printf $NORMAL
sleep 2
echo

}

f_mx(){

printf "$WHITE ####################################### $RED Getting Mailservers For $CYAN $COM $WHITE ###################### $NORMAL"
printf $YELLOW
echo

host -t mx $COM
printf $NORMAL
sleep 2
echo

}

f_wordlist(){

printf "$WHITE ####################################### $RED Select Wordlist for Bruteforce DNS Enumeration $WHITE ###################### $NORMAL"
printf $CYAN
echo

select menusel in "dnsmap.txt (17576)" "deepmagic.com_top500prefixes.txt" "deepmagic.com_top50kprefixes.txt" "fierce_hostlist.txt (2280)" "namelist.txt (1907)" "sorted_knock_dnsrecon_fierce_recon-ng.txt (102598)" "subdomains-top1mil-110000.txt" "subdomains-top1mil-20000.txt" "subdomains-top1mil-5000.txt" "custom wordlist"; do

printf $YELLOW
echo

case $menusel in
    "dnsmap.txt (17576)")
        echo -e "Using dnsmap.txt as ur wordlist"
        V_WORDLIST="/usr/share/wordlists/dnsmap.txt" ;;

    "deepmagic.com_top500prefixes.txt")
        echo -e "Using deepmagic.com_top500prefixes.txt as ur wordlist"
        V_WORDLIST="/usr/share/wordlists/seclists/Discovery/DNS/deepmagic.com_top500prefixes.txt" ;;

    "deepmagic.com_top50kprefixes.txt")
        echo -e "Using deepmagic.com_top50kprefixes.txt as ur wordlist"
        V_WORDLIST="/usr/share/wordlists/seclists/Discovery/DNS/deepmagic.com_top50kprefixes.txt" ;;

    "fierce_hostlist.txt (2280)")
        echo -e "Using fierce_hostlist.txt as ur wordlist"
        V_WORDLIST="/usr/share/wordlists/seclists/Discovery/DNS/fierce_hostlist.txt" ;;

    "namelist.txt (1907)")
        echo -e "Using namelist.txt as ur wordlist"
        V_WORDLIST="/usr/share/wordlists/seclists/Discovery/DNS/namelist.txt" ;;

    "sorted_knock_dnsrecon_fierce_recon-ng.txt (102598)")
        echo -e "Using sorted_knock_dnsrecon_fierce_recon-ng.txt as ur wordlist"
        V_WORDLIST="/usr/share/wordlists/seclists/Discovery/DNS/sorted_knock_dnsrecon_fierce_recon-ng.txt" ;;

    "subdomains-top1mil-110000.txt")
        echo -e "Using subdomains-top1mil-110000.txt as ur wordlist"
        V_WORDLIST="/usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1mil-110000.txt" ;;

    "subdomains-top1mil-20000.txt")
        echo -e "Using subdomains-top1mil-20000.txt as ur wordlist"
        V_WORDLIST="/usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1mil-20000.txt" ;;

    "subdomains-top1mil-5000.txt")
        echo -e "Using subdomains-top1mil-5000.txt as ur wordlist"
        V_WORDLIST="/usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1mil-5000.txt" ;;

    "custom wordlist")
        printf $RED
        read -p "Please Enter The Path To Your Custom List: "       V_CLIST
        printf $YELLOW
        echo -e "Using $V_CLIST as ur wordlist"
        V_WORDLIST=$V_CLIST
esac

break

done

printf $CYAN
echo "Wordlist = $V_WORDLIST"
printf $NORMAL
sleep 2
echo

}

f_forward(){

printf "$WHITE ####################################### $RED Performing Forward Lookup (Brute Force) on $YELLOW$COM $RED using $CYAN$V_WORDLIST $WHITE ###################### $NORMAL"
echo

for name in $(cat $V_WORDLIST);do host $name.$COM | grep "has address" | cut -d " " -f1,4;done > /tmp/dnsforward.txt
cat /tmp/dnsforward.txt | awk '{print "\033[33m" $1,"\033[37m" $2}'
sleep 2
echo

}

f_reverse(){

printf "$WHITE ####################################### $RED Performing Reverse Lookup on $YELLOW$COM $WHITE ###################### $NORMAL"
echo

V_SUBD=$(cat /tmp/dnsforward.txt | awk '{print $2}' | cut -d "." -f1,2,3 | head -n1)
V_MIN=$(cat /tmp/dnsforward.txt | awk '{print $2}' | cut -d "." -f4 | sort | head -n1)
V_MAX=$(cat /tmp/dnsforward.txt | awk '{print $2}' | cut -d "." -f4 | sort | tail -n1)

for ip in $(seq $V_MIN $V_MAX);do
     host $V_SUBD.$ip | grep "$DOM" | awk '{print "\033[37m" $1,"\033[33m" $5}'
done

rm -rf /tmp/dnsforward.txt
sleep 2
echo

}

f_transfer(){

printf "$WHITE ####################################### $RED Attempting Zone Transfer on $YELLOW$COM $WHITE ###################### $YELLOW"
echo
echo

for server in $(host -t ns $COM | cut -d " " -f4);do
     host -l $COM $server | grep "has address" | awk '{print "\033[33m" $1,"\033[37m" $4}'
done

}
f_dom
f_ns
f_mx
f_wordlist
f_forward 
f_reverse
f_transfer
printf "$WHITE ####################################### $RED DNS Enumeration of $YELLOW$COM $RED Is COMPLETE $WHITE ######################"
echo
echo
