#! /bin/bash

### BEGIN INIT INFO
# Provides:        ssh-tunnel
# Required-Start:  $network $local_fs $syslog
# Required-Stop:   $network $local_fs $syslog
# Default-Start:   2 3 4 5
# Default-Stop:    0 1 6
# Short-Description: Start/stop reverse SSH tunnel to seykhl.ecn.purdue.edu
### END INIT INFO

start(){
    #ifdown wlan0
    #ifup wlan0
    #ntpdate -s -u us.pool.ntp.org
    #echo "Updated time with us.pool.ntp.org"
    ssh -f -N -Y -R 22222:localhost:22 10.184.165.253
    echo "Started reverse SSH tunnel to seykhl.ecn.purdue.edu"
}

stop(){
    # ssh -nNT ... &
    # PID=$!
    # bash
    # kill $PID
    kill $(ps -ef | grep "[s]sh -f" | awk '{print $2}')
    echo "Killed reverse SSH tunnel process"
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

