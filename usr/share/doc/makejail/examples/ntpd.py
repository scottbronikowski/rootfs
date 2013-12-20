chroot="/var/chroot/ntpd"
testCommandsInsideJail=["start-stop-daemon --start --quiet --exec /usr/sbin/ntpd"]
processNames=["ntpd"]
testCommandsOutsideJail=["ntpdate -q 127.0.0.1"]
