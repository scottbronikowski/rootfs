#!/bin/bash  
#swishmutt
#MH 2002 <mhummel@debian.org>; starting point was: http://www.muttfr.org/gen.php3/2001/12/05/85,0,1,0.html   
#awkward example just to show the possibilities of integration of swish++ and mutt
#You certainly could create a temporary Maildir and not a mbox like here
#You need the procmail-package for the mbox formater: formail
#
#Have a look at the howto ... 
MAILHOME=~/mail
TMPRAW=$MAILHOME/sqmbox.raw
TMPMBOX=$MAILHOME/sqmbox.tmp
INDEXFILE=$MAILHOME/swish++.index
if [ -f $TMPRAW ]; then
    rm -f $TMPRAW
fi
if [ -f $TMPMBOX ]; then
    rm -f $TMPMBOX
fi
#remove old results

echo -e "Keywords with less than 4 chars get ignored by swish++ \n Your query please: \n"

read KEYWORD

if [ -z "$KEYWORD" ]; then
    echo -e "No keyword found\n"
    echo -e "Your query please !: ( type q to quit )\n"
    read KEYWORD
    if [ -z "$KEYWORD" ]; then
	echo -e "You didn't specify any keyword\n"
	echo -e "Your query please !: ( type q to quit )\n"
	read KEYWORD
    elif [ "$KEYWORD" = "q" ]; then
	exit 0
    fi  
fi

#The following assumes you created an index to $MAILHOME/swish++.index
#like:
#
#index++ -v3 -e 'mail:*' -c /PATH_TO/swish++.conf -i $MAILHOME/swish++.index ~/DIR/DIR1 ~/DIR/DIR2  ...
#if ~/DIR/DIR# is a Maildir you should give ~/DIR/DIR#/cur 
#
for i in `search++ --index-file=$INDEXFILE "$KEYWORD"  | cut -d" "  --fields=2`
  do
    
  if [ $i = "results:" -o $i = "ignored:" ]; then
    continue
#don't try to read the "results" and "ignored" indications ;-)
  fi
   cat $MAILHOME$i >> $TMPRAW 
done 
if [ ! -f $TMPRAW ]; then
    echo "No search results for the given keyword(s)"
    exit 0
#no file no result
fi
formail -ds < $TMPRAW >> $TMPMBOX
#violent approach, but can come in very handy repairing headers ...                                                     
exit  0
