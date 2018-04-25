#!/bin/bash
touch /itop_install.log
touch /itop_install_error.log
echo Hello, this script is made by Chen Jiang, the iTop is deploying, please waiting
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config 1>>/itop_install.log 2>>/itop_install_error.log
yum -y install epel-release 1>>/itop_install.log 2>>/itop_install_error.log
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm 1>>/itop_install.log 2>>/itop_install_error.log
systemctl start firewalld && systemctl enable firewalld 1>>/itop_install.log 2>>/itop_install_error.log
firewall-cmd --permanent --add-service=http && firewall-cmd --reload 1>>/itop_install.log 2>>/itop_install_error.log
systemctl restart firewalld 1>>/itop_install.log 2>>/itop_install_error.log
yum install -y httpd mariadb mariadb-server php56w.x86_64 php56w-common.x86_64 php56w-mysql.x86_64 php56w-mcrypt.x86_64 php56w-xmlrpc php56w-cli.x86_64 php56w-soap.x86_64 php56w-ldap.x86_64 php56w-gd.x86_64 php56w-xml.x86_64 graphviz wget unzip expect 1>>/itop_install.log 2>>/itop_install_error.log
systemctl start mariadb && systemctl enable mariadb 1>>/itop_install.log 2>>/itop_install_error.log
systemctl start httpd && systemctl enable httpd 1>>/itop_install.log 2>>/itop_install_error.log
echo '#!/usr/bin/expect
set timeout 60
set password [lindex $argv 0]
spawn mysql_secure_installation
expect {
"enter for none" { send "\r"; exp_continue}
"Y/n" { send "Y\r" ; exp_continue}
"ew password" { send "123419itop\r"; exp_continue}
"Cleaning up" { send "\r"}
}
interact ' > mysql_secure_installation.exp 
chmod +x mysql_secure_installation.exp 
./mysql_secure_installation.exp 1>>/itop_install.log 2>>/itop_install_error.log
sed -i '9a\max_allowed_packet=20971520' /etc/my.cnf 1>>/itop_install.log 2>>/itop_install_error.log
sed -i "s/file_uploads = On/file_uploads = on/g" /etc/php.ini 1>>/itop_install.log 2>>/itop_install_error.log
sed -i "s/upload_max_filesize = 2/upload_max_filesize = 5/g" /etc/php.ini 1>>/itop_install.log 2>>/itop_install_error.log
sed -i "s/max_file_uploads = 20/max_file_uploads = 20/g" /etc/php.ini 1>>/itop_install.log 2>>/itop_install_error.log
sed -i "s/post_max_size = 8/post_max_size = 10/g" /etc/php.ini 1>>/itop_install.log 2>>/itop_install_error.log
sed -i "s/memory_limit = 128/memory_limit = 256/g" /etc/php.ini 1>>/itop_install.log 2>>/itop_install_error.log
sed -i "s/max_input_time = 60/max_input_time = 120/g" /etc/php.ini 1>>/itop_install.log 2>>/itop_install_error.log
sed -i '861a\extension=/usr/lib64/php/modules/gd.so' /etc/php.ini 1>>/itop_install.log 2>>/itop_install_error.log
sed -i 's/Options Indexes FollowSymLinks/#Options Indexes FollowSymLinks/g' /etc/httpd/conf/httpd.conf 1>>/itop_install.log 2>>/itop_install_error.log
sed -i '145a\Options None' /etc/httpd/conf/httpd.conf 1>>/itop_install.log 2>>/itop_install_error.log
sed -i '5,22s//#/' /etc/httpd/conf.d/welcome.conf 1>>/itop_install.log 2>>/itop_install_error.log
wget -c https://raw.githubusercontent.com/jock312452/iTop-auto-install-script/master/iTop-2.4.1.zip 1>>/itop_install.log 2>>/itop_install_error.log
mkdir /var/www/html/itop 1>>/itop_install.log 2>>/itop_install_error.log
unzip -d /iTop-2.4.1 /iTop-2.4.1.zip 1>>/itop_install.log 2>>/itop_install_error.log
cp -R /iTop-2.4.1/web/* /var/www/html/itop/ 1>>/itop_install.log 2>>/itop_install_error.log
mkdir -p /var/www/html/itop/{conf,data,env-production,env-production-build} 1>>/itop_install.log 2>>/itop_install_error.log
chown -R apache:apache /var/www/html/itop/{conf,data,log,env-production,env-production-build,extensions} 1>>/itop_install.log 2>>/itop_install_error.log
chown -R apache:apache /var/www/html/itop/datamodels 1>>/itop_install.log 2>>/itop_install_error.log
echo The iTop deployment is finished, the system will reboot in 30s, after that please login the http://ip address/itop to make first configuration.
sleep 30s
reboot 

