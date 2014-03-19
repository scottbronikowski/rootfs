top
emacs &
cd test_code/flycapture/include/C
ls
grep -i "property" *
grep -i "fc2Context" *
ls
cd ../
cd ..
cd src/
ls
cd MultipleCameraEx/
ls
emacs MultipleCameraEx.cpp &
cd ..
cd..
cd ..
grep -r "fc2StartSyncCapture" *
top
reboot
cd /
git status
git add -A
git commit -m "got test.c to work reliably for a color image; now need to modify test-capture-c.c to work better"
git push
git add -A
git commit -m "working on test2.c--pictures good when starting and stopping capture inside picture taking loop, but bad when starting in init loop"
git push
git add -A
git commit -m "got test2.c working with numPics and write input--still chasing down crash"
git push
emacs &
cd test_code/flycapture/src/testing
ls
./c-test-capture 1 write
./test2 40
./cpp-test-capture 1 write
./cpp-test-capture 11
./test2 40 write
ls
make clean
ls
tar -czf testing-25-feb.tgz *
ls
lla
rsync -avz ./testing-25-feb.tgz seykhl:.
./test2 100
ls
make
./test2 100
emacs &
top
cd pointgrey/flycapture.2.6.3.2_armhf/bin/
ls
./FlyCap2
lsusb
reboot
ls
reboot
cd pointgrey/flycapture.2.6.3.2_armhf/bin
./FlyCap2
lsusub
lsusb
ifdown wlan0
reboot
cd test_code/flycapture/src/testing
ls
./c-test-capture 1 write
./test2
emacs &
make
./test2 1 
/etc/init.d/ssh-tunnel.sh start
halt
emacs &
cd test_code/flycapture/src/support/
make
ls
make clean
ls
make clean
make
ls
make clean
ls
make
./test2 50
./test2 1 write
make
./test2 50
make
make clean
tar -czf test2.tgz *
ls
rm *.tgz
tar -cvzf test2.tgz *
rsync -avz test2.tgz seykhl:.
cd ../testing
cd
cd test_code/flycapture/
ls
cd src
ls
cd testing
ls
./test2 100
ls
mkdir ../support
cp test2.c ../support
cp test2.h ../support
cp RoverCamDefs.h ../support
cp Makefile ../support
cd ../support
ls
cd ../testing
emacs &
cd test_code/
ls
./motor_control 
./motor_control forward_1
./motor_control 
./motor_control forward_1
./motor_control 
ifdown wlan0
ifup wlan0
/etc/init.d/ssh-tunnel.sh start
reboot
test_code/motor_control
test_code/motor_control forward_2
test_code/motor_control
lsusb
reboot
emacs &
ps -ef | grep ping
vi /etc/init.d/keepalive-ping.sh 
ping www.purdue.edu
/etc/init.d/keepalive-ping.sh start
cd test_code/flycapture/src/testing
ls
./test2 10 write
make
./test2 10 write
make
./test2 10 write
./test2 10
./test2 10 write
make
./test 10 write
./test2 10 write
../../bin
cd ../../bin
ls
cd C
ls
./FlyCapture2Test_C 
cd /
git status
git add -A
git commit -m "commit before modifying test2.c to remove all Imlib2 references"
git push
emacs &`

emacs &
top
reboot
ls
cp testcapture.cc testcapture.cc.backup
make clean
emacs &
cd pointgrey/flycapture.2.6.3.2_armhf/bin
ls
lla /tmp/images
cd /tmp
ls
cd ~/pointgrey/flycapture.2.6.3.2_armhf/bin
ps -ef | grep emacs
kill -9 1112
emacs &
./testcapture 2
lsusb
./testcapture 2
make
./testcapture 2
./testcapture 10
./testcapture 100
lsusb
top
emacs &
top
reboot
emacs &
cd pointgrey/flycapture.2.6.3.2_armhf/src/testing/
emacs &
cd ../../bin
ls
./testcapture 50
lsusb
./testcapture 50
lsusb
./testcapture 50
rm /tmp/images/OLD*
./testcapture 5
rm /tmp/images/OLD*
./testcapture 5
rm /tmp/images/OLD*
./testcapture 50
lsusb
reboot
top
ps -ef | grep ssh
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
ps -ef | grep ping
reboot
cd test_code/flycapture/src/CustomImageEx/
ls
cp CustomImageEx.cpp CustomImageEx-original.cpp
rsync -avz seykhl:~/CustomImageEx.cpp .
lla
make
emacs &
kill -9 1141
emacs &
cd test_code/flycapture/src/support/
ls
rm test2.tgz
make clean
cat Makefile 
tar -cvzf test2.tgz *
rsync test2.tgz seykhl:~/test2.tgz
cd /
git status
git add -A
git commit -m "more work on testing/test2.c, support/test2.c, old testcapture.cc under ~/pointgrey"
cd test_code/flycapture/bin
ls
./CustomImageEx 
lla
lsusb
cd test_code/flycapture/bin
./CustomImageEx 
lsusb
reboot
cd test_code/flycapture/src/support/
cd test_code/flycapture/bin
ls
rm *.ppm
./CustomImageEx 
ls
rm *-99*
./CustomImageEx 
emacs &
top
reboot
cd test_code/flycapture/src/CustomImageEx/
make
rsync CustomImageEx.cpp seykhl:~/.
lsusb

ls
cd test_code/flycapture/bin
./CustomImageEx 
reboot
cd test_code/flycapture/bin
./CustomImageEx 
exit
halt
cd test_code/flycapture/bin
ls
./CustomImageEx 
date
/etc/init.d/time-update.sh start
date
date
daet
date
cd test_code/flycapture/bin
./CustomImageEx 
emacs &
cd ..
cd src/
ls
cd ../bin
cd ../src/Cu
cd ../src/CustomImageEx/
make
../../bin/CustomImageEx 
ls ../../bin
lla ../../bin
rm ../../bin/*.ppm
lla ../../bin
../../bin/CustomImageEx 
lla ../../bin
ls
rm *.ppm
cd ../../bin
./CustomImageEx 
lla
halt
hwclock
date
hwclock -s
date
hwclock
vi /etc/init.d/time-update.sh 
halt
date
hwclock
vi /etc/init.d/time-update.sh 
halt
/etc/init.d/time-update.sh start
vi /etc/init.d/time-update.sh 
/etc/init.d/time-update.sh 
/etc/init.d/time-update.sh start
halt
date
hwclock
date
cd /etc/init.d/
ls ../rc2.d/
update-rc.d -f remove time-update.sh 
update-rc.d -f time-update.sh remove
halt
date
hwclock
ntpdate -s -u us.pool.ntp.org
date
hwclock
hwclock -w
hwclock
date
cd /etc/init.d
ls ../rc2.d/
update-rc.d time-update.sh defaults 99
halt
date
hwclock
vi /etc/init.d/time-update.sh 
date
hwclock
vi /etc/init.d/time-update.sh 
hwclock -w
datge
date
hwclock
halt
date
hwclock
cd /etc/init.d/
update-rc.d time-update.sh remove
update-rc.d -f time-update.sh remove
ls ../rc2.d/
update-rc.d time-update.sh defaults 98
halt
date
hwclock
vi /etc/init.d/time-update.sh 
halt
date
hwclock
hwclock -w
hwclock
date
vi /etc/init.d/time-update.sh 
halt
reboot
date
ntpdate
ntpdate -vq us.pool.ntp.org
ntpdate -v us.pool.ntp.org
ps -ef | grep ntp
ntpd
ntpdate -v us.pool.ntp.org
date
ls /etc/init.d/
ls /etc/init.d/n*
vi /etc/init.d/ntp
man ntp
man ntpd
ntpd -g
date
dmesg | tail
locate ntp.conf
vi /etc/ntp.conf
/etc/init.d/ntp stop
/etc/init.d/ntp start
date
ntpd
date
nptd -g -u ntp:ntp
ntpd -g -u ntp:ntp
date
locate syslog
more /var/log/syslog
lla /var/log/sys*
more /var/log/syslog.1
more /var/log/syslog.1 | grep ntp
ntpdate -v pool.ntp.org
ls /etc/rc2.d/
cd /etc/init.d/
update-rc.d -f time-update.sh remove
update-rc.d time-update.sh defaults 27
vi time-update.sh 
halt
date
hwclock
ntpdate pool.ntp.org
ntpdate -uv ntp.ubuntu.com pool.ntp.org
date
hwclock
hwclock -w
hwclock
date
vi /etc/init.d/time-update.sh 
date
halt
hwclock
date
vi /etc/init.d/time-update.sh 
ls
halt
date
ntpdate -uv ntp.ubuntu.com
date
ntpdate -buv ntp.ubuntu.com
date
ntpdate -buv pool.ntp.org
date
hwclock
cat /etc/timezone 
vi /etc/init.d/time-update.sh 
halt
date
vi /etc/init.d/time-update.sh 
halt
date
ntpdate -buv ntp.ubuntu.com
date
hwclock
ntpdate -v ntp.ubuntu.com
ntpdate -uv ntp.ubuntu.com
vi /etc/init.d/time-update.sh 
halt
ls /etc/rc2.d/
cd /etc/init.d/
update-rc.d -f keepalive-ping.sh remove
update-rc.d keepalive-ping.sh defaults 25
update-rc.d -f time-update.sh remove
update-rc.d -f ntp remove
update-rc.d time-update.sh defaults 23
update-rc.d ntp defaults 24
vi time-update.sh 
halt
date
ntpq -d
ntpq -p
cd /etc/init.d/
ls
update-rc.d -f time-update.sh remove
halt
ntpq -p
date
hwclock
cd /etc/init.d/
update-rc.d time-update.sh defaults 98
vi time-update.sh 
halt
date
vi /etc/init.d/time-update.sh 
halt
ntpq -p
cd /etc/init.d/
ls ../rc2.d/
update-rc.d -f time-update.sh remove
update-rc.d time-update.sh defaults 99
vi time-update.sh 
halt
date
hwclock
ls /etc/rc2.d/
vi /etc/init.d/monitor.sh 
halt
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
date
vi /etc/init.d/time-update.sh 
emacs &
cd test_code/flycapture/bin
ls
rm *.ppm
./CustomImageEx 
lsusb
./CustomImageEx 
reboot
cd test_code/flycapture/src/support/
ls
rsync seykhl:~/*test.c .
ls
cat test.c
cd ../CustomImageEx/
ls
lla
top
date
hwclock
cd test_code/flycapture/bin
ls
./CustomImageEx 
cd test_code/flycapture/src/CustomImageEx/
emacs &
top
reboot
cd test_code/flycapture/bin
./CustomImageEx 
reboot
cd test_code/flycapture/src/CustomImageEx/
emacs &
cd test_code/flycapture/src/CustomImageEx/
./CustomImageEx 
cd ../../bin
./CustomImageEx 
reboot
cd test_code/flycapture/src/CustomImageEx/
emacs &
cd test_code/flycapture/bin
./CustomImageEx 
reboot
cd test_code/flycapture/src/CustomImageEx/
emacs &
top
cd test_code/flycapture/bin
./CustomImageEx 
reboot
cd test_code/flycapture/bin
./CustomImageEx 
reboot
cd test_code/flycapture/bin
./CustomImageEx 
lsusb
reboot
cd test_code/flycapture/src/CustomImageEx/
emacs &
cd test_code/flycapture/bin
./CustomImageEx 
lsusb
cd test_code/flycapture/bin
./CustomImageEx 
emacs &
./CustomImageEx 
reboot
cd test_code/flycapture/bin
./CustomImageEx 
lsusb
./CustomImageEx 
ls ../
cd ../include/
ls
cd test_code/flycapture/src/support/
ls
make
./test2 
lsusb
cat Makefile 
less simpletest.c 
cat simpletest.c 
~gcc -Wall -g -I/usr/include/flycapture -std=gnu99 -o simpletest simpletest.c -L/usr/lib -lflycapture-c `imlib2-config --cflags --libs`
gcc -Wall -g -I/usr/include/flycapture -std=gnu99 -o simpletest simpletest.c -L/usr/lib -lflycapture-c `imlib2-config --cflags --libs`
gcc -Wall -g -I/../../include/ -std=gnu99 -o simpletest simpletest.c -L/../../lib -lflycapture-c `imlib2-config --cflags --libs`
gcc -Wall -g -I../../include/ -std=gnu99 -o simpletest simpletest.c -L../../lib -lflycapture-c `imlib2-config --cflags --libs`
./simpletest 
./simpletest 1
reboot
cd test_code/flycapture/bin/
ls
./CustomImageEx 
emacs &
ls
rm *.ppm
./CustomImageEx 
lsusb
reboot
cd test_code/flycapture/bin
./CustomImageEx 
lsusb
reboot
ps -ef | grep ssh
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
cd test_code/flycapture/bin
./CustomImageEx 
reboot
emacs &
date
hwclock
cd test_code/flycapture/bin
./CustomImageEx 
lsusb
cd ~
vi notes3march.txt 
emacs notes3march.txt &
top
reboot
cd test_code/flycapture/bin
./CustomImageEx 
reboot
cd test_code/flycapture/bin/
./CustomImageEx 
exit
emacs &
ps -ef | grep emacs
kill -9 1210
emacs &
top
exit
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
reboot
ls
rm notes3march.txt 
emacs &
dpkg-query -l
dpkg-query -l > query.txt
ls
ps -ef | grep gvfs
lsof
aptitude why gvfs
aptitude why gvfs-backends
aptitude
cd test_code/flycapture/bin/
./CustomImageEx
ls
feh 12262775-final.ppm 
feh *.ppm
rfkill list
rfkill help
cd test_code/flycapture/bin
./CustomImageEx 
reboot
cd test_code/flycapture/bin
./CustomImageEx 
lsusb
reboot
cd test_code/flycapture/src/CustomImageEx/
emacs &
cd test_code/flycapture/bin
./CustomImageEx 
ls
rm *.ppm
./CustomImageEx 
reboot
cd test_code/flycapture/src/CustomImageEx/
emacs &
ls
make
Dmake
make
cd test_code/flycapture/bin
./CustomImageEx 
reboot
cd test_code/flycapture/src/CustomImageEx/
emacs &
date
ntpq -p
date
hwclock 
service ntpd restart
service ntp restart
date
ntpq -p
date
vi /etc/ntp.conf
cat /var/lib/ntp/ntp.drift 
/etc/init.d/ntp stop
/etc/init.d/ntp start
date
ntpq -p
date
vi /etc/init.d/ntp
date
ntpd -q
date
ntpq -p
ntpdate -s -u pool.ntp.org
date
hwclock
/etc/init.d/time-update.sh start
hwclock
ntpd -g
date
ntpq -p
/etc/init.d/ntp stop
/etc/init.d/ntp start
/etc/init.d/ntp stop
ntpd -gq
ntpd -g
/etc/init.d/ntp start
date
exit
emacs &
exit
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
halt
date
ntpq -p
nptd -gq
ntpd -gq
date
vi /etc/init.d/ntp
halt
date
ntpd 
date
n
ping www.purdue.edu
date
ntpd -gq
date
ntpq -d
ntpq -p
date
ntpd -gq
date
reboot
emacs &
date
ntpdate -uvb ntp.ubuntu.com us.pool.ntp.org
date
hwclock
hwclock -w
hwclock
ntpdate -uvb ntp.ubuntu.com us.pool.ntp.org
exit
cd /etc/init.d/
ls ../rc2.d/
locate ntpdate
exit
date
ntpd -gq
date
ntpd -v
man ntpd
ntpd -help
date
ntpd -gq
ntpd -g
date
/etc/init.d/ntp stop
date
ntpd -gq
date
ntpd -q
date
ntpd -gq
date
hwclock
date
halt
emacs /etc/init.d/time-update.sh &
exit
exit
date
hwclock
halt
date
ifdown wlan0
ifup wlan0
ping www.purdue.edu
date
reboot
date
ping www.google.com
date
hwclock
vi /etc/init.d/time-update.sh 
reboot
date
hwclock
date
hwclock -w
date
hwclock
halt
date
hwclock
date
hwclock
hwclock -w
hwclock
hwclock --debug
vi /etc/init.d/time-update.sh 
halt
exit
top
cd test_code/flycapture/bin
./CustomImageEx 
ls /tmp/images
lla
date
hwclock
date
hwclock
date
cd /
git add -A
git commit -m "tweaks to bootup time sync in /etc/init.d/ntp and time-update.sh--looks like it should update 'date' and 'hwclock' correctly now"
git push
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
ifdown wlan0
ifup wlan0
ps -ef | grep ping
/etc/init.d/keepalive-ping.sh stop
/etc/init.d/keepalive-ping.sh start
ps -ef | grep ping
kill -9 911
ps -ef | grep ping
/etc/init.d/ssh-tunnel.sh start
cd test_code/flycapture/src/CustomImageEx/
emacs &
cd test_code/flycapture/bin
./CustomImageEx 
reboot
ps -ef | grep ssh
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
cd test_code/flycapture/src/CustomImageEx/
emacs &
cd
reboot
cd test_code/flycapture/bin
./Cus
./CustomImageEx 
reboot
date
cd test_code/flycapture/src/CustomImageEx/
cd test_code/flycapture/bin
./CustomImageEx 
emacs CustomImageEx.cpp &
reboot
cd test_code/flycapture/src/CustomImageEx/
emacs CustomImageEx.cpp &
make
reboot
cd test_code/flycapture/bin
./CustomImageEx 
cd test_code/flycapture/bin
./CustomImageEx 
reboot
cd test_code/flycapture/bin
./CustomImageEx 
reboot
cd test_code/flycapture/src/CustomImageEx/
emacs CustomImageEx.cpp &
cd test_code/flycapture/src/CustomImageEx/
emacs CustomImageEx.cpp &
make
cd test_code/flycapture/bin
./CustomImageEx 
reboot
cd test_code/flycapture/src/CustomImageEx/
emacs CustomImageEx.cpp &
make
ls
chmod a+x bigtest.sh 
ls
./bigtest
./bigtest.sh 
make
./bigtest.sh 
make
./bigtest.sh 
make
./bigtest.sh 
make
./bigtest.sh 
make
./bigtest.sh 
make
reboot
cd test_code/flycapture/bin
./CustomImageEx 
lsusb
cd test_code/flycapture/src/CustomImageEx/
emacs CustomImageEx.cpp &
make
./bigtest.sh 
cd test_code/flycapture/bin
./CustomImageEx 
lsusb
reboot
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
cd test_code/flycapture/src/CustomImageEx/
./bigtest.sh 
reboot
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
cd test_code/flycapture/src/CustomImageEx/
./bigtest.sh 
lsusb
reboot
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
cd test_code/flycapture/src/CustomImageEx/
./bigtest.sh 
reboot
exit
cd /
git status
git add -A
git commit -m "more work on CustomImageEx.cpp--set cameras to synchronized frame rate--still having problem of cameras dying after a random number of captures"
git push
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
ifdown wlan0
ifup wlan0
ps -ef | grep ntp
ps -ef | grep ping
/etc/init.d/keepalive-ping.sh start
/etc/init.d/ssh-tunnel.sh start
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
ps -ef | grep ping
/etc/init.d/keepalive-ping.sh stop
ps -ef | grep ping
kill -9 1102
ps -ef | grep ping
ps -ef | grep ssh
ifdown wlan0
ifup wlan0
/etc/init.d/keepalive-ping.sh start
ps -ef | grep ping
/etc/init.d/ssh-tunnel.sh start
cd test_code/flycapture/src/CustomImageEx/
emacs CustomImageEx.cpp &
make
./bigtest.sh 
make
reboot
cd test_code/flycapture/bin
./CustomImageEx 
top
reboot
halt
exit
date
hwclock
hwclock -w
hwclock
halt
cd test_code/flycapture/src/CustomImageEx/
./bigtest.sh 
cd test_code/flycapture/bin
./CustomImageEx 
exit
cd test_code/flycapture/src/CustomImageEx/
emacs CustomImageEx.cpp &
make
./bigtest.sh 
lsusub
lsusb
exit
halt
cd test_code/flycapture/src/CustomImageEx/
emacs CustomImageEx.cpp &
make
reboot
cd test_code/flycapture/bin
./CustomImageEx 
lsusb
cd test_code/flycapture/src/CustomImageEx/
emacs CustomImageEx.cpp &
make
top
exit
cd test_code/flycapture/bin
./CustomImageEx 
top
./CustomImageEx 
top
exit
date
ifdown wlan0
ifup wlan0
/
/etc/init.d/ntp
/etc/init.d/ntp start
date
/etc/init.d/keepalive-ping.sh start
/etc/init.d/ssh-tunnel.sh start
reboot
[]
top
hwclock
halt
cd test_code/flycapture/bin
./CustomImageEx 
cd test_code/flycapture/src/CustomImageEx/
emacs CustomImageEx.cpp &
top
emacs CustomImageEx.cpp &
top
reboot
exitexit
exit
ATZ
AT S7=45 S0=0 L1 V1 X4 &c1 E1 Q0
ls
top
ls
top
/etc/init.d/monitor.sh stop
top
reboot
/etc/init.d/monitor.sh stop
top
ps -ef | grep ssh
to
top
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
cd test_code/flycapture/bin
top
apt-get install htop
apt-get autoremove
htop
reboot
cd test_code/flycapture/src/CustomImageEx/
emacs CustomImageEx.cpp &
ls
cd test_code/flycapture/bin
./CustomImageEx 
lsusb
cd test_code/flycapture/bin
./CustomImageEx 
rm /tmp/images/*
./CustomImageEx 
lsusb
htop
reboot
cd test_code/flycapture/src/CustomImageEx/
emacs CustomImageEx.cpp &
cd test_code/flycapture/src/testing
ls
cd ..
cd support/
ls
htop
reboot
cd test_code/flycapture/src/bin
cd test_code/flycapture/bin
./CustomImageEx 
lsusb
cd test_code/flycapture/src/CustomImageEx/
emacs CustomImageEx.cpp &
htop
reboot
cd test_code/flycapture/bin
./CustomImageEx 
lsusb
cd test_code/flycapture/src/CustomImageEx/
emacs openfiles.txt &
htop
reboot
cd test_code/flycapture/bin
./CustomImageEx 
lsusb
cd test_code/flycapture/src/CustomImageEx/
emacs CustomImageEx.cpp &
make
cd test_code/flycapture/src/CustomImageEx/
emacs CustomImageEx.cpp &
ls
emacs openfiles.txt &
kill -9 1157
exit
cd test_code/flycapture/bin
./CustomImageEx 
ls
apt-get install opencv
apt-cache search opencv
lsusb
dpkg --get-selections | grep libdc
dpkg --get-selections | grep ff
ssh -T git@github.com
apt-get install libcv-dev libcv2.3 libcvaux-dev libcvaux2.3 libhighgui-dev libhighgui2.3 libopencv-calib3d-dev libopencv-calib3d2.3 libopencv-contrib-dev libopencv-contrib2.3 libopencv-core-dev libopencv-core2.3 libopencv-dev libopencv-features2d-dev libopencv-features2d2.3 libopencv-flann-dev libopencv-flann2.3 libopencv-gpu-dev libopencv-gpu2.3 libopencv-highgui-dev libopencv-highgui2.3 libopencv-imgproc-dev libopencv-imgproc2.3 libopencv-legacy-dev libopencv-legacy2.3 libopencv-ml-dev libopencv-ml2.3 libopencv-objdetect-dev libopencv-objdetect2.3 libopencv-video-dev libopencv-video2.3 opencv-doc python-opencv libfaad-dev libgsm1-dev libogg-dev libschroedinger-dev libspeex-dev libtheora-dev libvorbis-dev
cd test_code/flycapture/src/CustomImageEx/
emacs CustomImageEx.cpp &
date
emacs &
htop
halt
cd test_code/flycapture/bin
apt-get --reinstall dictionaries-common
apt-get install dictionaries-common
ispell
aspell
apt-get install ispell
apt-get install aspell
apt-get install spell iamerican ispell-dictionary wamerican wordlist aspell-doc spellutils aspell-en aspell-dictionary aspell6a-dictionary
apt-get install spell iamerican wamerican aspell-doc spellutils aspell-en
./CustomImageEx 
ps -ef | grep Cus
./CustomImageEx 
lsusb
date
lsusb
echo 20000 > /dev/pwm10
echo 20000 > /dev/pwm9
echo 15000 > /dev/pwm9
echo 15000 > /dev/pwm10
reboot
cd test_code/flycapture/src/CustomImageEx/
ls
vi bigtest.sh 
./bigtest.sh 
reboot
emacs today.text &
exit
halt
reboot
halt
/e
ls /etc/init.d
ls /etc/rc2.d/
/etc/init.d/servo-control.sh stop
/etc/init.d/servo-control.sh start
echo 17000 > /dev/pwm10
echo 15000 > /dev/pwm10
emacs today.text &
cd test_code/flycapture/src/CustomImageEx/
ls
cd test_code/flycapture/bin
./CustomImageEx 
htop
reboot
emacs today.text &
exit
exit
exit
emacs today.text &
cd test_code/fl
cd test_code/flycapture/src/CustomImageEx/
ls
cd test_code/flycapture/bin
./CustomImageEx 
lsusb
htop
reboot
emacs today.text &
cd test_code/flycapture/bin
./CustomImageEx 
lsusb
htop
reboot
cd /
git status
git add -A
git commit -m "***CustomImageEx.cpp now sends dummy data across network (first length len, then string data of length len).  Should be able to modify to send image dimensions followed by image data***
removed ntpdate call from /etc/init.d/ntp--seems to be ok now with backup battery;
apt-get install dictionaries-common ispell aspell spell iamerican wamerican aspell-doc spellutils aspell-en;
created separate Network_StartCameras(), Imlib_GetFrameWithResize() functions in CustomImageEx.cpp;
"
git push
echo 20000 > /dev/pwm10
echo 10000 > /dev/pwm10
echo 15000 > /dev/pwm10
emacs today.text &
cd test_code/flycapture/src/CustomImageEx/
make
cd test_code/flycapture/bin
./CustomImageEx 
~~~~~~~~~~~~~~~~~~~~~~~~~
./CustomImageEx 
lsusb
htop
reboot
emacs today.text &
conky
conky -bdo
ps -ef | grep conky
kill 3017
cd /
git status
git add -A
git commit -m "sending image data over network works (still need to get image on server end), but takes ~20x too long to be workable (getting 0.3 img/sec/cam)--possibly compression of data (miniz??) or faster wifi could help;
apt-get install iptraf;
apt-get install conky (need to configure to monitor network);"
git push
ip addr
ip link set dev eth0 down
dhclient eth0
cd test_code/flycapture/bin
./CustomImageEx 
htop
iptraf
apt-get install iptraf
iptraf
ntop
apt-get install ntop
ntop
apt-get purge ntop
ip addr
ls /sys/class/net
lsusb
ls /sys/class/net
ip addr
lsusb
ls /sys/class/net
ip addr
if eth0 up;  exit; '
;
ifup eth0
ip addr
apt-get install ntop
ntop
apt-get purge ntop
apt-get install conky
htop
exit
ls
google-chrome &
chromium-browser &
chromium-browser --user-data-dir . &
exit
lsusb
top
ip addr
ls
ip addr
ifdown wlan0
ping google.com
ifconfig
wget
wget -T 30 -q 192.168.32.2 -O /tmp/post_response.txt
cat /tmp/post_response.txt 
rm /tmp/post_response.txt 
wget -T 30 http://192.168.32.2/condata -O /tmp/post_response.txt
vi /tmp/post_response.txt 
clear
wget -T 30 http://192.168.32.2/condata 
wget -T 30 http://192.168.32.2/condata?action=connect -O /tmp/post_response.txt
ping google.com
ps -ef | grep ssh
/etc/init.d/ssh-tunnel.sh start
/etc/init.d/ssh-tunnel.sh stop
ifup wlan0
/etc/init.d/ssh-tunnel.sh start
lsusb
chromium-browser --user-data-dir /root &
emacs today.text &
lsusb
ip addr
ifconfig
ls /sys/class/net
lspci
lsusb
reboot
htop
iptraf
ATZ
AT S7=45 S0=0 L1 V1 X4 &c1 E1 Q0
lsusb
ip addr
ping google.com
reboot
emacs today.text &
ndiswrapper
apt-get install ndiswrapper
apt-cache search ndiswrapper
apt-get install ndiswrapper-*
apt-get install ndisgtk
apt-cache search ndis
ndiswrapper
man ndiswrapper
ls
mkdir marvell
cd marvell/
'

ls
lla
ndiswrapper -i netmw24c.inf 
rm *
ls
cd ..
rmdir marvell/
apt-get purge debhelper dh-apparmor dkms gettext gettext-base html2text intltool-debian
lsusb
ip addr
lsmod
ls /sys/class/net
ip addr
lsusb
ip addr
iface wlan2 inet dhcp
ifup wlan2
dhclient wlan2
iwlist wlan2 scan
iwlist wlan2 scan | grep ESSID
iwconfig wlan2 essid qobi-office
ip addr
iwspy
ip addr
ifconfig
lshw -C network
iwconfig
dhclient wlan2
ps -ef
ip addr
htop
chromium-browser --user-data-dir .
cd test_code/flycapture/bin
./CustomImageEx 
iwconfig
cd test_code/flycapture/bin
./CustomImageEx 
lsusb -v
ip link
dmesg | grep firmware
lspci
lsusb -k
lsmod
dmesg | grep rt2800
iw
iwconfig wlan2
iwconfig wlan2 mode managed
ping google.com
iwconfig wlan0 power off
iw dev
iw dev wlan2 link
iw dev wlan0 link
ip link set wlan2 up
iw dev wlan0 scan | less
dhcpd wlan2
dhclient wlan2
htop
iptraf
emacs today.text &
cd test_code/fly
cd test_code/flycapture/include/
grep -r ImageMetadata *
cd ../src/CustomImageEx/
make
htop
reboot
cd test_code/flycapture/bin
./CustomImageEx 
ls
./FlyCap2
lsusb
exit
iptraf
dhclient wlan2
htop
emacs today.text &
ip addr
ifup wlan2
ip addr
ls /sys/class/net
iwconfig
ifconfig wlan2 down
dhclient -r wlan2
ifconfig wlan2 up
iwconfig
iwconfig wlan2 essid "qobi-cccp"
iwconfig
iwconfig wlan2 mode managed
dhcleint wlan2
dhclient wlan2
ip addr
ifup wlan2
ifconfig wlan2 down
dhclient -r wlan2
ifconfig wlan2 up
iwconfig wlan2 essid "qobi-cccp"
iwconfig
dhclient wlan2
iwconfig
ip addr
ifup wlan2
ifconfig wlan2 up
ip addr
ifdown wlan2
ip addr
ifup wlan2
ip addr
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
lsusb
emacs today.text &
ping google.com
ssh scott@scottbronikowski-2.yourhda.com -p 2222
ip addr
ssh scott@scottbronikowski-2.yourhda.com -p 2222
cd /
git status
git add -A
git commit -m "-- First test of sending raw images across network successful, images saved via PGR methods as color PPM.  Getting ~1.2-1.3 frames/sec/cam.
-- Need to look into ways to speed up transfer to the 5-8 f/s/c range (possibly compression, alternate wifi, ???)"
git push
htop
iptraf
reboot
cd test_code/flycapture/bin
./CustomImageEx 
cd /
git status
git add -A
git commit -m "-- started on sending the raw PGR image across the network piece by piece...need to finish receiver and test
"
git push
cd /root/test_code/flycapture/bin
./CustomImageEx 
cd test_code/flycapture/bin
./CustomImageEx 
iwconfig
iptraf
htop
ping google.com
ls /etc/rc2.d/
cat /etc/init.d/servo-control.sh 
insmod /root/build/linux-omap-3.5/drivers/omap3-pwm/pwm.ko servo=1 timers=9,
insmod /root/build/linux-omap-3.5/drivers/omap3-pwm/pwm.ko servo=1 timers=9,10
iwconfig
iwconfig wlan1
iwconfig wlan2
iwconfig wlan2 essid qobi-cccp
iwconfig wlan2
ip addr
ifup wlan2
ip addr
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/keepalive-ping.sh stop
ifdown wlan0
ps -ef | grep ping
kill -9 867
ip addr
ping google.com
ping 192.168.2.1
ping google.com
service network restart
ifconfig
ping google.com
dhclient wlan2
ifdown wlan2
ifup wlan2
ip addr
dhclient wlan2
ip addr
ping google.com
/etc/init.d/keepalive-ping.sh start
/etc/init.d/ssh-tunnel.sh start
ps -ef | grep ping
kill -9 1450
ps -ef | grep ssh
kill -9 1453
lsusb
ping google.com
iwconfig
ip addr
vi /etc/network/interfaces 
reboot
ping google.com
ip addr
ifdown wlan0
ping google.com
ps -ef | grep ping 
kill -9 1023
ps -ef | grep ssh
kill -9 1061
vi /etc/network/interfaces 
reboot
ping google.com
/etc/init.d/ssh-tunnel.sh start
reboot
cd test_code/flycapture/bin
./CustomImageEx 
nano /etc/network/interfaces 
ip traf
iptraf
htop
ps -ef | grep ping
kill -9 874
vi /etc/network/interfaces 
reboot
iwconfig
ls
dpkg --get-selections | grep crda
cd /
locate regulatory.bin
locate db.txt
ip addr
iwconfig
cd test_code/flycapture/src/CustomImageEx/
./bigtest.sh 
iptraf
nano /etc/network/interfaces 
reboot
htop
cd test_code/flycapture/src/CustomImageEx/
./bigtest.sh 
nano /etc/network/interfaces 
reboot
iwconfig
ip addr
iwconfig
iptraf 
cd test_code/flycapture/src/CustomImageEx/
./bigtest.sh 
lsusb
htop
reboot
nano /etc/network/interfaces 
ls /etc/udev/
ls /etc/udev/rules.d/
nano /etc/udev/rules.d/70-persistent-net.rules 
udevadm
udevadm info
udevadm --info
lsmod
lsusb
lsmod
ip addr
ls /sys/class/net
ls
mkdir realtek
cd realtek/
ls
unzip RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911.zip 
ls
cd RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911
ls
chmod 755 ./install.sh 
./install.sh 
ls
cat install.sh 
ps -ef | grep ssh
kill -9 880
/etc/init.d/ssh-tunnel.sh start
ps -ef | grep ssh
kill -9 1083
/etc/init.d/ssh-tunnel.sh start
emacs today.text &
cd realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911
ls
cd document/
ls
xpdf
lsusb
cd ../..
ls
git clone https://github.com/dz0ny/rt8192cu.git
ls
cd rt
cd rt8192cu/
ls
cat README.md 
make
cd ..
rm -rf rt8192cu/
ls
git clone https://github.com/dz0ny/rt8192cu.git
ls
cd RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911
ls
./install.sh 
lsusb
iwconfig
ip addr
dhclient -r wlan1
ifconfig wlan1 up
iwconfig wlan1 essid "qobi-cccp"
iwconfig wlan1 mode Managed
dhclient wlan1
ifconfig wlan1 down
ifconfig wlan1 up
ip addr
dhclient wlan1
iwconfig wlan1 essid "qobi-cccp
"
iwconfig wlan1 essid "qobi-cccp"
dhclient wlan1
iwlist wlan1 scan
iwlist wlan1 scan | grep ESSID
iwconfig wlan1
iwconfig wlan0
reboot
emacs today.text &
exit
iptraf
exit
htop
exit
cd test_code/flycapture/bin
./CustomImageEx 
cd ../src/CustomImageEx/
./bigtest.sh 
htop
iwconfig
cd /
git status
git add -A
git commit -m "-- First effort at using TP-LINK TL-W822N USB Wifi adapter.  Driver installed and works, but still need to have it come up automatically on boot.  First test of transfer gets ~2.9 f/s/c.  Getting same "task crda blocked" message as with other USB Wifi--not sure if I can just ignore it"
git commit -m "-- First effort at using TP-LINK TL-W822N USB Wifi adapter.  Driver installed and works, but still need to have it come up automatically on boot.  First test of transfer gets ~2.9 f/s/c.  Getting same 'task crda blocked' message as with other USB Wifi--not sure if I can just ignore it"
git push
iptraf 
ip addr
ping google.com
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/keepalive-ping.sh stop
ps -ef | grep ping
vi /etc/init.d/keepalive-ping.sh 
ps -ef | grep "[p]ing -i 5 purdue.edu"
vi /etc/init.d/ssh-tunnel.sh
ps -ef | grep ping
ps -ef | grep "[p]ing -i 5 www.purdue.edu"
vi /etc/init.d/keepalive-ping.sh 
/etc/init.d/keepalive-ping.sh stop
ifdown wlan0
ping google.com
ip addr
dhclient wlan1
ping google.com
/etc/init.d/keepalive-ping.sh 
/etc/init.d/keepalive-ping.sh start
/etc/init.d/ssh-tunnel.sh start
STARTING BIGTEST HERE
ps -ef | grep ping
kill -9 1435
/etc/init.d/ssh-tunnel.sh stop
lsusb
vi /etc/network/interfaces 
reboot
cd test_code/flycapture/bin
./CustomImageEx 
cd test_code/flycapture/bin
./CustomImageEx 
COUNTRY=US crda
iptraf
reboot
emacs today.text &
iwconfig
lsmod
crda
iw set country US
htop
ps -ef
kill -9 1403
kill -9 1405
kill -9 1406
iw reg
locate wireless-regdom
locate wireless-reg
cat /usr/share/doc/wireless-regdb/
ls /usr/share/doc/wireless-regdb/
wireless-regdb
ls /lib/udev/rules.d/
cat /lib/udev/rules.d/85-regulatory.rules 
ls /etc/wi*
locate regdb
reboot
apt-get install wireless-regdb
nano today.text 
apt-get install iw
apt-get update
apt-get upgrade
reboot
export COUNTRY=US
echo $COUNTRY
crda
clear
iwconfig
iw reg get
ps -ef
iw list
dpkg-query -l | grep iw
dpkg-query -l | grep iwconfig
lla /sys/module/cfg80211/
cd /sys/module/cfg80211/pa
cd /sys/module/cfg80211/parameters/
lla
chmod u+w ieee80211_regdom 
lla
vi ieee80211_regdom 
cat ieee80211_regdom 
cat /var/log/syslog | grep cfg
dpkg-query -l | grep iw
dpkg-query -l | grep libnl
dpkg-query -l | grep libnl-dev
dpkg-query -l | grep pkg-config
apt-get install libnl-dev
iw dev
ps -ef | grep iw
kill -9 1145
ps -ef | grep iw
cd /
git status
cat .gitignore 
nano .gitignore 
git status
git add -A
~
git status
git add -A
git rm -f sys/module/8192cu/coresize 
cat .gitignore 
nano .gitignore 
git status
git add -A
git commit -m "-- apt-get install libnl1 libnl-dev
-- changed /sys/module/cfg80211/parameters/ieee80211_regdom from '00' to 'US' using 'cat US >> ...' in an attempt to try to fix crda error message -- FILE NOT IN GIT"
git push
ps -ef | grep iw
reboot
iw dev wlan1 link
ls
ps -ef | grep
ps -ef 
locate cfg80211.conf
locate cfg80211
ls /etc/modprobe.d/
locate syslog
cat /var/log/syslog | grep cfg
iwconfig
echo $COUNTRY
cat /var/log/syslog | grep cfg
ls /sys/module/cfg80211/parameters/
cat /sys/module/cfg80211/parameters/ieee80211_regdom 
cat /sys/module/cfg80211/parameters/cfg80211_disable_40mhz_24ghz 
nano /sys/module/cfg80211/parameters/ieee80211_regdom 
cat /sys/module/cfg80211/parameters/ieee80211_regdom 
sudo nano /sys/module/cfg80211/parameters/ieee80211_regdom 
lla /sys/module/cfg80211/parameters/
lla /sys/module/cfg80211/
cd /sys/module/cfg80211/parameters/
lla
echo US >> ieee80211_regdom 
lla
cat ieee80211_regdom 
chmod u-w ieee80211_regdom 
lla
cd /sys
ls
cd dev
ls
cd ..
cd module/
ls
cat cfg80211/parameters/ieee80211_regdom 
cd 8192cu/
ls
lla
cat coresize 
lla
cd ..
lla
cd ..
lla
cd ..
lla
cd sys
touch .gitignore
lla
cd ..
nano .gitignore 
iw reg get
htop
iwconfig
iwlist
cat /sys/module/cfg80211/parameters/
cat /sys/module/cfg80211/parameters/ieee80211_regdom 
cat /sys/module/cfg80211/taint
lla /sys/module/cfg80211/
cd /sys/module/cfg80211/par
cd /sys/module/cfg80211/parameters/
ls
cat ieee80211_regdom 
lla
chmod u+w ieee80211_regdom 
echo US>>ieee80211_regdom 
cat ieee80211_regdom 
lla
chmod u-w ieee80211_regdom 
cat ieee80211_regdom 
reboot
iw
exit
cat /sys/module/cfg80211/parameters/ieee80211_regdom 
iwlist
iwconfig
ilsusb
lsusb
reboot
iwconfig
apt-get purge iw
iwconfig
apt-get install iw
iw
iw list
lla
iw
iw help
iw list
lla
dpkg-query -l | grep nl80211
apt-get install nl80211
lsusb
reboot
lsusb
ps -ef | grep ssh
kill -9 894
/etc/init.d/ssh-tunnel.sh start
iwconfig
iwconfig wlan1 txpower 30dBm
apt-get purge crda wireless-crda wireless-regdb
reboot
dmesg | grep crda
dmesg | tail
dmesg
crda
cat /var/log/syslog | grep crda
dmesg
dmesg tail
cat /var/log/syslog | tail -n20
lsmod
touch /etc/modprobe.d/8192cu.conf
nano /etc/modprobe.d/8192cu.conf 
iwconfig
iwconfig
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
iwconfig
lsusb
reboot
iwconfig wlan1 power off
iwconfig wlan1 power on
iwconfig
iptraf
htop
cd test_code/flycapture/src/Cu
cd test_code/flycapture/src/CustomImageEx/
./bigtest.sh 
iwconfig
iptraf
ps -ef | grep ping
kill -9 857
lsusb
tail -F /var/log/syslog
lsusb
ls
lsusb
cd /sys/bus/usb/
ls
cd devices/
ls
lla
tail -F /var/log/syslog
ls
lla
cd usb1
ls
lla
cat bConfigurationValue 
cat quirks 
cat avoid_reset_quirk 
tail -F /var/log/syslog
lsusb
reboot
lsusb
cd
cd /sys/bus/usb/
ls
cd devices/
ls
lla
cd 1-0\:1.0
ls
tail -F /var/log/syslog
cd ..
ls
lsusb
lsmod
lsusb
dmesg | grep usb
ps -ef | grep ping
kill -9 862
ls /etc/rc2.d/
cat /etc/init.d/servo-control.sh 
cat /etc/init.d/pinmux.sh 
ls /etc/rc2.d/
cat /etc/init.d/gpio-
cat /etc/init.d/gpio-monitor.sh 
vi /etc/init.d/gpio-monitor.sh 
ls
reboot
depmod
lsmod
ls /sys/devices/platform/
ls /sys/devices/platform/ | grep usb
cd /sys/devices/platform/musb-omap2430/
ls
cat modalias 
cd musb-hdrc/
ls
cat mode 
lla
echo host > mode 
cat mode
echo host >> mode 
cat mode
nano mode
cat mode
nano mode
cat mode
echo host >> ./mode
cat mode
lsusb
echo host >> ./mode
cd /
locate g_serial
cd /lib/modules/3.5.0-2-linaro-omap/kernel/drivers/usb/
ls
cd gadget/
ls
modinfo g_serial
modprobe g_serial
lsusb
modprobe -r g_serial
modprobe g_multi
lsusb
modinfo g_multi
lsusb
clear
tail -F /var/log/syslog
tail -f /var/log/syslog
lsusb
reboot
lsusb
halt
lsusb
emacs today.text &
cd test_code/flycapture/src/CustomImageEx/
./bigtest.sh 
lsusb
./bigtest.sh 
cd /
git status
git add -A
git commit -m "-- changing of /sys/module/cfg80211/parameters/ieee80211_regdom did not work--file gets rewritten at boot
-- attempting to uninstall crda, wireless-crda, wireless-regdb to fix
   apt-get purge crda wireless-crda wireless-regdb
-- purge of crda/regdb seemed to work
-- still having issues with USB port quitting after a certain amount of time (non-deterministic)
-- added 'modprobe g_multi' to /etc/init.d/gpio-monitor.sh to load module needed to enable USB OTG port as second USB"
git push
git status
git add -A
git commit -m "-- Modified CustomImageEx.cpp with methods to just transfer image data on first image to see if it speeds things up...still need to finish work on camera-server.cpp to get it to break out of fork before we can see if it speeds things up or not"
git push
ps -ef | grep Custom
cd test_code/flycapture/bin
./CustomImageEx 
lsusb
./CustomImageEx 
lsusb
./CustomImageEx 
iptraf
clear
ls
whereis 7za
ls
cd miniz
ls
htop
top
htop
lsusb
iwconfig
cd test_code/flycapture/bin
./CustomImageEx 
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
./CustomImageEx 
halt
cd test_code/flycapture/bin
./CustomImageEx 
emacs today.text &
cd test_code/flycapture/
grep -ri "getdatasize" *
iptraf
