# Copyrights 2001-2011 by Mark Overmeer.
#  For other contributors see ChangeLog.
# See the manual pages for details on the licensing terms.
# Pod stripped from pm file by OODoc 2.00.

use strict;
use warnings;

package Mail::Message::TransferEnc::Binary;
use vars '$VERSION';
$VERSION = '2.099';

use base 'Mail::Message::TransferEnc';


sub name() { 'binary' }

#------------------------------------------

sub check($@)
{   my ($self, $body, %args) = @_;
    $body;
}

#------------------------------------------

sub decode($@)
{   my ($self, $body, %args) = @_;
    $body->transferEncoding('none');
    $body;
}

#------------------------------------------

sub encode($@)
{   my ($self, $body, %args) = @_;

    my @lines;

    my $changes = 0;
    foreach ($body->lines)
    {   $changes++ if s/[\000\013]//g;
        push @lines, $_;
    }

    unless($changes)
    {   $body->transferEncoding('none');
        return $body;
    }

    my $bodytype = $args{result_type} || ref($self->load);

    $bodytype->new
     ( based_on          => $self
     , transfer_encoding => 'none'
     , data              => \@lines
     );
}

#------------------------------------------

1;
