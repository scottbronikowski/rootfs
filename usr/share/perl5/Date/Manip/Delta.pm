package Date::Manip::Delta;
# Copyright (c) 1995-2011 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

########################################################################
# Any routine that starts with an underscore (_) is NOT intended for
# public use.  They are for internal use in the the Date::Manip
# modules and are subject to change without warning or notice.
#
# ABSOLUTELY NO USER SUPPORT IS OFFERED FOR THESE ROUTINES!
########################################################################

use Date::Manip::Obj;
@ISA = ('Date::Manip::Obj');

require 5.010000;
use warnings;
use strict;
use IO::File;
#use re 'debug';

our $VERSION;
$VERSION='6.25';
END { undef $VERSION; }

########################################################################
# BASE METHODS
########################################################################

sub is_delta {
   return 1;
}

sub config {
   my($self,@args) = @_;
   $self->SUPER::config(@args);

   # A new config can change the value of the format fields, so clear them.
   $$self{'data'}{'f'}    = {};
   $$self{'data'}{'flen'} = {};
}

# Call this every time a new delta is put in to make sure everything is
# correctly initialized.
#
sub _init {
   my($self) = @_;

   my $def = [0,0,0,0,0,0,0];
   my $dmt = $$self{'tz'};
   my $dmb = $$dmt{'base'};

   $$self{'err'}              = '';
   $$self{'data'}{'delta'}    = $def;   # the delta
   $$self{'data'}{'business'} = 0;      # 1 for a business delta
   $$self{'data'}{'gotmode'}  = 0;      # if exact/business set explicitly
   $$self{'data'}{'in'}       = '';     # the string that was parsed (if any)
   $$self{'data'}{'f'}        = {};     # format fields
   $$self{'data'}{'flen'}     = {};     # field lengths
}

sub _init_args {
   my($self) = @_;

   my @args = @{ $$self{'args'} };
   if (@args) {
      if ($#args == 0) {
         $self->parse($args[0]);
      } else {
         warn "WARNING: [new] invalid arguments: @args\n";
      }
   }
}

sub value {
   my($self) = @_;
   my $dmt = $$self{'tz'};
   my $dmb = $$dmt{'base'};

   return undef  if ($$self{'err'});
   if (wantarray) {
      return @{ $$self{'data'}{'delta'} };
   } elsif ($$self{'data'}{'business'}) {
      return $dmb->join('business',$$self{'data'}{'delta'});
   } else {
      return $dmb->join('delta',$$self{'data'}{'delta'});
   }
}

sub input {
   my($self) = @_;
   return  $$self{'data'}{'in'};
}

########################################################################
# DELTA METHODS
########################################################################

BEGIN {
   my %ops = map { $_,1 } qw( delta business normal );
   my %f   = map { $_,1 } qw( y M w d h m s );

   sub set {
      my($self,$field,$val) = @_;

      $field       = lc($field);
      my $business = 0;
      my $dmt      = $$self{'tz'};
      my $dmb      = $$dmt{'base'};
      my $zone     = $$self{'data'}{'tz'};
      my $gotmode  = $$self{'data'}{'gotmode'};
      my (@delta,$err);

      if (exists $ops{$field}) {

         if ($field eq 'business') {
            $business = 1;
            $gotmode  = 1;
         } elsif ($field eq 'normal') {
            $business = 0;
            $gotmode  = 1;
         } elsif ($field eq 'delta') {
            $business = $$self{'data'}{'business'};
            $gotmode  = $$self{'data'}{'gotmode'};
         }
         my $type = ($business ? 'business' : 'delta');
         if ($business) {
            ($err,@delta) = $dmb->_normalize_business('norm',@$val);
         } else {
            ($err,@delta) = $dmb->_normalize_delta('norm',@$val);
         }

      } elsif (exists $f{$field}) {

         if ($$self{'err'}) {
            $$self{'err'} = "[set] Invalid delta";
            return 1;
         }

         @delta             = @{ $$self{'data'}{'delta'} };
         $business          = $$self{'data'}{'business'};
         my %f              = qw(y 0 M 1 w 2 d 3 h 4 m 5 s 6);
         $delta[$f{$field}] = $val;

         if ($business) {
            ($err,@delta) = $dmb->_normalize_business(0,@delta);
         } else {
            ($err,@delta) = $dmb->_normalize_delta(0,@delta);
         }

      } elsif ($field eq 'mode') {

         @delta             = @{ $$self{'data'}{'delta'} };
         $val = lc($val);
         if ($val eq "business"  ||  $val eq "normal") {
            $gotmode = 1;
            $business = ($val eq "business" ? 1 : 0);

         } else {
            $$self{'err'} = "[set] Invalid mode: $val";
            return 1;
         }

      } else {

         $$self{'err'} = "[set] Invalid field: $field";
         return 1;

      }

      if ($err) {
         $$self{'err'} = "[set] Invalid field value: $field";
         return 1;
      }

      $self->_init();
      $$self{'data'}{'delta'}    = [ @delta ];
      $$self{'data'}{'business'} = $business;
      $$self{'data'}{'gotmode'}  = $gotmode;
      return 0;
   }
}

