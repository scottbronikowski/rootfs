cd gpio/
ls
cd ..
modinfo pwm.ko
modinfo pwm
dmesg -T | tail
modinfo pwm
dmesg -T | tail
cd ~/build/linux-omap-3.5/drivers/omap3-pwm/
cd
ln -s ./pwm.ko /lib/modules/3.5.0-2-linaro-omap/kernel/drivers/omap3-pwm/
ln -s ~/build/linux-omap-3.5/drivers/omap3-pwm/pwm.ko /lib/modules/3.5.0-2-linaro-omap/kernel/drivers/omap3-pwm/
cd ../gpio-event/
ls
cd module/
ls
`pwd`
pwd
ln -s `pwd`/gpio-event-drv.ko /lib/modules/3.5.0-2-linaro-omap/kernel/drivers/gpio-event/
cd /lib/modules/3.5.0-2-linaro-omap/
ls
cd ker
cd kernel/
ls
cd drivers/
ls
lla
depmod -a
modinfo pwm-new
modinfo pwm
ls
rm pwm-new.ko 
lla
modinfo pwm-new
depmod -a
modinfo pwm-new
ln -s /omap3-pwm/pwm.ko ./pwm-new.ko
lla
depmod -a
modinfo pwm-new
cd 
ls
rsync -avrz seykhl:~/Downloads/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911\ \(3\).zip .
rsync -avrz seykhl:~/Downloads/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911.zip .
cd realtek/
ls
cd ..
rm RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911.zip 
cd realtek/
ls
lla
cd rt8192cu/
ls
cd ../RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911
ls
./install.sh 
modinfo 8192cu
ls
locate Makefile
ls
cd driver/
ls
ls | grep .tar.gz
cd rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911
ls
cd ..
ls | grep -iv '.tar.gz'
cd rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911
ls m*
cd ../..
cd ..
locate make_drv
cd 
locate pwm.ko
cd build/linux-omap-3.5/
ls
cd drivers/
ls
cd omap3-pwm/
ls
lla
lla /lib/modules/3.5.0-2-linaro-omap/kernel/drivers/omap3-pwm/
cd ../gpio-event/
ls
cd module/
ls
rsync -avrz ./* ~/gpio-event-temp/
modinfo gpio-event-drv
lla
cd ../..
cd input/misc/
ls
make ARCH=arm CROSS_COMPILE= -C /lib/modules/3.5.0-2-linaro-omap/build M=`pwd` modules
modinfo rotary_encoder
depmod -a
modinfo rotary_encoder
lla r*
lla /lib/modules/3.5.0-2-linaro-omap/kernel/drivers/input/
ln -s `pwd`/rotary_encoder.ko /lib/modules/3.5.0-2-linaro-omap/kernel/drivers/input/rotary_encoder.ko
lla /lib/modules/3.5.0-2-linaro-omap/kernel/drivers/input/
depmod -a
modinfo rotary_encoder
modprobe rotary_encoder
lsmod
modprobe -r rotary_encoder
lsmod
exit
cd /lib/modules/3.5.0-2-linaro-omap/build
ls
cd arch/
ls
lla
cd
emacs today.text
exit
ls
ping google.com
halt
reboot
emacs today.text
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5-linux64.tgz
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5-linux64.tgz .
emacs today.text
htop
updatedb
locate librxtxSerial.so
updatedb
locate rt.jar
locate tools.jar
apt-get install sun-java6-jre
apt-get install sun-java6-jdk
apt-get install sun-java6-bin
apt-get install sun-java6
ls /usr/lib/librx*
lla /usr/lib/librxtxSerial.so 
rm /usr/lib/librxtxSerial.so 
cd /usr/share/arduino/
ls
find
find > rover-arduino-package.txt
cp rover-arduino-package.txt ~/.
lla
lla a*
tar -xvf arduino-1.0.5-linux64.tgz 
rsync -avrz seykhl:~/Downloads/Teensy/49-teensy.rules /etc/udev/rules.d/
ls /etc/udev/rules.d/
rsync -avrz seykhl:~/Downloads/Teensy/teensyduino.64bit .
./teensyduino.64bit 
ls
cd source/
ls
mkdir sketches
cd /usr/lib
ls
cd jvm/java-7-openjdk-armhf/jre/lib/arm
ls
lla
rm libjvm.so
lla
ln -s jamvm/libjvm.so .
lla
cd /usr/lib/jvm/
ls
cd java-7-openjdk-armhf/
ls
cd jre/lib/arm/
lla
rm libjvm.so 
lla
cd /usr/lib/jvm
lla
rmdir java-7-openjdk-armhf/
rm -rf java-7-openjdk-armhf/
lla
java -version
cd /root/arduino-1.0.5/java/lib
ln -s /usr/lib/jvm/java-6-openjdk-armhf/jre/lib/rt.jar .
lla
dpkg-query -l | grep openjdk
apt-get install openjdk-6-jdk
apt-cache search openjdk
apt-cache search openjdk-6
apt-cache search openjdk-6-
dpkg-query -l | grep openjdk-6-
apt-get install openjdk-6-*
apt-get reinstall openjdk-6-*
apt-get install --reinstall openjdk-6-*
cd /
cd ~
ls
rm -rf arduino-1.0.5
ls
rm arduino-1.0.5-linux32.tgz 
cd /
locate AnalogReadSerial.ino
cd /usr/share/doc/arduino-core/examples/
ls
cd ../../arduino
ls
locate BarometricPressureWebServer
cd ../arduino-core/examples/
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/examples/Teensy .
cd /usr/share/arduino/
ls
lla examples
cd hardware/
ls
cd arduino/bootloaders/atmega8/
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/arduino/bootloaders/atmega8/ATmegaBOOT.txt .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/arduino/bootloaders/atmega8/ATmegaBOOT-p* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/arduino/bootloaders/cater* .
ls
rm -rf cater*
ls
cd ..
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/arduino/bootloaders/cater* .
ls
cd stk500v2/
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/arduino/bootloaders/stk500v2/avr_* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/arduino/bootloaders/stk500v2/Li* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/arduino/bootloaders/stk500v2/Mega* .
cd ../../
cd cores/
ls
cd arduino/
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/arduino/cores/arduino/avr-libc .
cd ..
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/arduino/cores/robot .
cd ../firmwares/
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/arduino/firmwares/* .
cd ../variants/
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/arduino/variants/robot* .
cd ../..
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/teensy .
cd ../..
ls
cd arduino/
ls
cd hardware/
ls
cd tools/
ls
lls
lla
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/tools/arm* .
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/tools/avr .
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/tools/avrdude64 .
lla
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/tools/m* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/tools/r* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/tools/t* .
lla
cd ../../lib
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/lib/ard* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/lib/ec* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/lib/lib* .
lla
cd ../libraries/
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/A* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/B* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/C* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/D* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/Enc* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/En* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/Es* .
cd Ethernet/
ls
cd examples/
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/Ethernet/examples/WebClientRepeating .
cd ../..
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/Fas* .
cd Firmata/examples/
ls
cd AnalogFirmata/
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/Firmata/examples/AnalogFirmata/M* .
cd ../EchoString/
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/Firmata/examples/EchoString/M* .
cd ../OldStandardFirmata/
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/Firmata/examples/OldStandardFirmata/L* .
cd ../ServoFirmata/
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/Firmata/examples/ServoFirmata/M* .
cd ../SimpleAnalogFirmata/
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/Firmata/examples/SimpleAnalogFirmata/M* .
cd ../SimpleDigitalFirmata/
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/Firmata/examples/SimpleDigitalFirmata/M* .
cd ../StandardFirmata/
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/Firmata/examples/StandardFirmata/M* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/Firmata/examples/StandardFirmata/L* .
cd ../..
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/Firmata/L* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/Firmata/r* .
cd ..
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/Fl* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/Fr* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/G* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/I* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/K* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/k* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/Le* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/LiquidCrystalFast .
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/Low* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/M* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/N* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/O* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/P* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/R* .
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/Sh* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/So* .
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/ST* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/T* .
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/U* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/V* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/WiFi .
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/X* .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/libraries/x* .
ls
cd ../lib
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/lib/teens* .
cat teensyduino.txt 
cd ..
ls
cd reference
ls
cd ..
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/src .
cd tools/Mangler/
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/tools/Mangler/make.sh .
lla t*
./teensyduino.64bit 
uname -m
file /usr/bin/file
lla ard*
rm -rf arduino-1.0.5/
rm arduino-1.0.5-linux64.tgz 
rm teensyduino.64bit 
rsync -avrz seykhl:~/Downloads/teensyduino.32bit .
rsync -avrz seykhl:~/Downloads/arduino-1.0.5-linux32.tgz .
tar -xvf arduino-1.0.5-linux32.tgz 
ls
rsync -avrz seykhl:~/Downloads/teensyduino.32bit .
lla t*
chmod a+x teensyduino.32bit 
./teensyduino.32bit 
lla tee*
cd arduino-1.0.5
ls
./arduino 
apt-get install arduino-core
./arduino 
cd ..
./teensyduino.32bit 
dpkg-query -l | grep jdk
apt-get install openjdk-7-jre
./teensyduino.32bit 
cd arduino-1.0.5
./arduino 
java -verbose:jni
apt-get install openjdk-7
apt-get install openjdk-7*
cd /usr/lib/jvm/
ls j*
cd java-7-openjdk-armhf/jre/lib/arm/
ls
ln -s jamvm/libjvm.so .
lla
cd ~/arduino-1.0.5
./arduino 
apt-get install openjdk-7-jdk
./arduino 
locate librxtxSerial
./arduino 
ls
cd lib
ls
java
java -version
ls
ln -s `pwd`/librxtxSerial.so /usr/lib/
lla /usr/lib/librx*
cd ..
./arduino 
apt-get install arduino
arduino
./arduino 
which arduino
locate arduino
arduino
cd ..
./teensyduino.32bit 
nautilus 
java -version
dpkg-query -l | grep ja
update-alternatives --config java
java -version
apt-get purge openjdk-7-*
arduino
cd arduino-1.0.5
./arduino 
ls
cd tools/
ls
cd ..
ls libraries/
cd ../lib
ls
cd ../arduino-1.0.5/lib
ls
feh about.jpg 
cd ..
ls
cd hardware/
ls
cd ..
java -version
apt-get install openjdk-6-jre
ls /usr/local/j*
ls usr/local
ls /usr/local
ls /usr
ls usr/share
ls /usr/share
ls /usr/share/java
locate rt.jar
locate tools.jar
mkdir java
cd java/
mkdir lib
ls /usr/lib/jvm
ls /usr/lib/java-6-openjdk-armhf
ls /usr/lib/jvm/java-6-openjdk-armhf/lib
ls /usr/lib/jvm/java-6-openjdk-armhf
ls /usr/lib/jvm/java-6-openjdk-armhf/jre
ls /usr/lib/jvm/java-6-openjdk-armhf/jre/lib
lla /usr/lib/jvm/java-6-openjdk-armhf/jre/lib
cd ../
$(dirname -- "$(readlink -f -- "${0}")" )
dirname
readlink
readlink -f
readlink --help
dirname -- "$(readlink -f -- "${0}")"
./arduino 
cd ..
wget http://udoo.org/download/files/arduino-1.5.4-hfp-for_UDOO.tar.gz
tar -xzvf arduino-1.5.4-hfp-for_UDOO.tar.gz 
lla *arduino*
cat seykhl-arduino.txt | sort
cd arduino-1.5.4
./arduino 
cd /
arduino
cd root
ls
cd razor-9dof-ahrs-Release-v1.4.2
ls
cd Arduino/
ls
cd Razor_AHRS/
ls
arduino Razor_AHRS.ino 
htop
cd arduino-1.0.5
ls
./arduino 
cd 
ls ar*
cd arduino-1.5.4
./arduino 
ls /etc/udev/rules.d/
cd /
find arduino-1.0.5
cd arduino-1.0.5
cd ~/arduino-1.0.5
find
cd ../arduino-1.5.4
find > rover-arduino-1.5.4.txt
cp rover-arduino-1.5.4.txt ../
cp rover-arduino-1.5.4.txt ~/.
cd ..
lla ro*
lla rover*
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/*.txt .
rm revisions.txt 
lla *arduino*
lla *arduino*.txt
cd arduino-1.5.4
ls
./arduino 
lla
ls
cd examples/
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/examples/Teensy/ .
ls
rm -rf Tutorial*/*
ls
rmdir Tutorial*
ls
rm -rf USB_*
ls
rm -rf Serial
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/examples/Teensy .
ls
cd ../hardware/
ls
cd arduino/
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/arduino/* .
ls
cd ..
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/teensy .
cd tools/arm-none-eabi/arm-none-eabi/bin
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/tools/arm-none-eabi/arm-none-eabi/bin/README.txt .
ls
cd ../include/
ls
cd c++/
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/tools/arm-none-eabi/arm-none-eabi/include/c++/4.7.2 .
ls
cd ../machine/
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/tools/arm-none-eabi/arm-none-eabi/include/machine/regdef.h .
cd ..
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/tools/arm-none-eabi/arm-none-eabi/include/process.h .
cd rpc/
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/tools/arm-none-eabi/arm-none-eabi/include/rpc/ .
cd ../../lib/
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/tools/arm-none-eabi/arm-none-eabi/lib/libarm_cortexM4l_math.a .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/tools/arm-none-eabi/arm-none-eabi/lib/thumb2 .
cd ../share/
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/tools/arm-none-eabi/arm-none-eabi/share/gcc-4.7.2 .
cd ../../bin/
ls
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/tools/arm-none-eabi/bin/arm-non-eabi-gcc-4.7.2 .
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/tools/arm-none-eabi/bin/arm-none-eabi-gcc-4.7.2 .
cd ..
ls
cd lib
ls
cd ..
rsync -avrz seykhl:~/Downloads/Teensy/arduino-1.0.5/hardware/tools/arm-none-eabi/libexec .
ls
cd ..cd /
cd /
ls
locate BitClear.html
locate Base.java
locate AvrdudeUploader.java
arduino
ls
cd ro
cd root
ls
lla ar*
rm -rf arduino-1.5.4
lla ar*
mkdir arduino-stuff
rsync -avrz seykhl:~/teensyduino/* ~/arduino-stuff/
cd arduino-stuff/
ls
lsusb
cd /
ls
cd root
ls
rsync -avrz seykhl:~/Downloads/razor* .
ls
lla raz*
lla /dev/tty*
lla /dev/ttyU*
cd /
git status
ls
top
rebps -ef | grep ssh
ps -ef | grep ssh
kill -9 925
ps -ef | grep ssh
reboot
lsusb
reboot
cat /dev/ttyUSB1
cat /dev/ttyUSB1 | tail
tail -f /dev/ttyUSB1
which minicom
which screen
man screen
screen /dev/ttyUSB1 57600
screen /dev/ttyUSB1 115200
screen /dev/ttyUSB1 57600
cd razor-9dof-ahrs-Release-v1.4.2/
ls
cd Processing/Magnetometer_calibration/
ls
rsync seykhl:~/vader-rover/output2.txt .
ls
cat output2.txt 
ls /dev/ttyUSB*
screen /dev/ttyUSB1 57600
exit
htop
exit
cd razor-9dof-ahrs-Release-v1.4.2
ls
cd Processing/
ls
cd Magnetometer_calibration/
ls
rsync -avrz seykhl:~/vader-rover/output.txt .
ls
cd ../../Arduino/Razor_AHRS/
ls
arduino Razor_AHRS.ino 
exit
ping google.com
emacs today.text &
halt
cd /dev
ls
lla R*
tail -f RazorIMU 
ls
udevadm trigger
ls
lla RazorIMU 
cat RazorIMU 
ls
udevadm trigger
ls
udevadm control --reload-rules
ls
udevadm trigger
ls
udevadm trigger
ls
udevadm control --reload-rules
ls
D[2~
lla R*
lla G*
lla ttyUSB*
exit
screen /dev/ttyUSB1 57600
ls /dev/ttyUSB*
screen /dev/ttyUSB1 57600
ls /dev/ttyUSB*
screen /dev/ttyUSB1 57600
screen /dev/ttyUSB0 57600
screen /dev/ttyUSB1 4800
screen /dev/GPS 4800
screen /dev/RazorIMU 57600
exit
cd /dev
ls
lla
cd /sys/devices
ls
find -name "ttyUSB1"
cd /sys/class/tty
ls
readlink ttyUSB1
lsusb
cd `readlink ttyUSB1`
ls
cd ../..
ls
cd ../..
ls
cat idProduct 
cat idVendor 
cd /etc/udev
ls
cat udev.conf 
cd rules.d/
ls
cat 40-pgr.rules 
ls
cd 70-persistent-
cd 70-persistent-cd.rules 
cat 70-persistent-cd.rules 
cat 70-persistent-net.rules
cat README 
udevinfo
apt-get install udevinfo
udevadm
udevadm info --query all -name /dev/ttyUSB* --attribute-walk
udevadm info --query all -name /dev/ttyUSB0 --attribute-walk
udevadm info --query all --name /dev/ttyUSB0 --attribute-walk
udevadm info --query all --name /dev/ttyO0 --attribute-walk
udevadm info --query all --name /dev/ttyUSB0 --attribute-walk
ls
ls /dev
udevadm control --reload-rules
ls /dev
udevadm control --reload-rules
ls /dev
udevadm control --reload-rules
ls /dev
udevadm control --reload-rules
ls /dev
udevadm trigger
ls /dev
lla /dev/RazorIMU 
screen /dev/RazorIMU 57600
screen /dev/ttyUSB1 57600
cat /dev/RazorIMU 
tail -f /dev/RazorIMU 
lsusb
udevadm info --query all --name /dev/ttyUSB1 --attribute-walk
lsusb
ls /dev/ttyUSB*
lsusb
exit
cd razor-9dof-ahrs-Release-v1.4.2/Arduino/Razor_AHRS/
arduino Razor_AHRS.ino 
exit
htop
exit
emacs today.text &
halt
ls
exit
exit
htop
exit
exit
emacs today.text
halt
lsusb
ls
ls /dev
ls /dev/G*
ls /dev/R*
lla /dev/R*
AT S7=45 S0=0 L1 V1 X4 &c1 E1 Q0
ls
pwd
rebootreboot
reboot
lla /dev/R*
emacs today.text 
ls
cd razor-9dof-ahrs-Release-v1.4.2/Processing/Magnetometer_calibration/
ls
rsync -avrz seykhl:~/vader-rover/output3.txt .
ls
cat output3.txt 
arduino
htop
screen /dev/GPS 4800
lla /dev/R*
lla /dev/G*
screen /dev/RazorIMU 57600
exit
exit
exit
arduino
exit
ATZ
AT S7=45 S0=0 L1 V1 X4 &c1 E1 Q0
ls
p;wd
pwd
ps
ps -ef
halt
screen /dev/RazorIMU 57600
cd source
ls
mkdir razor-imu
cd razor-imu/
ls
mkdir arduino
cd arduino/
ls
mv *.ino Razor_AHRS/
ls
lla /dev/R*
exit
cd razor-9dof-ahrs-Release-v1.4.2/Arduino/
ls
cd Razor_AHRS/
ls
htop
exit
screen /dev/RazorIMU 57600
exit
arduino
exit
emacs today.text
exit
lsusb
dmesg -T | tail
dmesg | tail
halt
screen /dev/RazorIMU 57600
ls /dev/R*
screen /dev/RazorIMU 57600
exit
lsmod
ls
exit
ls
halt
cd source/libbeagle/
ls
grep -ri pread *
cd ..
ls
cd razor-imu/
ls
lla
rep -ri 57600 *
grep -ri 57600 *
cd ../emperor/
make
lla /dev/RazorIMU 
cd ../razor-imu/arduino/Razor_AHRS/
ls
screen /dev/RazorIMU 57600
cd ~/razor-9dof-ahrs-Release-v1.4.2
ls
cd C++
ls
make
g++ RazorAHRS.cpp Example.cpp -o example
g++ -lpthread -D_REENTRANT RazorAHRS.cpp Example.cpp -o example
g++ -lpthread -D_REENTRANT -c RazorAHRS.cpp
ls
g++ -lpthread -D_REENTRANT -c Example.cpp 
g++ -o example RazorAHRS.o Example.o -lpthread
ls
./example 
touch Makefile
make
make clean
make
make clean
make
./example 
screen /dev/RazorIMU 57600
htop
cd ~/
ls
cd source/razor-imu/arduino/Razor_AHRS/
ls
grep -i millis *
screen /dev/RazorIMU 57600
exit
lla /dev/RazorIMU 
cd source/
ls
grep -ri log_data *
screen /dev/RazorIMU 57600
lla /dev/GPS
cd motor_control/
ls
cat Makefile 
cd ..
ls
cd camera/
ls
cat Makefile 
cd ..
cd razor-imu/
ls
touch razor-imu.cpp
touch razor-imu.h
ls
cd ../emperor/
ls
make
screen /dev/RazorIMU 57600
make
cd ../../include/
ls
lla
ln -s /root/source/razor-imu/razor-imu.h ./razor-imu.h
lla
cd ../source/emperor/
ls
make
grep -ri pread *
cd ..
grep -ri pread *
grep -ri SIGALRM *
grep -ri ALRM *
ls
cd libbeagle/
lla
cd main/src/
ls
lla
grep -ri SIGALRM *
grep -ri sig *
grep -ri sigalrm *
cat makefile 
cd ..
grep -ri signal *
grep -ri sig *
grep -ri timer *
cd ~
ls
grep -ri timer *
grep -ri sigalrm *
cd rotary-encoder/
ls
cd bgwz/
ls
cd BeagleBone/
ls
cd libbeagle/
ls
grep -ri SIGALRM *
grep -ri sig *
grep -ri timer *
lla
cd main/
lla
cd src/
ls
lla
cd ../../
ls
cd ..
ls
cd libbeagle/
cd examples/
ls
cd rotary/
ls
grep -ri sig *
lla
./rotary 
./my_rotary 
lla
cd ~/source/libbeagle/
ls
cd examples/
ls
cd rotary/
ls
lla
./rotary 
lla
grep -ri SIGALRM *
grep -ri sig *
cat rotary.cpp 
cat my_rotary.cpp 
cat makefile 
cd ../..
grep -ri sig *
grep -ri timer *
grep -ri action *
grep -ri sigact
grep -ri sigact *
cd examples/rotary/
ls
cat rotary.cpp 
lla
ls
rsync -avrz seykhl:~/Downloads/rotary/rotary.cpp .
lla
chown root:root rotary.cpp
lla
cd ../../main/src/
ls
rsync -avrz seykhl:~/Downloads/rotary/rotary.* .
lla
chown root:root rotary.*
lla
cd../../
ls
cd ../../examples/
ls
cd rotary/
ls
make
make clean
make
cat makefile 
cd ..
cd main/
ls
cd src/
ls
cat makefile 
make clean
make
cd ../../examples/rotary/
ls
make
./rotary 
cd ~/source/emperor/
ls
make
make clean
make
make clean
make
cd ../razor-imu/arduino/Razor_AHRS/
ls
grep compensate *
grep output_mine *
grep Compass_Heading *
grep Matrix_update() *
grep Matrix_update *
grep GRAVITY *
cd ../../../emperor/
ls
lla
ls ../../bin
lla ../../bin
make
grep -ri log_data *
cd ../
grep -ri log_data *
cd emperor/
make
exit
screen /dev/RazorIMU 57600
cd razor-9dof-ahrs-Release-v1.4.2/C++/
ls
cd ..
ls
cd Matlab/
ls
cd ..
cd Android/
ls
cd RazorExampleApp/
ls
acd src/
cd src/
ls
cd de/
ls
cd tuberlin/
ls
cd qu
ls
cat RazorExample.java 
cd RazorExampleApp
cd ~/source/bin
ls
cd ~/source/
ls
cd ../bin/
ls
./emperor 
exit
arduino
screen /dev/RazorIMU 57600
ls
cd bin
ls
cd path
ls
cd scc 
cd ~
cd scheme2c-bgc/
ls
cat README 
cd /home/abarbu
cd /
ls
cd home
ls
cd ~
ls
cat notes28jan14.txt 
cat notes10feb14.txt 
cat notes28jan14.txt 
cat notes4march.txt 
cat notes7march.txt 
ls
cat open-files-13-feb.txt 
cat open-files-14-feb.txt 
cat open-files-17-feb.txt 
cat open-files-24-feb.txt 
cat open-files-25-feb.txt 
cat open-files-26-feb.txt 
ardunio
arduino
htop
exit
emacs today.text
exit
lsusb
ATZ
AT S7=45 S0=0 L1 V1 X4 &c1 E1 Q0
ATZ
AT S7=45 S0=0 L1 V1 X4 &c1 E1 Q0
halt
emacs today.text
arduino
exit
˜ž`þž˜`þžf`


halt
emacs today.text
cd bin
./emperor 
htop
reboot
cd bin
ls
./emperor 
exit
htop
exit
exit
exit
emacs today.text
exit
cd bin
./emperor 
exit
reboot
clear
emacs today.text 
cd bin
./run-emperor start
reboot
emacs today.text
emacs today.text &
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
ls
top
lsusb
ps -ef | grep run-
killall run-imu
killall emperor
ps -ef | grep ssh
reboot
emacs today.text
cd source/razor-imu/arduino/Razor_AHRS/
ls
grep -ri millis *
lla /dev/U*
lla /dev/ttyU*
cd ../
cd ..
make
pkill run-imu
make
make clean
make
ls
cd arduino/
ls
cd ..
make
ps -ef | grep screen
kill -9 4036
make
make clean
make
cd bin
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
lla /dev/RazorIMU 
screen /dev/RazorIMU 57600
cd ../source/razor-imu/
make
cd ../../bin
./run-imu 
gdb
gdb ./run-imu 
./run-imu 
screen /dev/RazorIMU 57600
./run-imu 
screen /dev/RazorIMU 57600
./run-imu 
screen /dev/RazorIMU 57600
cd ..
ls
cd razor-9dof-ahrs-Release-v1.4.2
ls
cd C++
ls
cat RazorAHRS.cpp 
cd ~/bin
./run-imu 
screen /dev/RazorIMU 57600
./run-imu 
screen /dev/RazorIMU 57600
./run-imu 
screen /dev/RazorIMU 57600
./run-imu 
screen /dev/RazorIMU 57600
./run-imu 
screen /dev/RazorIMU 57600
./run-imu 
screen /dev/RazorIMU 57600
./run-imu 
./run-emperor 
./run-emperor start
./run-imu 
screen /dev/RazorIMU 57600
./run-imu 
screen /dev/RazorIMU 57600
./run-imu 
./run-emperor start
htop
emacs today.text
cd bin
./run-emperor start
./run-emperor stop
./run-emperor start
reboot
htop
top
htop
exit
cd bin
./run-emperor start
./run-emperor stop
./run-emperor start
./run-emperor stop
./run-imu 
exit
cd source/razor-imu/
make
lla /dev/RazorIMU 
screen /dev/RazorIMU 57600
lla /dev/RazorIMU 
cd arduino/Razor_AHRS/
ls
locate Razor_AHRS.cpp
cd /
locate Razor_AHRS.cpp
screen /dev/RazorIMU 57600
git status
git add -A
git commit -m "commit before starting to collect IMU data"
git push
screen /dev/RazorIMU 57600
exit
arduino
exit
emacs today.text
exit
halt
screen /dev/RazorIMU 57600
exit
exit
arduino
cd bin
ls
./run-imu 
exit
cd source/razor-imu/
ls
make
ls /dev/RazorIMU 
lla /dev/RazorIMU 
screen /dev/RazorIMU 57600
make
screen /dev/RazorIMU 57600
exit
arduino
exit
À
emacs today.text
halt
cd /bin
ls
cd /root/bin
./run-emperor 
./run-emperor start
exit
screen /dev/RazorIMU 57600
cd
exit
halt
screen /dev/RazorIMU 57600
lla /dev/RazorIMU 
screen /dev/RazorIMU 57600
lla /dev/RazorIMU 
screen /dev/RazorIMU 57600
cat /etc/udev/rules.d/49-teensy.rules 
ls /dev
lla
lla /dev/
cd /dve
cd /dev
lla u*
cd usbmon0
cat usbmon0
lla
udevadm control --reload_rules
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
