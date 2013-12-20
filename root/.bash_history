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
