#!/bin/sh
#
# © 2009-2010 Cyril Brulebois <kibi@debian.org>

# Fail early:
set -e

# Check whether a copy is needed:
if [ ! -z "$1" ]; then
    summary_filename=$1
    echo "A summary is going to be kept in: $summary_filename"
else
    echo "No parameter was passed, no summary will be kept."
fi

# Make sure rmadison is available:
if [ -z "$(which rmadison)" ]; then
    echo "E: rmadison isn't available, please install devscripts."
    exit 1
fi

# Locate compliant.list:
dir=$(dirname $0)
list=$dir/compliant.list
if [ ! -f $list ]; then
    echo "E: Unable to find the list of known modules ($list)"
    exit 1
fi

# What to check for:
suites="oldstable stable testing unstable"

# Prepare the summary:
suites_header="| O | S | T | U |"
summary=$(mktemp) || exit 2
# Date:
date '+%Y-%m-%d:' >> $summary
echo '===========' >> $summary
# First line:
printf "%40s" >> $summary
printf "$suites_header" >> $summary
printf "\n" >> $summary
# Second line (= underline):
for i in $(seq 1 40); do printf '-'; done >> $summary
printf -- $(echo "$suites_header"|sed 's/[^|]/-/g') >> $summary
printf "\n" >> $summary

# That's kind of ugly:
temp_line=$(mktemp) || exit 2

# Whole list:
modules=$(cat $list)
not_found=''
for m in $modules; do
    echo "Checking for $m" >&2
    found=no
    : > $temp_line
    available_suites=$(rmadison $m | awk '{print $5}')
    printf "%-40s" $m >> $temp_line
    printf "|" >> $temp_line
    for s in $suites; do
        if echo $available_suites | grep -qs "\<$s\>"; then
            printf " x |" >> $temp_line
            if [ "$s" != "oldstable" ]; then
                found=yes
            fi
        else
            printf "   |" >> $temp_line
        fi
    done
    printf "\n" >> $temp_line
    if [ "$found" = no ]; then
        # Remember it might go away:
        not_found="$not_found $m"
    else
        # Add that to the summary:
        cat $temp_line >> $summary
    fi
done

# Keep a copy if needed:
if [ ! -z "$summary_filename" ]; then
    cp $summary $summary_filename
fi

# Final output
cat $summary
rm $summary

# Possibly obsolete packages:
if [ ! -z "$not_found" ]; then
    echo
    echo
    echo "Obsolete packages (not found, or only in oldstable):"
    echo "----------------------------------------------------"
    for m in $not_found; do
        echo $m
    done | sort -u
fi
