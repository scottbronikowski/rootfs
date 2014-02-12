# Copyrights 2001-2011 by Mark Overmeer.
#  For other contributors see ChangeLog.
# See the manual pages for details on the licensing terms.
# Pod stripped from pm file by OODoc 2.00.

use strict;
use warnings;

package Mail::Message::TransferEnc;
use vars '$VERSION';
$VERSION = '2.099';

use base 'Mail::Reporter';


my %encoder =
 ( base64 => 'Mail::Message::TransferEnc::Base64'
 , '7bit' => 'Mail::Message::TransferEnc::SevenBit'
 , '8bit' => 'Mail::Message::TransferEnc::EightBit'
 , 'quoted-printable' => 'Mail::Message::TransferEnc::QuotedPrint'
 );

#------------------------------------------

 
sub create($@)
{   my ($class, $type) = (shift, shift);

    my $encoder = $encoder{lc $type};
    unless($encoder)
    {   $class->new(@_)->log(WARNING => "No decoder for transfer encoding $type.");
        return;
    }

    eval "require $encoder";
    if($@)
    {   $class->new(@_)->log(ERROR =>
            "Decoder for transfer encoding $type does not work:\n$@");
        return;
    }

    $encoder->new(@_);
}

#------------------------------------------


sub addTransferEncoder($$)
{   my ($class, $type, $encoderclass) = @_;
    $encoder{lc $type} = $encoderclass;
    $class;
}

#------------------------------------------


sub name {shift->notImplemented}

#------------------------------------------


sub check($@) {shift->notImplemented}

#------------------------------------------


sub decode($@) {shift->notImplemented}

#------------------------------------------


sub encode($) {shift->notImplemented}

#------------------------------------------


1;
