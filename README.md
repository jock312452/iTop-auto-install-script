# iTop-auto-install-script
The auto install script for iTop2.4.1

############################################
#   This bash script made by Chen Jiang    #
############################################

The bash script should be downloaded to your CentOS7 which already finished installation and network configuration, your CentOS7 must be able to access to the internet. This script will configure the firewall open & add httpd,SSH is OK, if you want to open other ports on firewall you should change the script!

Steps:

1）First Step:
Download the itop_install_all_extensions.sh to your CentOS7 which preinstalled and internet is accessed.

2）Second Step:
run the command as root as follows：
#chmod 755 itop_install_all_extensions_v1.2.sh

3）Third Step:
run the command as root as follows：
#bash itop_install_all_extensions_v1.2.sh

4）After rebooting, please login the http://ip address/itop to make first configuration.


MySQL connect: root / 123419itop
