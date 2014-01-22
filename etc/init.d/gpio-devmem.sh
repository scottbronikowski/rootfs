#! /bin/bash

##first two commands load kernel module and set up bump switches
insmod /root/build/linux-omap-3.5/drivers/gpio-event/module/gpio-event-drv.ko
echo "Loaded gpio-event-drv.ko"
/root/build/linux-omap-3.5/drivers/gpio-event/app/gpio-event 145:f:20 146:f:20
echo "Set up to monitor bump switches on GPIOs 145, 146"

##now we make devmem2 calls to change the pinmux mode for GPIOs 172-175
##CAN WE REMOVE THESE IF WE CAN WRITE TO THE MEMORY IN ANOTHER KERNEL MODULE?

#for gpio 175, 173 (left side)
devmem2 0x480021d0 w 0x114010C
devmem2 0x480021cc w 0x1080104
#for gpio 174, 172 (right side)
devmem2 0x480021cc w 0x10C0104
devmem2 0x480021c8 w 0x1040100
echo "Completed devmem2 calls to set up GPIOs 172, 173, 174, 175"

#now add new gpios to monitoring -- MAY NOT NEED THIS AFTER NEW DRIVER!!
/root/build/linux-omap-3.5/drivers/gpio-event/app/gpio-event 172:b:0 173:b:0 174:b:0 175:b:0
cat /proc/gpio-event/pins
echo "Set up monitoring of encoders on GPIOs 173, 175 (right side) and 172, 174 (left side)"