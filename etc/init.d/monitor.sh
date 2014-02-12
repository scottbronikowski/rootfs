#! /bin/bash

### BEGIN INIT INFO
# Provides:        monitor
# Required-Start:  $network $local_fs $syslog
# Required-Stop:   $network $local_fs $syslog
# Default-Start:   2 3 4 5
# Default-Stop:    0 1 6
# Short-Description: Start/stop monitor for bump switches
### END INIT INFO

start(){
    echo "Starting monitor client"	
    /root/test_code/monitor
}

stop(){
    kill $(ps -ef | grep "[/]root/test_code/monitor" | awk '{print $2}')
    echo "Killed monitor process"
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

