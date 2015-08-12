#!/usr/bin/env bash

echo "###################################################################################"
echo "Please be Patient: Installation will start now.......and it will take some time :)"
echo "###################################################################################"

if grep -qiE 'centos' /etc/os-release; then
  clear

  sudo yum install -y httpd php php-mysql php-fpm mariadb-server mariadb

  sudo systemctl start httpd.service
  sudo systemctl enable httpd.service

  sudo systemctl start mariadb

  sudo mysql_secure_installation
  sudo systemctl enable mariadb.service

  echo "<?php phpinfo(); ?>" > /var/www/html/info.php

  clear
  echo 'Okay.... apache, php and mysql is installed, running and set to your desired password'
  echo '-----------------------------------------------'
  echo 'The address you want to visit will be:'
  echo '-----------------------------------------------'
  echo 'http://your_server_IP_address/info.php'

elif grep -qiE 'ubuntu' /etc/os-release; then
  sudo apt-get update
  sudo apt-get -y install apache2 mysql-server php5-mysql php5 libapache2-mod-php5 php5-mcrypt php5-cli
  sudo apt-get -y install mysql-server
  sudo mysql_install_db
  sudo mysql_secure_installation
  sudo service apache2 restart && sudo service mysql restart > /dev/null
  sudo echo "<?php phpinfo(); ?>" > /var/www/html/info.php
  if [ $? -ne 0 ]; then
    echo "Please Check the Install Services, There is some $(tput bold)$(tput setaf 1)Problem$(tput sgr0)"
  else
    echo 'Okay.... apache, php and mysql is installed, running and set to your desired password'
    echo '-----------------------------------------------'
    echo 'The address you want to visit will be:'
    echo '-----------------------------------------------'
    echo 'http://your_server_IP_address/info.php'
  fi
fi