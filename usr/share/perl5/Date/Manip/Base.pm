package Date::Manip::Base;
# Copyright (c) 1995-2011 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

###############################################################################
# Any routine that starts with an underscore (_) is NOT intended for
# public use.  They are for internal use in the the Date::Manip
# modules and are subject to change without warning or notice.
#
# ABSOLUTELY NO USER SUPPORT IS OFFERED FOR THESE ROUTINES!
###############################################################################

use Date::Manip::Obj;
use Date::Manip::TZ_Base;
@ISA = qw(Date::Manip::Obj Date::Manip::TZ_Base);

require 5.010000;
use strict;
use warnings;
use integer;
use IO::File;
use Encode qw(encode_utf8 from_to);
require Date::Manip::Lang::index;

our $VERSION;
$VERSION='6.25';
END { undef $VERSION; }

###############################################################################
# BASE METHODS
###############################################################################

sub _init {
   my($self) = @_;

   $self->_init_cache();
   $self->_init_language();
   $self->_init_config();
   $self->_init_events();
   $self->_init_holidays();
   $self->_init_now();
}

# The base object has some config-independant information which is
# always reused, and only needs to be initialized once.
sub _init_cache {
   my($self) = @_;
   return  if (exists $$self{'cache'}{'init'});
   $$self{'cache'}{'init'}    = 1;

   # ly          => {Y}    = 0/1  1 if it is a leap year
   # ds1_mon     => {Y}{M} = N    days since 1BC for Y/M/1
   # dow_mon     => {Y}{M} = DOW  day of week of Y/M/1

   $$self{'cache'}{'ly'}      = {}  if (! exists $$self{'cache'}{'ly'});
   $$self{'cache'}{'ds1_mon'} = {}  if (! exists $$self{'cache'}{'ds1_mon'});
   $$self{'cache'}{'dow_mon'} = {}  if (! exists $$self{'cache'}{'dow_mon'});
}

# Config dependent data. Needs to be reset every time the config is reset.
sub _init_data {
   my($self,$force) = @_;
   return  if (exists $$self{'data'}{'calc'}  &&  ! $force);

   $$self{'data'}{'calc'}     = {};     # Calculated values
}

# Initializes config dependent data
sub _init_config {
   my($self,$force) = @_;
   return  if (exists $$self{'data'}{'sections'}{'conf'}  &&  ! $force);
   $self->_init_data();

   $$self{'data'}{'sections'}{'conf'} =
     {
      # Reset config, holiday lists, or events lists
      'defaults'         => '',
      'eraseholidays'    => '',
      'eraseevents'      => '',

      # Which language to use when parsing dates.
      'language'         => '',

      # 12/10 = Dec 10 (US) or Oct 12 (anything else)
      'dateformat'       => '',

      # Define the work week (1=monday, 7=sunday)
      #
      # These have to be predefined to avoid a bootstrap
      # issue, but the true defaults are defined below.
      'workweekbeg'      => 1,
      'workweekend'      => 5,

      # If non-nil, a work day is treated as 24 hours
      # long (WorkDayBeg/WorkDayEnd ignored)
      'workday24hr'      => '',

      # Start and end time of the work day (any time
      # format allowed, seconds ignored). If the
      # defaults change, be sure to change the starting
      # value of bdlength above.
      'workdaybeg'       => '',
      'workdayend'       => '',

      # 2 digit years fall into the 100
      # year period given by [ CURR-N,
      # CURR+(99-N) ] where N is 0-99.
      # Default behavior is 89, but
      # other useful numbers might be 0
      # (forced to be this year or
      # later) and 99 (forced to be this
      # year or earlier).  It can also
      # be set to 'c' (current century)
      # or 'cNN' (i.e.  c18 forces the
      # year to bet 1800-1899).  Also
      # accepts the form cNNNN to give
      # the 100 year period NNNN to
      # NNNN+99.
      'yytoyyyy'         => '',

      # First day of the week (1=monday,
      # 7=sunday).  ISO 8601 says
      # monday.
      'firstday'         => '',

      # If this is 0, use the ISO 8601
      # standard that Jan 4 is in week
      # 1.  If 1, make week 1 contain
      # Jan 1.
      'jan1week1'        => '',

      # Date::Manip printable format
      #   0 = YYYYMMDDHH:MN:SS
      #   1 = YYYYHHMMDDHHMNSS
      #   2 = YYYY-MM-DD-HH:MN:SS
      'printable'        => '',

      # If 'today' is a holiday, we look either to
      # 'tomorrow' or 'yesterday' for the nearest
      # business day.  By default, we'll always look
      # 'tomorrow' first.
      'tomorrowfirst'    => 1,

      # Use an international character set.
      'intcharset'       => 0,

      # Used to set the current date/time/timezone.
      'forcedate'        => 0,
      'setdate'          => 0,

      # Use this to set the default range of the
      # recurrence.
      'recurrange'       => '',

      # Use this to set the default time.
      'defaulttime'      => 'midnight',

      # *** DEPRECATED ***
      'recurnumfudgedays'=> '',
      'tz'               => '',
      'convtz'           => '',
      'globalcnf'        => '',
      'ignoreglobalcnf'  => '',
      'personalcnf'      => '',
      'personalcnfpath'  => '',
      'pathsep'          => '',
      'oldconfigfiles'   => '',
      'internal'         => '',
      'resetworkday'     => 0,
      'deltasigns'       => 0,
      'updatecurrtz'     => 0,
     };

   # Set config defaults

   # In order to avoid a bootstrap issue, set the default work day here.
   $self->_config_var('workday24hr',  1);
   $self->_config_var('workdaybeg',   '08:00:00');
   $self->_config_var('workdayend',   '17:00:00');
   $self->_config_var('workday24hr',  0);

   $self->_config_var('dateformat',   'US');
   $self->_config_var('yytoyyyy',     89);
   $self->_config_var('jan1week1',    0);
   $self->_config_var('printable',    0);
   $self->_config_var('firstday',     1);
   $self->_config_var('workweekbeg',  1);
   $self->_config_var('workweekend',  5);
   $self->_config_var('language',     'english');
   $self->_config_var('recurrange',   'none');
   $self->_config_var('defaulttime',  'midnight');

   # Set OS specific defaults

   my $os = $self->_os();

   # *** DEPRECATED ***
   if ($os eq 'Windows') {
      $self->_config_var('pathsep',';');
      $self->_config_var('personalcnf','Manip.cnf');
      $self->_config_var('personalcnfpath','.');

   } elsif ($os eq 'Other') {
      $self->_config_var('pathsep',':');
      $self->_config_var('personalcnf','Manip.cnf');
      $self->_config_var('personalcnfpath','.');

   } elsif ($os eq 'VMS') {
      # VMS doesn't like files starting with '.'
      $self->_config_var('pathsep',',');
      $self->_config_var('personalcnf','Manip.cnf');
      $self->_config_var('personalcnfpath','/sys$login');

   } else {
      # Unix
      $self->_config_var('pathsep',':');
      $self->_config_var('personalcnf','.DateManip.cnf');
      $self->_config_var('personalcnfpath','.:~');
   }
}

# Events and holidays are reset only when they are read in.
sub _init_events {
   my($self,$force) = @_;
   return  if (exists $$self{'data'}{'events'}  &&  ! $force);

   # {data}{sections}{events} = [ STRING, EVENT_NAME, ... ]
   #
   # {data}{events}{I}{type}  = TYPE
   #                  {name}  = NAME
   #    TYPE: specified         An event with a start/end date (only parsed once)
   #                  {beg}   = DATE_OBJECT
   #                  {end}   = DATE_OBJECT
   #    TYPE: ym
   #                  {beg}   = YM_STRING
   #                  {end}   = YM_STRING (only for YM;YM)
   #                  {YEAR}  = [ DATE_OBJECT, DATE_OBJECT ]
   #    TYPE: date              An event specified by a date string and delta
   #                  {beg}   = DATE_STRING
   #                  {end}   = DATE_STRING  (only for Date;Date)
   #                  {delta} = DELTA_OBJECT (only for Date;Delta)
   #                  {YEAR}  = [ DATE_OBJECT, DATE_OBJECT ]
   #    TYPE: recur
   #                  {recur} = RECUR_OBJECT
   #                  {delta} = DELTA_OBJECT
   #
   # {data}{eventyears}{YEAR} = 0/1
   # {data}{eventobjs}        = 0/1

   $$self{'data'}{'events'}             = {};
   $$self{'data'}{'sections'}{'events'} = [];
   $$self{'data'}{'eventyears'}         = {};
   $$self{'data'}{'eventobjs'}          = 0;
}

sub _init_holidays {
   my($self,$force) = @_;
   return  if (exists $$self{'data'}{'holidays'}  &&  ! $force);

   # {data}{sections}{holidays} = [ STRING, HOLIDAY_NAME, ... ]
   #
   # {data}{holidays}{YEAR}     = 1  if this year has been parsed
   #                              2  if YEAR-1 and YEAR+1 have been parsed
   #                                 (both must be done before holidays can
   #                                 be known so that New Years can be
   #                                 celebrated on Dec 31 if Jan 1 is weekend)
   #                 {date}     = DATE_OBJ
   #                                 a Date::Manip::Date object to use for holidays
   #                 {hols}     = [ RECUR_OBJ|DATE_STRING, HOLIDAY_NAME, ... ]
   #                                 DATE_STRING is suitable for parse_date
   #                                 using DATE_OBJ.  RECUR_OBJ is a Date::Manip::Recur
   #                                 object that can be used once the start and
   #                                 end date is set.
   #                 {dates}    = { Y => M => D => NAME }
   #
   # {data}{init_holidays}      = 1  if currently initializing holidays

   $$self{'data'}{'holidays'}             = {};
   $$self{'data'}{'sections'}{'holidays'} = [];
   $$self{'data'}{'init_holidays'}        = 0;
}

