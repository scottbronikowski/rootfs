package Date::Manip::TZ::afbraz00;
# Copyright (c) 2008-2011 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Wed Aug 31 11:04:58 EDT 2011
#    Data version: tzdata2011i
#    Code version: tzcode2011i

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::afbraz00 - Support for the Africa/Brazzaville time zone

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
        [ [1,1,2,0,0,0],[1,1,2,1,1,8],'+01:01:08',[1,1,8],
          'LMT',0,[1911,12,31,22,58,51],[1911,12,31,23,59,59],
          '0001010200:00:00','0001010201:01:08','1911123122:58:51','1911123123:59:59' ],
     ],
   1911 =>
     [
        [ [1911,12,31,22,58,52],[1911,12,31,23,58,52],'+01:00:00',[1,0,0],
          'WAT',0,[9999,12,31,0,0,0],[9999,12,31,1,0,0],
          '1911123122:58:52','1911123123:58:52','9999123100:00:00','9999123101:00:00' ],
     ],
);

%LastRule      = (
);

1;
