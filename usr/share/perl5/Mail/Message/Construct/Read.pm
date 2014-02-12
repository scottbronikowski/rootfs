# Copyrights 2001-2011 by Mark Overmeer.
#  For other contributors see ChangeLog.
# See the manual pages for details on the licensing terms.
# Pod stripped from pm file by OODoc 2.00.

use strict;

package Mail::Message;
use vars '$VERSION';
$VERSION = '2.099';


use Mail::Box::FastScalar;


sub read($@)
{   my ($class, $from, %args) = @_;
    my ($filename, $file);
    my $ref       = ref $from;

    if(!$ref)
    {   $filename = 'scalar';
        $file     = Mail::Box::FastScalar->new(\$from);
    }
    elsif($ref eq 'SCALAR')
    {   $filename = 'ref scalar';
        $file     = Mail::Box::FastScalar->new($from);
    }
    elsif($ref eq 'ARRAY')
    {   $filename = 'array of lines';
        my $buffer= join '', @$from;
        $file     = Mail::Box::FastScalar->new(\$buffer);
    }
    elsif($ref eq 'GLOB')
    {   $filename = 'file (GLOB)';
        local $/;
        my $buffer= <$from>;
        $file     = Mail::Box::FastScalar->new(\$buffer);
    }
    elsif($ref && $from->isa('IO::Handle'))
    {   $filename = 'file ('.ref($from).')';
        my $buffer= join '', $from->getlines;
        $file     = Mail::Box::FastScalar->new(\$buffer);
    }
    else
    {   $class->log(ERROR => "Cannot read from $from");
        return undef;
    }

    my $strip_status = exists $args{strip_status_fields}
                     ? delete $args{strip_status_fields}
                     : 1;

    require Mail::Box::Parser::Perl;  # not parseable by C parser

    my $parser = Mail::Box::Parser::Perl->new
     ( %args
     , filename  => $filename
     , file      => $file
     , trusted   => 1
     );

    my $self = $class->new(%args);
    $self->readFromParser($parser, $args{body_type});
    $self->addReport($parser);

    $parser->stop;

    my $head = $self->head;
    $head->set('Message-ID' => '<'.$self->messageId.'>')
        unless $head->get('Message-ID');

    $head->delete('Status', 'X-Status') if $strip_status;

    $self;
}

1;
