#!/bin/bash
# This just renames all the pwk vidz so it also has the topic in the name
#
#                           Colorz
######################################################################
YELLOW=$(echo -e "\e[1;33m")       #Alter fonts to yellow bold
WHITE=$(echo -e "\e[1;37m")        #Alter fonts to white bold
RED=$(echo -e "\e[1;31m")        #Alter fonts to red bold
CYAN=$(echo -e "\e[1;36m")         #Alter fonts to cyan bold
#
#                          Variables
######################################################################
COLORZ=1
REVERSE=0
#
#                           Help
######################################################################
f_help() {
echo -e $WHITE"########################## $RED pwk-rename.sh $WHITE##############################\r\n"
echo -e $YELLOW"All this does is add the topic to the names of ur pwk video's so its easier to find a specific video\r\n"
echo -e $YELLOW"You MUST be in the same directory as the videos for this to work"
echo ""
echo $WHITE"Options
-r   --   reverse the filenames back to original (pwk-1.mp4)
-c   --   no colors
-h   --   this menu"
exit 1
}
#
#                          Functionz
#####################################################################
f_header() {
echo $WHITE
echo "
   ___________   ____ ___.__.       
  / ___\_  __ \_/ __ <   |  |      
 / /_/  >  | \/\  ___/\___  |     
 \___  /|__|    \___  > ____|
/_____/             \/\/     
        pwk-rename.sh By: Grey-Matter
"
sleep 2
echo
echo
}

f_list1() {
echo $RED"############################################################"
echo $YELLOW"Listing Vids"
echo $RED"############################################################"
echo $WHITE
sleep 2
echo
echo
ls -v | grep "mp4"
echo
echo
}

