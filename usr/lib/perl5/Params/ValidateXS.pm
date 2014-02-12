package Params::Validate;
BEGIN {
  $Params::Validate::VERSION = '0.97';
}

use strict;
use warnings;

require XSLoader;
XSLoader::load(
    'Params::Validate',
    exists $Params::Validate::{VERSION}
    ? do { ${ $Params::Validate::{VERSION} } }
    : 42
);

my $default_fail = sub {
    require Carp;
    Carp::confess( $_[0] );
};

{
    my %defaults = (
        ignore_case    => 0,
        strip_leading  => 0,
        allow_extra    => 0,
        on_fail        => $default_fail,
        stack_skip     => 1,
        normalize_keys => undef,
    );

    *set_options = \&validation_options;

    sub validation_options {
        my %opts = @_;

        my $caller = caller;

        foreach ( keys %defaults ) {
            $opts{$_} = $defaults{$_} unless exists $opts{$_};
        }

        $OPTIONS{$caller} = \%opts;
    }
}

sub _check_regex_from_xs {
    return ( defined $_[0] ? $_[0] : '' ) =~ /$_[1]/ ? 1 : 0;
}

BEGIN {
    *validate      = \&_validate;
    *validate_pos  = \&_validate_pos;
    *validate_with = \&_validate_with;
}

1;

# ABSTRACT: XS implementation of Params::Validate



=pod

=head1 NAME

Params::Validate - XS implementation of Params::Validate

=head1 VERSION

version 0.97

=head1 SYNOPSIS

  See Params::Validate

=head1 DESCRIPTION

This is an XS implementation of Params::Validate.  See the
Params::Validate documentation for details.

=head1 AUTHOR

Dave Rolsky, <autarch@urth.org> and Ilya Martynov <ilya@martynov.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2011 by Dave Rolsky and Ilya Martynov.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut


__END__

