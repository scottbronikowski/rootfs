udevadm control --reload-rules
lla
udevadm trigger
ls
lla Teensy 
ar\\\
udevadm info --query all -name /dev/bus/usb/001/056 --attribute-walk
udevadm info --query all --name /dev/bus/usb/001/056 --attribute-walk
ls ttyA*
screen /dev/ttyACM0 57600
udevadm info --query all --name /dev/ttyACM0 --attribute-walk
udevadm control --reload-rules; udevadm trigger
ls
lla Teensy 
screen /dev/Teensy 57600
exit
cd source/razor-imu/
make
exit
exit
arduino
exit
emacs today.text
exit
ping 
reboot
screen /dev/Teensy 57600
lsusb
reboot
cd bin
ls
./run-emperor start
lsusb
exit
htop
exit
screen /dev/Teensy 57600
exit
exit
halt
dmesg -tail
tail dmesg
killall ping
dmesg
;
reboot
htop
lsusb
reboot
emacs today.text
exit
emacs today.text
exit
halt
reboot
halt
lsusb
halt
lsusb
vi /etc/network/interfaces
ifconfig
ip link
lsusb
ip link
cd /etc/udev/rules.d/
ls
cat 70-persistent-net.rules
ip link
vi 70-persistent-net.rules
udevadm trigger
ip link
reboot
lsusb
exit
emacs today.text
exit
halt
lsusb
halt
ls
sl
ls
halt
pkill screen
screen /dev/GPS 57600
screen /dev/GPS 9600
screen /dev/GPS 4800
screen /dev/Teensy 57600
screen /dev/GPS 4800
emacs today.text
screen /dev/GPS 4800
ls
screen /dev/GPS 4800 > gps.txt
ls g*
cat gps.txt 
rm gps.txt 
screen /dev/GPS 4800
cd source/
ls
cd razor-imu/
ls
emacs razor-imu.cpp
htop
ls
lsusb
ls /dev/ttyU*
lla /dev/GPS
screen /dev/GPS 4800
ls
lsusb
lla /dev/GPS 
lsusb
reboot
/etc/init.d/ssh-tunnel.sh start
ls /etc/rc2.d/
ps -ef | grep ssh
kill -9 636
/etc/init.d/ssh-tunnel.sh start
emacs today.text 
cd source/razor-imu/
emacs razor-imu.cpp
screen /dev/GPS 4800
cd
cd bin
ls
./run-emperor start
clear
./run-emperor start
ls
lla
reboot
./bin/run-emperor stop
screen /dev/RazorIMU 57600
htop
exit
emacs today.text
exit
lsusb
halt
screen /dev/Teensy 57600
exit
exit
exit
exit
exit
ls
halt
exit
cd /
git status
git add -A
git commit -m "Friday commit"
git push
git status
exit
emacs today.text
exit
cd source/
LS
ls
mkdir encoders
cd razor-imu/
ls
cp Makefile ../encoders/
cp run-imu.* ../encoders/
cd ../
cd encoders/
ls
rm *.o
mv run-imu.cpp run-encoders.cpp
mv run-imu.h run-encoders.h
cp ../gps/run-gps.cpp ./run-encoders.cpp
ls /dev/
make
exit
htop
ls
cd /
git status
git add -A
git commit -m "--Started work on run-encoders.{cpp,h} to run on rover and read data from encoders (via Teensy) and send it back to seykhl to be logged.  Have all of the boilerplate stuff adapted from run-imu and run-gps, just need to write the functions to initialize the Teensy, listen for and read the data, and the handler function that runs in the main loop (which all should be fairly straightforward adaptations from razor-imu.cpp).  
--Dan was in for a while today and we spoke about adapting his old Kalman filter code to my project.  It seems like it won't be too difficult to go from the data that I'm logging in my log file to a series of (x, y, orientation) positions, which will form the trace of the robot's path."
git push
ls
exit
ls
emacs today.text
reboot
ls
htop
top
htop
exit
htop
exit
cd bin
./run-emperor start
\
./run-emperor start
htop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
exit
cd source/razor-imu/
make
cd 
ls
cd razor-9dof-ahrs-Release-v1.4.2
ls
cd Arduino/
ls
cd Razor_AHRS/
lla
exit
cd source/encoders/
ls
make
lla /dev/RazorIMU 
make
lla /dev/RazorIMU 
htop
make
cd ../razor-imu/
make
cd ../encoders/
make
cd ..
grep -ri ClientConnect *
grep -ri bind *
exit
arduino
exit
emacs today.text
exit
lsusb
halt
cd source/
ls
cd razor-imu/
ls
cat run-imu.cpp 
cd ..
ls
mkdir sensors
cp razor-imu/Makefile ./sensors/
cd sensors/
ls
touch run-sensors.h
touch run-sensors.cpp
cd ..
grep -ri file_ptr *.cpp
grep -ri file_ptr *
cd sensors/
make
exit
exit
emacs today.text
halt
cd bin
ls
./run-sensors 
ls
./emperor &
./run-sensors &
./run-gps 
./run-emperor start
exit
halt
reboot
halt
reboot
halt
reboot
emacs today.text &
cd /
git status
git add -A
git commit -m "--Added 'null' loop in run-sensors to clear out bogus data in serial buffers before transmitting data back to seykhl.  Loop runs for 200 ms.  No more bogus (dt != 20ms) data arriving in log."
git push
exit
emacs today.text
exit
halt
reboot
ls
halt
lsusb
reboot
cd source/sensors/
make
emacs today.text
cd bin
ls
./run-emperor start
lsusb
reboot
emacs today.text
cd source/sensors/
make
echo $PSRF100,0,9600,8,1,0*0C > /dev/GPS 
echo $PSRF101,0,0,0,0,0,0,12,4*10
echo "$PSRF101,0,0,0,0,0,0,12,4*10\r\n"
$PSRF101,0,0,0,0,0,0,12,4*10
make
pkill run-sensors
pkill emperor
make
ls
make
cd /
git status
git add -A
git commit -m "--Started incorporating GPS reading into run-sensors.  Discovered that the fgets() I was using to read a full line (since NMEA sentences are terminated with a newline) from the GPS will block, so calling it after every encoder/IMU read (since I can't predict when a GPS sentence will be there to read) limits the encoder/IMU data to the GPS rate of 1Hz.  Going to have to find/write a function that does a normal read and just continues until it hits a newline, and then wrap that read in a select in order to not block.  Not sure how long of a timeout I can afford to give the select--maybe start with 10ms.
--Tried a readLine() function that I found that was reportedly supposed to continue to call read() until it reached a newline.  Could not get it to work--it kept returning after reading only 3 characters.  Instead tried using an fgets() call inside of a select()--basically a copy of what run-gps had done, put inside of a 10ms timeout--and it seemed to work.  
--Then I started getting errors from the terminal saying '*** buffer overflow detected ***: /root/bin/run-sensors terminated'.  I might have been getting these errors yesterday as well, and just not noticing them because I was running the 'run-emperor' script (which starts emperor and run-sensors) from the button in the driver-viewer instead of from its own terminal window.  Upon looking at the log, it appears that near the end of the file, before run-sensors terminates, the Gumstix-timestamp interval between the combined IMU/encoder message lines decreases to <11 ms between messages (while the timestamps from the IMU are still at 20 ms intervals)--and this happens whether or not I'm trying to run the GPS at the same time. 
--From the above, I think I may have a classic 'producer/consumer' problem--the messages are coming in from the serial buffer faster than the Gumstix can send them over the network, and eventually the buffer gets overflowed.  
--I think the fix might be similar to what we did for the receiving of the camera images on seykhl--have one thread (or possibly two, one for the IMU/encoder lines and one for the GPS) put the messages to send into a large circular buffer, and then have a separate thread read the messages out of the buffer and send them."
git push
htop
cd /
git status
git add -A
git commit -m "--Started incorporating GPS reading into run-sensors.  Discovered that the fgets() I was using to read a full line (since NMEA sentences are terminated with a newline) from the GPS will block, so calling it after every encoder/IMU read (since I can't predict when a GPS sentence will be there to read) limits the encoder/IMU data to the GPS rate of 1Hz.  Going to have to find/write a function that does a normal read and just continues until it hits a newline, and then wrap that read in a select in order to not block.  Not sure how long of a timeout I can afford to give the select--maybe start with 10ms."
man gpsctl
stty -F /dev/ttyUSB0 ispeed 4800 && cat < /dev/ttyUSB0
screen /dev/GPS 4800
minicom
cd root/source/bin
cd root
cd bin
./run-sensors 
./run-emperor start
gdb run-sensors 
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
screen /dev/GPS 4800
./run-emperor start
clear
./run-emperor start
clear
./run-emperor start
clear
./run-emperor start
clear
./run-emperor start
clear
./run-emperor start