sub _init_now {
   my($self) = @_;

   #  {'data'}{'now'} = {
   #                     date     => [Y,M,D,H,MN,S]  now
   #                     isdst    => ISDST
   #                     offset   => [H,MN,S]
   #                     abb      => ABBREV
   #
   #                     force    => 0/1             SetDate/ForceDate information
   #                     set      => 0/1
   #                     setsecs  => SECS            time (in secs since epoch) when
   #                                                 SetDate was called
   #                     setdate  => [Y,M,D,H,MN,S]  the date (IN GMT) we're calling
   #                                                 now when SetDate was called
   #
   #                     tz       => ZONE            timezone we're working in
   #                     systz    => ZONE            timezone of the system
   #                    }
   #

   $$self{'data'}{'now'}          = {};
   $$self{'data'}{'now'}{'force'} = 0;
   $$self{'data'}{'now'}{'set'}   = 0;
   $$self{'data'}{'tmpnow'}       = [];
}

# Language information only needs to be initialized if the language changes.
sub _init_language {
   my($self,$force) = @_;
   return  if (exists $$self{'data'}{'lang'}  &&  ! $force);

   $$self{'data'}{'lang'}      = {};     # Current language info
   $$self{'data'}{'rx'}        = {};     # Regexps generated from language
   $$self{'data'}{'words'}     = {};     # Types of words in the language
   $$self{'data'}{'wordval'}   = {};     # Value of words in the language
}

###############################################################################
# MAIN METHODS
###############################################################################

sub leapyear {
   my($self,$y) = @_;
   $y += 0;
   return $$self{'cache'}{'ly'}{$y}
     if (exists $$self{'cache'}{'ly'}{$y});

   $$self{'cache'}{'ly'}{$y} = 0, return 0 unless ($y %   4 == 0);
   $$self{'cache'}{'ly'}{$y} = 1, return 1 unless ($y % 100 == 0);
   $$self{'cache'}{'ly'}{$y} = 0, return 0 unless ($y % 400 == 0);
   $$self{'cache'}{'ly'}{$y} = 1, return 1;
}

sub days_in_year {
   my($self,$y) = @_;
   return ($self->leapyear($y) ? 366 : 365);
}

{
   my(@leap)=(31,29,31,30, 31,30,31,31, 30,31,30,31);
   my(@nonl)=(31,28,31,30, 31,30,31,31, 30,31,30,31);

   sub days_in_month {
      my($self,$y,$m) = @_;

      if ($m) {
         return ($self->leapyear($y) ? $leap[$m-1] : $nonl[$m-1]);
      } else {
         return ($self->leapyear($y) ? @leap : @nonl);
      }
   }
}