f_move() {
echo $RED"############################################################"
echo $YELLOW"Adding Topics To The Names Of All Your PWK Vids"
echo $RED"############################################################"
sleep 2
echo
echo
mv pwk-0.* pwk-0-Intro.mp4
mv pwk-0-* pwk-0-Intro.mp4
mv pwk-1.* pwk-1-Intro2.mp4
mv pwk-1-* pwk-1-Intro2.mp4
mv pwk-2.* pwk-2-FindingFilesInKali.mp4
mv pwk-2-* pwk-2-FindingFilesInKali.mp4
mv pwk-3.* pwk-3-ManagingKaliLinuxServices.mp4
mv pwk-3-* pwk-3-ManagingKaliLinuxServices.mp4
mv pwk-4.* pwk-4-SSHService.mp4
mv pwk-4-* pwk-4-SSHService.mp4
mv pwk-5.* pwk-5-HTTPService.mp4
mv pwk-5-* pwk-5-HTTPService.mp4
mv pwk-6.* pwk-6-ServiceManagement.mp4
mv pwk-6-* pwk-6-ServiceManagement.mp4
mv pwk-7.* pwk-7-ServiceBootPersistence.mp4
mv pwk-7-* pwk-7-ServiceBootPersistence.mp4
mv pwk-8.* pwk-8-TheBashShell.mp4
mv pwk-8-* pwk-8-TheBashShell.mp4
mv pwk-9.* pwk-9-BashScenario-1.mp4
mv pwk-9-* pwk-9-BashScenario-1.mp4
mv pwk-10.* pwk-10-BashScenario-2.mp4
mv pwk-10-* pwk-10-BashScenario-2.mp4
mv pwk-11.* pwk-11-EssentialTools.mp4
mv pwk-11-* pwk-11-EssentialTools.mp4
mv pwk-12.* pwk-12-Netcat.mp4
mv pwk-12-* pwk-12-Netcat.mp4
mv pwk-13.* pwk-13-BannerGrabbing.mp4
mv pwk-13-* pwk-13-BannerGrabbing.mp4
mv pwk-14.* pwk-14-NetcatChat.mp4
mv pwk-14-* pwk-14-NetcatChat.mp4
mv pwk-15* pwk-15-ExecutingRemoteCommandsWithNetcat.mp4
mv pwk-16* pwk-16-BindShell.mp4
mv pwk-17* pwk-17-ReverseShell.mp4
mv pwk-18* pwk-18-NCat.mp4
mv pwk-19* pwk-19-Wireshark.mp4
mv pwk-20* pwk-20-PassiveInformationGathering.mp4
mv pwk-21* pwk-21-TheGoogleSearchEngine.mp4
mv pwk-22* pwk-22-GoogleHacking.mp4
mv pwk-23* pwk-23-GoogleHackingDatabase-GHDB.mp4
mv pwk-24* pwk-24-ActiveInformationGathering.mp4
mv pwk-25* pwk-25-DNSEnumeration.mp4
mv pwk-26* pwk-26-ForwardDNSLookups.mp4
mv pwk-27* pwk-27-ReverseDNSLookups.mp4
mv pwk-28* pwk-28-DNSZoneTransfers.mp4
mv pwk-29* pwk-29-PortScanning.mp4
mv pwk-30* pwk-30-TCPConnectScanning.mp4
mv pwk-31* pwk-31-TCPSYNScanning.mp4
mv pwk-32* pwk-32-UDPScanning.mp4
mv pwk-33* pwk-33-NetworkImplicationsOfPortScanning.mp4
mv pwk-34* pwk-34-NMAPPortScanner.mp4
mv pwk-35* pwk-35-AccountabilityForYourTraffic.mp4
mv pwk-36* pwk-36-NetworkSweeping.mp4
mv pwk-37* pwk-37-NmapOSandBannerDiscovery.mp4
mv pwk-38* pwk-38-NmapNSEScripts.mp4
mv pwk-39* pwk-39-SMBEnumeration.mp4
mv pwk-40* pwk-40-SMBNullSessions.mp4
mv pwk-41* pwk-41-Enum4Linux.mp4
mv pwk-42* pwk-42-NmapSmbNSEScripts.mp4
mv pwk-43* pwk-43-SMTPEnumeration.mp4
mv pwk-44* pwk-44-SmtpVRFYBashScript.mp4
mv pwk-45* pwk-45-PythonPort.mp4
mv pwk-46* pwk-46-SNMPEnumeration.mp4
mv pwk-47* pwk-47-SNMPMiB.mp4
mv pwk-48* pwk-48-SNMPWalk.mp4
mv pwk-49* pwk-49-VulnerabilityScanning.mp4
mv pwk-50* pwk-50-VulnerabilityScanningWithNSEScripts.mp4
mv pwk-51* pwk-51-OpenVas.mp4
mv pwk-52* pwk-52-IntroductionToBufferOverflows.mp4
mv pwk-53* pwk-53-VulnerableCodeSample.mp4
mv pwk-54* pwk-54-StackOverflowExample.mp4
mv pwk-55* pwk-55-BufferOverflowsWindows32Bit.mp4
mv pwk-56* pwk-56-Fuzzing.mp4
mv pwk-57* pwk-57-ReplicatingTheCrash.mp4
mv pwk-58* pwk-58-ControllingEiP.mp4
mv pwk-59* pwk-59-IntroducingOurShellcode.mp4
mv pwk-60* pwk-60-BadCharacters.mp4
mv pwk-61* pwk-61-RedirectingTheExecutionFlow.mp4
mv pwk-62* pwk-62-IntroducingTheMONAScript.mp4
mv pwk-63* pwk-63-Shellcode.mp4
mv pwk-64* pwk-64-BufferOverflowsLinux32Bit.mp4
mv pwk-65* pwk-65-ControllingEiP.mp4
mv pwk-66* pwk-66-LocatingSpaceForOurShellcode.mp4
mv pwk-67* pwk-67-FirstStageShellcode.mp4
mv pwk-68* pwk-68-LocatingAReturnAddress.mp4
mv pwk-69* pwk-69-GeneratingShellcode.mp4
mv pwk-70* pwk-70-UsingPublicExploits.mp4
mv pwk-71* pwk-71-FindingPublicExploits.mp4
mv pwk-72* pwk-72-ExploitDatabase.mp4
mv pwk-73* pwk-73-FixingPublicExploits-1.mp4
mv pwk-74* pwk-74-FixingPublicExploits-2.mp4
mv pwk-75* pwk-75-CrossCompilingWindowsExploitCode.mp4
mv pwk-76* pwk-76-PostExploitation-FileTransfers.mp4
mv pwk-77* pwk-77-TFTPFileTransfers.mp4
mv pwk-78* pwk-78-FTPFileTransfers.mp4
mv pwk-79* pwk-79-VBScriptFileTransfers.mp4
mv pwk-80* pwk-80-PowershellFileTransfers.mp4
mv pwk-81* pwk-81-PrivilegeEscalation.mp4
mv pwk-82* pwk-82-PrivilegeEscalationExploitsInLinux.mp4
mv pwk-83* pwk-83-PrivilegeEscalationExploitsInWindows.mp4
mv pwk-84* pwk-84-AbusingWeakServicePermissionsInWindows.mp4
mv pwk-85* pwk-85-AbusingWeakServicePermissionsInLinux.mp4
mv pwk-86* pwk-86-ClientSideAttacks.mp4
mv pwk-87* pwk-87-ReplacingTheShellcode.mp4
mv pwk-88* pwk-88-MaliciousJavaApplets.mp4
mv pwk-89* pwk-89-WebApplicationAttacks.mp4
mv pwk-90* pwk-90-LFI.mp4
mv pwk-91* pwk-91-SQLInjection.mp4
mv pwk-92* pwk-92-ClassicAuthenticationBypass.mp4
mv pwk-93* pwk-93-ErrorBasedDatabaseEnumeration.mp4
mv pwk-94* pwk-94-BlindSQLInjectionBasics.mp4
mv pwk-95* pwk-95-BypassingInterfaceRestrictions.mp4
mv pwk-96* pwk-96-SQLMap.mp4
mv pwk-97* pwk-97-PasswordAttacks.mp4
mv pwk-98* pwk-98-Crunch.mp4
mv pwk-99* pwk-99-PWDump-FGDump.mp4
mv pwk-100* pwk-100-WindowsCredentialsEditor-WCE.mp4
mv pwk-101* pwk-101-PassingTheHash.mp4
mv pwk-102* pwk-102-PasswordProfiling.mp4
mv pwk-103* pwk-103-OnlinePasswordAttacks.mp4
mv pwk-104* pwk-104-Medusa.mp4
mv pwk-105* pwk-105-Ncrack.mp4
mv pwk-106* pwk-106-Hydra.mp4
mv pwk-107* pwk-107-PasswordsAndHashes.mp4
mv pwk-108* pwk-108-CrackingHashes.mp4
mv pwk-109* pwk-109-LMandNTLMHashing.mp4
mv pwk-110* pwk-110-PortRedirectionAndTunneling.mp4
mv pwk-111* pwk-111-PortForwarding.mp4
mv pwk-112* pwk-112-FunWithSSH-TunnelsAndProxies.mp4
mv pwk-113* pwk-113-SSHDynamicForwarding.mp4
mv pwk-114* pwk-114-ProxyChains.mp4
mv pwk-115* pwk-115-TheMetasploitFramework.mp4
mv pwk-116* pwk-116-AuxiliaryModules.mp4
mv pwk-117* pwk-117-SNMPAuxiliaryModule.mp4
mv pwk-118* pwk-118-SMBAuxiliaryModule.mp4
mv pwk-119* pwk-119-WEBDAVAuxiliaryModule.mp4
mv pwk-120* pwk-120-MetasploitDatabaseServices.mp4
mv pwk-121* pwk-121-MetasploitExploits.mp4
mv pwk-122* pwk-122-MetasploitPayloads.mp4
mv pwk-123* pwk-123-Meterpreter.mp4
mv pwk-124* pwk-124-MeterpreterInAction.mp4
mv pwk-125* pwk-125-AdditionalPayloads.mp4
mv pwk-126* pwk-126-BinaryPayloads.mp4
mv pwk-127* pwk-127-TheMultihandlerModule.mp4
mv pwk-128* pwk-128-PortingExploitsToMSF.mp4
mv pwk-129* pwk-129-PostExploitationWithMetasploit.mp4
mv pwk-130* pwk-130-AntivirusSoftwareAvoidance.mp4
mv pwk-131* pwk-131-PackersAndCrypters.mp4
mv pwk-132* pwk-132-PrivateCustomTools.mp4
mv pwk-133* pwk-133-PuttingItAllTogether-SimulatedPenetrationTest.mp4
mv pwk-134* pwk-134-DirectoryAndPasswordBruteforce.mp4
mv pwk-135* pwk-135-TargetEnumerationAndResearch.mp4
mv pwk-136* pwk-136-CrackingHashedAndSaltedPasswords.mp4
mv pwk-137* pwk-137-VulnerabilityAssessment.mp4
mv pwk-138* pwk-138-Exploitation.mp4
mv pwk-139* pwk-139-PrivilegeEscalation.mp4
mv pwk-140* pwk-140-ClientSideAttack.mp4
mv pwk-141* pwk-141-DomainPrivilegeEscalationViaMisconfiguration.mp4
mv pwk-142* pwk-142-PassingTheHashAndTunneling.mp4
mv pwk-143* pwk-143-GettingSYSTEMBackdoors.mp4
mv pwk-144* pwk-144-GettingInteractive.mp4
mv pwk-145* pwk-145-BreakingOutOfCitrix.mp4
mv pwk-146* pwk-146-LocalPrivilegeEscalationExploit.mp4
mv pwk-147* pwk-147-DumpingHashesAndOwningTheDomain.mp4
mv pwk-148* pwk-148-ThankYouAndTryHarder.mp4
echo $RED"############################################################"
echo $YELLOW"All Done! Enjoy :)"
echo $RED"############################################################"
sleep 2
echo
echo
}

