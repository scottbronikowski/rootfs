#! /bin/bash
insmod /root/build/linux-omap-3.5/drivers/omap3-pwm/pwm.ko servo=1 timers=9,10
echo "Started kernel module for pan (/dev/pwm10) & tilt (/dev/pwm9) camera servos."
