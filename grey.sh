#!/bin/bash
#grey.sh v0.1a
#created by Grey-Matter
#special guest appearances by TAPE-Diddy the mutha fuckin bash pimp
#last edit 08-23-2016 23:00 CET
#just greysh it.. ;) and thus a new verb was born
#and people will ask.. why would you want grey shit?
#
#
########################################################################
X=$(shuf -i 1-3 -n 1)
DIR=$(locate banner.nse | sed 's/\/banner.nse/\//')
LOC="/usr/share/nmap/scripts/"
VERS=$(sed -n 2p $0 | awk '{print $2}')
LED=$(sed -n 3p $0 | awk '{print $3 " - " $4}')
#
#							TEH COLORZ
########################################################################
STD=$(echo -e "\e[0;0;0m")		#Revert fonts to standard colour/format
RED=$(echo -e "\e[1;31m")		#Alter fonts to red bold
REDN=$(echo -e "\e[0;31m")		#Alter fonts to red normal
GRN=$(echo -e "\e[1;32m")		#Alter fonts to green bold
GRNN=$(echo -e "\e[0;32m")		#Alter fonts to green normal
BLU=$(echo -e "\e[1;34m")		#Alter fonts to blue bold
BLUN=$(echo -e "\e[0;34m")		#Alter fonts to blue normal
YELLOW=$(echo -e "\e[1;33m")       #Alter fonts to yellow bold
YELLOWN=$(echo -e "\e[0;33m")      #Alter fonts to yellow normal
WHITE=$(echo -e "\e[1;37m")        #Alter fonts to white bold
WHITEN=$(echo -e "\e[0;37m")       #Alter fonts to white normal
CYAN=$(echo -e "\e[1;36m")         #Alter fonts to cyan bold
CYANN=$(echo -e "\e[0;36m")        #Alter fonts to cyan normal
#
#
#							HEADERS
#############################################################
f_header1() {
echo $WHITE""
echo "                                  .__     
   ___________   ____ ___.__.      _____|  |__  
  / ___\_  __ \_/ __ <   |  |     /  ___/  |  \\ 
 / /_/  >  | \/\  ___/\___  |     \___ \|   Y  \\
 \___  /|__|    \___  > ____| /\ /____  >___|  /
/_____/    $VERS    \/\/      \/      \/     \/	

"
}
f_header2() {
echo $WHITE""
echo  "     
                       _    
 ___ ___ ___ _ _   ___| |_ 
| . |  _| -_| | |_|_ -|   |
|_  |_| |___|_  |_|___|_|_|
|___|       |___|  $VERS       
"
}
f_header3() {
echo $WHITE""
echo "
                                  __    
 .-----.----.-----.--.--.  .-----|  |--.
 |  _  |   _|  -__|  |  |__|__ --|     |
 |___  |__| |_____|___  |__|_____|__|__|
 |_____|          |_____|   $VERS           
"
}            
#
#								HELP
########################################################################
echo $YELLOW""
f_help() {
echo $WHITE""
f_header$X
echo $YELLOW"This is just an NSE helper script. I created it as somewhat of an indexer for nmap scripts. You can choose scripts by category, and it will list descriptions and usage options. All the CVE/VULN scripts have their own menu (option 3) with service submenu's to sort them" 
echo $WHITE"
Usage;
grey.sh <no input required for menu> 

Options;
-h  --- this help information
-u  --- update the script db

Examples;
bash grey.sh
"
}
#
#								CONTINUE
########################################################################
f_cont() {
echo -ne $BLU">$STD Hit Enter to Continue or q/Q to quit "$BLU
read INPUT
if [ "$INPUT" == "q" ] || [ "$INPUT" == "Q" ]; then 
	echo $WHITE""
	exit
else 
	echo $RED""
	f_menu
fi
}
#
#								SERVICE SCRIPT LIST
########################################################################
f_script_list() {
echo
LIST=$(ls $LOC | grep "$BASE")
prompt="Please select a file:"
options=( $(ls $LOC | grep "$BASE") )

PS3="$prompt "
select opt in "${options[@]}" "All" "Quit";
do
     case $opt in
          "All")
               echo
               echo -e $BLU"###########################################################################################\r\n"
               echo -e $GRN"Parsing All $BASE Scripts"
               echo $WHITE
               ls $LOC | grep $BASE
               echo
               echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
               echo $GRN
               echo 
               for i in $(echo $LIST) ; do
                    echo $i
                    echo $YELLOW
                    cat $LOC$i | sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
                    echo -e $WHITE
                    cat $LOC$i | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' | sed 's/\-\-//' ; echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
                    echo $GRN
               done ;;
          "Quit") break ;;
     esac
     if (( REPLY == 1 + ${#options[@]} )) ; then
        exit
        
     elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
        echo -e "You picked $opt which is file $REPLY\r\n"
        break
     fi
done
echo -e $GRN "$opt\r\n"
echo $YELLOW
cat $LOC$opt| sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
echo $WHITE
cat $LOC$opt | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' |  sed 's/\-\-//'
echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
f_cont
}
#
#
f_script_old() {
echo
LIST=$(ls $LOC | grep "$BASE")
echo -e $CYAN$LIST
echo $WHITE
for i in $(echo $LIST) ; do 
	echo $i
	echo $YELLOW
	cat $LOC$i | sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
	echo -e $WHITE
	cat $LOC$i | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' | sed 's/\-\-//'
#	cat $LOC$i | sed '0,/\@usage/d;/@output/' | sed '$d' | sed 's/$/\r\n/'
done
echo $STD""
f_cont
}
#
#
f_script_list2() {
echo
LIST=$(ls $LOC | grep "$BASE" && ls $LOC | grep $BASE2)
LIST2=$(ls $LOC | grep "$BASE2")
prompt="Please select a file:"
options=( $(ls $LOC | grep "$BASE" && ls $LOC | grep $BASE2) )

PS3="$prompt "
select opt in "${options[@]}" "All" "Quit";
do
     case $opt in
          "All")
               echo -e $GRN"Parsing All $BASE and $BASE2 Scripts"
               echo $WHITE
               ls $LOC | grep $BASE && ls $LOC | grep $BASE2
               echo
               echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
               echo $WHITE
               echo 
               for i in $(echo $LIST) ; do
                    echo $i
                    echo $YELLOW
                    cat $LOC$i | sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
                    echo -e $WHITE
                    cat $LOC$i | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' | sed 's/\-\-//' ; echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
                    echo $GRN
               done ;;
          "Quit") break ;;
     esac
     if (( REPLY == 1 + ${#options[@]} )) ; then
        exit
     elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
        echo -e "You picked $opt which is file $REPLY\r\n"
        break
     fi
done
echo -e $GRN "$opt\r\n"
echo $YELLOW
cat $LOC$opt| sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
echo $WHITE
cat $LOC$opt | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' |  sed 's/\-\-//'
echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
f_cont
}
#
#
f_script2_old() {
echo
LIST=$(ls $LOC | grep "$BASE")
LIST2=$(ls $LOC | grep "$BASE2")
echo -e $CYAN$LIST
echo -e $CYAN$LIST2
echo $WHITE
for i in $(echo $LIST) ; do 
	echo $i
	echo $YELLOW
	cat $LOC$i | sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
	echo -e $WHITE
	cat $LOC$i | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' | sed 's/\-\-//'
#	cat $LOC$i | sed '0,/\@usage/d;/@output/' | sed '$d' | sed 's/$/\r\n/'
done
for i in $(echo $LIST2) ; do 
	echo $i
	echo $YELLOW
     cat $LOC$i | grep description -n6 | sed -n '/\[\[/,/]]/p' | sed '/=/d' | sed '/\-\-/d' | grep -v ctx_log | grep -v "return true" | grep -v "return nil" | grep -v "return false" | grep -v "if alert" | grep -v "elseif" | grep -v "local resource" | grep -v "local function" | grep -v "return (" | grep -v "if (" | grep -v "="
#	cat $LOC$i | sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
	echo -e $WHITE
	cat $LOC$i | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' | sed 's/\-\-//'
#	cat $LOC$i | sed '0,/\@usage/d;/@output/' | sed '$d' | sed 's/$/\r\n/'
done
echo $STD""
f_cont
}
#
#
f_list() {
echo
LIST=$(ls $LOC | grep "$BASE")
prompt="Please select a file:"
options=( $(ls $LOC | grep "$BASE") )

PS3="$prompt "
select opt in "${options[@]}" "All" "Quit" ; do 
    if (( REPLY == 1 + ${#options[@]} )) ; then
        exit
        
    elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        echo -e "You picked $opt which is file $REPLY\r\n"
        break
    elif [ $REPLY == "All" ]; then
        echo "alllllllll"
            
    else
        echo "Invalid option. Try another one."
    fi
done    
}
#
#
f_script() {
echo
LIST=$(ls $LOC | grep "$BASE")
prompt="Please select a file:"
options=( $(ls $LOC | grep "$BASE") )

PS3="$prompt "
select opt in "${options[@]}" "All" "Quit";
do
     case $opt in
          "All")
               BASE=$BASE
               f_script_list ;;
          "Quit") break ;;
     esac
     if (( REPLY == 1 + ${#options[@]} )) ; then
        exit
        
     elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        echo -e "You picked $opt which is file $REPLY\r\n"
        break
     fi
done
echo -e $GRN "$opt\r\n"
echo $YELLOW
cat $LOC$opt| sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
echo $WHITE
cat $LOC$opt | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' |  sed 's/\-\-//'
echo ""
}
#
#
f_extra() {
echo -e $GRN "$opt\r\n"
echo $YELLOW
cat $LOC$opt| sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
echo $WHITE
cat $LOC$opt | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' 
break
}
#f_cvemenu() {
#echo $YELLOW""
#PS4='Choose The Type Of Service..: '
#options=("HTTP" "SAMBA/SMB" "SMTP" "MySQL" "RDP" "RMI" "FTP")
#select opt in "${options[@]}"
#do
#echo $WHITE""
#    case $opt in
f_novuln() {
echo
LIST=$(ls $LOC | grep "$BASE" | grep -v "vuln")
prompt="Please select a file:"
options=( $(ls $LOC | grep "$BASE" | grep -v "vuln") )

PS3="$prompt "
select opt in "${options[@]}" "All" "Quit";
do
     case $opt in
          "All")
               echo -e $GRN"Parsing All $BASE Scripts"
               echo $WHITE
               ls $LOC | grep $BASE
               echo
               echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
               echo $WHITE
               echo 
               for i in $(echo $LIST) ; do
                    echo $i
                    echo $YELLOW
                    cat $LOC$i | sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
                    echo -e $WHITE
                    cat $LOC$i | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' | sed 's/\-\-//' ; echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
                    echo $GRN
               done ;;
          "Quit") break ;;
     esac
     if (( REPLY == 1 + ${#options[@]} )) ; then
        exit
        
     elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
        echo -e "You picked $opt which is file $REPLY\r\n"
        break
     fi
done
echo -e $GRN "$opt\r\n"
echo $YELLOW
cat $LOC$opt| sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
echo $WHITE
cat $LOC$opt | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' |  sed 's/\-\-//'
echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
f_cont
}
#
#
f_novuln_old(){
echo
LIST=$(ls $LOC | grep "$BASE" | grep -v "vuln")
echo -e $GRN$LIST
echo $WHITE
for i in $(echo $LIST);do 
	echo $i
	echo $YELLOW
	cat $LOC$i | sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
	echo -e $WHITE
	cat $LOC$i | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' | sed 's/\-\-//'
#	cat $LOC$i | sed '0,/\@usage/d;/@output/' | sed '$d' | sed 's/$/\r\n/'
done
echo $STD""
f_cont
}
#
#
f_novuln2() {
echo
LIST=$(ls $LOC | grep "$BASE" | grep -v "vuln" && ls $LOC | grep $BASE2 | grep -v "vuln")
prompt="Please select a file:"
options=( $(ls $LOC | grep "$BASE" | grep -v vuln && ls $LOC | grep $BASE2 | grep -v vuln) )

PS3="$prompt "
select opt in "${options[@]}" "All" "Quit";
do
     case $opt in
          "All")
               echo -e $GRN"Parsing All $BASE and $BASE2 Scripts"
               echo $WHITE
               ls $LOC | grep $BASE && ls $LOC | grep $BASE2
               echo
               echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
               echo $WHITE
               echo 
               for i in $(echo $LIST) ; do
                    echo $i
                    echo $YELLOW
                    cat $LOC$i | sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
                    echo -e $WHITE
                    cat $LOC$i | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' | sed 's/\-\-//' ; echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
                    echo $GRN
               done ;;
          "Quit") break ;;
     esac
     if (( REPLY == 1 + ${#options[@]} )) ; then
        exit
     elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
        echo -e "You picked $opt which is file $REPLY\r\n"
        break
     fi
done
echo -e $GRN "$opt\r\n"
echo $YELLOW
cat $LOC$opt| sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
echo $WHITE
cat $LOC$opt | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' |  sed 's/\-\-//'
echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
f_cont
}
#
#
f_novuln2_old() {
echo
LIST=$(ls $LOC | grep "$BASE" | grep -v "vuln")
LIST2=$(ls $LOC | grep "$BASE2" | grep -v "vuln")
echo -e $CYAN$LIST
echo -e $CYAN$LIST2
echo $WHITE
for i in $(echo $LIST);do 
	echo $i
	echo $YELLOW
	cat $LOC$i | sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
	echo -e $WHITE
	cat $LOC$i | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' | sed 's/\-\-//'
#	cat $LOC$i | sed '0,/\@usage/d;/@output/' | sed '$d' | sed 's/$/\r\n/'
done
for i in $(echo $LIST2 | grep -v vuln);do 
	echo $i
	echo $YELLOW
	cat $LOC$i | sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
	echo -e $WHITE
	cat $LOC$i | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' | sed 's/\-\-//'
#	cat $LOC$i | sed '0,/\@usage/d;/@output/' | sed '$d' | sed 's/$/\r\n/'
done
echo $STD""
f_cont
}
#
#
f_vuln() {
echo
LIST=$(ls $LOC | grep "$VBASE" | grep "vuln")
prompt="Please select a file:"
options=( $(ls $LOC | grep "$VBASE" | grep "vuln") )

PS3="$prompt "
select opt in "${options[@]}" "All" "Quit";
do
     case $opt in
          "All")
               echo
               echo -e $BLU"###########################################################################################\r\n"
               echo -e $GRN"Parsing All $VBASE Vuln Scripts"
               echo $WHITE
               ls $LOC | grep $VBASE | grep "vuln"
               echo
               echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
               echo $GRN
               echo 
               for i in $(echo $LIST) ; do
                    echo $i
                    echo $YELLOW
                    cat $LOC$i | sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
                    echo -e $WHITE
                    cat $LOC$i | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' | sed 's/\-\-//' ; echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
                    echo $GRN
               done ;;
          "Quit") break ;;
     esac
     if (( REPLY == 1 + ${#options[@]} )) ; then
        exit
        
     elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
        echo -e "You picked $opt which is file $REPLY\r\n"
        break
     fi
done
echo -e $GRN "$opt\r\n"
echo $YELLOW
cat $LOC$opt| sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
echo $WHITE
cat $LOC$opt | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' |  sed 's/\-\-//'
echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
f_cont
}
#
#
f_vuln2() {
echo
LIST=$(ls $LOC | grep "$VBASE" | grep vuln && ls $LOC | grep $VBASE2 | grep vuln)
prompt="Please select a file:"
options=( $(ls $LOC | grep "$VBASE" | grep vuln && ls $LOC | grep $VBASE2 | grep vuln) )

PS3="$prompt "
select opt in "${options[@]}" "All" "Quit";
do
     case $opt in
          "All")
               echo -e $GRN"Parsing All $VBASE and $VBASE2 Scripts"
               echo $WHITE
               cat $LIST
#               ls $LOC | grep $BASE | grep "vuln" && ls $LOC | grep $BASE2 | grep "vuln"
               echo
               echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
               echo $WHITE
               echo 
               for i in $(echo $LIST) ; do
                    echo $i
                    echo $YELLOW
                    cat $LOC$i | sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
                    echo -e $WHITE
                    cat $LOC$i | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' | sed 's/\-\-//' ; echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
                    echo $GRN
               done ;;
          "Quit") break ;;
     esac
     if (( REPLY == 1 + ${#options[@]} )) ; then
        exit
     elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
        echo -e "You picked $opt which is file $REPLY\r\n"
        break
     fi
done
echo -e $GRN "$opt\r\n"
echo $YELLOW
cat $LOC$opt| sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
echo $WHITE
cat $LOC$opt | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' |  sed 's/\-\-//'
echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
f_cont
}
#
#
f_vuln2_old() {
echo
LIST=$(ls $LOC | grep "$VBASE")
LIST2=$(ls $LOC | grep "$VBASE2")
echo -e $CYAN$LIST
echo -e $CYAN$LIST2
echo $WHITE
for i in $(echo $LIST | grep vuln);do 
	echo $i
	echo $YELLOW
	cat $LOC$i | sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
	echo -e $WHITE
	cat $LOC$i | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' | sed 's/\-\-//'
#	cat $LOC$i | sed '0,/\@usage/d;/@output/' | sed '$d' | sed 's/$/\r\n/'
done
for i in $(echo $LIST2 | grep vuln);do 
	echo $i
	echo $YELLOW
	cat $LOC$i | sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
	echo -e $WHITE
	cat $LOC$i | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' | sed 's/\-\-//'
#	cat $LOC$i | sed '0,/\@usage/d;/@output/' | sed '$d' | sed 's/$/\r\n/'
done
echo $STD""
f_cont
}
#
#
f_options() {
echo $WHITE""
PS3=' Choose An Option..: '
echo $YELLOW
options=("Find NSE Directory" "Install Vulscan..." "List Your NSE Directory" "Grab Your Nmap Version" "Back")
select opt in "${options[@]}"
do
echo $WHITE""
    case $opt in
    
          "Find NSE Directory")
               locate banner.nse | sed 's/\/banner.nse/\//'
               break ;;
          "Install Vulscan...")
               VSCAN=$(echo $DIR/vulscan | sed -r 's/\/\//\//g')
               echo $VSCAN
               if   [ ! -d $DIR/vulscan ]; then
                    cd $DIR
                    wget http://www.computec.ch/projekte/vulscan/download/nmap_nse_vulscan-2.0.tar.gz &>/dev/null 
                    tar -xzf nmap_nse_vulscan-2.0.tar.gz &>/dev/null
                    rm -rf nmap_nse_vulscan-2.0.tar.gz
                    ls $DIR/vulscan
                         if   [ -d $DIR/vulscan ]; then
                              echo -e $GRN"Vulscan Is Installed!!\r\n"
                              echo $WHITE
                         else
                              echo "Something Went Wrong"
                         fi
               fi  ;;
               
          "List Your NSE Directory")
               echo $YELLOW
               ls $DIR 
               echo "" ;;
          
          "Grab Your Nmap Version")
               echo $GRN
               nmap -V ;;
      
          "Back")
                f_cont ;;
        
          *) echo invalid option;;
    esac
done
f_cont
}
#
#
f_vulscan() {
LIST=$(ls $DIR/vulscan/)
VULS=$(echo $DIR | sed 's/$/vulscan\/vulscan.nse/')
if   [ -d $DIR/vulscan ]; then
     echo -e $GRN"Vulscan Is Installed...\r\n"
     echo -e $GRN"Vulscan Is Located At $WHITE$VULS \r\n"
else
     echo -e $RED"Install Vulscan From The Options Menu\r\n"
     echo $WHITE
fi
sleep 2
echo
echo -e $WHITE"################################## $RED -- Vulscan Folder Contents -- $WHITE##################################\r\n"
echo -e $RED$LIST "\r\n"
echo -e $WHITE"##############################################################################################################\r\n"
echo
sleep 2
echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
echo
sleep 2
echo $GRN
echo -e $YELLOW
cat $VULS | sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
echo 
sleep 2
echo -e $WHITE
cat $VULS | grep "nmap -sV" | sed 's/^...//' | awk '{print "\033[1;36m" $1,$2,$3,$4}' ; cat $VULS | grep -n1 "script-args" | sed -r 's/^\-\-//' | sed 's/^....//' |  sed 's/[0-9]\{2\}//' | sed '/^$/d' | sed '/^\-/d' | awk '{print "\033[37m" $1,$2}'
#cat $VULS | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' | sed 's/\-\-//' ; echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
echo $GRN
f_cont
}
#
#
f_template() {
LIST=$(ls $LOC | grep "$BASE")
prompt="Please select a file:"
options=( $(ls $LOC | grep "$BASE") )

PS3="$prompt "
select opt in "${options[@]}" "All" "Quit";
do
     case $opt in
          "All")
               echo
               echo -e $BLU"###########################################################################################\r\n"
               echo -e $GRN"Parsing All $BASE Scripts"
               echo $WHITE
               ls $LOC | grep $BASE
               echo
               echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
               echo $GRN
               echo 
               for i in $(echo $LIST) ; do
                    echo $i
                    echo $YELLOW
                    cat $LOC$i | sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
                    echo -e $WHITE
                    cat $LOC$i | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' | sed 's/\-\-//' ; echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
                    echo $GRN
               done ;;
          "Quit") break ;;
     esac
     if (( REPLY == 1 + ${#options[@]} )) ; then
        exit
        
     elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
        echo -e "You picked $opt which is file $REPLY\r\n"
        break
     fi
done
echo -e $GRN "$opt\r\n"
echo $YELLOW
cat $LOC$opt| sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
echo $WHITE
cat $LOC$opt | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' |  sed 's/\-\-//'
echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
f_cont
}
#
#
f_misc() {
echo $YELLOW""
PS4='Select A Script: '
options=("acarsd-info" "allseeingeye-info" "amqp-info" "asn-query" "backorifice-info" "bacnet-info" "bittorrent-discovery" "bjnp-discover" "cccam-version" "clamav-exec" "daap-get-library" "db2-das-info" "dict-info" "distcc-cve2004-2687" "docker-version" "domino-enum-users" "duplicates" "eap-info" "enip-info" "epmd-info" "eppc-enum-processes" "fcrdns" "flume-master-info" "freelancer-info" "ganglia-info" "giop-info" "gkrellm-info" "gopher-ls" "hnap-info" "icap-info" "ike-version" "isns-info" "lexmark-config" "lltd-discovery" "maxdb-info" "mcafee-epo-agent" "modbus-discover" "murmur-version" "nrpe-enum" "omron-info" "openlookup-info" "ovs-agent-version" "pjl-ready-message" "qconn-exec" "riak-http-info" "s7-info" "stuxnet-detect" "supermicro-ipmi-conf" "teamspeak2-version" "ventrilo-info" "versant-info" "voldemort-info" "vuze-dht-info" "weblogic-t3-info")
select opt in "${options[@]}"
do
echo $WHITE""
     case $opt in
          "acarsd-info") ;;
          "allseeingeye-info") ;;
          "amqp-info") ;; 
          "asn-query") ;; 
          "backorifice-info") ;; 
          "bacnet-info") ;; 
          "bittorrent-discovery") ;; 
          "bjnp-discover") ;; 
          "cccam-version") ;;
          "clamav-exec") ;;
          "daap-get-library") ;; 
          "db2-das-info") ;;
          "dict-info") ;;
          "distcc-cve2004-2687") ;; 
          "docker-version") ;;
          "domino-enum-users") ;; 
          "duplicates") ;;
          "eap-info") ;;
          "enip-info") ;;
          "epmd-info") ;;
          "eppc-enum-processes") ;; 
          "fcrdns") ;;
          "flume-master-info") ;; 
          "freelancer-info") ;;
          "ganglia-info") ;;
          "giop-info") ;;
          "gkrellm-info") ;;
          "gopher-ls") ;;
          "hnap-info") ;; 
          "icap-info") ;; 
          "ike-version") ;; 
          "isns-info") ;;
          "lexmark-config") ;; 
          "lltd-discovery") ;;
          "maxdb-info") ;;
          "mcafee-epo-agent") ;; 
          "modbus-discover") ;;
          "murmur-version") ;;
          "nrpe-enum") ;;
          "omron-info") ;;
          "openlookup-info") ;;
          "ovs-agent-version") ;; 
          "pjl-ready-message") ;;
          "qconn-exec") ;;
          "riak-http-info") ;; 
          "s7-info") ;;
          "stuxnet-detect") ;; 
          "supermicro-ipmi-conf") ;; 
          "teamspeak2-version") ;;
          "ventrilo-info") ;;
          "versant-info") ;;
          "voldemort-info") ;; 
          "vuze-dht-info") ;;
          "weblogic-t3-info") ;;
          "Back")
               f_cont ;;
          *) echo invalid option
     esac
     if (( REPLY == 1 + ${#options[@]} )) ; then
        exit
        
     elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
        echo -e "You picked $opt.nse which is file $REPLY\r\n"
        break
     fi
done
echo -e $GRN "$opt.nse\r\n"
echo $YELLOW
cat $LOC$opt.nse| sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
echo $WHITE
cat $LOC$opt.nse | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' |  sed 's/\-\-//'
echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
f_cont
}
#
#
f_tools() {
echo $YELLOW""
PS4='Choose your poison..: '
options=("address-info" "creds-summary" "daytime" "finger" "gpsd-info" "hddtemp-info" "ipidseq" "krb5-enum-users" "llmnr-resolve" "memcached-info" "mrinfo" "mtrace" "nbstat" "nntp-ntlm-info" "nping-brute" "p2p-conficker" "path-mtu" "pptp-version" "qscan" "resolveall" "reverse-index" "rfc868-time" "rusers" "servicetags" "shodan-api" "skypev2-version" "sniffer-detect" "sstp-discover" "tls-nextprotoneg" "tor-consensus-checker" "traceroute-geolocation" "unittest" "unusual-port" "upnp-info" "url-snarf" "wdb-version" "whois-domain" "whois-ip" "wsdd-discover" "x11-access" "xdmcp-discover" "Back")
select opt in "${options[@]}"
do
echo $WHITE""
     case $opt in
          "address-info") ;;
          "creds-summary") ;;
          "daytime") ;;
          "finger") ;;
          "gpsd-info") ;; 
          "hddtemp-info") ;; 
          "ipidseq") ;;
          "krb5-enum-users") ;;
          "llmnr-resolve") ;;
          "memcached-info") ;; 
          "mrinfo") ;;
          "mtrace") ;;
          "nbstat") ;;
          "nntp-ntlm-info") ;;
          "nping-brute") ;;
          "p2p-conficker") ;;
          "path-mtu") ;;
          "pptp-version") ;;
          "qscan") ;;
          "resolveall") ;;
          "reverse-index") ;;
          "rfc868-time") ;;
          "rusers") ;;
          "servicetags") ;;
          "shodan-api") ;;
          "skypev2-version") ;;
          "sniffer-detect") ;;
          "sstp-discover") ;;
          "tls-nextprotoneg") ;;
          "tor-consensus-checker") ;;
          "traceroute-geolocation") ;;
          "unittest") ;;
          "unusual-port") ;;
          "upnp-info") ;;
          "url-snarf") ;;
          "wdb-version") ;;
          "whois-domain") ;;
          "whois-ip") ;;
          "wsdd-discover") ;;
          "x11-access") ;;
          "xdmcp-discover") ;;
          "Back")
               f_cont ;;
          *) echo invalid option
     esac
     if (( REPLY == 1 + ${#options[@]} )) ; then
        exit
        
     elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
        echo -e "You picked $opt.nse which is file $REPLY\r\n"
        break
     fi
done
echo -e $GRN "$opt.nse\r\n"
echo $YELLOW
cat $LOC$opt.nse| sed -n '/description/,/]]/p' | sed 's/\]\]/\r\n/' | sed 's/\[\[/\r\n/' | sed '/description/{d;}'
echo $WHITE
cat $LOC$opt.nse | sed -n '/usage/,/output/p' | grep -v "@output" | sed 's/$/\r\n/' |  sed 's/\-\-//'
echo -e $RED"################################## $WHITE -- Details & Usage -- $RED#################################\r\n"
f_cont
}
#
#
f_vulnmenu(){
echo $YELLOW""
PS4='Choose your poison..: '
options=("AFP" "FTP" "HTTP" "MySQL" "RDP" "RMI" "SMB/SAMBA" "SMTP" "Back")
select opt in "${options[@]}"
do
echo $WHITE""
     case $opt in

          "AFP")  
               VBASE="afp"
               f_vuln ;;
          "FTP")
               VBASE="ftp"
               f_vuln ;;
          "HTTP")
               VBASE="http"
               f_vuln ;;
          "MySQL")
               VBASE="mysql"
               f_vuln ;;
          "RDP")
               VBASE="rdp"
               f_vuln ;;
          "RMI")
               VBASE="rmi"
               f_vuln ;;
          "SMB/SAMBA")
               VBASE="samba"
               VBASE2="smb"
               f_vuln2 ;;
          "SMTP")
               VBASE="smtp"
               f_vuln ;;          
          "Back")
               f_cont ;;
          *) echo invalid option
     esac