sub _rx {
   my($self,$rx) = @_;
   my $dmt = $$self{'tz'};
   my $dmb = $$dmt{'base'};

   return $$dmb{'data'}{'rx'}{'delta'}{$rx}
     if (exists $$dmb{'data'}{'rx'}{'delta'}{$rx});

   if ($rx eq 'expanded') {
      my $sign    = '[-+]?\s*';
      my $sep     = '(?:,\s*|\s+|$)';

      my $nth     = $$dmb{'data'}{'rx'}{'nth'}[0];
      my $yf      = $$dmb{data}{rx}{fields}[1];
      my $mf      = $$dmb{data}{rx}{fields}[2];
      my $wf      = $$dmb{data}{rx}{fields}[3];
      my $df      = $$dmb{data}{rx}{fields}[4];
      my $hf      = $$dmb{data}{rx}{fields}[5];
      my $mnf     = $$dmb{data}{rx}{fields}[6];
      my $sf      = $$dmb{data}{rx}{fields}[7];

      my $y       = "(?:(?:(?<y>$sign\\d+)|(?<y>$nth))\\s*(?:$yf)$sep)";
      my $m       = "(?:(?:(?<m>$sign\\d+)|(?<m>$nth))\\s*(?:$mf)$sep)";
      my $w       = "(?:(?:(?<w>$sign\\d+)|(?<w>$nth))\\s*(?:$wf)$sep)";
      my $d       = "(?:(?:(?<d>$sign\\d+)|(?<d>$nth))\\s*(?:$df)$sep)";
      my $h       = "(?:(?:(?<h>$sign\\d+)|(?<h>$nth))\\s*(?:$hf)$sep)";
      my $mn      = "(?:(?:(?<mn>$sign\\d+)|(?<mn>$nth))\\s*(?:$mnf)$sep)";
      my $s       = "(?:(?:(?<s>$sign\\d+)|(?<s>$nth))\\s*(?:$sf)?)";

      my $exprx   = qr/^\s*$y?$m?$w?$d?$h?$mn?$s?\s*$/i;
      $$dmb{'data'}{'rx'}{'delta'}{$rx} = $exprx;

   } elsif ($rx eq 'mode') {

      my $mode = qr/\b($$dmb{'data'}{'rx'}{'mode'}[0])\b/i;
      $$dmb{'data'}{'rx'}{'delta'}{$rx} = $mode;

   } elsif ($rx eq 'when') {

      my $when = qr/\b($$dmb{'data'}{'rx'}{'when'}[0])\b/i;
      $$dmb{'data'}{'rx'}{'delta'}{$rx} = $when;

   }

   return $$dmb{'data'}{'rx'}{'delta'}{$rx};
}

