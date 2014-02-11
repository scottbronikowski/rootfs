package Date::Manip::TZ::afmala00;
# Copyright (c) 2008-2011 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Wed Aug 31 11:04:57 EDT 2011
#    Data version: tzdata2011i
#    Code version: tzcode2011i

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::afmala00 - Support for the Africa/Malabo time zone

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
        [ [1,1,2,0,0,0],[1,1,2,0,35,8],'+00:35:08',[0,35,8],
          'LMT',0,[1911,12,31,23,24,51],[1911,12,31,23,59,59],
          '0001010200:00:00','0001010200:35:08','1911123123:24:51','1911123123:59:59' ],
     ],
   1911 =>
     [
        [ [1911,12,31,23,24,52],[1911,12,31,23,24,52],'+00:00:00',[0,0,0],
          'GMT',0,[1963,12,14,23,59,59],[1963,12,14,23,59,59],
          '1911123123:24:52','1911123123:24:52','1963121423:59:59','1963121423:59:59' ],
     ],
   1963 =>
     [
        [ [1963,12,15,0,0,0],[1963,12,15,1,0,0],'+01:00:00',[1,0,0],
          'WAT',0,[9999,12,31,0,0,0],[9999,12,31,1,0,0],
          '1963121500:00:00','1963121501:00:00','9999123100:00:00','9999123101:00:00' ],
     ],
);

%LastRule      = (
);

1;
