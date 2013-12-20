#----------------------------------------------------------------------
# Monkeysphere Validation Agent, Perl version
# Marginal User Interface for reasonable prompting
# Copyright © 2010 Daniel Kahn Gillmor <dkg@fifthhorseman.net>,
#                  Matthew James Goins <mjgoins@openflows.com>,
#                  Jameson Graef Rollins <jrollins@finestructure.net>,
#                  Elliot Winard <enw@caveteen.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#----------------------------------------------------------------------

{ package Crypt::Monkeysphere::MSVA::Logger;

  use strict;
  use warnings;

  # Net::Server log_level goes from 0 to 4
  # this is scaled to match.
  my %loglevels = (
                   'silent' => 0,
                   'quiet' => 0.25,
                   'fatal' => 0.5,
                   'error' => 1,
                   'info' => 2,
                   'verbose' => 3,
                   'debug' => 4,
                   'debug1' => 4,
                   'debug2' => 5,
                   'debug3' => 6,
                  );

  sub log {
    my $self = shift;
    my $msglevel = shift;

    if ($loglevels{lc($msglevel)} <= $self->{loglevel}) {
      printf STDERR @_;
    }
  };

  sub get_log_level {
    my $self = shift;

    return $self->{loglevel};
  }
  sub set_log_level {
    my $self = shift;
    my $loglevel = shift;
    my $logval = $loglevels{lc($loglevel)};

    if (defined($logval)) {
      $self->{loglevel} = $logval;
    } else {
      $self->log('error', "Invalid log level: '%s' (log level not changed)\n", $loglevel);
    }
  }
  sub more_verbose {
    my $self = shift;
    my $increment = shift;

    $increment = 1
      if (!defined $increment);
    $self->{loglevel} += $increment;
  }

  # let the user test to see if we're noisier than this level
  # directly:
  sub is_logging_at {
    my $self = shift;
    my $qlevel = shift;

    return ($loglevels{lc($qlevel)} <= $self->{loglevel});
  }

  sub new {
    my $class = shift;
    my $loglevel = shift;

    my $self = {loglevel => $loglevels{lc($loglevel)}};
    $self->{loglevel} = $loglevels{error}
      if (!defined $self->{loglevel});

    bless ($self, $class);
    return $self;
  }

  1;
}
