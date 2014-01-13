#! /bin/bash
#ifdown wlan0
#ifup wlan0
ntpdate -s -u us.pool.ntp.org
echo "Updated time with us.pool.ntp.org"
ssh -f -N -Y -R 22222:localhost:22 seykhl
echo "Started reverse SSH tunnel to seykhl.ecn.purdue.edu"
#ssh -nNT ... &
#PID=$!
#bash
#kill $PID