package Date::Manip::TZ::inreun00;
# Copyright (c) 2008-2011 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Wed Aug 31 11:05:18 EDT 2011
#    Data version: tzdata2011i
#    Code version: tzcode2011i

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::inreun00 - Support for the Indian/Reunion time zone

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
        [ [1,1,2,0,0,0],[1,1,2,3,41,52],'+03:41:52',[3,41,52],
          'LMT',0,[1911,5,31,20,18,7],[1911,5,31,23,59,59],
          '0001010200:00:00','0001010203:41:52','1911053120:18:07','1911053123:59:59' ],
     ],
   1911 =>
     [
        [ [1911,5,31,20,18,8],[1911,6,1,0,18,8],'+04:00:00',[4,0,0],
          'RET',0,[9999,12,31,0,0,0],[9999,12,31,4,0,0],
          '1911053120:18:08','1911060100:18:08','9999123100:00:00','9999123104:00:00' ],
     ],
);

%LastRule      = (
);

1;
