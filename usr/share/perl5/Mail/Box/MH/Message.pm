# Copyrights 2001-2011 by Mark Overmeer.
#  For other contributors see ChangeLog.
# See the manual pages for details on the licensing terms.
# Pod stripped from pm file by OODoc 2.00.

use strict;
use warnings;

package Mail::Box::MH::Message;
use vars '$VERSION';
$VERSION = '2.099';

use base 'Mail::Box::Dir::Message';

use File::Copy;
use Carp;


#-------------------------------------------


# Purpose of doc is only the warning... no new implementation required.

#-------------------------------------------


1;
