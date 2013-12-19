#!/bin/sh

#set -x

# (C) 2007 Canonical Ltd.
# Author: Alexander Sack <asac@jwsdot.com>
# Author: Mathieu Trudel-Lapierre <mathieu.trudel-lapierre@canonical.com>
# License: GNU General Public License, version 2 or any later version

if test x$NIF_FILE = x; then
   NIF_FILE=/etc/network/interfaces
fi

auto_ifs=$(cat $NIF_FILE | \
    egrep "^auto|^allow-" | \
    sed -e 's/auto//' | \
    sed -e 's/allow-[^ ].* //')

ifaces_to_disable=""

echo Auto interfaces found: $auto_ifs

# iterate over all auto interfaces
for i in $auto_ifs; do

  if grep -q "^[[:space:]]*iface[[:space:]]\+$i[[:space:]].*dhcp" $NIF_FILE; then
     ifaces_to_disable="$ifaces_to_disable $i"
     echo iface to disable = $i
  fi
done

backup_suffix=0
while test -e ${NIF_FILE}.bak-${backup_suffix}; do
   backup_suffix=$(expr $backup_suffix + 1)
done

if [ -n "$ifaces_to_disable" ]; then
    cp $NIF_FILE "$NIF_FILE.bak-${backup_suffix}"
    for i in $ifaces_to_disable; do
	echo -n "Disabling interface: $i ... "
	sed -i -e"/^[[:space:]]*iface[[:space:]]\+$i[[:space:]].*dhcp/,/^[[:space:]]*\(iface\|auto\|mapping\|source\|allow-\)/ { /^[[:space:]]*iface[[:space:]]\+$i[[:space:]].*dhcp/ s/^/#NetworkManager#/; /^[[:space:]]*\(iface\|auto\|mapping\|source\|allow-\)/ ! s/^[^#]/#NetworkManager#/; }" $NIF_FILE
	echo done.
    done
fi

