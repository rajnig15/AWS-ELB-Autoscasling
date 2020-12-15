#!/bin/bash
script logfile1
yum install httpd php php-mysql php-gd php-xml mariadb-server mariadb php-mbstring -y
systemctl restart httpd.service ; systemctl enable httpd.service
systemctl start mariadb ; systemctl enable mariadb
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
SHOW DATABASES ;
SHOW GRANTS FOR 'wiki'@'localhost' ;
EOF
systemctl enable mariadb
systemctl enable httpd
wget https://releases.wikimedia.org/mediawiki/1.35/mediawiki-1.35.0.tar.gz
wget https://releases.wikimedia.org/mediawiki/1.35/mediawiki-1.35.0.tar.gz.sig
gpg --verify mediawiki-1.35.0.tar.gz.sig mediawiki-1.35.0.tar.gz
tar -zxf mediawiki-1.35.0.tar.gz
mv mediawiki-1.35.0.tar.gz /var/www/html/mediawiki
tar -zxf /home/ec2-user/mediawiki-1.35.0.tar.gz
chown -R apache:apache /var/www/mediawiki-1.35.0 
service httpd restart