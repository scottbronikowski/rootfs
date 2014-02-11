package Date::Manip::TZ::aflago00;
# Copyright (c) 2008-2011 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Wed Aug 31 11:05:07 EDT 2011
#    Data version: tzdata2011i
#    Code version: tzcode2011i

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::aflago00 - Support for the Africa/Lagos time zone

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
        [ [1,1,2,0,0,0],[1,1,2,0,13,36],'+00:13:36',[0,13,36],
          'LMT',0,[1919,8,31,23,46,23],[1919,8,31,23,59,59],
          '0001010200:00:00','0001010200:13:36','1919083123:46:23','1919083123:59:59' ],
     ],
   1919 =>
     [
        [ [1919,8,31,23,46,24],[1919,9,1,0,46,24],'+01:00:00',[1,0,0],
          'WAT',0,[9999,12,31,0,0,0],[9999,12,31,1,0,0],
          '1919083123:46:24','1919090100:46:24','9999123100:00:00','9999123101:00:00' ],
     ],
);

%LastRule      = (
);

1;
