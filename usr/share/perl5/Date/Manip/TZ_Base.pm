package Date::Manip::TZ_Base;
# Copyright (c) 2010-2011 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

########################################################################
########################################################################

require 5.010000;
use warnings;
use strict;

our ($VERSION);
$VERSION='6.25';
END { undef $VERSION; }

########################################################################
# METHODS
########################################################################

sub _config_var {
   my($self,$var,$val) = @_;
   $var = lc($var);

   # A simple flag used to force a new configuration, but has
   # no other affect.
   return  if ($var eq 'ignore');

   my $istz     = ref($self) eq 'Date::Manip::TZ';

   if ($istz  &&  ($var eq 'tz'  ||
                   $var eq 'forcedate'  ||
                   $var eq 'setdate')) {
      return $self->_config_var_tz($var,$val);
   } else {
      my $base  = ($istz ? $$self{'base'} : $self);
      return $base->_config_var_base($var,$val);
   }
}

sub _fix_year {
   my($self,$y) = @_;
   my $istz     = ref($self) eq 'Date::Manip::TZ';
   my $base     = ($istz ? $self->base() : $self);

   my $method   = $base->_config('yytoyyyy');

   return $y     if (length($y)==4);
   return undef  if (length($y)!=2);

   my $curr_y;
   if (ref($self) eq 'Date::Manip::TZ') {
      ($curr_y) = $self->_now('y',1);
   } else {
      $curr_y  = ( localtime(time) )[5];
      $curr_y += 1900;
   }

   if ($method eq 'c') {
      return substr($curr_y,0,2) . $y;

   } elsif ($method =~ /^c(\d\d)$/) {
      return "$1$y";

   } elsif ($method =~ /^c(\d\d)(\d\d)$/) {
      return "$1$y" + ($y<$2 ? 100 : 0);

   } else {
      my $y1      = $curr_y - $method;
      my $y2      = $y1 + 99;
      $y1         =~ /^(\d\d)/;
      $y          = "$1$y";
      if ($y<$y1) {
         $y += 100;
      }
      if ($y>$y2) {
         $y -= 100;
      }
      return $y;
   }
}

###############################################################################
# Functions for setting the default date/time

