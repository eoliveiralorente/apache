#!/bin/sh

apt update -y
apt install apache2 -y
service apache2 start
sevice apache2 enable
echo "Para frente MANDIC!!!!!" > /var/www/html/index.html

