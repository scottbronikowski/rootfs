#!/bin/sh

# apt-listchanges should not interrupt it
APT_LISTCHANGES_FRONTEND=mail
export APT_LISTCHANGES_FRONTEND

# run that if needed
# apt-get update > /dev/null

t=`mktemp`
# hide output if everything was okay, good for cron jobs
module-assistant update,a-i allu -vito >"$t" 2>&1 || cat "$t"
rm -f "$t"

