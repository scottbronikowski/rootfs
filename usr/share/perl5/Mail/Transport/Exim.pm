# Copyrights 2001-2011 by Mark Overmeer.
#  For other contributors see ChangeLog.
# See the manual pages for details on the licensing terms.
# Pod stripped from pm file by OODoc 2.00.
use strict;
use warnings;

package Mail::Transport::Exim;
use vars '$VERSION';
$VERSION = '2.099';

use base 'Mail::Transport::Send';

use Carp;


sub init($)
{   my ($self, $args) = @_;

    $args->{via} = 'exim';

    $self->SUPER::init($args) or return;

    $self->{MTS_program}
      = $args->{proxy}
     || ( -x '/usr/sbin/exim4' ? '/usr/sbin/exim4' : undef)
     || $self->findBinary('exim', '/usr/exim/bin')
     || return;

    $self;
}

#------------------------------------------


sub trySend($@)
{   my ($self, $message, %args) = @_;

    my $from = $args{from} || $message->sender;
    $from    = $from->address if ref $from && $from->isa('Mail::Address');
    my @to   = map {$_->address} $self->destinations($message, $args{to});

    my $program = $self->{MTS_program};
    if(open(MAILER, '|-')==0)
    {   { exec $program, '-i', '-f', $from, @to; }  # {} to avoid warning
        $self->log(NOTICE => "Errors when opening pipe to $program: $!");
        exit 1;
    }

    $self->putContent($message, \*MAILER, undisclosed => 1);

    unless(close MAILER)
    {   $self->log(ERROR => "Errors when closing Exim mailer $program: $!");
        $? ||= $!;
        return 0;
    }

    1;
}

#------------------------------------------

1;
