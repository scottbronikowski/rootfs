#! /bin/bash

### BEGIN INIT INFO
# Provides:        keepalive-ping
# Required-Start:  $network $local_fs $syslog
# Required-Stop:   $network $local_fs $syslog
# Default-Start:   2 3 4 5
# Default-Stop:    0 1 6
# Short-Description: Pings purdue.edu every 5 seconds
### END INIT INFO

start(){
    echo "Starting keep alive ping to pudue.edu"
    ping -i 5 purdue.edu > /dev/null &

}

stop(){
    kill $(ps -ef | grep "[p]ing -i 5 purdue.edu" | awk '{print $2}')
    echo "Killed keepalive-ping process"
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

