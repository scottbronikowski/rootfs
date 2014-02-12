# Copyrights 2001-2011 by Mark Overmeer.
#  For other contributors see ChangeLog.
# See the manual pages for details on the licensing terms.
# Pod stripped from pm file by OODoc 2.00.
use strict;
use warnings;

package Mail::Message::Convert::EmailSimple;
use vars '$VERSION';
$VERSION = '2.099';

use base 'Mail::Message::Convert';

use Mail::Internet;
use Mail::Header;
use Mail::Message;
use Mail::Message::Head::Complete;
use Mail::Message::Body::Lines;

use Email::Simple;
use Carp;


sub export($@)
{   my ($thing, $message) = (shift, shift);

    croak "Export message must be a Mail::Message, but is a ".ref($message)."."
        unless $message->isa('Mail::Message');

    Email::Simple->new($message->string);
}


sub from($@)
{   my ($thing, $email) = (shift, shift);

    croak "Converting from Email::Simple but got a ".ref($email).'.'
        unless $email->isa('Email::Simple');

    my $message = Mail::Message->read($email->as_string);
}

1;
