#!/bin/bash -xe
sudo su -
script logfile1
yum install httpd php php-mysql php-gd php-xml mariadb-server mariadb php-mbstring -y
systemctl restart httpd.service
systemctl enable httpd.service
systemctl start mariadb
systemctl enable mariadb
yum install -y amazon-linux-extras
amazon-linux-extras enable php7.4
yum clean metadata
yum install httpd php php-mysql php-gd mariadb-server php-xml php-intl mysql -y
mysql_secure_installation <<EOF

y
secret
secret
y
y
y
y
EOF
mysql -u root -psecret << EOF > /tmp/sql123.log
CREATE USER 'wiki'@'localhost' IDENTIFIED BY 'THISpasswordSHOULDbeCHANGED' ;
CREATE DATABASE wikidatabase ;
GRANT ALL PRIVILEGES ON wikidatabase.* TO 'wiki'@'localhost' ;
FLUSH PRIVILEGES ;
EOF
wget https://releases.wikimedia.org/mediawiki/1.35/mediawiki-1.35.0.tar.gz
wget https://releases.wikimedia.org/mediawiki/1.35/mediawiki-1.35.0.tar.gz.sig
gpg --verify mediawiki-1.35.0.tar.gz.sig mediawiki-1.35.0.tar.gz
tar -zxf /home/ec2-user/mediawiki-1.35.0.tar.gz -C /var/www/html/
mv /var/www/html/mediawiki-1.35.0 /var/www/html/mediawiki
chown -R apache:apache /var/www/html/mediawiki 
service httpd restart
