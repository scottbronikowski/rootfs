ls /etc/rc6.d/
rm -f /etc/rc6.d/S0*
rm -f /etc/rc6.d/K0*
ls /etc/rc6.d/
git status
rm -f /etc/rcS.d/S0*
rm -f /etc/init.d/.depend.*
ls /etc/rc*
cd /etc/init.d
update-rc.d -f keepalive-ping.sh remove
cd /
git status
git add -A
git commit -m "removed keepalive-ping.sh from startup"
git push
cd /etc/rcS.d/
touch S05keymap.sh
chmod a+x S05keymap.sh 
vi S05keymap.sh 
reboot
ls /etc/rc5.d
ps -ef | grep ssh
date
ps -ef | grep moni
ps -ef | grep noi
cd /etc/init.d/
update-rc.d keepalive-ping.sh defaults
reboot
cd /etc/init.d/
update-rc.d -f keepalive-ping.sh remove
/etc/init.d/keepalive-ping.sh start
vi /etc/init.d/keepalive-ping.sh 
ls ke*
lla ../rcS.d/
cd ../rcS.d/
rm S05keymap.sh 
ln -s ../init.d/keymap.sh S05keymap.sh
lla
reboot
/etc/init.d/keepalive-ping.sh 
/etc/init.d/keepalive-ping.sh start
ps -ef | grep ping
cd /
git status
git add -A
git commit -m 
git commit -m "commit before demo--keepalive-ping.sh NOT in startup"
git push
ps -ef | grep ssh
ps -ef | grep ping
reboot
]
hald
halt
daTE
date
emacs &
date
/etc/init.d/time-update.sh start
emacs &
exit
date
ps -ef | grep ssh
/etc/init.d/keepalive-ping.sh start
ping google.com
ps -ef | grep ssh
kill -9 919
ps -ef | grep ssh
/etc/init.d/ssh-tunnel.sh start
date
ls /etc/rc*
ps -ef | grep noi
update-rc.d /etc/init.d/time-update.sh defaults 26
update-rc.d time-update.sh defaults 26
update-rc.d -f time-update.sh remove
update-rc.d time-update.sh defaults 26
ls /etc/rc*
git status
git add -A
git commit -m "moved time-update.sh to 26 vice 25 -- may still need to add 'set -e' to scripts"
git push
ping google.com
ifdown wlan0
ifup wlan0
ping google.com
ps -ef | grep moni
/root/test_code/monitor 
/etc/init.d/ssh-tunnel.sh start
ps -ef | grep ssh
kill 2469
/etc/init.d/ssh-tunnel.sh
/etc/init.d/ssh-tunnel.sh start
ps -ef | grep ssh
halt
emacs &
ls
halt
date
emacs &
ls /etc/rc*
ps -ef | grep noi
ps -ef | grep ntp
ls
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
ps -ef | grep ping
ps -ef | grep ntp
reboot
date
/etc/init.d/time-update.sh 
/etc/init.d/time-update.sh start
emacs &
cd /etc/init.d
update-rc.d -f ssh-tunnel.sh remove
update-rc.d ssh-tunnel.sh defaults 28
lsusb
cd ~/pointgrey/
ls
cd flycapture.2.5.3.5_armhf
ls
cd src
ls
lla
cd MultipleCameraEx/
ls
more ReadMe.txt 
ls
more Makefile 
cd ../../bin
ls
lla
cd C
ls
cd ..
ls
cd ../src
ls
cd FlyCap2_ARM/
ls
less FlyCap2.rc
more Makefile 
ls
dpkg -s libdc1394
dpkg -s libusb
cd ../../bin
ls
./FlyCap2
lsusb
ls
cd /
git status
git add -A
git commit -m "added keepalive-ping.sh to startup as #27 (does not appear to work); moved ssh-tunnel.sh to #28 (vice #24); apt-get install libgtkmm-2.4 libglademm-2.4 libusb-1.0-0 vlc imagej imagemagick inkscape feh; apt-get install dhelp dwww doc-central yelp khelpcenter4 rarian-compat gtkmm-documentation libglibmm-2.4-doc"
git push
apt-get install java-virtual-machine default-jre equivs icedtea-plugin sun-java6-fonts fonts-ipafont-gothic fonts-ipafont-mincho ttf-wqy-microhei ttf-wqy-zenhei ttf-indic-fonts-core ttf-telugu-fonts ttf-oriya-fonts ttf-kannada-fonts ttf-bengali-fonts ttf-dejavu-extra icedtea-netx icedtea-6-jre-cacao icedtea-6-jre-jamvm
apt-get install default-jre equivs icedtea-plugin sun-java6-fonts fonts-ipafont-gothic fonts-ipafont-mincho ttf-wqy-microhei ttf-wqy-zenhei ttf-indic-fonts-core ttf-telugu-fonts ttf-oriya-fonts ttf-kannada-fonts ttf-bengali-fonts ttf-dejavu-extra icedtea-netx icedtea-6-jre-cacao icedtea-6-jre-jamvm
apt-get install java-virtual-machine default-jre equivs icedtea-plugin fonts-ipafont-gothic fonts-ipafont-mincho ttf-wqy-microhei ttf-wqy-zenhei ttf-indic-fonts-core ttf-telugu-fonts ttf-oriya-fonts ttf-kannada-fonts ttf-bengali-fonts ttf-dejavu-extra icedtea-netx icedtea-6-jre-cacao icedtea-6-jre-jamvm
git add -A
git commit -m "apt-get install java-virtual-machine default-jre equivs icedtea-plugin fonts-ipafont-gothic fonts-ipafont-mincho ttf-wqy-microhei ttf-wqy-zenhei ttf-indic-fonts-core ttf-telugu-fonts ttf-oriya-fonts ttf-kannada-fonts ttf-bengali-fonts ttf-dejavu-extra icedtea-netx icedtea-6-jre-cacao icedtea-6-jre-jamvm"
git push
apt-get install libdc1394
apt-get install imagemagick-doc autotrace cups-bsd lpr lprng enscript ffmpeg gnuplot grads hp2xx html2ps libwmf-bin povray radiance sane-utils texlive-base-bin transfig ufraw-batch libmagickcore4-extra netpbm
apt-get install imagemagick-doc autotrace cups-bsd lpr lprng enscript ffmpeg gnuplot grads hp2xx html2ps libwmf-bin radiance sane-utils texlive-base-bin transfig ufraw-batch libmagickcore4-extra netpbm
apt-get install imagemagick-doc autotrace lpr lprng enscript ffmpeg gnuplot grads hp2xx html2ps libwmf-bin radiance sane-utils texlive-base-bin transfig ufraw-batch libmagickcore4-extra netpbm
apt-get install imagemagick-doc autotrace enscript ffmpeg gnuplot grads hp2xx html2ps libwmf-bin radiance sane-utils texlive-base-bin transfig ufraw-batch libmagickcore4-extra netpbm
git add -A
git commit -m "apt-get install imagemagick-doc autotrace enscript ffmpeg gnuplot grads hp2xx html2ps libwmf-bin radiance sane-utils texlive-base-bin transfig ufraw-batch libmagickcore4-extra netpbm"
git push
apt-get install  dia dia-gnome libsvg-perl libxml-xql-perl pstoedit transfig libgnomevfs2-bin gamin fam gnome-mime-data gsl-ref-psdoc gsl-doc-pdf gsl-doc-info gsl-ref-html libwmf-bin python-lxml python-uniconvertor libgnomevfs2-extra perlmagick libjpeg-progs
apt-get install  dia dia-gnome libsvg-perl libxml-xql-perl pstoedit transfig libgnomevfs2-bin fam gamin gnome-mime-data gsl-ref-psdoc gsl-doc-pdf gsl-doc-info gsl-ref-html libwmf-bin python-lxml python-uniconvertor libgnomevfs2-extra perlmagick libjpeg-progs
apt-get install  dia dia-gnome libsvg-perl libxml-xql-perl pstoedit transfig libgnomevfs2-bin fam gnome-mime-data gsl-ref-psdoc gsl-doc-pdf gsl-doc-info gsl-ref-html libwmf-bin python-lxml python-uniconvertor libgnomevfs2-extra perlmagick libjpeg-progs
git add -A
git commit -m "apt-get install  dia dia-gnome libsvg-perl libxml-xql-perl pstoedit transfig libgnomevfs2-bin fam gnome-mime-data gsl-ref-psdoc gsl-doc-pdf gsl-doc-info gsl-ref-html libwmf-bin python-lxml python-uniconvertor libgnomevfs2-extra perlmagick libjpeg-progs"
git push
ps
ps -ef
ps -ef | grep ssh
date
ps -ef | grep moni
ls /etc/rc*
ps -ef | grep ping
echo 20000 > /dev/pwm9
echo 15000 > /dev/pwm9
ls /etc/rc5.d/
cat /etc/rc5.d/S21fam 
ls /etc/rc5.d/
cd /etc/init.d
update-rc.d -f gpio-monitor.sh remove
update-rc.d gpio-monitor.sh defaults 21
ls /etc/rc5.d/
update-rc.d -f monitor.sh remove
update-rc.d monitor.sh defaults 22
ls /etc/init.d/
ls /etc/rc5.d/
ps -ef | grep noi
update-rc.d -f time-update.sh remove
update-rc.d time-update.sh defaults 24
ls /etc/rc5.d/
update-rc.d -f keepalive-ping.sh remove
update-rc.d keepalive-ping.sh defaults 24
update-rc.d -f ssh-tunnel.sh remove
update-rc.d ssh-tunnel.sh defaults 25
ls /etc/rc5.d/
cd /
git status
git add -A
git commit -m "changed startup order: root@vader-rover:/etc/init.d# ls /etc/rc5.d/
README              S21servo-control.sh  S24keepalive-ping.sh  S50saned
S20pinmux.sh        S22monitor.sh        S24time-update.sh     S75sudo
S21fam              S23debian.noip2.sh   S25ssh-tunnel.sh      S99ondemand
S21gpio-monitor.sh  S23ntp               S50rsync              S99rc.local"
git push
reboot
echo 20000 > /dev/pwm10
echo 15000 > /dev/pwm10
ps -ef
date
ls /etc/rc5.d/
ps -ef | grep noi
ps -ef | grep ntp
ps -ef | grep ssh
cd /var/log
ls
cat boot.log
ls /etc/rc*
cat /etc/rc5.d/S22monitor.sh 
runlevel
ls /etc/rc2.d/
ls /etc/rc*
/etc/init.d/ssh-tunnel.sh start
ifdown wlan0
ifup wlan0
/etc/init.d/ssh-tunnel.sh start
emacs &
ps -ef | grep noi
cd /etc/init.d/
update-rc.d -f monitor.sh remove
update-rc.d monitor.sh defaults
update-rc.d -f monitor.sh remove
update-rc.d monitor.sh defaults 99
cd /
git add -A
git commit -m "moved monitor.sh to #99"
git push
reboot
cd /etc/default
ls
more saned 
vi saned
reboot
vi /etc/init.d/keepalive-ping.sh 
ls /etc/rc*
ls
apt-get install dlocate upower virtuoso-minimal kubuntu-debug-installer icoutils libcanberra-pulse libcanberra-gstreamer libvisual-0.4-plugins
it-java libdom4j-java-doc ttf-dustin libjaxme-java-doc libjaxp1.3-java-gcj libjdom1-java-doc liblog4j1.2-java-doc libgnumail-java libmx4j-java libscalar-number-perl libsaxon-java-doc libsaxonb-java-doc sidplay-base xsidplay libxalan2-java-doc libxsltc-java libxerces2-java-doc libxerces2-java-gcj libxml-commons-resolver1.1-java-doc libxom-java-doc manpages-dev w3m-img menu w3m-el migemo texlive-fonts-recommended pdf2djvu debian-faq rhino libcanberra-gtk-module libpackage-stash-xs-perl libxml-sax-expat-perl texlive-luatex lmodern
n
apt-get install dlocate upower virtuoso-minimal kubuntu-debug-installer icoutils libcanberra-pulse libcanberra-gstreamer libvisual-0.4-plugins gstreamer0.10-plugins-good gnome-user-guide videolan-doc libmtp-runtime vlc-plugin-notify vlc-plugin-pulse dh-make fastjar gcj-4.6-jdk libgcj12-awt gcj-jdk libgcj12-dbg libmail-box-perl x-ttcidfont-conf gcj-4.6-jre-lib libmail-sendmail-perl lpr gnuplot-doc weblint-perl texlive-base xhtml2ps libgd-tools geotiff-bin gdal-bin libgeotiff-epsg gphoto2 gtkam libhdf4-doc libhdf4-dev hdf4-tools proj-bin hpoj hplip libsane-extras libgnomeprintui2.2-0 radiance-doc unpaper tclreadline xfig ufraw groff ttf-liberation libgphoto2-l10n radiance-materials gv ps-viewer libbonobo2-bin desktop-base python-imaging-doc python-imaging-dbg python-lxml-dbg python-egenix-mxtexttools python-reportlab-doc python-uniconvertor-dbg gsfonts-x11 gvfs python-reportlab-accel python-renderpm djvulibre-desktop psgml jadetex docbook-dsssl-doc dlocate grep-dctrl tasksel fop-doc libservlet2.5-java gvfs-backends libavalon-framework-java-doc libbackport-util-concurrent-java-doc bsh libcommons-io-java-doc libcommons-logging-java-doc libexcalibur-logkit-java libdom4j-java-doc ttf-dustin libjaxme-java-doc libjaxp1.3-java-gcj libjdom1-java-doc liblog4j1.2-java-doc libgnumail-java libmx4j-java libscalar-number-perl libsaxon-java-doc libsaxonb-java-doc sidplay-base xsidplay libxalan2-java-doc libxsltc-java libxerces2-java-doc libxerces2-java-gcj libxml-commons-resolver1.1-java-doc libxom-java-doc manpages-dev w3m-img menu w3m-el migemo texlive-fonts-recommended pdf2djvu debian-faq rhino libcanberra-gtk-module libpackage-stash-xs-perl libxml-sax-expat-perl texlive-luatex lmodern
apt-get install dlocate upower virtuoso-minimal kubuntu-debug-installer icoutils libcanberra-pulse libcanberra-gstreamer libvisual-0.4-plugins gstreamer0.10-plugins-good gnome-user-guide videolan-doc libmtp-runtime vlc-plugin-notify vlc-plugin-pulse dh-make fastjar gcj-4.6-jdk libgcj12-awt gcj-jdk libgcj12-dbg libmail-box-perl x-ttcidfont-conf gcj-4.6-jre-lib libmail-sendmail-perl lpr gnuplot-doc weblint-perl texlive-base xhtml2ps libgd-tools geotiff-bin gdal-bin libgeotiff-epsg gphoto2 gtkam libhdf4-doc libhdf4-dev hdf4-tools proj-bin hplip libsane-extras libgnomeprintui2.2-0 radiance-doc unpaper tclreadline xfig ufraw groff ttf-liberation libgphoto2-l10n radiance-materials gv libbonobo2-bin desktop-base python-imaging-doc python-imaging-dbg python-lxml-dbg python-egenix-mxtexttools python-reportlab-doc python-uniconvertor-dbg gsfonts-x11 gvfs python-reportlab-accel python-renderpm djvulibre-desktop psgml jadetex docbook-dsssl-doc dlocate grep-dctrl tasksel fop-doc libservlet2.5-java gvfs-backends libavalon-framework-java-doc libbackport-util-concurrent-java-doc bsh libcommons-io-java-doc libcommons-logging-java-doc libexcalibur-logkit-java libdom4j-java-doc ttf-dustin libjaxme-java-doc libjaxp1.3-java-gcj libjdom1-java-doc liblog4j1.2-java-doc libgnumail-java libmx4j-java libscalar-number-perl libsaxon-java-doc libsaxonb-java-doc sidplay-base xsidplay libxalan2-java-doc libxsltc-java libxerces2-java-doc libxerces2-java-gcj libxml-commons-resolver1.1-java-doc libxom-java-doc manpages-dev w3m-img menu w3m-el migemo texlive-fonts-recommended pdf2djvu debian-faq rhino libcanberra-gtk-module libpackage-stash-xs-perl libxml-sax-expat-perl texlive-luatex lmodern
git status
git add -A
git commit -m " apt-get install dlocate upower virtuoso-minimal kubuntu-debug-installer icoutils libcanberra-pulse libcanberra-gstreamer libvisual-0.4-plugins gstreamer0.10-plugins-good gnome-user-guide videolan-doc libmtp-runtime vlc-plugin-notify vlc-plugin-pulse dh-make fastjar gcj-4.6-jdk libgcj12-awt gcj-jdk libgcj12-dbg libmail-box-perl x-ttcidfont-conf gcj-4.6-jre-lib libmail-sendmail-perl lpr gnuplot-doc weblint-perl texlive-base xhtml2ps libgd-tools geotiff-bin gdal-bin libgeotiff-epsg gphoto2 gtkam libhdf4-doc libhdf4-dev hdf4-tools proj-bin hplip libsane-extras libgnomeprintui2.2-0 radiance-doc unpaper tclreadline xfig ufraw groff ttf-liberation libgphoto2-l10n radiance-materials gv libbonobo2-bin desktop-base python-imaging-doc python-imaging-dbg python-lxml-dbg python-egenix-mxtexttools python-reportlab-doc python-uniconvertor-dbg gsfonts-x11 gvfs python-reportlab-accel python-renderpm djvulibre-desktop psgml jadetex docbook-dsssl-doc dlocate grep-dctrl tasksel fop-doc libservlet2.5-java gvfs-backends libavalon-framework-java-doc libbackport-util-concurrent-java-doc bsh libcommons-io-java-doc libcommons-logging-java-doc libexcalibur-logkit-java libdom4j-java-doc ttf-dustin libjaxme-java-doc libjaxp1.3-java-gcj libjdom1-java-doc liblog4j1.2-java-doc libgnumail-java libmx4j-java libscalar-number-perl libsaxon-java-doc libsaxonb-java-doc sidplay-base xsidplay libxalan2-java-doc libxsltc-java libxerces2-java-doc libxerces2-java-gcj libxml-commons-resolver1.1-java-doc libxom-java-doc manpages-dev w3m-img menu w3m-el migemo texlive-fonts-recommended pdf2djvu debian-faq rhino libcanberra-gtk-module libpackage-stash-xs-perl libxml-sax-expat-perl texlive-luatex lmodern
"
git status
cd /
git add -A
git commit -m "Second attempt at commit: apt-get install dlocate upower virtuoso-minimal kubuntu-debug-installer icoutils libcanberra-pulse libcanberra-gstreamer libvisual-0.4-plugins gstreamer0.10-plugins-good gnome-user-guide videolan-doc libmtp-runtime vlc-plugin-notify vlc-plugin-pulse dh-make fastjar gcj-4.6-jdk libgcj12-awt gcj-jdk libgcj12-dbg libmail-box-perl x-ttcidfont-conf gcj-4.6-jre-lib libmail-sendmail-perl lpr gnuplot-doc weblint-perl texlive-base xhtml2ps libgd-tools geotiff-bin gdal-bin libgeotiff-epsg gphoto2 gtkam libhdf4-doc libhdf4-dev hdf4-tools proj-bin hplip libsane-extras libgnomeprintui2.2-0 radiance-doc unpaper tclreadline xfig ufraw groff ttf-liberation libgphoto2-l10n radiance-materials gv libbonobo2-bin desktop-base python-imaging-doc python-imaging-dbg python-lxml-dbg python-egenix-mxtexttools python-reportlab-doc python-uniconvertor-dbg gsfonts-x11 gvfs python-reportlab-accel python-renderpm djvulibre-desktop psgml jadetex docbook-dsssl-doc dlocate grep-dctrl tasksel fop-doc libservlet2.5-java gvfs-backends libavalon-framework-java-doc libbackport-util-concurrent-java-doc bsh libcommons-io-java-doc libcommons-logging-java-doc libexcalibur-logkit-java libdom4j-java-doc ttf-dustin libjaxme-java-doc libjaxp1.3-java-gcj libjdom1-java-doc liblog4j1.2-java-doc libgnumail-java libmx4j-java libscalar-number-perl libsaxon-java-doc libsaxonb-java-doc sidplay-base xsidplay libxalan2-java-doc libxsltc-java libxerces2-java-doc libxerces2-java-gcj libxml-commons-resolver1.1-java-doc libxom-java-doc manpages-dev w3m-img menu w3m-el migemo texlive-fonts-recommended pdf2djvu debian-faq rhino libcanberra-gtk-module libpackage-stash-xs-perl libxml-sax-expat-perl texlive-luatex lmodern
"
git push
emacs &
vi pointgrey/flycapture.2.5.3.5_armhf/include/C/FlyCapture2_C.h
cat FlyCapture2_C.h
cat pointgrey/flycapture.2.5.3.5_armhf/include/C/FlyCapture2_C.h 
vi pointgrey/flycapture.2.5.3.5_armhf/include/C/FlyCapture2_C.h
ls
cd pointgrey/
ls
rm -rf flycapture.2.6.3.2_armhf/
ls
tar xvfz flycapture.2.6.3.2_armhf.tar.gz 
cd flycapture.2.6.3.2_armhf/lib
cp libflycapture* /usr/lib
ls /usr/lib/libflycap*
lla /usr/lib/libflycap*
rm /usr/lib/libflycapture*
lla /usr/lib/libflycap*
cp libflycapture* /usr/lib
lla /usr/lib/libflycap*
lla
rm /usr/lib/libflycapture*
cp -av libflycapture* /usr/lib
lla
lla /usr/lib/libflycap*
cd ~/pointgrey/flycapture.2.6.3.2_armhf
ls
./flycap2-conf 
cd src/FlyCapture2Test
ls
make
cd ..
ls
cd ../bin
./FlyCapture2Test 
lsusb
top
/etc/init.d/monitor.sh stop
top
htop
dpkg -s top
top
ls
rm *.pgm
./MultipleCameraEx 
cd ../src
ls
cd FlyCap2_ARM/
ls
cd ..
ls * Makefile
cd FlyCap2_ARM/
cat Makefile 
make
cd ../../bin
ls
./FlyCap2
reboot
emacs &
top
cd pointgrey/
ls
cd flycapture.2.6.3.2_armhf
cd bin
ls
./FlyCap2
lsusb
ls
./MultipleCameraEx 
ls
./FlyCapture2Test 
lsusb
ls
feh
./FlyCap2 
ls
lsusb
ps -ef | grep moni
lsusb
dpkg-query -l
dpkg-query -l 'cups'
aptitude purge cups
dpkg-query -l 'lp'
dpkg-query -l 'lpr'
aptitude purge lpr
cd /
git status
git add -A
git commit -m "aptitude purge cups; aptitude purge lpr"
git push
reboot
top
/etc/init.d/monitor.sh stop
vi /etc/init.d/monitor.sh 
reboot
emacs &
cd pointgrey/flycapture.2.6.3.2_armhf/bin
./FlyCap2
lsusb
./FlyCap2
lsusb
./FlyCap2
lsusb
/etc/init.d/ssh-tunnel.sh start
reboot
emacs &
cd pointgrey/flycapture.2.6.3.2_armhf/bin
./FlyCap2
lsusb
./FlyCap2
lsusb
/etc/init.d/monitor.sh stop
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
lsusb
reboot
pointgrey/flycapture.2.6.3.2_armhf/bin/FlyCap2
cd pointgrey/flycapture.2.6.3.2_armhf
cd bin
ls
lla
./FlyCap2
./FlyCap2 &
lsusb
cd pointgrey/flycapture.2.6.3.2_armhf/bin
./FlyCap2
lsusb
ps -ef | grep Fly
lsusb
/etc/init.d/monitor.sh stop
lsusb
ps -ef | grep ssh
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
ps -ef | grep ssh
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
lsusb
modprobe
modprobe g_ether
lsmod
lsusb
reboot
lsusb
/etc/init.d/monitor.sh stop
lsusb
reboot
/etc/init.d/monitor.sh stop
lsusb
echo 15000 > /dev/pwm10
halt
emacs &
cd pointgrey/flycapture.2.6.3.2_armhf/bin
./FlyCap2
./FlyCap2 &
echo 10000 > /dev/pwm10
./FlyCap2 &
lsusb
/etc/init.d/monitor.sh stop
emacs &
cd pointgrey/flycapture.2.6.3.2_armhf/bin
./FlyCap2
lsusb
./FlyCap2
lsusb
halt
top
date
reboot
date
xit
date
/etc/init.d/time-update.sh 
/etc/init.d/time-update.sh start
date
hatl
halt
ls /etc/rc2.d/
cat /etc/rc2.d/S23ntp 
cd /etc/init.d/
update-rc.d -f ssh-tunnel.sh remove
update-rc.d ssh-tunnel.sh defaults 26
update-rc.d -f time-update.sh remove
update-rc.d time-update.sh defaults 25
ls ../rc2.d/
emacs &
cd /
git status
git add -A
/etc/init.d/monitor.sh stop
git commit -m "added hwclock -w call to time-update.sh, tweaked init order"
gs
gs -h
git push
git status
git att -A
git add -A
git commit -m "aptitude purge ghostscript"
git push
ls
lla tmp
mkdir /tmp/images
lla tmp
ls 
ls /tmp/images/
feh /tmp/images/*
lla /tmp/images
git status
git add -A
date
ntpd -gq
date
cat /etc/init.d/time-update.sh 
ntpdate -s -u us.pool.ntp.org
date
sys2hw
hwclock
hwclock -w
hwclock
date
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
AT S7=45 S0=0 L1 V1 X4 &c1 E1 Q0
ls
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
reboot
ls .bas*
cat .bash_history
cd test_code/
ls
g++ -o monitor monitor.cc motor_control_functions.cc 
ls
lla
./monitor 
cd ../pointgrey/flycapture.2.6.3.2_armhf/src/testing/
ls
ulimit -a
ulimit -c unlimited
ulimit -a
vi ~/.bashrc 
ls /etc/lim*
ls /etc/security/l*
more /etc/security/limits.conf
vi ~/.bashrc 
top
cd /
git add -A
git status
git commit -m "added usleep(10000) to monitor.cc; first draft of testcapture.cc--still having errors causing USB bus shutdown"
git push
exit
reboot
emacs &
locate CameraInternal.cpp
find CameraInternal.cpp
cd pointgrey/flycapture.2.6.3.2_armhf
grep -r "Generation count" *
cat lib/libflycapture.so
62;9;c62;9;c62;9;c62;9;c62;9;c62;9;c62;9;c62;9;c62;9;c62;9;c62;9;c62;9;c62;9;c
top
cd /tmp/
ls 
feh
cd ~/pointgrey/flycapture.2.6.3.2_armhf/bin
ls
./testcapture 
mkdir /tmp/images
./testcapture 
lsusb
emacs &
cd pointgrey/flycapture.2.6.3.2_armhf/src/testing/
make
feh /tmp/images/*
inkscape /tmp/images/*
make
ls /tmp/images
rm /tmp/images/*
ls /tmp/images
feh /tmp/images/*
lla /tmp/images
make
lla /tmp/images
feh /tmp/images/panor*
lla /tmp/images
feh /tmp/images/panor{1,2}.png
rm /tmp/images/*
feh /tmp/images/panor0.png 
rm -rf /tmp/images
ls /tmp
maek
make
lla /tmp
mkdir /tmp/images
lla
lla /tmp
rmdir /tmp/images
lla /tmp
make
lla /tmp
make
ls
cd ..
ls
cd testing/
emacs &
make
lla /tmp/images/
feh /tmp/images/*
make
lla /tmp/images/
feh /tmp/images/*
make
lla /tmp/images/
emacs &
ls
cd ..
mkdir test_c
cp testing/RoverCamDefs.h test_c/RoverCamDefs.h
ls
cd test_c/
ls
cd ../FlyCapture2Test_C/
ls
cp Makefile ../test_c/
cp FlyCapture2Test_C.c ../test_c/
cd ../test_c
ls
cd ..
cd FlyCapture2Test_C/
ls
make
cd ../test_c/
touch test.c
lla /tmp/images/
cd ../testing
make
lsusb
lla /tmp/images/
feh /tmp/images/panor0.png 
top
cd pointgrey/flycapture.2.6.3.2_armhf
grep -r PIXEL_FORMAT *
grep -r fc2CreateContext *
cd pointgrey/flycapture.2.6.3.2_armhf/bin
./testcapture 
mkdir /tmp/images
./testcapture 
feh /tmp/images
feh /tmp/images/*
ps -ef | grep ink
./testcapture 
./testcapture 2
./testcapture 1
ls
rm *.pgm
ls
./testcapture 
./testcapture 1
ls
cd C
ls
./FlyCapture2Test_C 
ls
feh fc2TestImage.png 
cd ..
./testcapture 1
;c62;9;c62;9;c62;9;c62;9;c62;9;c62;9;c62;9;c62;9;c62;9;c62;9;c
./testcapture 1
reboot
cd pointgrey/flycapture.2.6.3.2_armhf/bin
ls
./testcapture 1
./testcapture 100
lsusb
reboot
emacs &
cd pointgrey/flycapture.2.6.3.2_armhf/src/testing/
ls
make
pointgrey/flycapture.2.6.3.2_armhf/bin
cd pointgrey/flycapture.2.6.3.2_armhf/bin
./testcapture 5
./testcapture 15
./testcapture 1\
./testcapture 10
./testcapture 50
./testcapture 10
./testcapture 1
./testcapture 10
./testcapture 100
./testcapture 10
./testcapture 100
fdisk -l
ls /etc/f*
cat /etc/fstab
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
emacs &
cd pointgrey/flycapture.2.6.3.2_armhf/src/testing/
ls
cd ..
ls
cd ..
grep -r "SetVideoModeAndFrameRate" *
grep -r "VideoMode" *
cd src/testing
make
emacs &
cd ~
ls open*
mv open-files-17feb.txt open-files-17-feb.txt
ls open*
reboot
cd /
ls
cd boot/
ls
lla
cd ~
cd pointgrey/flycapture.2.6.3.2_armhf/bin/
ls
./testcapture 
cat /var/log/upstart/network-interface-eth0.log
ls /var/log/upstart/network-interface-*
cat /var/log/upstart/network-interface-wlan0.log.orig 
./testcapture 
./testcapture 50
./testcapture 
./testcapture 50
lsusb
./testcapture 50
./testcapture 
./testcapture 100
./testcapture 1000
./testcapture 
./testcapture 100
lsusb
ls
cd /
git status
git add -A
git commit -m "commit prior to surgery on testcapture.cc"
git push
git add -A
git commit -m "commit before tweaking image capture loop--getting ~4.1 images/sec/cam"
git status
git push
emacs &
cd pointgrey/flycapture.2.6.3.2_armhf/src/testing
ls
make
D
make
grep video *
grep Video *
cd pointgrey/flycapture.2.6.3.2_armhf/bin
ls
./testcapture 
./testcapture 100
./testcapture 10
./testcapture
./MultipleCameraEx 
lsusb
./testcapture
./testcapture 100
./testcapture 10
./testcapture 100
./testcapture 1000
./testcapture 10
./testcapture 100
cd /
git status
git add -A
git commit -m "commit before trying card swap--got testcapture.cc old method working at 30fps by setting video mode and frame rate; new method errors on StartSyncCapture"
git push
did
ls
lsusb
ls
halt
cd /
git status
mount
vi /etc/fstab
mount
vi /etc/fstab
reboot
emacs &
date
emacs -nw
exit
mount
cd ..
git status
date
/etc/init.d/time-update.sh start
git status
git add -A
git commit -m "first commit from new card; added noatime,nodiratime to /etc/fstab"
git push
ps -ef | grep ssh
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
ifdown wlan0
ifup wlan0
ls /etc/init.d
/etc/init.d/keepalive-ping.sh start
/etc/init.d/ssh-tunnel.sh start
pwd
git status
git add -A
git commit -m "started working on point-grey.c to use multiple cameras"
git push
reboot
emacs &
ls
cp point-grey* ./pointgrey/flycapture.2.6.3.2_armhf/src/testing/
rm point-grey*
cd pointgrey/
ls
rmdir flycapture.2.5.3.5_armhf
rm -rf flycapture.2.5.3.5_armhf/*
rmdir flycapture.2.5.3.5_armhf
ls
mkdir tarballs
mv *.gz ./tarballs/
ls
cd flycapture.2.6.3.2_armhf/
ls
cd bin
ls
./testcapture 
./testcapture 30
cd ../..
ls
cd ../test_code/
ls
mkdir flycapture
cd ..
cd pointgrey/
cp -r ./flycapture.2.6.3.2_armhf/* ../test_code/flycapture/
cd ../test_code/
rm -rf flycapture/*
rmdir flycapture/
mkdir flycapture
cd ..
cd pointgrey/
cp -av ./flycapture.2.6.3.2_armhf/* ../test_code/flycapture/
cd ..
cd test_code/
cd flycapture/src/
ls
cd testing/
ls
ls ../test_c/
man diff
diff RoverCamDefs.h ../test_c/RoverCamDefs.h 
rm ../test_c/RoverCamDefs.h 
diff Makefile ../test_c/Makefile 
more Makefile 
make clean_obj
make
ls
emacs &
cd ..
grep -r context *
cd sr
cd src/testing/
ls
touch test-capture-c.c
ls
apt-get install imlib2
apt-get install libimlib2 libimlib2-dev
ls
cp Makefile oldMakefile
make
darpa-wrap make
locate libflycapture*
cd /
locate libflycapture*
find libflycapture*
cd ~/pointgrey/flycapture.2.6.3.2_armhf/
ls
cd lib
ls
find libflycapture
locate libflycapture*
cd /usr/lib
ls
ls C*
cd C
ls libfly*
cd ~/pointgrey/flycapture.2.6.3.2_armhf/src/
cd test_c/
ls
more Makefile 
cd ~/test_code/
ls
cd flycapture/
cd src/
cd testing/
ls
make
ls
make
make clean
make
./test-capture 
make
./test-capture 
ulimit -a
make
make clean
make
./test-capture 
make clean
make
./test-capture 
make
./test-capture 
make clean
make
./test-capture 
make
./test-capture 
make
./test-capture 
make
./test-capture 
make
./test-capture 
make
./test-capture 
make
./test-capture 
make
./test-capture 
make
./test-capture 
make
./test-capture 
make
./test-capture 
make
./test-capture 
make
./test-capture 
make
./test-capture 
make
./test-capture 
make
./test-capture 
make
./test-capture 
make
./test-capture 
cd ../..
grep -r "fc2StartCapture" *
cd src/testing/
make
./test-capture 
make
./test-capture 
make
./test-capture 
./test-capture 100
make
./test-capture 100
./test-capture 10 write
make
./test-capture 10 write
./test-capture 100 write
./test-capture 50 write
make clean
make 
ls
cp testcapture.cc testcapture-cpp.cpp
make clean
ls
rm testcapture.o
mv testcapture.cc OLDtestcapture.cc
ls
make
make clean
make
ls
make clean
ls
make
ls
mv testcapture-cpp.cpp test-capture-cpp.cpp
ls
make
ls
make
make clean
ls
make
ls
./cpp-test-capture 
./cpp-test-capture 100
./c-test-capture 10 write
make clean
ls
make
make clean
ls
make
make clean
make
./cpp-test-capture 10 write
./cpp-test-capture 100 write
./cpp-test-capture 100
./c-test-capture 10 write
make
./cpp-test-capture 10
./c-test-capture 10
make
./cpp-test-capture 10
./cpp-test-capture 100
make
./cpp-test-capture 100
make
./cpp-test-capture 100
make
./cpp-test-capture 100
./cpp-test-capture 10 write
./c-test-capture 10 write
make
./c-test-capture 10 write
make
./c-test-capture 10 write
make
./cpp-test-capture 10 write
./cpp-test-capture 100 write
make clean
cd ..
ls
tar -czvf testing.tar.gz testing/
ls
cd testing
ls
make
./c-test-capture 100
./cpp-test-capture 100
./c-test-capture 10
./c-test-capture 100
ls
lla
./c-test-capture 10
./cpp-test-capture 10
make
./c-test-capture 100
./cpp-test-capture 100
make
./cpp-test-capture 100
./c-test-capture 100
./cpp-test-capture 100
make
./cpp-test-capture 100
make
./cpp-test-capture 
./c-test-capture
make
./c-test-capture
./cpp-test-capture 
make
./cpp-test-capture 
./c-test-capture
man cp
cd /
git status
git add -A
git commit -m "more work on {c-,cpp-}test-capture...both working near speed, but not color...still need to do network stuff"
git push
cd /tmp/images/
ls
feh *.png
lla
feh *
lla
feh *
lla
feh *
rm *
feh *
lla
feh *
top
cd ~
cat .bashrc
cd bin
ls
cat architecture-path 
`architecture-path`
ls
pwd
top
cd test_code/flycapture/src/
ls
cd FlyCapture2Test
ls
cd ~
;s
ls
rm Panoramic_camera_final.ppm 
exit
emacs &
cd test_code/flycapture/src/testing
ls
./c-test-capture 
./cpp-test-capture 
man index++
./cpp-test-capture 
./c-test-capture 
make
./cpp-test-capture 
./c-test-capture 
make
./c-test-capture 10 write
ls /tmp/images
feh /tmp/images *
display /tmp/images/*
./cpp-test-capture 10 write
ls
make clean
ls
cd ..
tar czf testing.tar.gz testing/
ls
rsync testing.tar.gz seykhl:~/temp/testing.tar.gz
rsync testing.tar.gz seykhl:~.
rsync testing.tar.gz seykhl:.
cd ../bin
ls
./FlyCap2
cd ../libs
cd ../lib
ls
cd ../src/testing
make clean
make
rm /tmp/images/*
./c-test-capture 10 write
cp test-capture-c.c test-capture-c.c-original
make
./c-test-capture 10 write
rsync -avz vader-rover:/tmp/images/* ~/.
ls
feh /tmp/images/*
./c-test-capture 10 write
feh /tmp/images/*
make
./c-test-capture 10 write
feh /tmp/images/*
make
./cpp-test-capture 10 write
feh /tmp/images/*
make
./c-test-capture 10 write
ls /tmp/images/
lla /tmp/images/
feh /tmp/images/
./cpp-test-capture 10 write
feh /tmp/images/*
./c-test-capture 10 write
feh /tmp/images/*
exit
cd /
git status
git add -A
git commit -m "more work on {c-,cpp-}testcapture--now at 1280x960Y8, 15FPS, c- performs near framerate, cpp- much slower (0-3 fps)"
git push
apt-get remove switsh++
apt-get remove swish++
git add -A
git commit -m "apt-get remove swish++"
git push
exit
halt
ls
cd test_code/
ls
cd ..
locate flycap
cd pointgrey/
ls
cd flycapture.2.6.3.2_armhf/bin
ls
FlyCap2
./FlyCap2
lsusb
./FlyCap2
cd ..
ls
cd src/
ls
cd FlyCap2_ARM/
ls
emacs &
ls
grep "ConvertMonoToOutput" *
grep "sk_ouptutPixelFormat" *
grep "sk_outputPixelFormat" *
cd ..
grep -r "PIXEL_FORMAT" *
grep -r "fc2ColorProcessing" *
grep -r "m_convertedImage" *
grep -r "ForcePGRY16Mode" *
bin/FlyCap2 
cd bin
ls
./FlyCap2
lsusb
cd ..
grep -r "ReadRegister" *
date
/etc/init.d/ssh-tunnel.sh stop
/etc/init.d/ssh-tunnel.sh start
emacs &
ps -ef | grep emacs
killall emacs
ps -ef | grep emacs
killall -9 emacs
ps -ef | grep emacs
emacs &
killkl
reboot
date
emacs &
cd pointgrey/flycapture.2.6.3.2_armhf/bin
ls
./FlyCap2
lsusb
cd ../src/FlyCap2_ARM/
ls
grep "SetVideo" *
cd ../../bin
./FlyCap2
lsusb
./FlyCap2
lsusb
reboot
cd test_code/
ls
cd flycapture/src/testing
ls
emacs &
make clean
make
./cpp-test-capture 1 write
make
./cpp-test-capture 1 write
MAKE
make
./c-test-capture 1 write
./cpp-test-capture 1 write
lsusb
emacs &
lsusub
lsusb
reboot
cd test_code/flycapture/testing
cd test_code/flycapture/
cd src/testing
ls
./c-test-capture 1 write
./cpp-test-capture 1 write
./c-test-capture 1 write
./c-test-capture 100 write
emacs &
./cpp-test-capture 1 write
emacs &
cd pointgrey/flycapture.2.6.3.2_armhf/bin/
./FlyCap2
lsusb
reboot
cd test_code/flycapture/src/testing
emacs &
make
./cpp-test-capture 1 write
make
./cpp-test-capture 1 write
make
./cpp-test-capture 1 write
make
./cpp-test-capture 1 write
make
./cpp-test-capture 1 write
lsusb
emacs &
ls
mv test.c test_code/flycapture/src/testing
ls
cd test_code/flycapture/src/testing
ls
make test
./test 
make test
./test
ls
make clean
ls
rm test
ls
diff test-capture-c.c test-capture-c.c-original 
rm *.c-original
ls
cp test-capture-c.c test-capture-c.c-backup
cp test-capture-cpp.cpp test-capture-cpp.cpp-backup
make
./c-test-capture 1 write
ulimit -c unlimited
./c-test-capture 1 write
make
./c-test-capture 1 write
make
./c-test-capture 1 write
lla /tmp/images
make
./c-test-capture 1 write
make
./c-test-capture 1 write
lla /tmp/images
./c-test-capture 1 write
make clean
make
./c-test-capture 1 write
make
./c-test-capture 1 write
make
./c-test-capture 1 write
make test
./test
make
./test
make
./test
make
./test
make
./test
make
test
./test
touch test2.c
touch test2.h
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
lla /tmp/images
make
./test2
lla /tmp/images
make
./test2
make
./test2
cp test2.c test2.c.backup
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
make
./test2
./test2 100
./test2 10 write
make
./test2 100
make
./test2 100
./test2 40
lsusb
dmesg | tail
less dmesg
dmesg
top
htop
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
