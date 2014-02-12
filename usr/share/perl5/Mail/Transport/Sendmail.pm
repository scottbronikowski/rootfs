# Copyrights 2001-2011 by Mark Overmeer.
#  For other contributors see ChangeLog.
# See the manual pages for details on the licensing terms.
# Pod stripped from pm file by OODoc 2.00.
use strict;
use warnings;

package Mail::Transport::Sendmail;
use vars '$VERSION';
$VERSION = '2.099';

use base 'Mail::Transport::Send';

use Carp;


sub init($)
{   my ($self, $args) = @_;

    $args->{via} = 'sendmail';

    $self->SUPER::init($args) or return;

    $self->{MTS_program}
      = $args->{proxy}
     || $self->findBinary('sendmail')
     || return;

    $self->{MTS_opts} = $args->{sendmail_options} || [];
    $self;
}

#------------------------------------------


sub trySend($@)
{   my ($self, $message, %args) = @_;

    my $program = $self->{MTS_program};
    if(open(MAILER, '|-')==0)
    {   my $options = $args{sendmail_options} || [];
        my @to = map {$_->address} $self->destinations($message, $args{to});

        # {} to avoid warning about code after exec
        {  exec $program, '-i', @{$self->{MTS_opts}}, @$options, @to; }

        $self->log(NOTICE => "Errors when opening pipe to $program: $!");
        exit 1;
    }
 
    $self->putContent($message, \*MAILER, undisclosed => 1);

    unless(close MAILER)
    {   $self->log(NOTICE => "Errors when closing sendmail mailer $program: $!");
        $? ||= $!;
        return 0;
    }

    1;
}

#------------------------------------------

1;
