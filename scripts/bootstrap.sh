#!/bin/bash
sudo setenforce 0
sudo sed -i 's/\(^SELINUX=\).*/\SELINUX=disabled/' /etc/sysconfig/selinux
sudo sed -i 's/\(^SELINUX=\).*/\SELINUX=disabled/' /etc/selinux/config
sudo systemctl enable firewalld.service
sudo systemctl start firewalld.service
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --reload
sudo yum -y install wget epel-release

sudo rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm
sudo curl -sL https://rpm.nodesource.com/setup_8.x | bash -
sudo wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
sudo rpm -Uvh remi*
sudo yum-config-manager --enable remi-php56
sudo yum -y install php56 php-fpm php-mbstring php56-php-mbstring php56w-mbstring nodejs
sudo yum -y groupinstall core base "Development Tools"
sudo yum -y install lynx mariadb-server mariadb install mysql-connector-odbc php php-mysql php-mbstring tftp-server httpd ncurses-devel sendmail sendmail-cf sox newt-devel libxml2-devel libtiff-devel audiofile-devel gtk2-devel subversion kernel-devel git php-process crontabs cronie cronie-anacronva vim php-xml uuid-devel sqlite-devel net-tools gnutls-devel php-pear
sudo yum -x gstreamer1-plugins-ugly-devel-docs,gstreamer1-plugins-ugly-devel-docs -y install mongodb-server ffmpeg ffmpeg-devel sox-devel lame lame-devel gstreamer* texinfo sox
sudo yum update -y

sudo adduser asterisk -M -c "Asterisk User"
sudo usermod -G apache -a asterisk
sudo systemctl enable mariadb.service
sudo systemctl start mariadb
sudo systemctl enable mongod
sudo systemctl start mongod

cd /usr/src
sudo wget http://www.pjsip.org/release/2.4/pjproject-2.4.tar.bz2
sudo tar -xjvf pjproject-2.4.tar.bz2
sudo rm -f pjproject-2.4.tar.bz2
cd pjproject-2.4
sudo CFLAGS='-DPJ_HAS_IPV6=1' ./configure --prefix=/usr --enable-shared --disable-sound --disable-resample --disable-video --disable-opencore-amr --libdir=/usr/lib64
sudo make dep
sudo make
sudo make install
sudo ldconfig

cd /usr/src
sudo wget -O iksemel-1.4.zip https://github.com/meduketto/iksemel/archive/master.zip
sudo unzip iksemel-1.4.zip
sudo rm -rf iksemel-1.4.zip
cd iksemel*
sudo ./autogen.sh
sudo ./configure
sudo make
sudo make all
sudo make install

cd /usr/src
sudo wget -O jansson.tar.gz https://github.com/akheron/jansson/archive/v2.7.tar.gz
sudo tar vxfz jansson.tar.gz
sudo rm -f jansson.tar.gz
cd jansson-*
sudo autoreconf -i
sudo ./configure --libdir=/usr/lib64
sudo make
sudo make install

cd /usr/src
sudo wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-15-current.tar.gz
sudo tar xvfz asterisk-15-current.tar.gz
sudo rm -f asterisk-15-current.tar.gz
cd asterisk-*
sudo contrib/scripts/install_prereq install
sudo ./configure --libdir=/usr/lib64
sudo contrib/scripts/get_mp3_source.sh
sudo make menuselect.makeopts
sudo menuselect/menuselect --enable format_mp3
sudo make
sudo make install
sudo make config
sudo ldconfig
sudo chkconfig asterisk off
cd /var/lib/asterisk/sounds
sudo wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-core-sounds-en-wav-current.tar.gz
sudo wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-extra-sounds-en-wav-current.tar.gz
sudo tar xvf asterisk-core-sounds-en-wav-current.tar.gz
sudo rm -f asterisk-core-sounds-en-wav-current.tar.gz
sudo tar xfz asterisk-extra-sounds-en-wav-current.tar.gz
sudo rm -f asterisk-extra-sounds-en-wav-current.tar.gz
sudo wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-core-sounds-en-g722-current.tar.gz
sudo wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-extra-sounds-en-g722-current.tar.gz
sudo tar xfz asterisk-extra-sounds-en-g722-current.tar.gz
sudo rm -f asterisk-extra-sounds-en-g722-current.tar.gz
sudo tar xfz asterisk-core-sounds-en-g722-current.tar.gz
sudo rm -f asterisk-core-sounds-en-g722-current.tar.gz
sudo chown asterisk. /var/run/asterisk
sudo chown -R asterisk. /etc/asterisk
sudo chown -R asterisk. /var/{lib,log,spool}/asterisk
sudo chown -R asterisk. /usr/lib64/asterisk
sudo chown -R asterisk.asterisk /var/lib/tftpboot
sudo chmod -R 777 /var/lib/tftpboot

cd /usr/src
sudo wget http://mirror.freepbx.org/modules/packages/freepbx/freepbx-14.0-latest.tgz
sudo tar xfz freepbx-14.0-latest.tgz
sudo rm -f freepbx-14.0-latest.tgz
cd freepbx
sudo systemctl enable asterisk.service
sudo cp /etc/init.d/asterisk /etc/init.d/asterisk.orig
sudo cp start_asterisk /etc/init.d/asterisk
sudo echo "load = cdr_adaptive_odbc.so" >> /etc/asterisk/modules.conf
sudo mkdir /home/asterisk; sudo chown asterisk.asterisk /home/asterisk;
sudo cp /home/vagrant/sync/data/`ls /home/vagrant/sync/data/ | grep .tgz` /home/asterisk/
sudo systemctl enable asterisk
sudo systemctl start asterisk
cd freepbx
sudo ./start_asterisk start
sudo ./install -n
sudo chown -R asterisk. /var/www/

sudo mysql -D asterisk -u root -e "INSERT INTO ampusers (username, password_sha1,sections) VALUES ('admin',SHA1('mypassword'),'*')"
sudo fwconsole ma download backup
sudo fwconsole ma install backup
sudo fwconsole reload
sudo su - asterisk -c "php /var/lib/asterisk/bin/restore.php --restore=/vagrant/data/`ls /vagrant/data/ | grep .tgz` --items=all"
sudo sed -i 's/^\(upload_max_filesize\).*/\1 = 1024M/' /etc/php.ini
sudo sed -i 's/^\(post_max_size\).*/\1 = 1024M/' /etc/php.ini
sudo sed -i 's/^\(memory_limit\).*/\1 = 256M/' /etc/php.ini
sudo sed -i 's/^\(User\|Group\).*/\1 asterisk/' /etc/httpd/conf/httpd.conf
sudo sed -i 's/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
sudo systemctl enable httpd.service
sudo systemctl start httpd.service
sudo chmod 755 /var/spool/mqueue/
sudo reboot
