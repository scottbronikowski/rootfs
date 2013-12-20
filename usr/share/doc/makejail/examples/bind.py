chroot="/var/chroot/bind"
forceCopy=["/etc/bind/*","/var/cache/bind","/usr/sbin/rndc"]
preserve=["/var/cache/bind"]
testCommandsInsideJail=["start-stop-daemon --start --quiet --pidfile /var/run/named.pid --exec /usr/sbin/named"]
processNames=["named"]
testCommandsOutsideJail=["dig @127.0.0.1 yahoo.com",
						 "dig @127.0.0.1 -x 127.0.0.1",
						 "dig @127.0.0.1 -x 198.186.203.20",
						 "ping -c 1 www.google.com"]

# start makejail with this configuration file, it won't be able to start the daemon,
# it should display a warning about /dev/log and /proc
#
# In the startup script:
# replace "start-stop-daemon ..." with "chroot /var/chroot/bind start-stop-daemon ..."
#
# handle /proc (mount when it starts, unmount when it stops):
# chroot /var/chroot/apache /bin/mount /proc
#
# configure syslog to also listen to the socket /var/chroot/bind/dev/log, 
# restart sysklogd

# tested successfully with bind 9.2.0 on Debian woody
