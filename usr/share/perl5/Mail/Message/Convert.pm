# Copyrights 2001-2011 by Mark Overmeer.
#  For other contributors see ChangeLog.
# See the manual pages for details on the licensing terms.
# Pod stripped from pm file by OODoc 2.00.

use strict;
use warnings;

package Mail::Message::Convert;
use vars '$VERSION';
$VERSION = '2.099';

use base 'Mail::Reporter';


sub init($)
{   my ($self, $args) = @_;
    $self->SUPER::init($args);

    $self->{MMC_fields}          = $args->{fields}    ||
       qr#^(Resent\-)?(To|From|Cc|Bcc|Subject|Date)\b#i;

    $self;
}

#------------------------------------------


sub selectedFields($)
{   my ($self, $head) = @_;
    $head->grepNames($self->{MMC_fields});
}

#------------------------------------------


1;