{
   # DinM        =     (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
   my(@doy_days) = ( 0, 31, 59, 90,120,151,181,212,243,273,304,334,365);

   # Note: I tested storing both leap year and non-leap year days in
   # a hash, but it was slightly slower.

   my($lyd,$n,$remain,$day,$y,$m,$d,$h,$mn,$s,$arg);

   sub day_of_year {
      my($self,@args) = @_;

      no integer;
      if ($#args == 1) {

         # $date = day_of_year($y,$day);
         ($y,$n) = @args;

         $lyd    = $self->leapyear($y);
         $remain = ($n - int($n));
         $n      = int($n);

         # Calculate the month and the day
         for ($m=1; $m<=12; $m++) {
            last  if ($n<=($doy_days[$m] + ($m==1 ? 0 : $lyd)));
         }
         $d = $n-($doy_days[$m-1] + (($m-1)<2 ? 0 : $lyd));
         return [$y,$m,$d]  if (! $remain);

         # Calculate the hours, minutes, and seconds into the day.
         $remain *= 24;
         $h       = int($remain);
         $remain  = ($remain - $h)*60;
         $mn      = int($remain);
         $remain  = ($remain - $mn)*60;
         $s       = $remain;

         return [$y,$m,$d,$h,$mn,$s];

      } else {
         $arg  = $args[0];
         @args = @$arg;

         ($y,$m,$d,$h,$mn,$s) = @args;
         $lyd     = $self->leapyear($y);
         $lyd     = 0  if ($m <= 2);
         $day     = ($doy_days[$m-1]+$d+$lyd);
         return $day  if ($#args==2);

         $day    += ($h*3600 + $mn*60 + $s)/(24*3600);
         return $day;
      }
   }
}

sub days_since_1BC {
   my($self,$arg) = @_;

   if (ref($arg)) {
      my($y,$m,$d) = @$arg;
      $y += 0;
      $m += 0;

      if (! exists $$self{'cache'}{'ds1_mon'}{$y}{$m}) {

         if (! exists $$self{'cache'}{'ds1_mon'}{$y}{1}) {

            my($Ny,$N4,$N100,$N400,$cc,$yy);

            my $yyyy  = "0000$y";

            $yyyy     =~ /(\d\d)(\d\d)$/;
            ($cc,$yy) = ($1,$2);

            # Number of full years since Dec 31, 1BC (starting at 0001)
            $Ny       = $y - 1;

            # Number of full 4th years (0004, 0008, etc.) since Dec 31, 1BC
            $N4       = int($Ny/4);

            # Number of full 100th years (0100, 0200, etc.)
            $N100     = $cc + 0;
            $N100--   if ($yy==0);

            # Number of full 400th years (0400, 0800, etc.)
            $N400     = int($N100/4);

            $$self{'cache'}{'ds1_mon'}{$y}{1} =
              $Ny*365 + $N4 - $N100 + $N400 + 1;
         }

         my($i,$j);
         my @mon   = $self->days_in_month($y,0);
         for ($i=2; $i<=12; $i++) {
            $j     = shift(@mon);
            $$self{'cache'}{'ds1_mon'}{$y}{$i} =
              $$self{'cache'}{'ds1_mon'}{$y}{$i-1} + $j;
         }
      }

      return ($$self{'cache'}{'ds1_mon'}{$y}{$m} + $d - 1);

   } else {
      my($days) = $arg;
      my($y,$m,$d);

      $y = int($days/365.2425)+1;
      while ($self->days_since_1BC([$y,1,1]) > $days) {
         $y--;
      }
      $m = 12;
      while ( ($d=$self->days_since_1BC([$y,$m,1])) > $days ) {
         $m--;
      }
      $d = ($days-$d+1);
      return [$y,$m,$d];
   }
}

sub day_of_week {
   my($self,$date) = @_;
   my($y,$m,$d) = @$date;
   $y += 0;
   $m += 0;

   my($dayofweek,$dec31) = ();
   if (! exists $$self{'cache'}{'dow_mon'}{$y}{$m}) {
      $dec31 = 7;               # Dec 31, 1BC was Sunday
      $$self{'cache'}{'dow_mon'}{$y}{$m} =
        ( $self->days_since_1BC([$y,$m,1])+$dec31 ) % 7;
   }
   $dayofweek = ($$self{'cache'}{'dow_mon'}{$y}{$m}+$d-1) % 7;
   $dayofweek = 7  if ($dayofweek==0);
   return $dayofweek;
}

# Can be the nth DoW of year or month (if $m given).  Returns undef if
# the date doesn't exists (i.e. 5th Sunday in a month with only 4).
#
sub nth_day_of_week {
   my($self,$y,$n,$dow,$m) = @_;
   $y += 0;
   $m  = ($m ? $m+0 : 0);

   # $d    is the current DoM (if $m) or DoY
   # $max  is the max value allowed for $d
   # $ddow is the DoW of $d

   my($d,$max,$ddow);

   if ($m) {
      $max = $self->days_in_month($y,$m);
      $d   = ($n<0 ? $max : 1);
      $ddow = $self->day_of_week([$y,$m,$d]);
   } else {
      $max = $self->days_in_year($y);
      $d   = ($n<0 ? $max : 1);
      if ($n<0) {
         $d = $max;
         $ddow = $self->day_of_week([$y,12,31]);
      } else {
         $d = 1;
         $ddow = $self->day_of_week([$y,1,1]);
      }
   }

   # Find the first occurrence of $dow on or after $d (if $n>0)
   # or the last occurrence of $dow on or before $d (if ($n<0);

   if ($dow < $ddow) {
      $d += 7 - ($ddow-$dow);
   } else {
      $d += ($dow-$ddow);
   }
   $d -= 7  if ($d > $max);

   # Find the nth occurrence of $dow

   if ($n > 1) {
      $d += 7*($n-1);
      return undef  if ($d > $max);
   } elsif ($n < -1) {
      $d -= 7*(-1*$n-1);
      return undef  if ($d < 1);
   }

   # Return the date

   if ($m) {
      return [$y,$m,$d];
   }
   return $self->day_of_year($y,$d);
}

{
   # Integer arithmetic doesn't work due to the size of the numbers.
   no integer;
   # my $sec_70 =($self->days_since_1BC([1970,1,1])-1)*24*3600;
   my $sec_70 = 62135596800;

   # Using 'global' variables saves 4%
   my($y,$m,$d,$h,$mn,$s,$sec,$sec_0,$tmp);
   sub secs_since_1970 {
      my($self,$arg) = @_;

      if (ref($arg)) {
         ($y,$m,$d,$h,$mn,$s) = @$arg;
         $sec_0 = ($self->days_since_1BC([$y,$m,$d])-1)*24*3600 + $h*3600 +
           $mn*60 + $s;
         $sec = $sec_0 - $sec_70;
         return $sec;

      } else {
         ($sec)     = $arg;
         $sec_0     = $sec_70 + $sec;
         $tmp       = int($sec_0/24/3600)+1;
         my $ymd    = $self->days_since_1BC($tmp);
         ($y,$m,$d) = @$ymd;
         $sec_0    -= ($tmp-1)*24*3600;
         $h         = int($sec_0/3600);
         $sec_0    -= $h*3600;
         $mn        = int($sec_0/60);
         $s         = $sec_0 - $mn*60;
         return [$y,$m,$d,$h,$mn,$s];
      }
   }
}

sub check {
   my($self,$date) = @_;
   my($y,$m,$d,$h,$mn,$s) = @$date;

   return 0  if (! $self->check_time([$h,$mn,$s])  ||
                 $y<1  ||  $y>9999  ||
                 $m<1  ||  $m>12);

   my $days = $self->days_in_month($y,$m);

   return 0  if ($d<1  ||  $d>$days);
   return 1;
}

sub check_time {
   my($self,$hms) = @_;
   my($h,$mn,$s) = @$hms;

   return 0  if ($h  !~ /^[0-2]?[0-9]$/  ||  $h > 24  ||
                 $mn !~ /^[0-5]?[0-9]$/ ||
                 $s  !~ /^[0-5]?[0-9]$/ ||
                 ($h == 24  &&  ($mn  ||  $s)));
   return 1;
}

sub week1_day1 {
   my($self,$year)  = @_;
   my $firstday  = $self->_config('firstday');
   return $self->_week1_day1($firstday,$year);
}

sub _week1_day1 {
   my($self,$firstday,$year) = @_;
   my $jan1week1 = $self->_config('jan1week1');
   return $$self{'cache'}{'week1day1'}{$firstday}{$jan1week1}{$year}
     if (exists $$self{'cache'}{'week1day1'}{$firstday}{$jan1week1}{$year});

   # First week contains either Jan 4 (default) or Jan 1

   my($y,$m,$d) = ($year,1,4);
   $d           = 1       if ($jan1week1);

   # Go back to the previous (counting today) $firstday

   my $dow = $self->day_of_week([$y,$m,$d]);
   if ($dow != $firstday) {
      $firstday = 0  if ($firstday == 7);
      $d -= ($dow-$firstday);
      if ($d<1) {
         $y--;
         $m = 12;
         $d += 31;
      }
   }

   $$self{'cache'}{'week1day1'}{$firstday}{$jan1week1}{$year} = [ $y,$m,$d ];
   return [$y,$m,$d];
}

sub weeks_in_year {
   my($self,$y)  = @_;
   my $firstday  = $self->_config('firstday');
   return $self->_weeks_in_year($firstday,$y);
}

sub _weeks_in_year {
   my($self,$firstday,$y) = @_;
   my $jan1week1 = $self->_config('jan1week1');
   return $$self{'cache'}{'wiy'}{$firstday}{$jan1week1}{$y}
     if (exists $$self{'cache'}{'wiy'}{$firstday}{$jan1week1}{$y});

   # Get the week1 day1 dates for this year and the next one.
   my ($y1,$m1,$d1) = @{ $self->_week1_day1($firstday,$y) };
   my ($y2,$m2,$d2) = @{ $self->_week1_day1($firstday,$y+1) };

   # Calculate the number of days between them.
   my $diy          = $self->days_in_year($y);
   if ($y1 < $y) {
      $diy += (32-$d1);
   } else {
      $diy -= ($d1-1);
   }
   if ($y2 < $y+1) {
      $diy -= (32-$d2);
   } else {
      $diy += ($d2-1);
   }

   $diy = $diy/7;
   $$self{'cache'}{'wiy'}{$firstday}{$jan1week1}{$y} = $diy;
   return $diy;
}

sub week_of_year {
   my($self,@args) = @_;
   my $firstday    = $self->_config('firstday');
   $self->_week_of_year($firstday,@args);
}

sub _week_of_year {
   my($self,$firstday,@args) = @_;
   my $jan1week1   = $self->_config('jan1week1');

   if ($#args == 1) {
      # (y,m,d) = week_of_year(y,w)
      my($year,$w) = @args;

      return $$self{'cache'}{'woy1'}{$firstday}{$jan1week1}{$year}{$w}
        if (exists $$self{'cache'}{'woy1'}{$firstday}{$jan1week1}{$year}{$w});

      my $ymd = $self->_week1_day1($firstday,$year);
      $ymd = $self->calc_date_days($ymd,($w-1)*7)  if ($w > 1);

      $$self{'cache'}{'woy1'}{$firstday}{$jan1week1}{$year}{$w} = $ymd;
      return $ymd;
   }

   # (y,w) = week_of_year([y,m,d])
   my($y,$m,$d) = @{ $args[0] };

   # Get the first day of the first week. If the date is before that,
   # it's the last week of last year.

   my($y0,$m0,$d0) = @{ $self->_week1_day1($firstday,$y) };
   if ($y0==$y  &&  $m==1  &&  $d<$d0) {
      return($y-1,$self->_weeks_in_year($firstday,$y-1));
   }

   # Otherwise, we'll figure out how many days are between the two and
   # divide by 7 to figure out how many weeks in it is.

   my $n = $self->day_of_year([$y,$m,$d]);
   if ($y0<$y) {
      $n += (32-$d0);
   } else {
      $n -= ($d0-1);
   }
   my $w = 1+int(($n-1)/7);

   # Make sure we're not into the first week of next year.

   if ($w>$self->_weeks_in_year($firstday,$y)) {
      return($y+1,1);
   }
   return($y,$w);
}

###############################################################################
# CALC METHODS
###############################################################################

sub calc_date_date {
   my($self,$date0,$date1) = @_;

   # Order them so date0 < date1
   # If $minus = 1, then the delta is negative

   my $minus   = 0;
   my $cmp     = $self->cmp($date0,$date1);

   if ($cmp == 0) {
      return [0,0,0];

   } elsif ($cmp == 1) {
      $minus  = 1;
      my $tmp = $date1;
      $date1  = $date0;
      $date0  = $tmp;
   }

   my($y0,$m0,$d0,$h0,$mn0,$s0) = @$date0;
   my($y1,$m1,$d1,$h1,$mn1,$s1) = @$date1;

   my $sameday = ($y0 == $y1  &&  $m0 == $m1  &&  $d0 == $d1  ? 1 : 0);

   # Handle the various cases.

   my($dh,$dm,$ds);
   if ($sameday) {
      ($dh,$dm,$ds) = @{ $self->_calc_hms_hms([$h0,$mn0,$s0],[$h1,$mn1,$s1]) };

   } else {
      # y0-m0-d0 h0:mn0:s0 -> y0-m0-d0 24:00:00
      # y1-m1-d1 h1:mn1:s1 -> y1-m1-d1 00:00:00

      my $t1 = $self->_calc_hms_hms([$h0,$mn0,$s0],[24,0,0]);
      my $t2 = $self->_calc_hms_hms([0,0,0],[$h1,$mn1,$s1]);
      ($dh,$dm,$ds) = @{ $self->calc_time_time($t1,$t2) };

      my $dd0 = $self->days_since_1BC([$y0,$m0,$d0]);
      $dd0++;
      my $dd1 = $self->days_since_1BC([$y1,$m1,$d1]);
      $dh    += ($dd1-$dd0)*24;
   }

   if ($minus) {
      $dh *= -1;
      $dm *= -1;
      $ds *= -1;
   }
   return [$dh,$dm,$ds];
}

sub calc_date_days {
   my($self,$date,$n,$subtract) = @_;
   my($y,$m,$d,$h,$mn,$s)       = @$date;
   my($ymdonly)                 = (defined $h ? 0 : 1);

   $n        *= -1  if ($subtract);
   my $d1bc   = $self->days_since_1BC([$y,$m,$d]);
   $d1bc     += $n;
   my $ymd    = $self->days_since_1BC($d1bc);

   if ($ymdonly) {
      return $ymd;
   } else {
      return [@$ymd,$h*1,$mn*1,$s*1];
   }
}

sub calc_date_delta {
   my($self,$date,$delta,$subtract) = @_;
   my($y,$m,$d,$h,$mn,$s,$dy,$dm,$dw,$dd,$dh,$dmn,$ds) = (@$date,@$delta);

   ($y,$m,$d)           = @{ $self->_calc_date_ymwd([$y,$m,$d], [$dy,$dm,$dw,$dd],
                                                    $subtract) };
   return $self->calc_date_time([$y,$m,$d,$h,$mn,$s],[$dh,$dmn,$ds],$subtract);
}

sub calc_date_time {
   my($self,$date,$time,$subtract) = @_;
   my($y,$m,$d,$h,$mn,$s,$dh,$dmn,$ds) = (@$date,@$time);

   if ($ds > 59  ||  $ds < -59) {
      $dmn += int($ds/60);
      $ds   = $ds % 60;
   }
   if ($dmn > 59  ||  $dmn < -59) {
      $dh  += int($dmn/60);
      $dmn  = $dmn % 60;
   }
   my $dd = 0;
   if ($dh > 23  ||  $dh < -23) {
      $dd  = int($dh/24);
      $dh  = $dh % 24;
   }

   # Handle subtraction
   if ($subtract) {
      $dh  *= -1;
      $dmn *= -1;
      $ds  *= -1;
      $dd  *= -1;
   }

   if ($dd == 0) {
      $y *= 1;
      $m *= 1;
      $d *= 1;
   } else {
      ($y,$m,$d) = @{ $self->calc_date_days([$y,$m,$d],$dd) };
   }

   $self->_mod_add(60,$ds,\$s,\$mn);
   $self->_mod_add(60,$dmn,\$mn,\$h);
   $self->_mod_add(24,$dh,\$h,\$d);

   if ($d<1) {
      $m--;
      $y--, $m=12  if ($m<1);
      my $day_in_mon = $self->days_in_month($y,$m);
      $d += $day_in_mon;
   } else {
      my $day_in_mon = $self->days_in_month($y,$m);
      if ($d>$day_in_mon) {
         $d -= $day_in_mon;
         $m++;
         $y++, $m=1  if ($m>12);
      }
   }

   return [$y,$m,$d,$h,$mn,$s];
}

sub _calc_date_time_strings {
   my($self,$date,$time,$subtract) = @_;
   my @date = @{ $self->split('date',$date) };
   return ''  if (! @date);
   my @time = @{ $self->split('time',$time) };

   my @date2 = @{ $self->calc_date_time(\@date,\@time,$subtract) };

   return $self->join('date',\@date2);
}

sub _calc_date_ymwd {
   my($self,$date,$ymwd,$subtract) = @_;
   my($y,$m,$d,$h,$mn,$s)          = @$date;
   my($dy,$dm,$dw,$dd)             = @$ymwd;
   my($ymdonly)                    = (defined $h ? 0 : 1);

   $dd += $dw*7;

   if ($subtract) {
      $y -= $dy;
      $self->_mod_add(-12,-1*$dm,\$m,\$y);
      $dd *= -1;

   } else {
      $y += $dy;
      $self->_mod_add(-12,$dm,\$m,\$y);
   }

   my $dim = $self->days_in_month($y,$m);
   $d      = $dim  if ($d > $dim);

   my $ymd;
   if ($dd == 0) {
      $ymd = [$y,$m,$d];
   } else {
      $ymd = $self->calc_date_days([$y,$m,$d],$dd);
   }

   if ($ymdonly) {
      return $ymd;
   } else {
      return [@$ymd,$h,$mn,$s];
   }
}

sub _calc_hms_hms {
   my($self,$hms0,$hms1) = @_;
   my($h0,$m0,$s0,$h1,$m1,$s1) = (@$hms0,@$hms1);

   my($s) = ($h1-$h0)*3600 + ($m1-$m0)*60  +  $s1-$s0;
   my($m) = int($s/60);
   $s    -= $m*60;
   my($h) = int($m/60);
   $m    -= $h*60;
   return [$h,$m,$s];
}

sub calc_time_time {
   my($self,$time0,$time1,$subtract) = @_;
   my($h0,$m0,$s0,$h1,$m1,$s1)       = (@$time0,@$time1);

   if ($subtract) {
      $h1 *= -1;
      $m1 *= -1;
      $s1 *= -1;
   }
   my($s) = (($h0+$h1)*60 + ($m0+$m1))*60 + $s0+$s1;
   my($m) = int($s/60);
   $s    -= $m*60;
   my($h) = int($m/60);
   $m    -= $h*60;

   return [$h,$m,$s];
}

###############################################################################

# Returns -1 if date0 is before date1, 0 if date0 is the same as date1, and
# 1 if date0 is after date1.
#
sub cmp {
   my($self,$date0,$date1) = @_;
   return ($$date0[0]  <=> $$date1[0]  ||
           $$date0[1]  <=> $$date1[1]  ||
           $$date0[2]  <=> $$date1[2]  ||
           $$date0[3]  <=> $$date1[3]  ||
           $$date0[4]  <=> $$date1[4]  ||
           $$date0[5]  <=> $$date1[5]);
}

###############################################################################
# This determines the OS.

sub _os {
   my($self) = @_;

   my $os = '';

   if ($^O =~ /MSWin32/i    ||
       $^O =~ /Windows_95/i ||
       $^O =~ /Windows_NT/i
      ) {
      $os = 'Windows';

   } elsif ($^O =~ /MacOS/i  ||
            $^O =~ /MPE/i    ||
            $^O =~ /OS2/i    ||
            $^O =~ /NetWare/i
           ) {
      $os = 'Other';

   } elsif ($^O =~ /VMS/i) {
      $os = 'VMS';

   } else {
      $os = 'Unix';
   }

   return $os;
}

###############################################################################
# Config file functions

# This reads a config file
#
sub _config_file {
   my($self,$file) = @_;

   return  if (! $file);

   if (! -f $file) {
      warn "ERROR: [config_file] file doesn't exist: $file\n";
      return;
   }
   if (! -r $file) {
      warn "ERROR: [config_file] file not readable: $file\n";
      return;
   }

   my $in = new IO::File;
   if (! $in->open($file)) {
      warn "ERROR: [config_file] unable to open file: $file: $!\n";
      return;
   }
   my @in = <$in>;
   $in->close();

   my $sect = 'conf';
   chomp(@in);
   foreach my $line (@in) {
      $line =~ s/^\s+//;
      $line =~ s/\s+$//;
      next  if (! $line  or  $line =~ /^\043/);

      if ($line =~ /^\*/) {
         # New section
         $sect = $self->_config_file_section($line);
      } else {
         $self->_config_file_var($sect,$line);
      }
   }
}

sub _config_file_section {
   my($self,$line) = @_;

   $line    =~ s/^\*//;
   $line    =~ s/\s*$//;
   my $sect = lc($line);
   if (! exists $$self{'data'}{'sections'}{$sect}) {
      warn "WARNING: [config_file] unknown section created: $sect\n";
      $self->_section($sect);
   }
   return $sect;
}

sub _config_file_var {
   my($self,$sect,$line) = @_;

   my($var,$val);
   if ($line =~ /^\s*(.*?)\s*=\s*(.*?)\s*$/) {
      ($var,$val) = ($1,$2);
   } else {
      die "ERROR: invalid Date::Manip config file line:\n  $line\n";
   }

   if ($sect eq 'conf') {
      $var = lc($var);
      $self->_config($var,$val);
   } else {
      $self->_section($sect,$var,$val);
   }
}

###############################################################################
# Config variable functions

# $self->config(SECT);
#    Creates a new section.
#
# $self->config(SECT,'_vars');
#    Returns a list of (VAR VAL VAR VAL ...)
#
# $self->config(SECT,VAR,VAL);
#    Adds (VAR,VAL) to the list.
#
sub _section {
   my($self,$sect,$var,$val) = @_;
   $sect = lc($sect);

   #
   # $self->_section(SECT)    creates a new section
   #

   if (! defined $var) {
      if ($sect eq 'conf') {
         $$self{'data'}{'sections'}{$sect} = {};
      } else {
         $$self{'data'}{'sections'}{$sect} = [];
      }
      return '';
   }

   if ($var eq '_vars') {
      return @{ $$self{'data'}{'sections'}{$sect} };
   }

   push @{ $$self{'data'}{'sections'}{$sect} },($var,$val);
   return;
}

# $val = $self->config(VAR);
#    Returns the value of a variable.
#
# $self->config([SECT], VAR, VAL)  sets the value of a variable
#    Sets the value of a variable.
#
sub _config {
   my($self,$var,$val) = @_;

   my $sect = 'conf';

   #
   # $self->_conf(VAR, VAL)  sets the value of a variable
   #

   $var = lc($var);
   if (defined $val) {
      return $self->_config_var($var,$val);
   }

   #
   # $self->_conf(VAR)       returns the value of a variable
   #

   if (exists $$self{'data'}{'sections'}{$sect}{$var}) {
      return $$self{'data'}{'sections'}{$sect}{$var};
   } else {
      warn "ERROR: [config] invalid config variable: $var\n";
      return '';
   }
}

# This sets a config variable. It also performs all side effects from
# setting that variable.
#
sub _config_var_base {
   my($self,$var,$val) = @_;

   if ($var eq 'defaults') {
      # Reset the configuration if desired.
      $self->_init_config(1);
      return;

   } elsif ($var eq 'eraseholidays') {
      $self->_init_holidays(1);
      return;

   } elsif ($var eq 'eraseevents') {
      $self->_init_events(1);
      return;

   } elsif ($var eq 'configfile') {
      $self->_config_file($val);
      return;

   } elsif ($var eq 'encoding') {
      my $err = $self->_config_var_encoding($val);
      return if ($err);

   } elsif ($var eq 'language') {
      my $err = $self->_language($val);
      return  if ($err);
      $err    = $self->_config_var_encoding();
      return  if ($err);

   } elsif ($var eq 'yytoyyyy') {
      $val = lc($val);
      if ($val ne 'c'  &&
          $val !~ /^c\d\d$/  &&
          $val !~ /^c\d\d\d\d$/  &&
          $val !~ /^\d+$/) {
         warn "ERROR: [config_var] invalid: YYtoYYYY: $val\n";
         return;
      }

   } elsif ($var eq 'workweekbeg') {
      my $err = $self->_config_var_workweekbeg($val);
      return  if ($err);

   } elsif ($var eq 'workweekend') {
      my $err = $self->_config_var_workweekend($val);
      return  if ($err);

   } elsif ($var eq 'workday24hr') {
      my $err = $self->_config_var_workday24hr($val);
      return  if ($err);

   } elsif ($var eq 'workdaybeg') {
      my $err = $self->_config_var_workdaybegend(\$val,'WorkDayBeg');
      return  if ($err);

   } elsif ($var eq 'workdayend') {
      my $err = $self->_config_var_workdaybegend(\$val,'WorkDayEnd');
      return  if ($err);

   } elsif ($var eq 'firstday') {
      my $err = $self->_config_var_firstday($val);
      return  if ($err);

   } elsif ($var eq 'tz'  ||
            $var eq 'forcedate'  ||
            $var eq 'setdate') {
      # These can only be used if the Date::Manip::TZ module has been loaded
      warn "ERROR: [config_var] $var config variable requires TZ module\n";
      return;

   } elsif ($var eq 'recurrange') {
      my $err = $self->_config_var_recurrange($val);
      return  if ($err);

   } elsif ($var eq 'defaulttime') {
      my $err = $self->_config_var_defaulttime($val);
      return  if ($err);

   } elsif ($var eq 'dateformat'  ||
            $var eq 'jan1week1'   ||
            $var eq 'printable'   ||
            $var eq 'tomorrowfirst') {
         # do nothing

      #
      # Deprecated ones
      #

   } elsif ($var eq 'convtz'  ||
            $var eq 'globalcnf'  ||
            $var eq 'ignoreglobalcnf' ||
            $var eq 'personalcnf' ||
            $var eq 'personalcnfpath' ||
            $var eq 'pathsep' ||
            $var eq 'resetworkday' ||
            $var eq 'deltasigns' ||
            $var eq 'internal' ||
            $var eq 'udpatecurrtz' ||
            $var eq 'recurnumfudgedays'  ||
            $var eq 'intcharset') {
         # do nothing

   } elsif ($var eq 'oldconfigfiles') {
      # This actually reads in the old-style config files
      if ($self->_config('globalcnf')  &&
          ! $self->_config('ignoreglobalcnf')) {
         my $file = $self->_config('globalcnf');
         $file    = $self->_ExpandTilde($file);
         $self->_config_file($file);
      }

      if ($self->_config('personalcnf')) {
         my $file = $self->_config('personalcnf');
         my $path = $self->_config('personalcnfpath');
         my $sep  = $self->_config('pathsep');
         $file    = $self->_SearchPath($file,$path,$sep);
         $self->_config_file($file)  if ($file);
      }
      return;

   } else {
      warn "ERROR: [config_var] invalid config variable: $var\n";
      return '';
   }

   #
   # Deprecated
   #

   if ($var eq 'internal') {
      $var = 'printable';
   }

   $$self{'data'}{'sections'}{'conf'}{$var} = $val;
   return;
}

###############################################################################
# Specific config variable functions

sub _config_var_encoding {
   my($self,$val) = @_;

   if (! $val) {
      $$self{'data'}{'calc'}{'enc_in'}  = [ @{ $$self{'data'}{'enc'} } ];
      $$self{'data'}{'calc'}{'enc_out'} = 'UTF-8';

   } elsif ($val =~ /^(.*),(.*)$/) {
      my($in,$out) = ($1,$2);
      if ($in) {
         my $o = find_encoding($in);
         if (! $o) {
            warn "ERROR: [config_var] invalid: Encoding: $in\n";
            return 1;
         }
      }
      if ($out) {
         my $o = find_encoding($out);
         if (! $o) {
            warn "ERROR: [config_var] invalid: Encoding: $out\n";
            return 1;
         }
      }

      if ($in  &&  $out) {
         $$self{'data'}{'calc'}{'enc_in'}  = [ $in ];
         $$self{'data'}{'calc'}{'enc_out'} = $out;

      } elsif ($in) {
         $$self{'data'}{'calc'}{'enc_in'}  = [ $in ];
         $$self{'data'}{'calc'}{'enc_out'} = 'UTF-8';

      } elsif ($out) {
         $$self{'data'}{'calc'}{'enc_in'}  = [ @{ $$self{'data'}{'enc'} } ];
         $$self{'data'}{'calc'}{'enc_out'} = $out;

      } else {
         $$self{'data'}{'calc'}{'enc_in'}  = [ @{ $$self{'data'}{'enc'} } ];
         $$self{'data'}{'calc'}{'enc_out'} = 'UTF-8';
      }

   } else {
      my $o = find_encoding($val);
      if (! $o) {
         warn "ERROR: [config_var] invalid: Encoding: $val\n";
         return 1;
      }
      $$self{'data'}{'calc'}{'enc_in'}  = [ $val ];
      $$self{'data'}{'calc'}{'enc_out'} = $val;
   }

   if (! @{ $$self{'data'}{'calc'}{'enc_in'} }) {
      $$self{'data'}{'calc'}{'enc_in'}  = [ qw(utf-8 perl) ];
   }

   return 0;
}

sub _config_var_recurrange {
   my($self,$val) = @_;

   $val = lc($val);
   if ($val =~ /^(none|year|month|week|day|all)$/) {
      return 0;
   }

   warn "ERROR: [config_var] invalid: RecurRange: $val\n";
   return 1;
}

sub _config_var_workweekbeg {
   my($self,$val) = @_;

   if (! $self->_is_int($val,1,7)) {
      warn "ERROR: [config_var] invalid: WorkWeekBeg: $val\n";
      return 1;
   }
   if ($val >= $self->_config('workweekend')) {
      warn "ERROR: [config_var] WorkWeekBeg must be before WorkWeekEnd\n";
      return 1;
   }

   $$self{'data'}{'calc'}{'workweek'} =
     $self->_config('workweekend') - $val + 1;
   return 0;
}

sub _config_var_workweekend {
   my($self,$val) = @_;

   if (! $self->_is_int($val,1,7)) {
      warn "ERROR: [config_var] invalid: WorkWeekBeg: $val\n";
      return 1;
   }
   if ($val <= $self->_config('workweekbeg')) {
      warn "ERROR: [config_var] WorkWeekEnd must be after WorkWeekBeg\n";
      return 1;
   }

   $$self{'data'}{'calc'}{'workweek'} =
     $val - $self->_config('workweekbeg') + 1;
   return 0;
}

sub _config_var_workday24hr {
   my($self,$val) = @_;

   if ($val) {
      $$self{'data'}{'sections'}{'conf'}{'workdaybeg'} = '00:00:00';
      $$self{'data'}{'sections'}{'conf'}{'workdayend'} = '24:00:00';
      $$self{'data'}{'calc'}{'workdaybeg'}             = [0,0,0];
      $$self{'data'}{'calc'}{'workdayend'}             = [24,0,0];
      $$self{'data'}{'calc'}{'bdlength'}               = 86400; # 24*60*60
   }

   return 0;
}

sub _config_var_workdaybegend {
   my($self,$val,$conf) = @_;

   # Must be a valid time.  Entered as H, H:M, or H:M:S

   my $tmp = $self->split('hms',$$val);
   if (! defined $tmp) {
      warn "ERROR: [config_var] invalid: $conf: $$val\n";
      return 1;
   }
   $$self{'data'}{'calc'}{lc($conf)} = $tmp;
   $$val = $self->join('hms',$tmp);

   # workdaybeg < workdayend

   my @beg = @{ $$self{'data'}{'calc'}{'workdaybeg'} };
   my @end = @{ $$self{'data'}{'calc'}{'workdayend'} };
   my $beg = $beg[0]*3600 + $beg[1]*60 + $beg[2];
   my $end = $end[0]*3600 + $end[1]*60 + $end[2];

   if ($beg > $end) {
      warn "ERROR: [config_var] WorkDayBeg not before WorkDayEnd\n";
      return 1;
   }

   # Calculate bdlength (unless 24 hour work day set)

   $$self{'data'}{'sections'}{'conf'}{'workday24hr'} = 0;
   $$self{'data'}{'calc'}{'bdlength'} =
     ($end[0]-$beg[0])*3600 + ($end[1]-$beg[1])*60 + ($end[2]-$beg[2]);

   return 0;
}

sub _config_var_firstday {
   my($self,$val) = @_;

   if (! $self->_is_int($val,1,7)) {
      warn "ERROR: [config_var] invalid: FirstDay: $val\n";
      return 1;
   }

   return 0;
}

sub _config_var_defaulttime {
   my($self,$val) = @_;

   if (lc($val) eq 'midnight'  ||
       lc($val) eq 'curr') {
      return 0;
   }
   warn "ERROR: [config_var] invalid: DefaultTime: $val\n";
   return 1;
}

###############################################################################
# Language functions

# This reads in a langauge module and sets regular expressions
# and word lists based on it.
#
no strict 'refs';
sub _language {
   my($self,$lang) = @_;
   $lang = lc($lang);

   if (! exists $Date::Manip::Lang::index::Lang{$lang}) {
      warn "ERROR: [language] invalid: $lang\n";
      return 1;
   }

   return 0  if (exists $$self{'data'}{'sections'}{'conf'}  &&
                 $$self{'data'}{'sections'}{'conf'} eq $lang);
   $self->_init_language(1);

   my $mod = $Date::Manip::Lang::index::Lang{$lang};
   eval "require Date::Manip::Lang::${mod}";
   if ($@) {
      die "ERROR: failed to load Date::Manip::Lang::${mod}: $@\n";
   }

   no warnings 'once';
   $$self{'data'}{'lang'} = ${ "Date::Manip::Lang::${mod}::Language" };
   $$self{'data'}{'enc'}  = [ @{ "Date::Manip::Lang::${mod}::Encodings" } ];

   # Common words
   $self->_rx_wordlist('at');
   $self->_rx_wordlist('each');
   $self->_rx_wordlist('last');
   $self->_rx_wordlist('of');
   $self->_rx_wordlist('on');
   $self->_rx_wordlists('when');

   # Next/prev
   $self->_rx_wordlists('nextprev');

   # Field names (years, year, yr, ...)
   $self->_rx_wordlists('fields');

   # Numbers (first, 1st)
   $self->_rx_wordlists('nth');
   $self->_rx_wordlists('nth','nth_dom',31);  # 1-31
   $self->_rx_wordlists('nth','nth_wom',5);   # 1-5

   # Calendar names (Mon, Tue  and  Jan, Feb)
   $self->_rx_wordlists('day_abb');
   $self->_rx_wordlists('day_char');
   $self->_rx_wordlists('day_name');
   $self->_rx_wordlists('month_abb');
   $self->_rx_wordlists('month_name');

   # H:M:S separators
   $self->_rx_simple('sephm');
   $self->_rx_simple('sepms');
   $self->_rx_simple('sepfr');

   # Time replacement strings
   $self->_rx_replace('times');

   # Some offset strings
   $self->_rx_replace('offset_date');
   $self->_rx_replace('offset_time');

   # AM/PM strings
   $self->_rx_wordlists('ampm');

   # Business/non-business mode
   $self->_rx_wordlists('mode');

   return 0;
}
use strict 'refs';

# This takes a string or strings from the language file which is a
# regular expression and copies it to the regular expression cache.
#
# If the language file contains a list of strings, a list of strings
# is stored in the regexp cache.
#
sub _rx_simple {
   my($self,$ele) = @_;

   if (exists $$self{'data'}{'lang'}{$ele}) {
      if (ref($$self{'data'}{'lang'}{$ele})) {
         @{ $$self{'data'}{'rx'}{$ele} } = @{ $$self{'data'}{'lang'}{$ele} };
      } else {
         $$self{'data'}{'rx'}{$ele} = $$self{'data'}{'lang'}{$ele};
      }
   } else {
      $$self{'data'}{'rx'}{$ele} = undef;
   }
}

# This takes a list of words and creates a simple regexp which matches
# any of them.
#
# The first word in the list is the default way to express the word using
# a normal ASCII character set.
#
# The second word in the list is the default way to express the word using
# a locale character set. If it isn't defined, it defaults to the first word.
#
sub _rx_wordlist {
   my($self,$ele) = @_;

   if (exists $$self{'data'}{'lang'}{$ele}) {
      my @tmp = @{ $$self{'data'}{'lang'}{$ele} };

      $$self{'data'}{'wordlistA'}{$ele} = $tmp[0];
      if (defined $tmp[1]  &&  $tmp[1]) {
         $$self{'data'}{'wordlistL'}{$ele} = $tmp[1];
      } else {
         $$self{'data'}{'wordlistL'}{$ele} = $tmp[0];
      }

      my @tmp2;
      foreach my $tmp (@tmp) {
         push(@tmp2,"\Q$tmp\E")  if ($tmp);
      }
      @tmp2  = sort _sortByLength(@tmp2);

      $$self{'data'}{'rx'}{$ele} = join('|',@tmp2);

   } else {
      $$self{'data'}{'rx'}{$ele} = undef;
   }
}

# This takes a hash of the form:
#    word => string
# and creates a regular expression to match word (which must be surrounded
# by word boundaries).
#
sub _rx_replace {
   my($self,$ele) = @_;

   if (! exists $$self{'data'}{'lang'}{$ele}) {
      $$self{'data'}{'rx'}{$ele} = [];
      return;
   }

   my(@key) = keys %{ $$self{'data'}{'lang'}{$ele} };
   my $i    = 1;
   foreach my $key (@key) {
      my $val = $$self{'data'}{'lang'}{$ele}{$key};
      $$self{'data'}{'rx'}{$ele}[$i++] = qr/\b(\Q$key\E)\b/i;
      $$self{'data'}{'wordmatch'}{$ele}{lc($key)} = $val;
   }

   @key   = sort _sortByLength(@key);
   @key   = map { "\Q$_\E" } @key;
   my $rx = join('|',@key);

   $$self{'data'}{'rx'}{$ele}[0] = qr/\b(?:$rx)\b/i;
}

# This takes a list of values, each of which can be expressed in multiple
# ways, and gets a regular expression which matches any of them, a default
# way to express each value, and a hash which matches a matched string to
# a value (the value is 1..N where N is the number of values).
#
sub _rx_wordlists {
   my($self,$ele,$subset,$max) = @_;
   $subset = $ele  if (! $subset);

   if (exists $$self{'data'}{'lang'}{$ele}) {
      my @vallist = @{ $$self{'data'}{'lang'}{$ele} };
      $max        = $#vallist+1  if (! $max  ||  $max > $#vallist+1);
      my (@all);

      for (my $i=1; $i<=$max; $i++) {
         my @tmp = @{ $$self{'data'}{'lang'}{$ele}[$i-1] };

         $$self{'data'}{'wordlistA'}{$subset}[$i-1] = $tmp[0];
         if (defined $tmp[1]  &&  $tmp[1]) {
            $$self{'data'}{'wordlistL'}{$subset}[$i-1] = $tmp[1];
         } else {
            $$self{'data'}{'wordlistL'}{$subset}[$i-1] = $tmp[0];
         }

         my @str;
         foreach my $str (@tmp) {
            next  if (! $str);
            $$self{'data'}{'wordmatch'}{$subset}{lc($str)} = $i;
            push(@str,"\Q$str\E");
         }
         push(@all,@str);

         @str  = sort _sortByLength(@str);
         $$self{'data'}{'rx'}{$subset}[$i] = join('|',@str);
      }

      @all  = sort _sortByLength(@all);
      $$self{'data'}{'rx'}{$subset}[0] = join('|',@all);

   } else {
      $$self{'data'}{'rx'}{$subset} = undef;
   }
}

# This sorts from longest to shortest element
#
no strict 'vars';
sub _sortByLength {
   return (length $b <=> length $a);
}
use strict 'vars';

###############################################################################
# Year functions
#
# $self->_method(METHOD)       use METHOD as the method for YY->YYYY
#                             conversions
#
# YEAR = _fix_year(YR)        converts a 2-digit to 4-digit year

sub _method {
   my($self,$method) = @_;
   $self->_config('yytoyyyy',$method);
}

# _fix_year is in TZ_Base

###############################################################################
# $self->_mod_add($N,$add,\$val,\$rem);
#   This calculates $val=$val+$add and forces $val to be in a certain
#   range.  This is useful for adding numbers for which only a certain
#   range is allowed (for example, minutes can be between 0 and 59 or
#   months can be between 1 and 12).  The absolute value of $N determines
#   the range and the sign of $N determines whether the range is 0 to N-1
#   (if N>0) or 1 to N (N<0).  $rem is adjusted to force $val into the
#   appropriate range.
#   Example:
#     To add 2 hours together (with the excess returned in days) use:
#       $self->_mod_add(-24,$h1,\$h,\$day);
#     To add 2 minutes together (with the excess returned in hours):
#       $self->_mod_add(60,$mn1,\$mn,\$hr);
sub _mod_add {
   my($self,$N,$add,$val,$rem)=@_;
   return  if ($N==0);
   $$val+=$add;
   if ($N<0) {
      # 1 to N
      $N = -$N;
      if ($$val>$N) {
         $$rem+= int(($$val-1)/$N);
         $$val = ($$val-1)%$N +1;
      } elsif ($$val<1) {
         $$rem-= int(-$$val/$N)+1;
         $$val = $N-(-$$val % $N);
      }

   } else {
      # 0 to N-1
      if ($$val>($N-1)) {
         $$rem+= int($$val/$N);
         $$val = $$val%$N;
      } elsif ($$val<0) {
         $$rem-= int(-($$val+1)/$N)+1;
         $$val = ($N-1)-(-($$val+1)%$N);
      }
   }
}

# $flag = $self->_is_int($string [,$low, $high]);
#    Returns 1 if $string is a valid integer, 0 otherwise.  If $low is
#    entered, $string must be >= $low.  If $high is entered, $string must
#    be <= $high.  It is valid to check only one of the bounds.
sub _is_int {
   my($self,$N,$low,$high)=@_;
   return 0  if (! defined $N  or
                 $N !~ /^\s*[-+]?\d+\s*$/  or
                 defined $low   &&  $N<$low  or
                 defined $high  &&  $N>$high);
   return 1;
}

###############################################################################
# Split/Join functions

sub split {
   my($self,$op,$string) = @_;

   if ($op eq 'date') {

      if ($string =~ /^(\d\d\d\d)(\d\d)(\d\d)(\d\d):(\d\d):(\d\d)$/  ||
          $string =~ /^(\d\d\d\d)\-(\d\d)\-(\d\d)\-(\d\d):(\d\d):(\d\d)$/  ||
          $string =~ /^(\d\d\d\d)(\d\d)(\d\d)(\d\d)(\d\d)(\d\d)$/) {
         my($y,$m,$d,$h,$mn,$s) = ($1+0,$2+0,$3+0,$4+0,$5+0,$6+0);
         return [$y,$m,$d,$h,$mn,$s];
      } else {
         return undef;
      }

   } elsif ($op eq 'offset') {
      if ($string =~ /^([-+]?)(\d\d)(\d\d)(\d\d)$/       ||
          $string =~ /^([-+]?)(\d\d)(\d\d)()$/           ||
          $string =~ /^([-+]?)(\d\d?):(\d\d?):(\d\d?)$/  ||
          $string =~ /^([-+]?)(\d\d?):(\d\d?)()$/        ||
          $string =~ /^([-+]?)(\d\d?)()()$/) {
         my($err,$h,$mn,$s) = $self->_normalize_offset('split',$1,$2,$3,$4);
         return undef  if ($err);
         return [$h,$mn,$s];
      } else {
         return undef;
      }

   } elsif ($op eq 'hms') {
      if ($string =~ /^(\d\d)(\d\d)(\d\d)$/     ||
          $string =~ /^(\d\d)(\d\d)()$/         ||
          $string =~ /^(\d\d?):(\d\d):(\d\d)$/  ||
          $string =~ /^(\d\d?):(\d\d)()$/       ||
          $string =~ /^(\d\d?)()()$/) {
         my($err,$h,$mn,$s) = $self->_normalize_hms('split',$1,$2,$3);
         return undef  if ($err);
         return [$h,$mn,$s];
      } else {
         return undef;
      }

   } elsif ($op eq 'time') {
      if ($string =~ /^[-+]?\d+(:[-+]?\d+){0,2}$/) {
         my($err,$dh,$dmn,$ds) = $self->_normalize_time('split',split(/:/,$string));
         return undef  if ($err);
         return [$dh,$dmn,$ds];
      } else {
         return undef;
      }

   } elsif ($op eq 'delta') {
      if ($string =~ /^[-+]?\d*(:[-+]?\d*){0,6}$/) {
         $string =~ s/::/:0:/g;
         $string =~ s/^:/0:/;
         $string =~ s/:$/:0/;
         my($err,@delta) = $self->_normalize_delta('split',split(/:/,$string));
         return undef  if ($err);
         return [@delta];
      } else {
         return undef;
      }

   } elsif ($op eq 'business') {
      if ($string =~ /^[-+]?\d*(:[-+]?\d*){0,6}$/) {
         $string =~ s/::/:0:/g;
         $string =~ s/^:/0:/;
         $string =~ s/:$/:0/;
         my($err,@delta) = $self->_normalize_business('split',split(/:/,$string));
         return undef  if ($err);
         return [@delta];
      } else {
         return undef;
      }
   }
}

sub _join_date {
   my($self,$data) = @_;
   my($y,$m,$d,$h,$mn,$s) = @$data;
   while (length($y) < 4) {
      $y = "0$y";
   }
   $m  = "0$m"    if (length($m)==1);
   $d  = "0$d"    if (length($d)==1);
   $h  = "0$h"    if (length($h)==1);
   $mn = "0$mn"   if (length($mn)==1);
   $s  = "0$s"    if (length($s)==1);
   return "$y$m$d$h:$mn:$s";
}

sub join{
   my($self,$op,$data) = @_;
   my @data = @$data;

   if ($op eq 'date') {

      my($err,$y,$m,$d,$h,$mn,$s) = $self->_normalize_date(@data);
      return undef  if ($err);
      my $form = $self->_config('printable');
      if ($form == 1) {
         return "$y$m$d$h$mn$s";
      } elsif ($form == 2) {
         return "$y-$m-$d-$h:$mn:$s";
      } else {
         return "$y$m$d$h:$mn:$s";
      }

   } elsif ($op eq 'offset') {
      my($err,$h,$mn,$s) = $self->_normalize_offset('join','',@data);
      return undef  if ($err);
      return "$h:$mn:$s";

   } elsif ($op eq 'hms') {
      my($err,$h,$mn,$s) = $self->_normalize_hms('join',@data);
      return undef  if ($err);
      return "$h:$mn:$s";

   } elsif ($op eq 'time') {
      my($err,$dh,$dmn,$ds) = $self->_normalize_time('join',@data);
      return undef  if ($err);
      return "$dh:$dmn:$ds";

   } elsif ($op eq 'delta') {
      my($err,@delta) = $self->_normalize_delta('join',@data);
      return undef  if ($err);
      return join(':',@delta);

   } elsif ($op eq 'business') {
      my($err,@delta) = $self->_normalize_business('join',@data);
      return undef  if ($err);
      return join(':',@delta);
   }
}

sub _normalize_date {
   my($self,@fields) = @_;
   return (1)  if ($#fields != 5);

   my($y,$m,$d,$h,$mn,$s) = @fields;

   while (length($y) < 4) {
      $y = "0$y";
   }
   $m  = "0$m"    if (length($m)==1);
   $d  = "0$d"    if (length($d)==1);
   $h  = "0$h"    if (length($h)==1);
   $mn = "0$mn"   if (length($mn)==1);
   $s  = "0$s"    if (length($s)==1);

   return (0,$y,$m,$d,$h,$mn,$s);
}

sub _normalize_offset {
   my($self,$op,$sign,@fields) = @_;
   while ($#fields < 2) {
      push(@fields,0);
   }
   return (1)  if ($#fields != 2);

   my($h,$mn,$s) = @fields;
   $mn   = 0  if (! $mn);
   $s    = 0  if (! $s);
   return (1)  if ($h  !~ /^[+-]?[0-2]?[0-9]$/  ||  $h < -23  ||  $h > 23  ||
                   $mn !~ /^[+-]?[0-5]?[0-9]$/  ||
                   $s  !~ /^[+-]?[0-5]?[0-9]$/);

   $h   *= 1;
   $mn  *= 1;
   $s   *= 1;

   if ($op eq 'join') {
      if ($h >= 0  &&  $mn >= 0  &&  $s >= 0) {
         $sign  = '+';
      } elsif ($h <= 0  &&  $mn <= 0  &&  $s <= 0) {
         $sign  = '-';
         $h    *= -1;
         $mn   *= -1;
         $s    *= -1;
      } else {
         return (1);
      }

      $h  = "0$h"   if ($h  < 10);
      $mn = "0$mn"  if ($mn < 10);
      $s  = "0$s"   if ($s  < 10);
      $h  = "$sign$h";

   } elsif ($sign eq '-') {
      $h    *= -1;
      $mn   *= -1;
      $s    *= -1;
   }

   return (0,$h,$mn,$s);
}

sub _normalize_hms {
   my($self,$op,@fields) = @_;
   while ($#fields < 2) {
      push(@fields,0);
   }
   return (1)  if ($#fields != 2);

   my($h,$mn,$s) = @fields;
   $h   *= 1;
   $mn   = 0  if (! $mn);
   $mn  *= 1;
   $s    = 0  if (! $s);
   $s   *= 1;

   return (1)  if (! $self->_is_int($h,0,24)  ||
                   ! $self->_is_int($mn,0,59) ||
                   ! $self->_is_int($s,0,59));

   if ($op eq 'join') {
      $h  = "0$h"   if ($h  < 10);
      $mn = "0$mn"  if ($mn < 10);
      $s  = "0$s"   if ($s  < 10);
   }

   return (0,$h,$mn,$s)  if ($h==24  &&  ! $mn  &&  ! $s);
   return (1)            if ($h==24);
   return (0,$h,$mn,$s);
}

sub _normalize_time {
   my($self,$op,@fields) = @_;
   while ($#fields < 2) {
      unshift(@fields,0);
   }
   return (1)  if ($#fields != 2);

   # If we're splitting, the sign needs to be carried.

   if ($op eq 'split') {
      my ($sign) = '+';
      foreach my $f (@fields) {
         if ($f =~ /^([-+])/) {
            $sign = $1;
         } else {
            $f = "$sign$f";
         }
      }
   }

   my($h,$mn,$s) = @fields;

   # Normalize

   my $sign = '+';

   $s += $h*3600 + $mn*60;       # convert h/m to s
   if ($op eq 'join'  &&  $s < 0) {
      $sign = '-';
      $s    = abs($s);
   }

   $mn = int($s/60);             # convert s to m
   $s -= $mn*60;

   $h   = int($mn/60);           # convert m to h
   $mn -= $h*60;

   $h  = "$sign$h"  if ($op eq 'join'  &&  $sign eq '-');

   return (0,$h,$mn,$s);
}

sub _normalize_delta {
   my($self,$op,@fields) = @_;
   foreach my $f (@fields) {
      $f=0  if (! defined($f));
   }
   while ($#fields < 6) {
      unshift(@fields,0);
   }
   return (1)  if ($#fields != 6);

   # If we're splitting, the sign needs to be carried.

   if ($op eq 'split') {
      my ($sign) = '+';
      foreach my $f (@fields) {
         if ($f =~ /^([-+])/) {
            $sign = $1;
         } else {
            $f = "$sign$f";
         }
         $f *= 1;
      }

   } elsif ($op eq 'norm') {
      foreach my $f (@fields) {
         $f *= 1;
      }
   }

   my($y,$m,$w,$d,$h,$mn,$s) = @fields;

   ($y,$m)           = $self->_normalize_ym($op,$y,$m);
   ($w,$d,$h,$mn,$s) = $self->_normalize_wdhms($op,$w,$d,$h,$mn,$s);

   return (0,$y,$m,$w,$d,$h,$mn,$s);
}

sub _normalize_business {
   my($self,$op,@fields) = @_;
   foreach my $f (@fields) {
      $f=0  if (! defined($f));
   }
   while ($#fields < 6) {
      unshift(@fields,0);
   }
   return (1)  if ($#fields != 6);

   # If we're splitting, the sign needs to be carried.

   if ($op eq 'split') {
      my ($sign) = '+';
      foreach my $f (@fields) {
         if ($f =~ /^([-+])/) {
            $sign = $1;
         } else {
            $f = "$sign$f";
         }
         $f *= 1;
      }

   } elsif ($op eq 'norm') {
      foreach my $f (@fields) {
         $f *= 1;
      }
   }

   my($y,$m,$w,$d,$h,$mn,$s) = @fields;

   ($y,$m)        = $self->_normalize_ym($op,$y,$m);
   $w             = $self->_normalize_w($op,$w);
   ($d,$h,$mn,$s) = $self->_normalize_dhms($op,$d,$h,$mn,$s);

   return (0,$y,$m,$w,$d,$h,$mn,$s);
}

sub _normalize_ym {
   my($self,$op,$y,$m) = @_;

   my $sign = '+';

   $m += $y*12;
   if ($op eq 'join'  &&  $m < 0) {
      $sign = '-';
      $m    = abs($m);
   }

   $y  = int($m/12);
   $m -= $y*12;

   $y  = "$sign$y"  if ($op eq 'join');
   return ($y,$m);
}

sub _normalize_wdhms {
   my($self,$op,$w,$d,$h,$mn,$s) = @_;

   my($len) = 86400;            # 24*3600
   my $sign = '+';

   {
      # Unfortunately, $s overflows for dates more than ~70 years
      # apart. Do the minimum amount of work here.
      no integer;

      $s += ($d+7*$w)*$len + $h*3600 + $mn*60; # convert w/d/h/m to s
      if ($op eq 'join'  &&  $s < 0) {
         $sign = '-';
         $s    = abs($s);
      }

      $d  = int($s/$len);        # convert s to d
      $s -= $d*$len;
   }

   $mn  = int($s/60);             # convert s to m
   $s  -= $mn*60;

   $h   = int($mn/60);            # convert m to h
   $mn -= $h*60;

   $w   = int($d/7);              # convert d to w
   $d  -= $w*7;

   # Attach the sign

   $w   = "$sign$w"  if ($op eq 'join');

   return ($w,$d,$h,$mn,$s);
}

sub _normalize_w {
   my($self,$op,$w) = @_;

   $w = "+$w"  if ($op eq 'join'  &&  $w >= 0);

   return $w;
}

sub _normalize_dhms {
   my($self,$op,$d,$h,$mn,$s) = @_;

   my($sign) = '+';
   my($len)  = $$self{'data'}{'calc'}{'bdlength'};

   {
      # Unfortunately, $s overflows for dates more than ~70 years
      # apart. Do the minimum amount of work here.
      no integer;

      $s += $d*$len + $h*3600 + $mn*60; # convert d/h/m to s
      if ($op eq 'join'  &&  $s < 0) {
         $sign = '-';
         $s    = abs($s);
      }

      $d  = int($s/$len);        # convert s to d
      $s -= $d*$len;
   }

   $mn  = int($s/60);            # convert s to m
   $s  -= $mn*60;

   $h   = int($mn/60);           # convert m to h
   $mn -= $h*60;

   # Attach the sign

   $d   = "$sign$d"  if ($op eq 'join');

   return ($d,$h,$mn,$s);
}

# $self->_delta_convert(FORMAT,DELTA)
#    This converts delta into the given format. Returns '' if invalid.
#
sub _delta_convert {
   my($self,$format,$delta)=@_;
   my $fields = $self->split($format,$delta);
   return undef  if (! defined $fields);
   return $self->join($format,$fields);
}

###############################################################################
# Timezone critical dates

# NOTE: Although I would prefer to stick this routine in the
# Date::Manip::TZ module where it would be more appropriate, it must
# appear here as it will be used to generate the data that will be
# used by the Date::Manip::TZ module.
#
# This calculates a critical date based on timezone information. The
# critical date is the date (usually in the current time) at which
# the current timezone period ENDS.
#
# Input is:
#    $year,$mon,$flag,$num,$dow
#       This is information from the appropriate Rule line from the
#       zoneinfo files. These are used to determine the date (Y/M/D)
#       when the timezone period will end.
#    $isdst
#       Whether or not the next timezone period is a Daylight Saving
#       Time period.
#    $time,$timetype
#       The time of day when the change occurs. The timetype can be
#       'w' (wallclock time in the current period), 's' (standard
#       time which will match wallclock time in a non-DST period, or
#       be off an hour in a DST period), and 'u' (universal time).
#
# Output is:
#    $endUT, $endLT, $begUT, $begLT
#       endUT is the actual last second of the current timezone
#       period.  endLT is the same time expressed in local time.
#       begUT is the start (in UT) of the next time period. Note that
#       the begUT date is the one which actually corresponds to the
#       date/time specified in the input. begLT is the time in the new
#       local time. The endUT/endLT are the time one second earlier.
#
sub _critical_date {
   my($self,$year,$mon,$flag,$num,$dow,
      $isdst,$time,$timetype,$stdoff,$dstoff) = @_;

   #
   # Get the predicted Y/M/D
   #

   my($y,$m,$d) = ($year+0,$mon+0,1);

   if ($flag eq 'dom') {
      $d = $num;

   } elsif ($flag eq 'last') {
      my $ymd = $self->nth_day_of_week($year,-1,$dow,$mon);
      $d = $$ymd[2];

   } elsif ($flag eq 'ge') {
      my $ymd = $self->nth_day_of_week($year,1,$dow,$mon);
      $d = $$ymd[2];
      while ($d < $num) {
         $d += 7;
      }

   } elsif ($flag eq 'le') {
      my $ymd = $self->nth_day_of_week($year,-1,$dow,$mon);
      $d = $$ymd[2];
      while ($d > $num) {
         $d -= 7;
      }
   }

   #
   # Get the predicted time and the date (not yet taking into
   # account time type).
   #

   my($h,$mn,$s) = @{ $self->split('hms',$time) };
   my $date      = [ $y,$m,$d,$h,$mn,$s ];

   #
   # Calculate all the relevant dates.
   #

   my($endUT,$endLT,$begUT,$begLT,$offset);
   $stdoff = $self->split('offset',$stdoff);
   $dstoff = $self->split('offset',$dstoff);

   if ($timetype eq 'w') {
      $begUT = $self->calc_date_time($date,($isdst ? $stdoff : $dstoff), 1);
   } elsif ($timetype eq 'u') {
      $begUT = $date;
   } else {
      $begUT = $self->calc_date_time($date,$stdoff, 1);
   }

   $endUT    = $self->calc_date_time($begUT,[0,0,-1]);
   $endLT    = $self->calc_date_time($endUT,($isdst ? $stdoff : $dstoff));
   $begLT    = $self->calc_date_time($begUT,($isdst ? $dstoff : $stdoff));

   return ($endUT,$endLT,$begUT,$begLT);
}

###############################################################################
# Get a list of strings to try to parse.

sub _encoding {
   my($self,$string) = @_;
   my @ret;

   foreach my $enc (@{ $$self{'data'}{'calc'}{'enc_in'} }) {
      if (lc($enc) eq 'utf-8') {
         push(@ret,$string);
      } elsif (lc($enc) eq 'perl') {
         push(@ret,encode_utf8($string));
      } else {
         my $tmp = $string;
         my $out = from_to($tmp,$enc,'utf-8');
         next  if (! defined($out));
         push(@ret,$tmp);
      }
   }

   return @ret;
}

###############################################################################
#### **** DEPRECATED FUNCTIONS ****

# $File=_ExpandTilde($file);
#   This checks to see if a '~' appears as the first character in a path.
#   If it does, the "~" expansion is interpreted (if possible) and the full
#   path is returned.  If a "~" expansion is used but cannot be
#   interpreted, an empty string is returned.
#
#   This is Windows/Mac friendly.
#   This is efficient.
sub _ExpandTilde {
   my($self,$file) = @_;
   my($user,$home);

   # ~aaa/bbb=      ~  aaa      /bbb
   if ($file =~ s|^~([^/]*)||) {
      $user=$1;
      # Single user operating systems (Mac, MSWindows) don't have the getpwnam
      # and getpwuid routines defined.  Try to catch various different ways
      # of knowing we are on one of these systems:
      my $os = $self->_os();
      return ''  if ($os eq 'Windows'  or
                     $os eq 'Other');
      $user=''  if (! defined $user);

      if ($user) {
         $home= (getpwnam($user))[7];
      } else {
         $home= (getpwuid($<))[7];
      }
      $home = VMS::Filespec::unixpath($home)  if ($os eq 'VMS');
      return ''  if (! $home);
      $file="$home/$file";
   }
   $file;
}

# $File=_SearchPath($file,$path,$sep);
#   Searches through directories in $path for a file named $file.  The
#   full path is returned if one is found, or an empty string otherwise.
#   $sep is the path separator.
#
sub _SearchPath {
   my($self,$file,$path,$sep) = @_;
   my @dir  = split(/\Q$sep\E/,$path);

   foreach my $d (@dir) {
      my $f = "$d/$file";
      $f    =~ s|//|/|g;
      $f    = $self->_ExpandTilde($f);
      return $f if (-r $f);
   }
   return '';
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
