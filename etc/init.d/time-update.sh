#! /bin/bash

### BEGIN INIT INFO
# Provides:        time-update
# Required-Start:  $network $local_fs $syslog
# Required-Stop:   $network $local_fs $syslog
# Default-Start:   2 3 4 5
# Default-Stop:    0 1 6
# Short-Description: Updates hwclock time on startup (after ntpd updates date)
### END INIT INFO

start(){
    echo "before:"
    echo " date: "
    date
#    echo " hwclock: "
#    hwclock
    sleep 5
    ntpdate -uvb 192.168.2.2 #ntp.ubuntu.com us.pool.ntp.org
    sleep 5
    ntpdate -uvb 192.168.2.2
    echo "Updated time"
    sleep 5
    echo "date : " 
    date
    hwclock -w
#    echo "hwclock : "
#    hwclock
#    echo "date again: "
#    date
   }

stop(){
    echo "time-update.sh exited"
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