done
}
#
#								MAIN MENU
########################################################################
f_menu() {
echo -e $GRN"Your Nmap Scripts Directory Was Located\r\n"
echo -e $WHITE$DIR
echo $WHITE""
PS3=' Choose your poison..: '
echo $YELLOW
options=("OPTiONS" "VULSCAN!!!!" "CVE-Vuln-Scans" "Tools (Whois,Finger,etc)" "Bruteforcers" $CYAN "AFP (Apple Filing Protocol)" "AJP (Apache JServ)" "Banner Grabbing" "Bitcoin" "Broadcast" "Cassandra" "Citrix" "CouchDB" "Cups" "CVS" "DHCP & DNS" "Domcon" "DRDA" "Firewalk" "FTP" "Hadoop" "HBase" "HostMap" "HTTP" "IAX2" "Identd" "iMAP" "Informix" "IP Scripts (Forwarding,Geolocation,etc)" "iPV6" "iRC" "iSCSI" "JDWP (Java Remote Debugging)" "KNX" "LDAP" "Membase" "Metasploit" "MMouse" "MongoDB" "MS-Sql" "MySQL" "NAT-PMP" "NCP" "NDMP" "Nessus" "Netbus" "NTP" "OMP2" "Oracle" "Pop3" "Quake" "RDP & VNC" "Redis" "RMI" "RPC & NFS" "RSync" "RTSP" "Samba/SMB" "SiP" "SMTP" "SNMP" "Socks" "SQL (ALL)" "SSH" "SSL" "Stun" "Targets" "Telnet" "XMPP" "WEBDAV"  "MiSC" "Back" $GRN)
echo -e $GRN "\r\n"
select opt in "${options[@]}"
do
echo $WHITE""
    case $opt in
    
        "OPTiONS")
               f_options ;;

        "CVE-Vuln-Scans")
               f_vulnmenu ;;         
                  
        "Tools (Whois,Finger,etc)") 
               f_tools ;;

        "VULSCAN!!!!")
               f_vulscan ;;
        "Bruteforcers")
               BASE="brute"
               f_script_list ;;
        "AFP (Apple Filing Protocol)")
               BASE="afp-"
               f_novuln ;;
        "AJP (Apache JServ)")
               BASE='ajp'
               f_script_list ;;
        "Banner Grabbing")
               BASE="banner"
               f_script ;;
        "Bitcoin") 
               BASE="bitcoin"
               f_script_list ;;
        "Broadcast")
               BASE="broadcast"
               f_script_list ;;
        "Cassandra")
               BASE="cassandra"
               f_script_list ;;
        "Citrix")
               BASE="citrix"
               f_script_list ;;
        "CouchDB")
               BASE="couchdb"
               f_script_list ;;
        "Cups")
               BASE="cups"
               f_script_list ;;
        "CVS")
               BASE="cvs"
               f_script_list ;;
        "DHCP & DNS")
               BASE="dhcp"
               BASE2="dns"
               f_script_list2 ;;
        "Domcon")
               BASE="domcon"
               f_script_list ;;
        "DRDA") 
               BASE="drda"
               f_script_list ;;
        "Firewall")
               BASE="firewalk"
               BASE2="firewall"
               f_script_list2 ;;
        "FTP") 
               BASE="ftp"
               f_novuln ;;
        "Hadoop")
               BASE="hadoop"
               f_script_list ;;
        "HBase")
               BASE="hbase"
               f_script_list ;; 
        "Hostmap")
               BASE="hostmap"
               f_script_list ;;
        "HTTP")
               BASE="http"
               f_novuln ;; 
        "IAX2")
               BASE="iax2"
               f_script_list ;;
        "Identd")
               BASE="auth-"
               f_script_list ;;
        "iMAP")
               BASE="imap"
               f_script_list ;;
        "Informix")
               BASE="informix"
               f_script_list ;;
        "IP Scripts (Forwarding,Geolocating,IPv6,etc")
               BASE="ip-"
               f_script_list ;;
        "iPV6")
               BASE="ipv6"
               f_script_list ;; 
        "iRC")
               BASE="irc"
               f_script_list ;; 
        "iSCSI")
               BASE="iscsi"
               f_script_list ;; 
        "JDWP (Java Remote Debugging)")
               BASE="jwp"
               f_script_list ;; 
        "KNX")
               BASE="knx"
               f_script_list ;;
        "LDAP")
               BASE="ldap"
               f_script_list ;; 
        "Membase")
               BASE="membase"
               f_script_list ;;
        "Metasploit")
               BASE="metasploit"
               f_script_list ;;
        "MMouse")
               BASE="mmouse"
               f_script_list ;; 
        "MongoDB") 
               BASE="mongodb"
               f_script_list ;;
        "MS-Sql") 
               BASE="ms-sql"
               f_script_list ;;
        "MySQL") 
               BASE="mysql"
               f_novuln ;;
        "Nat-PMP") 
               BASE="nat-pmp"
               f_script_list ;;
        "NCP") 
               BASE="ncp"
               f_script_list ;;
        "NDMP") 
               BASE="ndmp"
               f_script_list ;;
        "Nessus") 
               BASE="nessus"
               f_script_list ;;
        "Netbus") 
               BASE="netbus"
               f_script_list ;;
        "NTP") 
               BASE="ntp"
               f_script_list ;;
        "OMP2") 
               BASE="omp2"
               f_script_list ;;
        "Oracle") 
               BASE="oracle"
               f_script_list ;;
        "Pop3") 
               BASE="pop3"
               f_script_list ;;
        "Quake") 
               BASE="quake"
               f_script_list ;;
        "RDP & VNC") 
               BASE="rdp"
               BASE2="vnc"
               f_novuln2 ;;
        "Redis") 
               BASE="redis"
               f_script_list ;;
        "RMI") 
               BASE="rmi"
               f_novuln ;;
        "RPC & NFS") 
               BASE="rpc"
               BASE2="nfs"
               f_script_list2 ;;
        "RSync") 
               BASE="rsync"
               f_script_list ;;
        "RTSP") 
               BASE="rtsp"
               f_script_list ;;
        "Samba/SMB")
               BASE="smb"
               BASE2="samba"
               f_novuln2 ;;        
        "SiP") 
               BASE="sip"
               f_script_list ;;
        "SMTP") 
               BASE="smtp"
               f_novuln ;;
        "SNMP") 
               BASE="snmp"
               f_script_list ;;
        "Socks") 
               BASE="socks"
               f_script_list ;;
        "SQL (ALL)")
               BASE="sql"
               f_script_list ;;
        "SSH") 
               BASE="ssh"
               f_script_list ;;
        "SSL") 
               BASE="ssl"
               f_script_list ;;
        "Stun") 
               BASE="stun"
               f_script_list ;;
        "Targets") 
               BASE="targets"
               f_script_list ;;
        "Telnet") 
               BASE="telnet"
               f_script_list ;;
        "XMPP") 
               BASE="xmpp"
               f_script_list ;;
        "WEBDAV")
               BASE="webdav"
               f_script_list ;;
        "MiSC") 
               f_misc ;;
        "Back")
               f_cont ;;
        *) echo invalid option;;
    esac
done
}
#
#                                OPTIONZ
########################################################################
while getopts "h:u" OPTION
do

     case $OPTION in
     
          u)
               UPDATE="True"
               ;;
          
          h)
               f_help
               ;;
          ?)
               f_help
               ;;
     esac
done
#
#                                 Run The Script
########################################################################
if   [ "$UPDATE" == "True" ] ; then f_header$X ; nmap --script-updatedb ; echo $YELLOW"Script DB Updated!!" ; fi
if   [ $# -eq 0 ]; then 
     f_header$X
     f_menu
else
     f_help
fi

