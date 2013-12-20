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

{ package Crypt::Monkeysphere::MSVA::Monitor;

  use strict;
  use warnings;

  sub createwindow {
    my $self = shift;

    require Gtk2;
    Gtk2->init();
    $self->{dialog} = Gtk2::Dialog->new("Monkeysphere Validation Agent updated!",
                                        undef,
                                        [],
                                        'gtk-no' => 'cancel',
                                        'gtk-yes' => 'ok');

    my $icon_file = '/usr/share/pixmaps/monkeysphere-icon.png';

    $self->{dialog}->set_default_icon_from_file($icon_file)
      if (-r $icon_file);
    $self->{dialog}->set_default_response('ok');
    my $label = Gtk2::Label->new("Some components of the running Monkeysphere
Validation Agent have been updated.

Would you like to restart the validation agent?");
    $label->show();
    $self->{dialog}->get_content_area()->add($label);
    $self->{dialog}->signal_connect(response => sub { my ($dialog,$resp) = @_; $self->button_clicked($resp); });
    $self->{dialog}->signal_connect(delete_event => sub { $self->button_clicked('cancel'); return 1; });
  }

  sub button_clicked {
    my $self = shift;
    my $resp = shift;
    if ($resp eq 'ok') {
      # if the user wants to restart the validation agent, we should terminate
      # so that our parent gets a SIGCHLD.
      exit 0;
    } else {
      $self->{dialog}->hide();
    }
  }

  sub prompt {
    my $self = shift;
    $self->{dialog}->show();
  }

  sub spawn {
    my $self = shift;
    if (! Module::Load::Conditional::can_load('modules' => { 'Gtk2' => undef,
                                                             'AnyEvent' => undef,
                                                             'Linux::Inotify2' => undef,
                                                           })) {
      $self->{logger}->log('info', "Not spawning a monitoring process; issue 'kill -s HUP %d' to restart after upgrades.\nInstall Perl modules Gtk2, AnyEvent, and Linux::Inotify2 for automated restarts on upgrades.\n", $$);
      return;
    }
    my $fork = fork();
    if (! defined $fork) {
      $self->{logger}->log('error', "Failed to spawn monitoring process\n");
      return;
    }
    if ($fork) {
      $self->{monitorpid} = $fork;
      $self->{logger}->log('debug', "spawned monitoring process pid %d\n", $self->{monitorpid});
      return;
    } else {
      $self->childmain();
    }
  }

  sub childmain {
    my $self = shift;

    $0 = 'MSVA (perl) Upgrade Monitor';

    $self->{files} = [ $0, values(%INC) ];
    $self->{logger}->log('debug3', "setting up monitoring on these files:\n%s\n", join("\n", @{$self->{files}}));

    # close all filedescriptors except for std{in,out,err}:
    # see http://markmail.org/message/mlbnvfa7ds25az2u
    close $_ for map { /^(?:ARGV|std(?:err|out|in)|STD(?:ERR|OUT|IN))$/ ? () : *{$::{$_}}{IO} || () } keys %::;

    $self->createwindow();

    require Linux::Inotify2;

    $self->{inotify} = Linux::Inotify2::->new()
      or die "unable to create new inotify object: $!";

    my $flags = 0xc06;
    # FIXME: couldn't figure out how to get these to work in "strict subs" mode:
    # my $flags = Linux::Inotify2::IN_MODIFY |
                # Linux::Inotify2::IN_ATTRIB |
                # Linux::Inotify2::IN_DELETE_SELF |
                # Linux::Inotify2::IN_MOVE_SELF;

    foreach my $file (@{$self->{files}}) {
      $self->{inotify}->watch($file,
                              $flags,
                              sub {
                                $self->prompt();
                              });
    }

    require AnyEvent;
    my $inotify_w = AnyEvent->io (
                                  fh => $self->{inotify}->fileno,
                                  poll => 'r',
                                  cb => sub { $self->changed },
                                 );
    my $w = AnyEvent->signal(signal => 'TERM', cb => sub { exit 1; });

    Gtk2->main();
    $self->{logger}->log('error', "Got to the end of the monitor process somehow\n");
    # if we get here, we want to terminate with non-zero
    exit 1;
  }


  sub changed {
    my $self = shift;

    $self->{logger}->log('debug', "changed!\n");
    $self->{inotify}->poll();
  }

  # forget about cleaning up the monitoring child (e.g. we only want
  # the parent process to know about this)
  sub forget {
    my $self = shift;
    undef $self->{monitorpid};
  }

  sub getchildpid {
    my $self = shift;
    return $self->{monitorpid};
  }

  sub DESTROY {
    my $self = shift;
    if (defined $self->{monitorpid}) {
      kill('TERM', $self->{monitorpid});
      my $oldexit = $?;
      waitpid($self->{monitorpid}, 0);
      $? = $oldexit;
      undef($self->{monitorpid});
    }
  }

  sub new {
    my $class = shift;
    my $logger = shift;

    my $self = { monitorpid => undef,
                 logger => $logger,
               };

    bless ($self, $class);

    $self->spawn();
    return $self;
  }

  1;
}