sub parse {
   my($self,$instring,$business) = @_;
   my $dmt = $$self{'tz'};
   my $dmb = $$dmt{'base'};
   my($gotmode,$type,@delta);
   $self->_init();

   if (! $instring) {
      $$self{'err'} = '[parse] Empty delta string';
      return 1;
   }

   my $mode  = $self->_rx('mode');

 ENCODING: foreach my $string ($dmb->_encoding($instring)) {

      $type      = 'delta';

      # Get the mode

      $gotmode  = 0;
      $gotmode  = 1  if (defined($business));
      $business = 0  if (! $business);

      if ($string =~ s/$mode//i) {
         my $m = ($1);
         if ($$dmb{'data'}{'wordmatch'}{'mode'}{lc($m)} == 1) {
            $business = 0;
         } else {
            $business = 1;
         }
         $gotmode = 1;
      }

      $type         = 'business'  if ($business);

      # Parse the delta

    PARSE: {

         $$self{'err'} = '';
         $string    =~ s/^\s*//;
         $string    =~ s/\s*$//;

         # Colon format

         if ($string) {
            my $tmp = $dmb->split($type,$string);
            if (defined $tmp) {
               @delta = @$tmp;
               last ENCODING;
            }
         }

         # Expanded format

         my $when      = $self->_rx('when');
         my $past      = 0;
         if ($string  &&
             $string =~ s/$when//i) {
            my $when = ($1);
            if ($$dmb{'data'}{'wordmatch'}{'when'}{lc($when)} == 1) {
               $past   = 1;
            }
         }

         my $rx        = $self->_rx('expanded');
         if ($string  &&
             $string   =~ $rx) {
            @delta     = @+{qw(y m w d h mn s)};
            foreach my $f (@delta) {
               if (! defined $f) {
                  $f = 0;
               } elsif (exists $$dmb{'data'}{'wordmatch'}{'nth'}{lc($f)}) {
                  $f = $$dmb{'data'}{'wordmatch'}{'nth'}{lc($f)};
               } else {
                  $f =~ s/\s//g;
               }
            }
            my $err;
            if ($type eq 'business') {
               ($err,@delta)  = $dmb->_normalize_business('split',@delta);
            } else {
               ($err,@delta)  = $dmb->_normalize_delta('split',@delta);
            }

            if ($err) {
               next ENCODING;
            }

            # if $past, reverse the signs
            if ($past) {
               foreach my $v (@delta) {
                  if (defined $v) {
                     $v *= -1;
                  }
               }
            }

            last ENCODING;
         }
      }

      $$self{'err'} = "[parse] Invalid delta string";
      last ENCODING;
   }

   return 1  if ($$self{'err'});

   $$self{'data'}{'in'}       = $instring;
   $$self{'data'}{'delta'}    = [@delta];
   $$self{'data'}{'business'} = $business;
   $$self{'data'}{'gotmode'}  = $gotmode;
   return 0;
}

