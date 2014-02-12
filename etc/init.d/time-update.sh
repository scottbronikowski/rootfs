#! /bin/bash

### BEGIN INIT INFO
# Provides:        time-update
# Required-Start:  $network $local_fs $syslog
# Required-Stop:   $network $local_fs $syslog
# Default-Start:   2 3 4 5
# Default-Stop:    0 1 6
# Short-Description: Updates time on startup
### END INIT INFO

start(){
    ntpdate -s -u us.pool.ntp.org
    echo "Updated time with us.pool.ntp.org"
    hwclock -w
    echo "date : "
    date
    echo "hwclock : "
    hwclock
}

stop(){
    echo "No exit conditions for time-update.sh"
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

