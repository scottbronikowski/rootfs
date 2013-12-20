chroot="/var/chroot/postgresql"
testCommandsInsideJail=["/etc/init.d/postgresql start"]
processNames=["postmaster"]
testCommandsOutsideJail=["su - postgres -c \"psql -c '\z' test\""]
users=["postgres","root"]
groups=["postgres","root"]
preserve=["/dev/log",
		  "/var/lib/postgres"]
cleanJailFirst=0

# The script /etc/init.d/postgresql does some complex things so I've been lazy and
# chrooted it too
#
# start makejail with this configuration file, it won't be able to start the daemon,
# it should display a warning about /dev/log and /proc
#
# overwrite the data files into the jail: cp -a /var/lib/postgres /var/chroot/postgresql/var/lib
#
# configure syslog to also listen to the socket /var/chroot/postgresql/dev/log, restart sysklogd
#
# start makejail again
#
# The deamon now starts fine with chroot /var/chroot/postgresql /etc/init.d/postgresql start
#
# However you can't connect from a client as it doesn't find the socket /var/run/postgresql/.s.PGSQL.5432
# I don't know how to tell psql to use the socket in the jail or TCPIP but there must be a way
#
# create a new startup script /etc/init.d/postgresql_chroot (outside the jail):
#   #!/bin/sh
#   chroot /var/chroot/postgresql /bin/mount /proc $1
#   chroot /var/chroot/postgresql /etc/init.d/postgresql $1

# tested with postgresql 7.1
