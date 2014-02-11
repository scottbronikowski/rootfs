package Date::Manip::TZ::amguay00;
# Copyright (c) 2008-2011 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Wed Aug 31 11:05:13 EDT 2011
#    Data version: tzdata2011i
#    Code version: tzcode2011i

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::amguay00 - Support for the America/Guayaquil time zone

=head1 SYNPOSIS

This module contains data from the Olsen database for the time zone. It
is not intended to be used directly (other Date::Manip modules will
load it as needed).

=cut

use strict;
use warnings;
require 5.010000;

our (%Dates,%LastRule);
END {
   undef %Dates;
   undef %LastRule;
}

our ($VERSION);
$VERSION='6.25';
END { undef $VERSION; }

%Dates         = (
   1    =>
     [
        [ [1,1,2,0,0,0],[1,1,1,18,40,40],'-05:19:20',[-5,-19,-20],
          'LMT',0,[1890,1,1,5,19,19],[1889,12,31,23,59,59],
          '0001010200:00:00','0001010118:40:40','1890010105:19:19','1889123123:59:59' ],
     ],
   1890 =>
     [
        [ [1890,1,1,5,19,20],[1890,1,1,0,5,20],'-05:14:00',[-5,-14,0],
          'QMT',0,[1931,1,1,5,13,59],[1930,12,31,23,59,59],
          '1890010105:19:20','1890010100:05:20','1931010105:13:59','1930123123:59:59' ],
     ],
   1931 =>
     [
        [ [1931,1,1,5,14,0],[1931,1,1,0,14,0],'-05:00:00',[-5,0,0],
          'ECT',0,[9999,12,31,0,0,0],[9999,12,30,19,0,0],
          '1931010105:14:00','1931010100:14:00','9999123100:00:00','9999123019:00:00' ],
     ],
);

%LastRule      = (
);

1;
