# Copyrights 2003,2004,2007-2009 by Mark Overmeer <perl@overmeer.net>.
#  For other contributors see Changes.
# See the manual pages for details on the licensing terms.
# Pod stripped from pm file by OODoc 1.06.
package Mail::Identity;
use vars '$VERSION';
$VERSION = '0.93';

use base 'User::Identity::Item';

use strict;
use warnings;

use User::Identity;
use Scalar::Util 'weaken';


sub type() { "email" }


sub init($)
{   my ($self, $args) = @_;

    $args->{name} ||= '-x-';

    $self->SUPER::init($args);

    exists $args->{$_} && ($self->{'MI_'.$_} = delete $args->{$_})
        foreach qw/address charset comment domain language
                   location organization pgp_key phrase signature
                   username/;

   $self->{UII_name} = $self->phrase || $self->address
      if $self->{UII_name} eq '-x-';

   $self;
}


sub from($)
{   my ($class, $other) = (shift, shift);
    return $other if $other->isa(__PACKAGE__);

    if($other->isa('Mail::Address'))
    {   return $class->new
          ( phrase  => $other->phrase
          , address => $other->address
          , comment => $other->comment
          , @_);
    }

    if($other->isa('User::Identity'))
    {   my $emails = $other->collection('emails') or next;
        my @roles  = $emails->roles or return ();
        return $roles[0];      # first Mail::Identity
    }

    undef;
}


sub comment($)
{   my $self = shift;
    return $self->{MI_comment} = shift if @_;
    return $self->{MI_comment} if defined $self->{MI_comment};

    my $user = $self->user     or return undef;
    my $full = $user->fullName or return undef;
    $self->phrase eq $full ? undef : $full;
}


sub charset()
{   my $self = shift;
    return $self->{MI_charset} if defined $self->{MI_charset};

    my $user = $self->user     or return undef;
    $user->charset;
}


sub language()
{   my $self = shift;
   
    return $self->{MI_language} if defined $self->{MI_language};

    my $user = $self->user     or return undef;
    $user->language;
}


sub domain()
{   my $self = shift;
    return $self->{MI_domain}
        if defined $self->{MI_domain};

    my $address = $self->{MI_address} or return 'localhost';
    $address =~ s/.*?\@// ? $address : undef;
}


sub address()
{   my $self = shift;
    return $self->{MI_address} if defined $self->{MI_address};

    return $self->username .'@'. $self->domain
        if $self->{MI_username} || $self->{MI_domain};

    my $name = $self->name;
    return $name if index($name, '@') >= 0;

    my $user = $self->user;
    defined $user ? $user->nickname : $name;
}


sub location()
{   my $self      = shift;
    my $location  = $self->{MI_location};

    if(! defined $location)
    {   my $user  = $self->user or return;
        my @locs  = $user->collection('locations');
        $location =  @locs ? $locs[0] : undef;
    }
    elsif(! ref $location)
    {   my $user  = $self->user or return;
        $location = $user->find(location => $location);
    }

    $location;
}


sub organization()
{   my $self = shift;

    return $self->{MI_organization} if defined $self->{MI_organization};

    my $location = $self->location or return;
    $location->organization;
}

#pgp_key

sub phrase()
{  my $self = shift;
    return $self->{MI_phrase} if defined $self->{MI_phrase};
    my $user = $self->user     or return undef;
    my $full = $user->fullName or return undef;
    $full;
}

#signature


sub username()
{   my $self = shift;
    return $self->{MI_username} if defined $self->{MI_username};
 
    if(my $address = $self->{MI_address})
    {   $address =~ s/\@.*$//;   # strip domain part if present
        return $address;
    }

    my $user = $self->user or return;
    $user->nickname;
}

1;

