# Copyrights 2001-2011 by Mark Overmeer.
#  For other contributors see ChangeLog.
# See the manual pages for details on the licensing terms.
# Pod stripped from pm file by OODoc 2.00.
use strict;
use warnings;

package Mail::Transport::SMTP;
use vars '$VERSION';
$VERSION = '2.099';

use base 'Mail::Transport::Send';

use Net::SMTP;


sub init($)
{   my ($self, $args) = @_;

    my $hosts   = $args->{hostname};
    unless($hosts)
    {   require Net::Config;
        $hosts  = $Net::Config::NetConfig{smtp_hosts};
        undef $hosts unless @$hosts;
        $args->{hostname} = $hosts;
    }

    $args->{via}  ||= 'smtp';
    $args->{port} ||= '25';

    $self->SUPER::init($args) or return;

    my $helo = $args->{helo}
      || eval { require Net::Config; $Net::Config::inet_domain }
      || eval { require Net::Domain; Net::Domain::hostfqdn() };

    $self->{MTS_net_smtp_opts}
       = { Hello   => $helo
         , Debug   => ($args->{smtp_debug} || 0)
         };

    $self;
}

#------------------------------------------


sub trySend($@)
{   my ($self, $message, %args) = @_;

    # From whom is this message.
    my $from = $args{from} || $message->sender || '<>';
    $from = $from->address if ref $from && $from->isa('Mail::Address');

    # Who are the destinations.
    if(defined $args{To})
    {   $self->log(WARNING =>
   "Use option `to' to overrule the destination: `To' would refer to a field");
    }

    my @to = map {$_->address} $self->destinations($message, $args{to});

    unless(@to)
    {   $self->log(NOTICE =>
            'No addresses found to send the message to, no connection made');
        return 1;
    }

    # Prepare the header
    my @header;
    require IO::Lines;
    my $lines = IO::Lines->new(\@header);
    $message->head->printUndisclosed($lines);

    #
    # Send
    #

    if(wantarray)
    {   # In LIST context
        my $server;
        return (0, 500, "Connection Failed", "CONNECT", 0)
            unless $server = $self->contactAnyServer;

        return (0, $server->code, $server->message, 'FROM', $server->quit)
            unless $server->mail($from);

        foreach (@to)
        {     next if $server->to($_);
# must we be able to disable this?
# next if $args{ignore_erroneous_destinations}
              return (0, $server->code, $server->message,"To $_",$server->quit);
        }

        $server->data;
        $server->datasend($_) foreach @header;
        my $bodydata = $message->body->file;

        if(ref $bodydata eq 'GLOB') { $server->datasend($_) while <$bodydata> }
        else    { while(my $l = $bodydata->getline) { $server->datasend($l) } }

        return (0, $server->code, $server->message, 'DATA', $server->quit)
            unless $server->dataend;

        return ($server->quit, $server->code, $server->message, 'QUIT',
                $server->code);
    }

    # in SCALAR context
    my $server;
    return 0 unless $server = $self->contactAnyServer;

    $server->quit, return 0
        unless $server->mail($from);

    foreach (@to)
    {
          next if $server->to($_);
# must we be able to disable this?
# next if $args{ignore_erroneous_destinations}
          $server->quit;
          return 0;
    }

    $server->data;
    $server->datasend($_) foreach @header;
    my $bodydata = $message->body->file;

    if(ref $bodydata eq 'GLOB') { $server->datasend($_) while <$bodydata> }
    else    { while(my $l = $bodydata->getline) { $server->datasend($l) } }

    $server->quit, return 0
        unless $server->dataend;

    $server->quit;
}

#------------------------------------------


sub contactAnyServer()
{   my $self = shift;

    my ($enterval, $count, $timeout) = $self->retry;
    my ($host, $port, $username, $password) = $self->remoteHost;
    my @hosts = ref $host ? @$host : $host;

    foreach my $host (@hosts)
    {   my $server = $self->tryConnectTo
         ( $host, Port => $port,
         , %{$self->{MTS_net_smtp_opts}}, Timeout => $timeout
         );

        defined $server or next;

        $self->log(PROGRESS => "Opened SMTP connection to $host.");

        if(defined $username)
        {   if($server->auth($username, $password))
            {    $self->log(PROGRESS => "$host: Authentication succeeded.");
            }
            else
            {    $self->log(ERROR => "Authentication failed.");
                 return undef;
            }
        }

        return $server;
    }

    undef;
}

#------------------------------------------


sub tryConnectTo($@)
{   my ($self, $host) = (shift, shift);
    Net::SMTP->new($host, @_);
}

#------------------------------------------

1;