# Many date operations use a default time and/or date to set some
# or all values.  This function may be used to set or examine the
# default time.
#
# _now allows you to get the current date and/or time in the
# local timezone.
#
# The function performed depends on $op and are described in the
# following table:
#
#    $op                  function
#    ------------------   ----------------------------------
#    undef                Returns the current default values
#                         (y,m,d,h,mn,s) without updating
#                         the time (it'll update if it has
#                         never been set).
#
#    'now'                Updates now and returns
#                         (y,m,d,h,mn,s)
#
#    'time'               Updates now and Returns (h,mn,s)
#
#    'y'                  Returns the default value of one
#    'm'                  of the fields (no update)
#    'd'
#    'h'
#    'mn'
#    's'
#
#    'systz'              Returns the system timezone
#
#    'isdst'              Returns the 'now' values if set,
#    'tz'                 or system time values otherwise.
#    'offset'
#    'abb'
#
sub _now {
   my($self,@op) = @_;
   my $istz      = ref($self) eq 'Date::Manip::TZ';
   my $base      = ($istz ? $self->base() : $self);
   my($noupdate,@ret);

   # Update "NOW" if we're checking 'now', 'time', or the date
   # is not set already.

   if (@op   &&  ($op[$#op] eq "0"  ||  $op[$#op] eq "1")) {
      $noupdate = pop(@op);
   } else {
      $noupdate = 1;
      my $op = join(" ",@op);
      $noupdate = 0  if ($op =~ /\b(?:now|time)\b/);
   }
   $noupdate = 0  if (! exists $$base{'data'}{'now'}{'date'});

   $self->_update_now()  unless ($noupdate);

   my @tmpnow   = @{ $$base{'data'}{'tmpnow'} };
   my @now      = (@tmpnow ? @tmpnow : @{ $$base{'data'}{'now'}{'date'} });

   # Get the appropriate values.

   foreach my $op (@op) {

      if ($op eq 'now') {
         push (@ret,@now);

      } elsif ($op eq 'tz') {
         if (exists $$base{'data'}{'now'}{'tz'}) {
            push (@ret,$$base{'data'}{'now'}{'tz'});
         } else {
            push (@ret,$$base{'data'}{'now'}{'systz'});
         }

      } elsif ($op eq 'y') {
         push (@ret,$now[0]);

      } elsif ($op eq 'systz') {
         push (@ret,$$base{'data'}{'now'}{'systz'});

      } elsif ($op eq 'time') {
         push (@ret,@now[3..5]);

      } elsif ($op eq 'm') {
         push (@ret,$now[1]);

      } elsif ($op eq 'd') {
         push (@ret,$now[2]);

      } elsif ($op eq 'h') {
         push (@ret,$now[3]);

      } elsif ($op eq 'mn') {
         push (@ret,$now[4]);

      } elsif ($op eq 's') {
         push (@ret,$now[5]);

      } elsif ($op eq 'isdst') {
         push (@ret,$$base{'data'}{'now'}{'isdst'});

      } elsif ($op eq 'offset') {
         push (@ret,@{ $$base{'data'}{'now'}{'offset'} });

      } elsif ($op eq 'abb') {
         push (@ret,$$base{'data'}{'now'}{'abb'});

      } else {
         warn "ERROR: [now] invalid argument list: @op\n";
         return ();
      }
   }

   return @ret;
}

sub _update_now {
   my($self) = @_;
   my $istz     = ref($self) eq 'Date::Manip::TZ';
   my $base     = ($istz ? $self->base() : $self);

   # If we've called ForceDate, don't change it.
   return  if ($$base{'data'}{'now'}{'force'});

   # If we've called SetDate (which will only happen if a
   # Date::Manip:TZ object is available), figure out what 'now' is
   # based on the number of seconds that have elapsed since it was
   # set.  This will ONLY happen if TZ has been loaded.

   if ($$base{'data'}{'now'}{'set'}) {
      my $date = $$base{'data'}{'now'}{'setdate'};
      my $secs = time - $$base{'data'}{'now'}{'setsecs'};

      $date      = $base->calc_date_time($date,[0,0,$secs]);  # 'now' in GMT
      my ($zone) = $self->_now('tz',1);
      my ($err,$date2,$offset,$isdst,$abbrev) = $self->convert_from_gmt($date,$zone);

      $$base{'data'}{'now'}{'date'}   = $date2;
      $$base{'data'}{'now'}{'isdst'}  = $isdst;
      $$base{'data'}{'now'}{'offset'} = $offset;
      $$base{'data'}{'now'}{'abb'}    = $abbrev;
      return;
   }

   # Otherwise, we'll use the system time.

   my $time = time;
   my($s,$mn,$h,$d,$m,$y,$wday,$yday,$isdst) = localtime($time);
   my($s0,$mn0,$h0,$d0,$m0,$y0)              = gmtime($time);

   $y += 1900;
   $m++;

   $y0 += 1900;
   $m0++;

   my $off = $base->calc_date_date([$y,$m,$d,$h,$mn,$s],[$y0,$m0,$d0,$h0,$mn0,$s0],1);

   $$base{'data'}{'now'}{'date'}  = [$y,$m,$d,$h,$mn,$s];
   $$base{'data'}{'now'}{'isdst'} = $isdst;
   $$base{'data'}{'now'}{'offset'}= $off;

   my $abb = '???';
   if (ref($self) eq 'Date::Manip::TZ') {
      my ($zone) = $self->_now('tz',1);
      my $per    = $self->date_period([$y,$m,$d,$h,$mn,$s],$zone,1,$isdst);
      $abb = $$per[4];
   }

   $$base{'data'}{'now'}{'abb'}   = $abb;

   return;
}

1;
# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 3
# cperl-continued-statement-offset: 2
# cperl-continued-brace-offset: 0
# cperl-brace-offset: 0
# cperl-brace-imaginary-offset: 0
# cperl-label-offset: -2
# End:
