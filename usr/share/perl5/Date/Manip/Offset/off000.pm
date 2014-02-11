package Date::Manip::Offset::off000;
# Copyright (c) 2008-2011 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Wed Aug 31 12:08:23 EDT 2011
#    Data version: tzdata2011i
#    Code version: tzcode2011i

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::Offset::off000 - Support for the +00:00:00 offset

=head1 SYNPOSIS

This module contains data from the Olsen database for the offset. It
is not intended to be used directly (other Date::Manip modules will
load it as needed).

=cut

use strict;
use warnings;
require 5.010000;

our ($VERSION);
$VERSION='6.25';
END { undef $VERSION; }

our ($Offset,%Offset);
END {
   undef $Offset;
   undef %Offset;
}

$Offset        = '+00:00:00';

%Offset        = (
   0 => [
      'wet',
      'europe/london',
      'africa/lome',
      'atlantic/faroe',
      'africa/abidjan',
      'africa/bamako',
      'africa/conakry',
      'africa/nouakchott',
      'africa/ouagadougou',
      'africa/sao_tome',
      'europe/lisbon',
      'africa/casablanca',
      'europe/dublin',
      'africa/accra',
      'africa/dakar',
      'atlantic/canary',
      'atlantic/st_helena',
      'africa/freetown',
      'africa/banjul',
      'atlantic/madeira',
      'atlantic/reykjavik',
      'africa/monrovia',
      'africa/bissau',
      'africa/el_aaiun',
      'america/danmarkshavn',
      'etc/gmt',
      'ut',
      'z',
      'atlantic/azores',
      'africa/ceuta',
      'africa/algiers',
      'africa/malabo',
      'africa/niamey',
      'america/rankin_inlet',
      'europe/gibraltar',
      'america/inuvik',
      'indian/kerguelen',
      'america/resolute',
      'europe/andorra',
      'america/iqaluit',
      'europe/brussels',
      'europe/madrid',
      'europe/monaco',
      'europe/paris',
      'europe/luxembourg',
      'america/yellowknife',
      'africa/porto-novo',
      'america/pangnirtung',
      'america/cambridge_bay',
      'antarctica/casey',
      'antarctica/davis',
      'antarctica/dumontdurville',
      'antarctica/macquarie',
      'antarctica/mawson',
      'antarctica/mcmurdo',
      'antarctica/palmer',
      'antarctica/rothera',
      'antarctica/syowa',
      'antarctica/vostok',
      ],
   1 => [
      'atlantic/azores',
      'america/scoresbysund',
      'atlantic/reykjavik',
      'atlantic/madeira',
      ],
);

1;
