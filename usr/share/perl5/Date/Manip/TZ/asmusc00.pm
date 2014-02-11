package Date::Manip::TZ::asmusc00;
# Copyright (c) 2008-2011 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Wed Aug 31 11:04:46 EDT 2011
#    Data version: tzdata2011i
#    Code version: tzcode2011i

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::asmusc00 - Support for the Asia/Muscat time zone

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
        [ [1,1,2,0,0,0],[1,1,2,3,54,20],'+03:54:20',[3,54,20],
          'LMT',0,[1919,12,31,20,5,39],[1919,12,31,23,59,59],
          '0001010200:00:00','0001010203:54:20','1919123120:05:39','1919123123:59:59' ],
     ],
   1919 =>
     [
        [ [1919,12,31,20,5,40],[1920,1,1,0,5,40],'+04:00:00',[4,0,0],
          'GST',0,[9999,12,31,0,0,0],[9999,12,31,4,0,0],
          '1919123120:05:40','1920010100:05:40','9999123100:00:00','9999123104:00:00' ],
     ],
);

%LastRule      = (
);

1;
