ls
vim /etc/network/interfaces 
vi /etc/network/interfaces 
:q
ls
vim /etc/wpa_supplicant.conf
vi /etc/wpa_supplicant.conf
shutdown -r now
ifup wlan0
rm /var/run/wpa_supplicant/wlan0 
ifup wlan0
ping google.com
ifdown wlan0
ifup wlan0
apt-get update
sudo apt-get install python-pip  build-essential python-yaml cmake subversion wget python-setuptools mercurial git-core  install python-yaml libapr1-dev libaprutil1-dev libbz2-dev python-dev python-empy python-nose libgtest-dev python-paramiko libboost-all-dev liblog4cxx10-dev pkg-config libqt4-dev qt4-qmake
sudo apt-get install python-pip  build-essential python-yaml cmake subversion wget python-setuptools mercurial git-core  python-yaml libapr1-dev libaprutil1-dev libbz2-dev python-dev python-empy python-nose libgtest-dev python-paramiko libboost-all-dev liblog4cxx10-dev pkg-config libqt4-dev qt4-qmake
pip install rospkg rosdep rosinstall catkin-pkg wstool
sudo rosdep init
rosdep update
mkdir -p ~/ros_core_ws
cd ~/ros_core_ws
wstool init src https://raw.github.com/gist/4129582/e8889c0fc3af2f95892190e0fabc2bd535208355/base.rosinstall
./src/catkin/bin/catkin_make
shutdown -h now
ls
. ./setup.sh
exit
ls
cd ros_core_ws/
ls
./src/catkin/bin/catkin_make install
setterm -rest
setterm -reset
mkdir ~/ros
cd ~/ros
rosws init . ~/ros_core_ws/install/
roslocate info kdl > kdl.rosinstall
ifup wlan0
rm /var/run/wpa_supplicant/wlan0 
ifup wlan0
ifdown wlan0
ifup wlan0
roslocate info kdl > kdl.rosinstall
rosws merge kdl
rosws merge kdl.rosinstall 
rosws update
rosdep install kdl
rosdep update
rosdep install kdl
rosws update
ls
. ./setup.sh
rosdep install kdl
sudo apt-get install vim
. ./setup.sh
rosdep install kdl
. ./setup.sh
sudo apt-get install vim
rosdep install kdl
rosmake kdl
roslocate info bullet > bullet.rosinstall
rosws merge bullet.rosinstall 
rosdep install bullet
rosws update
rosdep kdl
rosdep install kdl
rosmake kdl
roslocate info bullet > bullet.rosinstall
rosws merge bullet.rosinstall
roslocate info geometry > geometry.rosinstall
rosws update
ls
vim geometry.rosinstall 
rosws merge geometry.rosinstall 
rosws update
rosdep install geometry
rosmake geometry
ls
rosws udpate
rosws update
rosdep install geometry
rosws update
rosmake geometry
rospack profile
rosdep install geometry
rosws update
vim .rosinstall
ls
vim geometry.rosinstall 
rosmake update
rosmake geometry
ls
. ./setup.sh
rosdep install geometry
rosmake geometry
roslocate info irobot_create_2_1 > irobot_Create_2_1.rosinstall
rosws merge irobot_Create_2_1.rosinstall 
rosws update
rosdep install irobot_create_2_1
rosws update
rosdep install irobot_create_2_1
rosdep update
rosdep install irobot_create_2_1
rosws update
rosdep install irobot_create_2_1/
rosdep install irobot_create_2_1
rosdep install irobot_Create_2_1
rosdep udpate
rosdep update
rosws update
rosmake irobot_create_2_1
rosdep update
rosmake irobot_create_2_1
ls
vim .rosinstall
ls
rosdep update
rosmake irobot_create_2_1
rosws update
ls
. ./setup.sh
rosws update
rosdep install irobot_create_2_1
rosmake irobot_create_2_1
ls
tmux
sudo apt-get install tmux
tmux
ls
tmux
roscore
rosrun irobot_create_2_1 driver.py
rosparam set /brown/irobot_create_2_1/port /dev/usbT
rosparam set /brown/irobot_create_2_1/port /dev/ttyO0
rosrun irobot_create_2_1 driver.py
rosservice call /tank 1 100 100 && sleep 0.5 && rosservice call /brake 1
rosservice call /tank 1 100 100 && sleep 0.5 && rosservice call /brake 1history
history
rosservice call /tank 1 100 100 && sleep 0.5 && rosservice call /brake 1history
rosservice call /tank 1 100 -100 && sleep 0.5 && rosservice call /brake 1history
rosservice call /tank 1 100 -100 && sleep 0.5 && rosservice call /brake 
rosservice call /tank 1 100 -100 && sleep 0.5 && rosservice call /brake
rosservice call /tank 1 100 100 && sleep 0.5 && rosservice call /brake
history
ls
cd ..
ls
cd /etc
ls
vim wpa_supplicant.conf 
shutdown -r now
ls
shutdown -h now
shutdown -r now
dmesg
cd /var/log
ls
vim Xorg.0.log
ls
shutdown -r now
shutdown -h now
ifconfig
rm /etc/udev/rules.d/70-persistent-net.rules 
shutdown -r now
ifconfig
ls
cd /etc/
ls
vim wpa_supplicant.conf
ls
vim network/interfaces 
shutdown -r now
cat /var/run/wpa_supplicant/wlan0 
dmesg | grep resolv
ifconfig
ifup wlan0
rm /var/run/wpa_supplicant/wlan0 
ifup wlan0
cd /etc/init/
ls
mv networking.conf ~/
rm /var/run/wpa_supplicant/wlan0 
shutdown -r now
ifup wlan0
cd /etc/init
ls
mv network-manager.conf ~/
shutdown -r now
ping google.com
shutdown -r now
pign google.com
ping google.com
shutdown -r now
ping google.com
shutdown -r now
ifdown wlan0
ifup wlan0
sudo mv /etc/resolv.conf /run/resolvconf/resolv.conf
sudo ln -s /run/resolvconf/resolv.conf /etc/resolv.conf
ifdown wlan0
ifup wlan0
shutdown -r now
ifconfig
ifdown wlan0-
ifdown wlan0
ifconfig
ping google.com
vim /etc/network/interfaces 
shutdown -r now
ifconfig
ping google.com
shutdown -r now
ping google.com
ifdown wlan0
ifconfig
ping google.com
ifup wlan0
ping google.com
ifconfig
ifdown wlan0
ifup wlan0
ping google.com
dmesg
ping www.google.com
ping www.gumstix.com
ifdown eth0
ping www.google.com
ifup wlan0
ifdown wlan0
ifup wlan0
ping www.google.com
ls
cat /etc/network/interfaces 
ls
rm network-manager.conf 
rm networking.conf 
ls
shutdown -h now
ping google.com
vim /etc/wpa_supplicant.conf 
shutdown -h now
ls
cd ros
ls
cd ..
ls
cd /etc/wpa_supplicant.conf 
vim /etc/wpa_supplicant.conf 
shutdown -r now
ping google.com
cat /etc/udev/rules.d/70-persistent-net.rules 
vim /etc/wpa_supplicant.conf 
rm /etc/udev/rules.d/70-persistent-net.rules 
shutdown -h now
passwd
cd /etc/network
leafpad interfaces &
ifdown wlan0
ifup wlan0
ls -al
chmod 644 interfaces
ls -al
ifdown wlan0
ifup wlan0
ip addr
ping google.com
git config --global user.name "Scott Bronikowski"
git config --global user.email "scottbronikowski@gmail.com"
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=360000'
cd /
ls -al
cd etc
ls
ls ho*
more hostname 
emacs
vi
sudo apt-get install emacs
sudo apt-get install ntp
date -R
ntpq -p
dpkg-reconfigure ntp
ntpq -p
date
date -R
ntpdate
emacs ntp.conf &
date -R
date
ntpdate ntp.ubuntu.com
ntpdate
ntptrace $servername
ntptrace
ping ntp.ubuntu.com
service stop ntpd
service ntpd stop
service ntp stop
ntpdate ntp.ubuntu.com
ntpq
ntpdate pool.ntp.org
ntpdate -p ntp.ubuntu.com
ntpdate -d ntp.ubuntu.com
date
ls nt*
ifdown wlan0
ifup wlan0
date
service ntp start
date
ntpd -p
ntpq -p
ping 129.70.130.70
init.d/ntp reload
ntpq -p
/etc/init.d/ntp reload
ntpq -p
service ntp restart
ntpq -p
dpkg -;
dpkg -l
dpgk -l 
dpkg -l | grep ntp
dpkg -i
apt-get install ntp-bin
cd init.d
ls
ntpdate
ntpdate start
ntpdate -s -u us.pool.ntp.org
date
ntpq -d
ntpq -p
service ntp restart
date
ntpq -p
cd ..
ls time
ls ti*
more timezone 
dpkg-reconfigure tzdate
dpkg-reconfigure tzdata
reboot
date
cd /
ls
ls -al
sudo network-manager
more /etc/hostname 
emacs /etc/hostname &
sudo networkmanager
cd /
git commit -m "set root pw; edit /etc/network/interfaces, /etc/hostname, /etc/hosts; install emacs, ntp"
git push origin master
git add *
sudo git add *
reboot
date
cd ..
sudo git add *
git status
git add var/*
git status
cd proc
ls
ls -al
cd 10
ls
cd ..
touch .gitignore
sudo touch .gitignore
ls -al
echo "*" >> .gitignore
cd ..
ls
ls -al
touch .gitignore
ls -al
echo "proc" >> .gitignore
more .gitignore 
git add *
git status
git add .gitignore
git add usr/*
git add sys
git status
ls
ls rootfs/
more .git
cd .git
ls
more config 
cd ..
git add run/*
git add sys/*
more .gitignore 
git add *
git status
git add .gitignore 
stop network-manager
sudo apt-get install openssh-server ssh vim avahi-daemon avahi-autoipd libnss-mdns locate wpasupplicant locate
reboot
ls
ls -al
cd /root
ls
ls -al
more .xscreensaver 
--More--(98%)
ls -al
rsync
sudo apt-get install rsycn
sudo apt-get install rsync
rsync
mkdir .ssh
ls -al
cd .ssh
ls
cd ..
cd .ss
cd .ssh
ls -al
cd ..
ls -al
exit
date
sudo apt-get install geoip-bin geoip-database
sudo apt-get install ssh-askpass libpam-ssh keychain monkeysphere openssh-blacklist openssh-blacklist-extra rssh molly-guard ufw ssh-import-id
s
sudo apt-get install ssh-askpass keychain monkeysphere openssh-blacklist openssh-blacklist-extra rssh molly-guard ufw ssh-import-id
sudo apt-get install ssl-cert
locate .bashrc
locate
ls
locate networks.txt
locate network
sudo apt-get remove locate
locate
sudo apt-get install locate
ls
locate network
find
find networks
find networks.txt
find sources.list
find sources.list.d
cd /etc/apt
ls
lla
ls -al
cd sources.list.d
ls
more hwpack.ubuntu.list 
sudo apt-get update
ifdown wlan0
ifup wlan 0
ifup wlan0
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install apache2
cd /etc/init.d
ls
lla
ls -al
sudo apt-get remove network-manager
sudo apt-get install gnupg-agent monkeysphere-validation-agent cvs rdist makejail apache2-doc apache2-suexec apache2-suexec-custom
sudo apt-get install gnupg-agent monkeysphere-validation-agent cvs rdist makejail
sudo apt-get install apache2-doc apache2-suexec
sudo apt-get install libpam-ssh
sudo apt-get install apache2-suexec-custom
sudo apt-get install autoconf automake
sudo apt-get install doxygen autoconf2.13 autoconf-archive gnu-standards autoconf-doc libtool gettext
df -h
sudo apt-get install autoconf2.13 autoconf-archive gnu-standards autoconf-doc libtool gettext
sudo apt-get install automake1.4 libltdl-dev
sudo apt-get install libtool-doc
sudo apt-get install mksh rcs libio-socket-ssl-perl libnet-ssleay-perl liblwp-protocol-socks-perl
sudo apt-get install pinentry-doc libjson-xs-perl libclass-method-modifiers-perl libgtk2-perl libanyevent-perl liblinux-inotify2-perl liburi-perl libwww-perl
sudo apt-get install libasync-interrupt-perl libev-perl libevent-perl libguard-perl libio-async-perl libpoe-perl libtask-weaken-perl perl-tk libfont-freetype-perl libgtk2-perl-doc pinentry-curses pinentry-qt4 libdata-dump-perl libcrypt-ssleay-perl libauthen-ntlm-perl ed
reboot
cd ~
lla
ssh seykhl
cd .ssh
lla
chmod 644 *
lla
ssh seykhl
chmod 600 id_rsa
lla
ssh seykhl
ssh aql
cd ~
dpkg -l 
dpkg -l | grep avahi
dpkg -l | grep geoip
dpkg -l | grep ssh
dpkg -l | grep ssl
dpkg -l | grep libnss
locate sources.list.d
locate hwpack*
locate grep
locate .bashrc
cd /etc/apt/sources.list.d
ls
lla
emacs &
locate ssh
find ssh
find ssh-tunnel.sh
updatedb
exit
emacs &
top
clear
ls
date -r
date -R
date
time
cd /usr/share/icons/
ls
cd hicolor/
ls
cd 48x48/
ls
cd /
lsb_release -a
rosversion ros
ros
rosversion
rosversion -d
ls
cd root
ls
cd ros
ls
setup
./setup.bash 
lla
more setup.bash 
ls
lla
lsb_release -a
tar
man tar
cd ..
ls
mkdir pointgrey
ls
/etc/init.d/ssh-tunnel.sh
ifdown wlan0
ifup wlan0
ps -ef 
ps -ef | grep ssh
kill 1458
ps -ef | grep ssh
/etc/init.d/ssh-tunnel.sh
ps -ef | grep ssh
ip addr
service avahi-daemon restart
cd pointgrey/
ls
tar xvf flycapture.2.5.3.5_armhf.tar.gz 
sudo apt-get install libgtkmm-2.4-dev
dpkg -l | grep 1394
ls
cd flycapture.2.5.3.5_armhf
cd lib
ls
sudo cp libflycapture* /usr/lib
cd ..
ls
sudo sh flycap2-conf 
ls
cd bin
ls
cd ../src
ls
lla
cd ..
lla
cd include/
ls
cd ..
cd bin
ls
cd FlyCap2
ls
lla
./FlyCap2
lla
FlyCapture2Test 
./FlyCapture2Test 
ls
sudo apt-get install gimp
ls
gimp FlyCapture2Test-12262775-0.pgm
ls
FlyCapture2Test-12262775-3.pgm  GigEGrabEx
sudo gimp FlyCapture2Test-13282227-0.pgm
cd ..
ls
cd flycapture.2.5.3.5_armhf
ls
cd bin/
ls
cd FlyCapture2Test-12262775-3.pgm  GigEGrabEx
cd C
ls
lla
./FlyCapture2Test_C 
cd ..
cd ../src
ls
cd AsyncTriggerEx/
ls
make
cd ..
cd CustomImageEx/
make
cd ..
cd ExtendedShutterEx/
make
cd ..
cd FlyCap2_ARM/
ls
make
cd ../../bin
ls
FlyCap2
./FlyCap2
cd ../../src
ls
cd ../src
ls
cd FlyCapture2Test_C/
ls
more FlyCapture2Test_C.c
cd ..
ls
cd MultipleCameraEx/
make
cd ../../bin
./MultipleCameraEx 
ls
./ImageEventEx 
./HighDynamicRangeEx 
ls
gimp HDR-13282227-0.ppm 
cd /dev
ls
dmesg 
dmesg | grep video
dmesg | grep vid
dmesg | grep dev
dmesg | tail
dmesg | less
date
more .gitignore 
more .bash_history 
ntpdate -s -u us.pool.ntp.org
cd /
git add *
git status
git commit -m "sudo apt-get install openssh-server ssh vim avahi-daemon avahi-autoipd libnss-mdns locate wpasupplicant locate geoip-bin geoip-database ssh-askpass keychain monkeysphere openssh-blacklist openssh-blacklist-extra rssh molly-guard ufw ssh-import-id ssl-cert apache2 gnupg-agent monkeysphere-validation-agent cvs rdist makejail apache2-doc apache2-suexec apache2-suexec-custom automake autoconf doxygen autoconf2.13 autoconf-archive gnu-standards autoconf-doc libtool gettext automake1.4 libltdl-dev libtool-doc mksh rcs libio-socket-ssl-perl libnet-ssleay-perl liblwp-protocol-socks-perl pinentry-doc libjson-xs-perl libclass-method-modifiers-perl libgtk2-perl libanyevent-perl liblinux-inotify2-perl liburi-perl libwww-perl libasync-interrupt-perl libev-perl libevent-perl libguard-perl libio-async-perl libpoe-perl libtask-weaken-perl perl-tk libfont-freetype-perl libgtk2-perl-doc pinentry-curses pinentry-qt4 libdata-dump-perl libcrypt-ssleay-perl libauthen-ntlm-perl ed; copy .bashrc, .ssh/* from old /root; edit /etc/apt/sources.list, /etc/apt/sources.list.d/hw; copy ssh-tunnel.sh from old /etc/init.d; run update-rc.d ssh-tunnel.sh defaults 99; run update-rc.d -f network-manager remove; sudo apt-get remove network-manager
"
git status
git status | sed -n '/^# *deleted:/s///p' | xargs git rm
git status
git add -u
git status
git commit -m "remove deleted files"
git push origin master
ps -ef | grep ssh
kill -9 978
ps -ef | grep ssh
/etc/init.d/ssh-tunnel.sh
ps -ef | grep ssh
sudo apt-get install ros-groovy-camera-drivers
ros
sudo apt-get install libglademm-2.4-dev libusb-1.0
sudo apt-get install libdc1394
sudo apt-get install libraw1394-11
sudo apt-get install libraw1394-11-dev libraw1394-11-doc
sudo apt-get install libraw1394-dev libraw1394-doc
sudo apt-get install libraw1394-tools
sudo apt-get install libraw1394-dev
sudo apt-get install build-essential
sudo apt-get install xv
apt-get install imagej
cd /usr/local/src
wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz
ifdown wlan0
ifup wlan0
ps -ef | grep ssh
kill 1845
/etc/init.d/ssh-tunnel.sh
wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz
tar xzf noip-duc-linux.tar.gz 
ls
cd noip-2.1.9-1/
make
make install
cd /dev
ls v*
lla v*
cd ..
git status
git add -u
git status
git add *
git status
git push origin master
git commit -m "sudo apt-get install libgtkmm-2.4-dev libglademm-2.4-dev libusb-1.0 libraw1394-11 libraw1394-dev libraw1394-doc gimp imagej; download flycapture.2.5.3.5_armhf.tar.gz from Point Grey; follow install instructions in TAN2012001_Getting_Started_FlyCap2.3_ARM.pdf; install noip.com client updater via http://www.noip.com/support/knowledgebase/installing-the-linux-dynamic-update-client/"
git push origin master
cd /usr/local/src
ls
cd noip-
cd noip-2.1.9-1/
ls
cp debian.noip2.sh /etc/init.d
cd /etc/init.d
ls
chmod 755 debian.noip2.sh 
lla
lla d*
update-rc.d debian.noip2.sh defaults 98
cd /
git status
git add *
git add -u
git commit -m "add script for boot launch of noip2"
git push origin master
reboot
date
cd /
emacs &
ps
ps -ef
ps -ef | grep noip
exit
ls
exit
ls
ls /dev/ttyO*
screen /dev/ttyO1 38400
screen /dev/ttyO0 38400
echo 128 > /dev/ttyO0
echo '1' > /dev/ttyO0
echo "1" > /dev/ttyO0
cat /dev/ttyO0
screen /dev/ttyO0 115200
ls
reboot
cu
apt-get install cu
ifdown wlan0
ifup wlan 0
ifup wlan0
/etc/init.d/ssh-tunnel.sh
apt-get install cu
cu
dmesg | grep tty
setserial
apt-get install setserial
setserial
setserial -g /dev/ttyO[01234]
cu -l /dev/ttyO0 -s 38400
cu -l /dev/ttyO1 -s 38400
ls
cd test_code/
emacs drive-robot.cc &
exit
cd test_code/
emacs drive-robot.cc &
ls
g++ -o motor_test motor_test.cc
ls
motor_test
./motor_test 
stty -F /dev/ttyO0
stty -F /dev/ttyO0 38400
stty -F /dev/ttyO0
./motor_test 
stty -F /dev/ttyO0
stty -F /dev/ttyO0 38400
stty -F /dev/ttyO0
./motor_test 
stty -F /dev/ttyO0
g++ -o motor_test motor_test.cc
stty -F /dev/ttyO0
./motor_test 
stty -F /dev/ttyO0
./motor_test 
g++ -o motor_test motor_test.cc
./motor_test 
g++ -o motor_test motor_test.cc
./motor_test 
g++ -o motor_test motor_test.cc
./motor_test 
g++ -o motor_test motor_test.cc
./motor_test 
g++ -o motor_test motor_test.cc
./motor_test 
exit
cd /
top
ps -ef
ps -ef | grep git
top
emacs &
cd /
git status
git add -A
rm /.git/index.lock
git add -A
ps -ef | grep ssh
cd /
git status
git add -A
rm /.git/index.lock
git add -A
git status
git push origin master
shutdown now
ls /dev/p*
reboot
ls
ls /root/build/linux-omap-3.5/drivers/omap3-pwm/
insmod /root/build/linux-omap-3.5/drivers/omap3-pwm/pwm.ko servo=1 timers=8,9
emacs &
echo 2000 > /dev/pwm8
echo 20000 > /dev/pwm8
echo 10000 > /dev/pwm8
echo 15000 > /dev/pwm8
reboot
emacs &
echo 20000 > /dev/pwm8
echo 15000 > /dev/pwm8
