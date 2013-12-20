chroot="/var/chroot/apache"
testCommandsInsideJail=["/usr/sbin/apachectl start"]
processNames=["apache"]

# Eventually append here the commands which access some services
# such as cgi or php scripts, database access, ...
testCommandsOutsideJail=["wget -r --spider http://localhost/",
			 "lynx --source https://localhost/"]

preserve=["/var/www",
	  "/var/log/apache",
	  "/dev/log"]
users=["www-data"]
groups=["www-data"]

userFiles=["/etc/password",
           "/etc/shadow"]
groupFiles=["/etc/group",
            "/etc/gshadow"]
forceCopy=["/etc/hosts",
           "/etc/mime.types"]

# launch makejail
#
# copy the documents and the logs to the jail
# cp -Rp /var/www /var/chroot/apache/var
# cp -Rp /var/log/apache/*.log /var/chroot/apache/var/log/apache
#
# configure syslog to also listen to the socket /var/chroot/apache/dev/log, restart sysklogd
#
# In the startup script /etc/init.d/apache, just change the paths
# of variables used from outside the jail:
# APACHECTL="chroot /var/chroot/apache /usr/sbin/apachectl" (remove the line which tests -f $APACHECTL)
# PIDFILE=/var/chroot/apache/var/run/$NAME.pid
# CONF=/var/chroot/apache/etc/apache/httpd.conf
#
# handle /proc in the script (mount when it starts, unmount when it stops):
# chroot /var/chroot/apache /bin/mount /proc
#
# apache can fail starting though apachectl doesn't fail, see error.log in the chroot
#

# tested successfully with apache 1.3.22 on Debian woody
# (also with php4, mysql and a search engine)

# OpenBSD
#processNames=["httpd"]
#users=["nobody"]
#groups=["nogroup","www"]
