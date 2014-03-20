#! /bin/bash

### BEGIN INIT INFO
# Provides:        g-multi
# Required-Start:  $local_fs $syslog
# Required-Stop:   $local_fs $syslog
# Default-Start:   2 3 4 5
# Default-Stop:    0 1 6
# Short-Description: Start/stop g_multi module
### END INIT INFO

start(){
    modprobe g_multi
    echo "Loaded g_multi.ko for USB OTG port"    
}

stop(){
    modprobe -r g_multi
    echo "Removed g_multi kernel module."
}

case $1 in
    start)
	start
	;;
    stop)
	stop
	;;
    *)
	echo "Usage: $0 {start|stop}"
	RETVAL=1
	;;
esac
exit 0

