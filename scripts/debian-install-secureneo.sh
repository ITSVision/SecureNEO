# Update and upgrade
apk update && apk upgrade

#add dependencies
apt-get install git curl php7.0 php7.0-dev php-pear php7.0-curl php7.0-mcrypt php7.0-mbstring php7.0-gmp php7.0-bcmath g++ make util-linux

#install scrypt
printf "\n" | pecl install scrypt
echo "extension=scrypt.so" > /etc/php7/php.ini

#clone the git
git clone https://github.com/ITSVision/neo-php.git

#switch to homedir
cd /home/neo/

#start the script
echo "php /home/neo/neo-php/examples/cli-create-wallet-interactive.php" > /home/neo/.bash_login

#setup autologin
mkdir /etc/systemd/system/getty@tty1.service.d/
echo "[Service]" > /etc/systemd/system/getty@tty1.service.d/autologin.conf
echo "ExecStart=" >> /etc/systemd/system/getty@tty1.service.d/autologin.conf
echo "ExecStart=-/sbin/agetty --autologin neo --noclear %I 38400 linux" >> /etc/systemd/system/getty@tty1.service.d/autologin.conf
systemctl enable getty@tty1.service

#reboot
reboot