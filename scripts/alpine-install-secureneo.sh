echo "#SecureNEO important repos" > /etc/apk/repositories
echo "http://mirror1.hs-esslingen.de/pub/Mirrors\
/alpine/edge/main" >> /etc/apk/repositories
echo "http://mirror1.hs-esslingen.de/pub/Mirrors\
/alpine/edge/community" >> /etc/apk/repositories

# Update and upgrade
apk update && apk upgrade

#add dependencies
apk add \
	bash ca-certificates git curl php7 php7-zlib \
	php7-opcache php7-mcrypt  php7-dev \
	php7-openssl php7-curl php7-json php7-mbstring \
	php7-pear php7-gmp php7-bcmath \
	g++ make util-linux

#install scrypt
printf "\n" | pecl install scrypt
echo "extension=scrypt.so" > /etc/php7/php.ini
#clone repo

#add the user
adduser -s /bin/bash -S neo
echo -e "neo\nneo" | (passwd neo)

#switch to homedir
cd /home/neo/

#clone the git
git clone https://github.com/ITSVision/neo-php.git

#start the script
echo "php /home/neo/neo-php/examples/cli-create-wallet-interactive.php" > /home/neo/.bash_login

#make the neo user login on start up
sed -i "s/tty1::respawn:\/sbin\/getty 38400 tty1/tty1:23456:respawn:\/sbin\/agetty -a neo -8 -s 38400 tty1/g" /etc/inittab

#reboot
reboot