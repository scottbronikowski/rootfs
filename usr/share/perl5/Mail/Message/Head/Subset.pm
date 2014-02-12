# Copyrights 2001-2011 by Mark Overmeer.
#  For other contributors see ChangeLog.
# See the manual pages for details on the licensing terms.
# Pod stripped from pm file by OODoc 2.00.

use strict;

package Mail::Message::Head::Subset;
use vars '$VERSION';
$VERSION = '2.099';

use base 'Mail::Message::Head';

use Object::Realize::Later
    becomes        => 'Mail::Message::Head::Complete',
    realize        => 'load',
    believe_caller => 1;

use Date::Parse;


sub count($)
{   my ($self, $name) = @_;

    my @values = $self->get($name);

    return $self->load->count($name)
       unless @values;

    scalar @values;
}

#-------------------------------------------


sub get($;$)
{   my $self = shift;
 
    if(wantarray)
    {   my @values = $self->SUPER::get(@_);
        return @values if @values;
    }
    else
    {   my $value  = $self->SUPER::get(@_);
        return $value  if defined $value;
    }

    $self->load->get(@_);
}


#-------------------------------------------


sub guessBodySize()
{   my $self = shift;

    my $cl = $self->SUPER::get('Content-Length');
    return $1 if defined $cl && $cl =~ m/(\d+)/;

    my $lines = $self->SUPER::get('Lines');   # 40 chars per lines
    return $1*40 if defined $lines && $lines =~ m/(\d+)/;

    undef;
}

#-------------------------------------------
# Be careful not to trigger loading: this is not the thoroughness
# we want from this method.

sub guessTimestamp()
{   my $self = shift;
    return $self->{MMHS_timestamp} if $self->{MMHS_timestamp};

    my $stamp;
    if(my $date = $self->SUPER::get('date'))
    {   $stamp = str2time($date, 'GMT');
    }

    unless($stamp)
    {   foreach ($self->SUPER::get('received'))
        {   $stamp = str2time($_, 'GMT');
            last if $stamp;
        }
    }

    $self->{MMHS_timestamp} = $stamp;
}

#-------------------------------------------


sub load() { $_[0] = $_[0]->message->loadHead }

#------------------------------------------

1;
