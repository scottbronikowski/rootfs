# Copyrights 2001-2011 by Mark Overmeer.
#  For other contributors see ChangeLog.
# See the manual pages for details on the licensing terms.
# Pod stripped from pm file by OODoc 2.00.
use warnings;
use strict;

package Mail::Message::Field::Date;
use vars '$VERSION';
$VERSION = '2.099';

use base 'Mail::Message::Field::Structured';

use POSIX qw/mktime/;


my $dayname = qr/Mon|Tue|Wed|Thu|Fri|Sat|Sun/;
my @months  = qw/Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec/;
my %monthnr; { my $i; $monthnr{$_} = ++$i for @months }
my %tz      = qw/EDT -0400  EST -0500  CDT -0500  CST -0600
                 MDT -0600  MST -0700  PDT -0700  PST -0800
                 UT  +0000  GMT +0000/;

sub parse($)
{   my ($self, $string) = @_;

    my ($dn, $d, $mon, $y, $h, $min, $s, $z) = $string =~
      m/ ^ \s*
           (?: ($dayname) \s* \, \s* )?
           ( 0?[1-9] | [12][0-9] | 3[01] ) \s* # day
           \s+ ( [A-Z][a-z][a-z] ) \s+         # month
           ( 19[0-9][0-9] | 2[0-9]{3} ) \s+    # year
                  ( [0-1][0-9] | 2[0-3] ) \s*  # hour
               \: ( [0-5][0-9] ) \s*           # minute
           (?: \: ( [0-5][0-9] ) )? \s+        # second
           ( [+-][0-9]{4} | [A-Z]+ )           # zone
           \s* /x
       or return undef;

    $dn =~ s/\s+//g if $dn;
    $y += 2000 if $y < 50;
    $y += 1900 if $y < 100;

    $z  =  $tz{$z} || '-0000'
        if $z =~ m/[A-Z]/;

    $self->{MMFD_date} = sprintf "%s%s%02d %s %04d %02d:%02d:%02d %s"
      , $dn, (length $dn ? ', ' : ''), $d, $mon, $y, $h, $min, $s, $z;

    $self;
}

sub produceBody() { shift->{MMFD_date} }
sub date() { shift->{MMFD_date} }

#------------------------------------------


sub addAttribute($;@)
{   my $self = shift;
    $self->log(ERROR => 'No attributes for date fields.');
    $self;
}


sub time()
{   my $date = shift->{MMFD_date};
    my ($d, $mon, $y, $h, $min, $s, $z)
      = $date =~ m/^ (?:\w\w\w\,\s+)? (\d\d)\s+(\w+)\s+(\d\d\d\d)
                     \s+ (\d\d)\:(\d\d)\:(\d\d) \s+ ([+-]\d\d\d\d)? \s*$ /x;
    my $timestamp = mktime $s, $min, $h, $d, $monthnr{$mon}-1, $y-1900
      , 0, 0, -1;
    $timestamp += ($1 eq '-' ? -1 : 1) * ($2*3600 + $3*60)
        if $z =~ m/^([+-])(\d\d)(\d\d)$/;
    $timestamp;
}

#------------------------------------------


1;
