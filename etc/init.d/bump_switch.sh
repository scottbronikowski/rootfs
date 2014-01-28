#! /bin/bash

### BEGIN INIT INFO
# Provides:        bump_switch
# Required-Start:  $local_fs $syslog
# Required-Stop:   $local_fs $syslog
# Default-Start:   2 3 4 5
# Default-Stop:    0 1 6
# Short-Description: Start/stop bump switch monitor
### END INIT INFO

start(){
    /root/test_code/bump_switch
    echo "Started bump switch monitor"
}

stop(){
    kill $(ps -ef | grep "[/]root/test_code/bump_switch" | awk '{print $2}')
    echo "Killed bump switch monitor process"
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

