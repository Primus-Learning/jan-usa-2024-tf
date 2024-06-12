#!/bin/bash
Yum update -y
yum install httpd -y
systemctl start httpd 
systemctl enable httpd 
wget https://github.com/startbootstrap/startbootstrap-stylish-portfolio/archive/gh-pages.zip
unzip gh-pages.zip
cp startbootstrap-stylish-portfolio-gh-pages/* /var/www/html/ -r