sub printf {
   my($self,@in) = @_;
   if ($$self{'err'}) {
      warn "WARNING: [printf] Object must contain a valid delta\n";
      return undef;
   }

   my($y,$M,$w,$d,$h,$m,$s) = @{ $$self{'data'}{'delta'} };

   my @out;
   foreach my $in (@in) {
      my $out = '';
      while ($in) {
         if ($in =~ s/^([^%]+)//) {
            $out .= $1;

         } elsif ($in =~ s/^%%//) {
            $out .= "%";

         } elsif ($in =~ s/^%
                           (\+)?                   # sign
                           ([<>0])?                # pad
                           (\d+)?                  # width
                           ([yMwdhms])             # field
                           v                       # type
                          //ox) {
            my($sign,$pad,$width,$field) = ($1,$2,$3,$4);
            $out .= $self->_printf_field($sign,$pad,$width,0,$field);

         } elsif ($in =~ s/^(%
                              (\+)?                   # sign
                              ([<>0])?                # pad
                              (\d+)?                  # width
                              (?:\.(\d+))?            # precision
                              ([yMwdhms])             # field
                              ([yMwdhms])             # field0
                              ([yMwdhms])             # field1
                           )//ox) {
            my($match,$sign,$pad,$width,$precision,$field,$field0,$field1) =
              ($1,$2,$3,$4,$5,$6,$7,$8);

            # Get the list of fields we're expressing

            my @field = qw(y M w d h m s);
            while (@field  &&  $field[0] ne $field0) {
               shift(@field);
            }
            while (@field  &&  $field[$#field] ne $field1) {
               pop(@field);
            }

            if (! @field) {
               $out .= $match;
            } else {
               $out .=
                 $self->_printf_field($sign,$pad,$width,$precision,$field,@field);
            }

         } elsif ($in =~ s/^%
                           (\+)?                   # sign
                           ([<>])?                 # pad
                           (\d+)?                  # width
                           Dt
                          //ox) {
            my($sign,$pad,$width) = ($1,$2,$3);
            $out .= $self->_printf_delta($sign,$pad,$width,'y','s');

         } elsif ($in =~ s/^(%
                              (\+)?                   # sign
                              ([<>])?                 # pad
                              (\d+)?                  # width
                              D
                              ([yMwdhms])             # field0
                              ([yMwdhms])             # field1
                           )//ox) {
            my($match,$sign,$pad,$width,$field0,$field1) = ($1,$2,$3,$4,$5,$6);

            # Get the list of fields we're expressing

            my @field = qw(y M w d h m s);
            while (@field  &&  $field[0] ne $field0) {
               shift(@field);
            }
            while (@field  &&  $field[$#field] ne $field1) {
               pop(@field);
            }

            if (! @field) {
               $out .= $match;
            } else {
               $out .= $self->_printf_delta($sign,$pad,$width,$field[0],$field[$#field]);
            }

         } else {
            $in =~ s/^(%[^%]*)//;
            $out .= $1;
         }
      }
      push(@out,$out);
   }

   if (wantarray) {
      return @out;
   } elsif (@out == 1) {
      return $out[0];
   }

   return ''
}

sub _printf_delta {
   my($self,$sign,$pad,$width,$field0,$field1) = @_;
   my $dmt = $$self{'tz'};
   my $dmb = $$dmt{'base'};
   my @delta = @{ $$self{'data'}{'delta'} };
   my $delta;
   my %tmp   = qw(y 0 M 1 w 2 d 3 h 4 m 5 s 6);

   # Add a sign to each field

   my $s = "+";
   foreach my $f (@delta) {
      if ($f < 0) {
         $s = "-";
      } elsif ($f > 0) {
         $s = "+";
         $f *= 1;
         $f = "+$f";
      } else {
         $f = "$s$f";
      }
   }

   # Split the delta into field sets containing only those fields to
   # print.
   #
   # @set = ( [SETa] [SETb] ....)
   #   where [SETx] is a listref of fields from one set of fields

   my @set;
   my $business = $$self{'data'}{'business'};

   my $f0 = $tmp{$field0};
   my $f1 = $tmp{$field1};

   if ($field0 eq $field1) {
      @set = ( [ $delta[$f0] ] );

   } elsif ($business) {

      if ($f0 <= 1) {
         # if (field0 = y or M)
         #    add [y,M]
         #    field0 = w   OR   done if field1 = M
         push(@set, [ @delta[0..1] ]);
         $f0 = ($f1 == 1 ? 7 : 2);
      }

      if ($f0 == 2) {
         # if (field0 = w)
         #    add [w]
         #    field0 = d  OR  done if field1 = w
         push(@set, [ $delta[2] ]);
         $f0 = ($f1 == 2 ? 7 : 3);
      }

      if ($f0 <= 6) {
         push(@set, [ @delta[$f0..$f1] ]);
      }

   } else {

      if ($f0 <= 1) {
         # if (field0 = y or M)
         #    add [y,M]
         #    field0 = w   OR   done if field1 = M
         push(@set, [ @delta[0..1] ]);
         $f0 = ($f1 == 1 ? 7 : 2);
      }

      if ($f0 <= 6) {
         push(@set, [ @delta[$f0..$f1] ]);
      }
   }

   # If we're not forcing signs, remove signs from all fields
   # except the first in each set.

   my @ret;

   foreach my $set (@set) {
      my @f = @$set;

      if (defined($sign)  &&  $sign eq "+") {
         push(@ret,@f);
      } else {
         push(@ret,shift(@f));
         foreach my $f (@f) {
            $f =~ s/[-+]//;
            push(@ret,$f);
         }
      }
   }

   # Width/pad

   my $ret = join(':',@ret);
   if ($width  &&  length($ret) < $width) {
      if (defined $pad  &&  $pad eq ">") {
         $ret .= ' 'x($width-length($ret));
      } else {
         $ret = ' 'x($width-length($ret)) . $ret;
      }
   }

   return $ret;
}

sub _printf_field {
   my($self,$sign,$pad,$width,$precision,$field,@field) = @_;

   my $val = $self->_printf_field_val($field,@field);
   $pad    = "<"  if (! defined($pad));

   # Strip off the sign.

   my $s = '';

   if ($val < 0) {
      $s   = "-";
      $val *= -1;
   } elsif ($sign) {
      $s   = "+";
   }

   # Handle the precision.

   if (defined($precision)) {
      $val = sprintf("%.${precision}f",$val);

   } elsif (defined($width)) {
      my $i = $s . int($val) . '.';
      if (length($i) < $width) {
         $precision = $width-length($i);
         $val = sprintf("%.${precision}f",$val);
      }
   }

   # Handle padding.

   if ($width) {
      if      ($pad eq ">") {
         $val = "$s$val";
         $val .= ' 'x($width-length($val));

      } elsif ($pad eq "<") {
         $val = "$s$val";
         $val = ' 'x($width-length($val)) . $val;

      } else {
         $val = $s . '0'x($width-length($val)-length($s)) . $val;
      }
   } else {
      $val = "$s$val";
   }

   return $val;
}

# $$self{'data'}{'f'}{X}{Y} is the value of field X expressed in terms of Y.
#
sub _printf_field_val {
   my($self,$field,@field) = @_;

   if (! exists $$self{'data'}{'f'}{'y'}  &&
       ! exists $$self{'data'}{'f'}{'y'}{'y'}) {

      my($yv,$Mv,$wv,$dv,$hv,$mv,$sv) = map { $_*1 } @{ $$self{'data'}{'delta'} };
      $$self{'data'}{'f'}{'y'}{'y'} = $yv;
      $$self{'data'}{'f'}{'M'}{'M'} = $Mv;
      $$self{'data'}{'f'}{'w'}{'w'} = $wv;
      $$self{'data'}{'f'}{'d'}{'d'} = $dv;
      $$self{'data'}{'f'}{'h'}{'h'} = $hv;
      $$self{'data'}{'f'}{'m'}{'m'} = $mv;
      $$self{'data'}{'f'}{'s'}{'s'} = $sv;
   }

   # A single field

   if (! @field) {
      return $$self{'data'}{'f'}{$field}{$field};
   }

   # Find the length of 1 unit of each field in terms of seconds.

   if (! exists $$self{'data'}{'flen'}{'s'}) {
      $$self{'data'}{'flen'}{'s'} = 1;
      $$self{'data'}{'flen'}{'m'} = 60;
      $$self{'data'}{'flen'}{'h'} = 3600;

      # Find the length of day/week/year
      #
      # $daylen is the number of second in a day
      # $weeklen is the number of days in a week
      # $yrlen is the number of days in a year

      my $business = $$self{'data'}{'business'};
      my ($weeklen,$daylen,$yrlen);
      if ($business) {
         my $dmt = $$self{'tz'};
         my $dmb = $$dmt{'base'};
         $daylen  = $$dmb{'data'}{'calc'}{'bdlength'};
         $weeklen = $$dmb{'data'}{'calc'}{'workweek'};
         # The approximate length of the business year in business days
         $yrlen   = 365.2425*$weeklen/7;
      } else {
         $weeklen = 7;
         $daylen  = 86400;  # 24*60*60
         $yrlen   = 365.2425;
      }

      $$self{'data'}{'flen'}{'d'} = $daylen;
      $$self{'data'}{'flen'}{'w'} = $weeklen*$daylen;
      $$self{'data'}{'flen'}{'M'} = $yrlen*$daylen/12;
      $$self{'data'}{'flen'}{'y'} = $yrlen*$daylen;
   }

   # Calculate the value for each field.

   my $val = 0;
   foreach my $f (@field) {

      # We want the value of $f expressed in terms of $field

      if (! exists $$self{'data'}{'f'}{$f}{$field}) {

         # Get the value of $f expressed in seconds

         if (! exists $$self{'data'}{'f'}{$f}{'s'}) {
            $$self{'data'}{'f'}{$f}{'s'} =
              $$self{'data'}{'f'}{$f}{$f} * $$self{'data'}{'flen'}{$f};
         }

         # Get the value of $f expressed in terms of $field

         $$self{'data'}{'f'}{$f}{$field} =
           $$self{'data'}{'f'}{$f}{'s'} / $$self{'data'}{'flen'}{$field};
      }

      $val += $$self{'data'}{'f'}{$f}{$field};
   }

   return $val;
}

sub type {
   my($self,$op) = @_;

   if ($op eq 'business') {
      return $$self{'data'}{'business'};

   } elsif ($op eq 'exact') {
      my $exact = 1;
      $exact    = 0  if ($$self{'data'}{'delta'}[0] != 0  ||
                         $$self{'data'}{'delta'}[1] != 0  ||
                         ($$self{'data'}{'delta'}[2] != 0  &&
                          $$self{'data'}{'business'}));
      return $exact;
   }

   return undef;
}

sub calc {
   my($self,$obj,$subtract) = @_;
   if ($$self{'err'}) {
      $$self{'err'} = "[calc] First object invalid (delta)";
      return undef;
   }

   if      (ref($obj) eq 'Date::Manip::Date') {
      if ($$obj{'err'}) {
         $$self{'err'} = "[calc] Second object invalid (date)";
         return undef;
      }
      return $obj->calc($self,$subtract);

   } elsif (ref($obj) eq 'Date::Manip::Delta') {
      if ($$obj{'err'}) {
         $$self{'err'} = "[calc] Second object invalid (delta)";
         return undef;
      }
      return $self->_calc_delta_delta($obj,$subtract);

   } else {
      $$self{'err'} = "[calc] Second object must be a Date/Delta object";
      return undef;
   }
}

sub _calc_delta_delta {
   my($self,$delta,$subtract) = @_;
   my $dmt = $$self{'tz'};
   my $dmb = $$dmt{'base'};
   my $ret = $self->new_delta;

   if ($self->err()) {
      $$ret{'err'} = "[calc] Invalid delta/delta calculation object: delta1";
      return $ret;
   } elsif ($delta->err()) {
      $$ret{'err'} = "[calc] Invalid delta/delta calculation object: delta2";
      return $ret;
   }

   my $business = 0;
   if ($$self{'data'}{'business'} != $$delta{'data'}{'business'}) {
      $$ret{'err'} = "[calc] Delta/delta calculation objects must be of " .
        'the same type';
      return $ret;
   } else {
      $business = $$self{'data'}{'business'};
   }

   my @delta;
   for (my $i=0; $i<7; $i++) {
      if ($subtract) {
         $delta[$i] = $$self{'data'}{'delta'}[$i] - $$delta{'data'}{'delta'}[$i];
      } else {
         $delta[$i] = $$self{'data'}{'delta'}[$i] + $$delta{'data'}{'delta'}[$i];
      }
      $delta[$i] = "+" . $delta[$i]  if ($delta[$i] > 0);
   }

   my $type  = ($business ? 'business' : 'delta');
   $ret->set($type,\@delta);

   return $ret;
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
