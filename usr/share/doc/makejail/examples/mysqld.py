chroot="/var/chroot/mysqld"
testCommandsInsideJail=["safe_mysqld"]
sleepAfterStartCommand=5
processNames=["mysqld"]
testCommandsOutsideJail=["mysql --user=root --socket='/var/chroot/mysqld/var/run/mysqld/mysqld.sock' --exec='show tables' mysql"]
preserve=["/var/lib/mysql",
		  "/var/log/mysql"]
users=["mysql"]
groups=["mysql"]

# Steps:
# 
# Copy the directories in the "preserve" directive to the jail
# with exactly the same ownerships and permissions (cp -RpP)
# Run makejail
# To connect from local clients, keep in mind that the socket
# is now in the jail

# OpenBSD
# preserve=["/var/mysql"]
# testCommandsOutsideJail=["mysql --user=root --socket='/var/chroot/mysqld/var/run/mysql/mysql.sock' --exec='show tables' mysql"]