f_list2() {
echo $RED"############################################################"
echo $YELLOW"Listing Renamed Vids"
echo $RED"############################################################"
sleep 2
echo
echo
echo $WHITE
ls -v | grep "mp4"
#ls -v | egrep "pwk-[0-9]+-[A-Za-z]*.mp4"
}

f_reverse() {
echo $RED"############################################################"
echo $YELLOW"Reverting Back To Original Filenames (Only Numbered)"
echo $RED"############################################################"
echo
ls -v | egrep "pwk-[0-9]+-*" | sed 's/^/mv /' | awk -F "-" '{print $1 "-" $2 "-" $3 "*" " " $1 "-" $2 ".mp4"}' | cut -d " " -f1,2,4 | bash 2>/dev/null
sleep 2
echo
echo
}
#
#                                Optionz
#####################################################################
while getopts "rch" OPTION
do

     case $OPTION in

          r) 
               REVERSE=1
               ;;
          c) 
               COLORZ=0
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
#                                Run
####################################################################
if   [ "$COLORZ" == "0" ] ; then read WHITE CYAN YELLOW RED <<< "" ; fi
if [ "$REVERSE" == "1" ] ; then
     echo
     echo
     echo -e $CYAN"Reverting To Original Names\r\n"
     sleep 2
     echo
     f_header
     f_list1
     f_reverse
     f_list2
else
     f_header
     f_list1
     f_move 2>/dev/null
     f_list2
fi
