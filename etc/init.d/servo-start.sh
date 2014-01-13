#! /bin/bash
insmod /root/build/linux-omap-3.5/drivers/omap3-pwm/pwm.ko servo=1 timers=8,9
echo "Started kernel module for pan & tilt camera servos."