clear
./run-emperor stop
./run-emperor start
clear
./run-emperor start
clear
./run-emperor start
clear
./run-emperor start
clear
./run-emperor start
clera
clear
./run-emperor start
clear
./run-emperor start
./run-sensors 
./run-emperor start
clear
./run-emperor start
cd /
git status
git add -A
git commit -m "--After an email exchange with Dan, decided to try to continue to have run-sensors operate single-threaded.  Created a buffer (sized with constant k_msg_buf_size) to have the IMU/encoder and gps reading functions write their data to, and then have a counter that calls a sending function when the counter reaches k_msg_buf_size.  This way we can send a buffer of k_msg_buf_size * 256-byte messages instead of sending every 256-byte message as soon as it's produced, saving k_msg_buf_size * TCP sending overhead (IIRC, ~40 bytes for a TCP packet).  Also added a sleep in the run-emperor script to make sure that run-sensors has a chance to send its buffer before being killed.
--Discovered that the true problem was with the IMU getting out of sync with the reads; IMU would start reading bogus data and never recover.  Attempted a fix by changing the IMU output to single frame instead of streaming, and then polling it for one frame in imu_data_read().  With output to terminal, observed runs that did not have errors, but the interval between IMU reads is 40ms, while for the encoder it's 20ms (so the encoder is buffering data and we're getting out of sync).  Don't think this technique will work.  
--Need to strip it back down to just reading the IMU, possibly putting the data in a buffer, and sending it to see if we can run fast enough.  Might need look at a way to have sync bytes on the IMU frame to ensure that we start reading at the beginning of the frame.
--Probably going to need to build multiple threads to have multiple writers putting data into the message send buffer and then one thread sending the buffer--can't have GPS in same thread as IMU and encoder b/c it sends data at 4800 baud, while IMU and encoders run at 57600 baud."
git push
git status
git add -A
git commit -m "Commit prior to trying to turn run-sensors into multithreaded"
git push
git status
git add -A
git commit -m "--Started working on making run-sensors multi-threaded: 3 producer threads (IMU, encoders, GPS) that put messages into the send buffer, and 1 consumer thread that sends the buffer when it is full.  Stopped while working on run_sensors_setup() function."
git push
git status
git add -A
git commit -m "--Got consumer thread and first producer thread (IMU) working, no problems so far.  Need to finish the encoder and GPS threads and then test."
git push
cd /
htop
screen /dev/GPS 4800
exit
cd bin
./run-emperor start
clear
./run-emperor start
clear
./run-emperor start
./run-emperor st
./run-emperor stop
./run-emperor st
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
exit
cd source/sensors/
make
cd ..
grep -r OpenCV_SendFrame *
cd sensors/
make
cd ..
ls
cd gps/
ls
cd ..
cd sensors/
ls
make
exit
exit
ls
emacs today.text
halt
reboot
halt
cd bin
./run-emperor start
reboot
cd bin
./run-emperor start
exit
screen /dev/GPS 4800
exit
exit
time
dtime
date
date +%s
cd source/sensors/
make
exit
exit
emacs today.text
cd /
git status
git add -A
git commit -m "final commit before shutdown to analyze data taken 2014-07-31"
git push
halt
reboot
ps -ef | grep wpa
killall wpa_supplicant
iface wlan1 inet dhcp
ifconfig -a
iwconfig
wpa_supplicant -Dwext -iwlan1 -c/etc/wpa_supplicant.conf -B
ps -ef | grep wpa
killall wpa_supplicant
wpa_supplicant -iwlan1 -c/etc/wpa_supplicant.conf -B
iwconfig
ps -ef | grep wpa
wpa_supplicant -iwlan1 -c/etc/wpa_supplicant.conf -B
killall wpa_supplicant
wpa_supplicant -iwlan1 -c/etc/wpa_supplicant.conf -B
iwconfig
ifconfig -a
ping google.com
iface
ifdown wlan1
ifconfig -a
ifconfig wlan1 dhcp
ifconfig --help
ifconfig -v wlan1 inet dhcp
ifconfig -v wlan1 inet
ifconfig -a
ping google.com
ifconfig wlan0 down
iwconfig wlan0 essid "PAL3.0"
iwconfig wlan1 essid "PAL3.0"
iwconfig
ifconfig wlan1 down
ifconfig wlan1 essid "PAL3.0"
iwconfig wlan1 essid "PAL3.0"
ifconfig wlan1 up
iwconfig
iwconfig wlan0 essid any
iwconfig
ifconfig
ping google.com
iwconfig
reboot
dmesg -tail
tail dmesg
dmesg -T | tail
dmesg 
wpa-cli
wpa_cli
wpa_cli list_networks
cd /etc
ls w*
cat wpa_supplicant.conf
ls /etc/ssl/certs/Add*
vi /etc/wpa_supplicant.conf
ifdown wlan1
ifup wlan1
ifconfig wlan1 down
ifconfig wlan1 up
iwconfig
ifconfig
ping google.com
/etc/init.d/networking stop
/etc/init.d/networking start
ifconfig
iwconfig
dhcpd wlan1
dhclient wlan1
iwconfig
ifconfig
ping google.com
vi wpa_supplicant.con
vi wpa_supplicant.conf
ifconfig wlan1 down
ifconfig wlan1 up
iwconfig
ifconfig
iwconfig
dhclient wlan1
vi wpa_supplicant.conf
ifconfig wlan1 down
iwconfig
ifconfig
ifconfig wlan1 up
iwconfig
iw dev
ip link show wlan1
ip link set wlan1 down
ip link show wlan1
ip link set wlan1 up
ip link show wlan1
iw wlan0 link
iw wlan1 link
iw wlan1 scan
iwconfig
killall wpa_supplicant
wpa_supplicant -iwlan1 -c/etc/wpa_supplicant.conf -B
dmesg | tail
iwconfig
ping google.com
dhclient wlan1
dhclient -nw wlan1
ifconfig
iwconfig
ifconfig
iwconfig
ifconfig
ps -ef | grep dhc
reboot
ping google.com
hwclock
ntpdate -s time.nist.gov
ntpdate
ntpdate -s time.nist.gov
hwclock
date
service ntp stop
ntpdate -s time.nist.gov
date
service ntp start
hwclock
hwclock --systohc
hwclock
date
vi /etc/wpa_supplicant.conf
reboot
emacs today.text &
date
iwconfig wlan0 essid any
ifup wlan0
iwconfig
ip link set wlan0 up
ip link show wlan0
iw wlan0 link
iw wlan0 scan
iwconfig wlan0 essid qobi-cccp
dhclient wlan0
iwconfig
ifconfig
dhclient -nw wlan0
ifconfig wlan0
ping google.com
ifconfig wlan0
ping google.com
ls /etc/rc2.d/
ls /etc/init.d *.lsh
ls /etc/init.d/*.sh
cat /etc/init.d/time-update.sh 
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
ifconfig wlan1
ifdown wlan1
ifconfig wlan1 down
ifconfig wlan1 up
ifconfig wlan1
iwconfig wlan1
ifconfig wlan1
dhclient -nw wlan1
ps -ef | grep dhcli
dmesg | tail
ping google.com
ifconfig wlan1
iwconfig wlan1
ifconfig wlan0
ps -ef | grep ssh
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
ps -ef | grep ssh
ifconfig
/etc/init.d/ssh-tunnel.sh start
date
hwclock
ps -ef | grep ping
ping google.com
reboot
ifconfig
iwconfig
top
ssh -T git@github
ssh -T git@github.com
ssh-add ~/.ssh/id_rsa_github
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa_github
ssh -T git@github.com
exit
ssh -T git@github.com
ssh-agent -s
ssh -T git@github.com
ssh-add ~/.ssh/id_rsa_github
exit
ssh -T git@github.com
exit
ssh -T git@github.com
exit
ssh -T git@github.com
exit
cd /etc/ssl/certs
ls
ls ca*
emacs ca-bundle.crt &
cd /
git status
git add -A
git commit -m "Added new ca-bundle.crt from purduelug.org wiki to /etc/ssl/certs and made change to /etc/wpa_supplicant.conf to see if this fixes PAL3.0 issue"
git push
ssh-agent -s
ssh-add ~/.ssh/id_rsa_github
killall ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa_github
git push
emacs ~/.bashrc
exit
date
iwlist
iwlist wlan0
iwlist wlan1
ifconfig
iwconfig
vi /etc/network/interfaces
iwconfig
ifconfig wlan0 down
ifconfig wlan0 up
ifconfig
iwconfig
ifconfig
iwconfig wlan0 essid "qobi-cccp"
dhclient -nw wlan0
iwconfig
ifconfig
ping google.com
vi /etc/network/interfaces
ls /etc/rc5.d/
/etc/init.d/keepalive-ping.sh start
/etc/init.d/ssh-tunnel.sh start
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
ssh-agent
/etc/init.d/ssh-tunnel.sh start
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
ls ./.ssh
lla ./.ssh
cd ./.ssh
lla
cat authorized_keys 
/etc/init.d/ssh-tunnel.sh start
lla
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
ping google.com
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
ping seykhl.ecn.purdue.edu
cd /etc/ssl/certs
ls
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
reboot
iwconfig
ifconfig
iw list
\
ip addr
ifconfig
cd /etc/ssl/certs
lla
lla c*
lla /usr/share/ca-certificates/mozilla/ePKI_Root_Certification_Authority.crt 
rsync -avrz seykhl:~/Downloads/ca-bundle.crt .
lla ca*
chown root ca-bundle.crt 
chgroup root ca-bundle.crt 
chgrp root ca-bundle.crt 
lla ca*
exit
emacs &
e
exit
ifconfig
iwconfig
ifconfig
iwconfig
iwconfig wlan0 essid qobi-cccp
dhclient -nw wlan0
iwconfig
ifconfig
/etc/init.d/keepalive-ping.sh start
/etc/init.d/ssh-tunnel.sh start
iwconfig
ifconfig
ps -ef | grep ssh
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
reboot
dmesg
lla d*
cd /
lla d*
ls dm*
cd 
dmesg > dmesg-29aug.txt
iwconfig
ifconfig
wpa-ifdown wlan1
ifdown wlan1
ifup wlan1
iwconfig wlan1 down
ifconfig wlan1 down
ifconfig wlan1 up
iwconfig
ifconfig
iwconfig
iwconfig wlan1 down
ifconfig wlan1 down
iwconfig
man iwconfig
iwconfig wlan1 essid eduroam
iwconfig
dmesg | tail
dmesg
ifconfig wlan1 down
iwconfig
ifconfig wlan1 up
exit
emacs &
exit
ifdown wlan0
ifup wlan0
iwconfig
iwconfig wlan0 essid qobi-cccp
iwconfig
dhclient -nw wlan0
ifconfig
ls /etc/init.d/
lla /etc/rc5.d/
/etc/init.d/keepalive-ping.sh start
/etc/init.d/debian.noip2.sh start
/etc/init.d/debian.noip2.sh stop
/etc/init.d/debian.noip2.sh start
/etc/init.d/ssh-tunnel.sh start
reboot
iwconfig
ifconfig
iwconfig wlan0 essid qobi-cccp
dhclient -nw wlan0
ifconfig
iwconfig
ifconfig
ifconfig wlan0 down
ifup wlan0
lla /etc/network/interfaces
lla /etc/wpa_supplicant.conf
nano
nano /etc/network/interfaces
vi /etc/network/interfaces
ifup wlan0
ifconfig
iwconfig
ifconfig wlan0 up
ifconfig
lla /etc/ssl/certs/AddTrust_External_Root.pem 
reboot
iwconfig
exit
emacs /etc/wpa_supplicant.conf
exit
ifconfig
reboot
nano /etc/network/interfaces
cd /
git status
git add -A
git commit -m "--Changed my /etc/network/interfaces to drop the 'pre-up' and 'down' lines and replaced them with 'wpa-conf /etc/wpa_supplicant.conf' and now it works--I'm connected to PAL3.0.  Not sure why that made a difference."
git push
iwconfig
ifconfig
ls
exit
nano /etc/network/interfaces
iwconfig
ifconfig
exit
cd /etc/network
ls
cat interfaces
cd ..
ls wpa*
nano wpa_supplicant.conf
iwconfig
ifconfig
vi /etc/network/interfaces
iwconfig
ifconfig
ATZ
AT S7=45 S0=0 L1 V1 X4 &c1 E1 Q0
ls
lla
ATZ
AT S7=45 S0=0 L1 V1 X4 &c1 E1 Q0
ls
ping seykhkl
ping seykhl.ecn.purdue.edu
ps -ef | grep ssh
/etc/init.d/ssh-tunnel.sh start
AT S7=45 S0=0 L1 V1 X4 &c1 E1 Q0
ls
reboot
ping google.com
iwconfig
reboot
ls
lla tod*
emacs today.text &
cd bin
lla
cat run-imu 
cat run-emperor 
lla
cd ../source/the-force/
ls
cd ../../bin
ls
lla
./the-force 
htop
i
iwconfig
ping purdue.edu
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
top
reboot
emacs today.text &
pkill the-force
cd bin/
ls
./the-force 
ls
./run-emperor 
./run-emperor start
./run-emperor stop
ls
./motor_control forward_1
./motor_control stop
cd ../source/
ls
cd sensors/
ls
cd ../../bin
./run-the-force start
lla
chmod a+x run-the-force
lla
./run-the-force start
./run-the-force stop
exit
emacs today.text &
cd bin
./run-the-force start
./run-the-force stop
ls
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
cd /
git status
git add -A
git commit -m "--Fixed logging of camera start and stop messages.  Also added 2-second sleeps after starting and before stopping cameras to allow the image stream to be fully functional during motion.
--Established pipe to go from sensors to main thread for sensor data for Kalman filter.  Have flag marking it as open or closed to keep a bunch of useless data from piling up in the pipe before rover is ready to move.  Also modified sensors_log_data() to not write data to log unless pipe is open, and to send the data being written to the log into the pipe as well.
--Have the-force structured so that the rover can execute multiple paths sequentially--the rover's own position is only initialized to (0,0,pi/2) once, and then at the end of the path following the position is preserved.
--Now just need to put Kalman filter and driving logic into the_force_parse_and_execute()."
git commit --amend
cd bin
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
pkill the-force
kill 10005
ls
lla
cat run-emperor 
lla
./run-the-force start
~
./run-the-force start
./run-the-force stop
./run-the-force start
exit
htop
top
htop
top
exit
emacs today.text &
git commit --amend
git push
halt
cd source/the-force/
make
exit
emacs source/the-force/the-force.cpp
exit
make
cd source/the-force/
make
exit
cd source/the-force/
emacs the-force.cpp
exit
halt
top
exit
cd source/the-force/
make
cd ../..
git status
git add -A
git commit -m "--Autodrive testing revealed that we need to do some tuning of the Kalman filter parameters, most likely the rover width parameter."
git push
exit
cd source/motor_control/
emacs motor_control_functions.cpp
cd ../the-force/
emacs the-force.cpp
cd ..
emacs today.text
exit
cd source/motor_control/
nano motor_control_functions.cpp
cd ..
ls
halt
emacs today.text &
halt
top
htop
exit
cd sour
cd source/
ls
cd sensors/
ls
cd ../camera/
ls
cd ../
ls
cd ..
ls
cd include/
ls
ln -s ../source/sensors/mNMEAParser.h ./mNMEAParser.h
lla
ln -s ../source/sensors/mGPSInfo.h ./mGPSInfo.h
cd ../source/sensors/
ls
cd ../emperor/
ls
rm *.o
ls
cd ../sensors/
ls
cd ../../include/
ln -s ../source/sensors/run-sensors.h ./run-sensors.h
exit
ls
ping google.com
emacs today.text &
halt
exit
top
exit
ping google.com
emacs today.text &
halt
ping google.com
ls
halt
emacs today.text &
top
exit
halt
emacs today.text
halt
emacs today.text &
halt
ping google.com
halt
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
ping google.com
halt
exit
emacs today.text &
exit
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
halt
emacs today.text &
exit
emacs today.text &
halt
arduino
ls
cd bin
ls
./run-the-force 
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
cd bin
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
(Ex
./run-the-force start
clear
./run-the-force start
clear
./run-the-force start
./run-the-force stop
clear
./run-the-force start
clear
./run-the-force start
./run-the-force stop
clear
./run-the-force start
./run-the-force stop
ps
ps -ef
exit
top
cd source/razor-imu/
ls
cd arduino/
ls
cd Razor_AHRS/
ls
lla
rsync -avrz seykhl:~/vader-rover/Razor_old/* .
lla
lla /dev/R*
cd ../../../the-force/
ls
make
htop
top
make
nano the-force.cpp 
make
top
make
top
make
exit
emacs today.text &
exit
cd bin
./run-the-force start
./run-the-force stop
clear
./run-the-force start
./run-the-force stop
clear
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
top
ps -ef
ps -ef | grep for
ps -ef | grep force
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
exit
cd bin
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
exit
cd bin
./run-the-force start
man top
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./motor_control stop
./run-the-force start
./motor_control stop
./run-the-force start
./motor_control stop
./run-the-force start
./motor_control stop
./run-the-force start
./motor_control stop
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
exit
cd bin/
./run-the-force start
./run-the-force stop
clear
./run-the-force start
./run-the-force stop
clear
./run-the-force start
./run-the-force stop
clear
./run-the-force start
./run-the-force stop
clear
./run-the-force start
./run-the-force stop
clear
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
./run-the-force stop
./run-the-force start
clear
./run-the-force start
./run-the-force stop
exit
cd bin
./run-the-force start
./run-the-force stop
clear
./run-the-force start
./run-the-force stop
clear
./run-the-force start
./run-the-force stop
./motor_control stop
top
exit
cd source/the-force/
exit
emacs today.text &
exit
halt
exit
emacs source/the-force/the-force.cpp
exit
ps -ef | grep ssh
ps -ef | grep emp
cd /
git status
git add -A
git commit -m "--changed distance threshold to 5cm"
git push
halt
exit
reboot
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
halt
\
ls
reboot
emacs today.text &
top
exit
AT S7=45 S0=0 L1 V1 X4 &c1 E1 Q0
ls
cd source/
vi camera/toollib-camera.cpp
reboot
cd source/
grep -ri seykhl *
ps -ef |grep ssh
vi /etc/init.d/ssh-tunnel.sh
reboot
ls
exit
emacs today.text &
cd bin
ls
./run-emperor start
ps -ef | grep noip
pkill noip2
/usr/local/bin/noip2 -C
/usr/local/bin/noip2
exit
ps -ef | grep ping
ps -ef | grep ssh
ifconfig
ps -ef | grep ssh
/etc/init.d/ssh-tunnel.sh start
ssh 10.184.174.241
ssh sbroniko@10.184.174.241
cat /etc/init.d/ssh-tunnel.sh
ssh sbroniko@10.184.174.241
/etc/init.d/ssh-tunnel.sh start
ps -ef | grep emp
ps -ef 
ps -ef | grep emp
cd /bin/
ls
cd ~/bin
ls
./run-emperor start
ifconfig
/usr/local/bin/noip2 -C
/usr/local/bin/noip2
pkill noip2
/usr/local/bin/noip2 -C
/usr/local/bin/noip2 
ifconfig
halt
exit
ifconfig
vi /etc/init.d/ssh-tunnel.sh
reboot
exit
/etc/init.d/ssh-tunnel.sh start
halt
git status
git add -A
git commit -m "--Changed configuration so that rover can be controlled from laptop instead of seykhl.  Need to verify that server address in /etc/init.d/ssh-tunnel.sh and ~/source/camera/toollib-camera.cpp is correct each time.  Also need to MAKE emepror and the-force if changed in source.
"
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
ifconfig
/etc/init.d/ssh-tunnel.sh start
ps -ef | grep ssh
reboot
vi /etc/init.d/ssh-tunnel.sh
/etc/init.d/ssh-tunnel.sh start
vi source/camera/toollib-camera.cpp 
cd source/emperor/
make
cd ../the-force/
make
halt
cd /
git status
git add -A
git commit -m "--Modified infrastructure so that rover connects to laptop instead of seykhl.  Seems to be working OK.  When moving laptop, need to check its IP address.  If IP has changed, need to change the IP address on the rover in /etc/init.d/ssh-tunnel.sh and ~/source/camera/toollib-camera.cpp.  Also need to MAKE emperor and the-force if toollib-camera.cpp is changed."
git push
vi /etc/init.d/ssh-tunnel.sh
vi source/camera/toollib-camera.cpp 
cd source/emperor/
make
cd ../the-force/
make
reboot
[
exit
ssh sbroniko@10.184.165.253
/etc/init.d/ssh-tunnel.sh start
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
halt
ls
ps -ef | grep emp
halt
exit
cd bin
./motor_control stop
exit
./motor_control stop
cd bin
./motor_control stop
exit
ps -ef | grep ssh
/etc/init.d/ssh-tunnel.sh start
halt
exit
eixt
exit
ping google.com
reboot
exit
ps -ef | grep emp
ps -ef 
exit
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
halt
ls
ping google.com
reboot
ro
ls
ps -ef 
top
cd bin
./run-the-force start
./run-emperor start
./run-the-force start
exit
emacs ./source/the-force/the-force.cpp
exit
halt
exit
reboot
cd /
git status
git add -A
git commit -m "--Fixed bugs in the-force with trace-buffer size.  Autodrive now works from laptop"
git push
ps -ef | grep the-
top
/etc/init.d/ssh-tunnel.sh start
ps
ps -ef
cd bin
./run-emperor start
reboot
cd bin
./run-emperor start
./run-emperor stop
exit

halt
exit
reboot
exit
/etc/init.d/ssh-tunnel.sh start
halt
ps
top
halt
cd source/the-force/
ls
emacs the-force.cpp &
exit
ls
ping google.com
reboot
exit
cd source/the-force/
emacs the-force.cpp &
make
exit
/etc/init.d/ssh-tunnel.sh start
halt
reboot
exit
halt
cd /
git status
git add -A
git commit -m "--Changed k_distance_threshold in the-force.cpp to 10 cm (was 5 cm).  This commit represents the software used in collecting the msee-1-auto-drive and msee-1-generation datasets on 20-21nov2014"
git push
exit
reboot
exit
top
exit
/etc/init.d/ssh-tunnel.sh start
halt
exit
reboot
exit
ping google.com
/etc/init.d/ssh-tunnel.sh start
alt
halt
iwconfig
cd /etc/network
ls
cat interfaces
cd ../
ls wp*
cat wpa_supplicant.conf
cd init.d/
ls
cat ssh-tunnel.sh
vi ssh-tunnel.sh
cd 
cd source/camera/
ls
vi toollib-camera.cpp
ls
cd ../emperor/
make
date
reboot
dmesg
date
date -s "8 JAN 2014 14:41:00"
date
hwclock -w
hwclock
reboot
cd source/
ls
grep -ri command *
cd ../bin
ls
./run-emperor start
cd ../source/
cd camera/
vi toollib-camera.cpp
cd ..
grep -ri k_Server *
grep -ri 253 *
cd camera/
ls
make clean
make
cd ..
cd emperor/
ls
cat Makefile 
make
cd ..
grep -ri 253 *
grep -ri .253 *
cd the-force/
make
cd ../../bin/
ls
./run-emperor start
./run-emperor stop
exit
date
hwclock
hwclock -w
hwclock
ping google.com
cat /etc/init.d/ssh-tunnel.sh
ssh sbroniko@10.184.161.62
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
ls
cd source/emperor/
ls
make
cd ../the-force/
make
cd ..
grep -ri "waiting for command connection"
grep -ri "waiting for command connection" *
grep -ri command *.cpp
grep -ri command *
grep -ri connection *
grep -ri server *
grep -ri waiting *
ls
cd /etc
ls
cat wpa_supplicant.conf
vi wpa_supplicant.conf
ls
ping google.com
reboot
emacs source/camera/toollib-camera.cpp &
cd source/the-force/
make
cd ../emperor/
make
date
ps -ef | grep ssh
ping google.com
cd /etc/init.d/ssh-tunnel.sh
vi /etc/init.d/ssh-tunnel.sh
/etc/init.d/ssh-tunnel.sh start
ping google.com
ps -ef | grep ssh
/etc/init.d/ssh-tunnel.sh start
iwconfig
ifconfig
vi /etc/init.d/ssh-tunnel.sh
/etc/init.d/ssh-tunnel.sh start
cd source/camera/
ls
vi toollib-camera.cpp
cd ../emperor/
make
cd ../the-force/
make
halt
hatl
halt
ls
l
ls
ls -al
ls
ping google.com
iwconfig
ifconfig
vi /etc/init.d/ssh-tunnel.sh
cd source/camera/
vi toollib-camera.cpp 
cd ../emperor/
make
cd ../the-force/
make
reboot
halt
ls
date
hwclock
date -s "Tue May 12 10:49:22 EDT 2015
date -s "May 12 10:49:50 EDT 2015"
date
hwclock -w
hwclock
reboot
exit
ls
exit
emacs source/camera/toollib-camera.cpp &
cd source/emperor/
ls
make
cd ../the-force/
make
exit
cd bin
./emperor 
exit
ls
/etc/init.d/ssh-tunnel.sh stop
cat /etc/init.d/ssh-tunnel.sh
/etc/init.d/ssh-tunnel.sh start
vi /root/.ssh/known_hosts 
ssh sbroniko@10.184.167.1
/etc/init.d/ssh-tunnel.sh start
cd source/camera/
vi toollib-camera.cpp
reboot
exit
\ls
ping google.com
ps -ef | grep ssh
/etc/init.d/ssh-tunnel.sh start
halt
exti
exit
ls
reboot
exit
exec env ENV='' PROMPT_COMMAND='' PS1=\#\$\  PS2='' PS3='' /bin/sh
ifconfig
ps -ef | grep ssh
kill -9 926
/etc/init.d/ssh-tunnel.sh start
[A
halt
exit
lsusb
reboot
exit
halt
exit
halt
ps -ef | grep the-
ps -ef | grep emp*
pkill emperor
ps -ef | grep emp*
exit
ps -ef | grep the
kill -9 1937
ps -ef | grep the
kill -9 2009
ls
halt
exit
pwd
halt
htop
ps -ef | grep the
ps -ef | grep emper
reboot
exit
ps -ef
htop
exit
halt
exit
reboot
exit
halt
ps -ef | grep the-
exit
halt
reboot
ipconfig
man ficonfig
reboot
halt
date
dmesg -tail
dmesg | tail
dmesg
iwconfig
date
ls
cd /etc/
ls
cd init.d/
ls
./time-update.sh 
./time-update.sh start
cat time-update.sh 
ntpdate -uvb ntp.ubuntu.com us.pool.ntp.org
ntpdate -u us.pool.ntp.org
ping google.com
iwconfig
ifconfig
ifconfig wlan1 down
ifconfig wlan1 up
ifconfig
iwconfig
reboot
dmesg
lsusb -v
lsusb
ip link
ip link set wlan1 down
ip link
ip link set wlan1 up
ip link
iw dev wlan1 link
ifconfig
iw dev wlan1 scan
iw devn wlan1 link
iw dev wlan1 link
iw dev
dmesg | grep wlan
ip link
ifconfig
iwconfig
sudo dhclient
iwconfig
ifconfig
dhclient -r wlan1
dhclient wlan1
ifconfig
iwconfig
reboot
date
date -s '2015-09-24 16:15:00'
date
hwclock
hwclock -w
hwclock
reboot
date
date -s '2015-09-24 16:18:00'
hwclock -w
hwclock
date
ifconfig
iwconfig
dhclient -r wlan1
dhclient wlan1
dmesg | grep iwlwifi
dmesg | grep firmware
ip link set wlan1 down
iwconfig
ip link set wlan1 up
iwconfig
ifconfig
ip addr
ls /etc/init.d
ls /etc/network
cat /etc/network/interfaces
cat /etc/wpa_supplicant.conf
date
reboot
vi /etc/wpa_supplicant.conf
reboot
emacs &
exit
emacs &
exit
ssh -Y vader-rover
exit
emacs &
ntp -u us.pool.ntp.org
ntpdate -u us.pool.ntp.org
date
hwclock -w
cd /etc/
ls
cat ntp.conf
ls
ntpq -d
ntpq -p
ntpdate -u 192.168.2.2
exit
ping google.com
ifconfig
iwconfig
vi /etc/init.d/ssh-tunnel.sh
/etc/init.d/ssh-tunnel.sh start
date
reboot
date
ntpq -p
emacs /etc/ntp.conf &
ntpdc -c sysinfo
date
cd /
git status
emacs ~/today.text &
htop
top
htop
exit
shutdown
halt
killall ping
s
ls
reboot
ls
cd bin/
ls
./emperor 
ls
exit
ls
ps -ef | grep ssh
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
ls
halt
emacs &
ping 192.168.2.2
ifconfig
exit
date
emacs &
exit
date
reboot
ls /etc/init.d/
cd /etc/init.d/
ls ti*
lla tim*
lla keep*
update-rc.d ./keepalive-ping.sh remove
cp keepalive-ping.sh keepalive-ping-OLD.sh
rm keepalive-ping.sh 
exit
ps -ef | grep ping
reboot
emacs today.text &
exit
emacs today.text &
exit
exit
xclock
exit
emacs today.text &
cat /etc/init.d/time-update.sh 
cat /etc/ntp.conf
ntpdate -vd
ntpdate -vd 192.168.2.2
ntpdate -vd ntp.ubuntu.com
ntpdate -vd 192.168.2.2
cat /etc/ntp.conf
ntpq
nano /etc/ntp.conf
ntpq
nano /etc/ntp.conf
ntpq
/etc/init.d/ntp restart
ntpq -d
ntpdate -uvb 192.168.2.2
exit
cat /root/bin/run-the-force 
exit
cd /
git status
git add -A
git commit -m "30 Oct 15

--Finished cleanup and implemented new barrier structure.  Testing
  shows that it achieves a steady 10fps camera rate within 1-2s of
  starting, so declaring that a success.
--**TO DOs**:
       1. Clean up commented out code in the-force
       2. Look at putting bump switches within barrier framework
       3. Look at code on laptop that stitches images into movies--do
          we need to reset the frame rate there?
       4. Port barrier structure back to emperor.  Probably easiest
          way to do it is to copy the-force and then replace the
	  automatic move section with the code from emperor that reads
	  and executes commands from the controller--PUT THIS INTO
  	  BARRIERS TOOgit commit -m "30 Oct 15

--Finished cleanup and implemented new barrier structure.  Testing
  shows that it achieves a steady 10fps camera rate within 1-2s of
  starting, so declaring that a success.
--**TO DOs**:
       1. Clean up commented out code in the-force
       2. Look at putting bump switches within barrier framework
       3. Look at code on laptop that stitches images into movies--do
          we need to reset the frame rate there?
       4. Port barrier structure back to emperor.  Probably easiest
          way to do it is to copy the-force and then replace the
	  automatic move section with the code from emperor that reads
	  and executes commands from the controller--PUT THIS INTO"
git commit -m "30 Oct 15

--Finished cleanup and implemented new barrier structure.  Testing
  shows that it achieves a steady 10fps camera rate within 1-2s of
  starting, so declaring that a success.
--**TO DOs**:
       1. Clean up commented out code in the-force
       2. Look at putting bump switches within barrier framework
       3. Look at code on laptop that stitches images into movies--do
          we need to reset the frame rate there?
       4. Port barrier structure back to emperor.  Probably easiest
          way to do it is to copy the-force and then replace the
	  automatic move section with the code from emperor that reads
	  and executes commands from the controller--PUT THIS INTO
  	  BARRIERS TOOgit commit -m "30 Oct 15

--Finished cleanup and implemented new barrier structure.  Testing
  shows that it achieves a steady 10fps camera rate within 1-2s of
  starting, so declaring that a success.
--**TO DOs**:
       1. Clean up commented out code in the-force
       2. Look at putting bump switches within barrier framework
       3. Look at code on laptop that stitches images into movies--do
          we need to reset the frame rate there?
       4. Port barrier structure back to emperor.  Probably easiest
          way to do it is to copy the-force and then replace the
	  automatic move section with the code from emperor that reads
	  and executes commands from the controller--PUT THIS INTO"
exit
