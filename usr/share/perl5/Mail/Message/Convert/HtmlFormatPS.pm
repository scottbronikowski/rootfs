# Copyrights 2001-2011 by Mark Overmeer.
#  For other contributors see ChangeLog.
# See the manual pages for details on the licensing terms.
# Pod stripped from pm file by OODoc 2.00.
use strict;
use warnings;

package Mail::Message::Convert::HtmlFormatPS;
use vars '$VERSION';
$VERSION = '2.099';

use base 'Mail::Message::Convert';

use Mail::Message::Body::String;

use HTML::TreeBuilder;
use HTML::FormatText;


sub init($)
{   my ($self, $args)  = @_;

    my @formopts = map { ($_ => delete $args->{$_} ) }
                       grep m/^[A-Z]/, keys %$args;

    $self->SUPER::init($args);

    $self->{MMCH_formatter} = HTML::FormatPS->new(@formopts);
    $self;
}

#------------------------------------------


sub format($)
{   my ($self, $body) = @_;

    my $dec  = $body->encode(transfer_encoding => 'none');
    my $tree = HTML::TreeBuilder->new_from_file($dec->file);

    (ref $body)->new
      ( based_on  => $body
      , mime_type => 'application/postscript'
      , data     => [ $self->{MMCH_formatter}->format($tree) ]
      );
}

#------------------------------------------

1;
