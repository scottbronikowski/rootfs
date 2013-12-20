#  You may distribute under the terms of either the GNU General Public License
#  or the Artistic License (the same terms as Perl itself)
#
#  (C) Paul Evans, 2011 -- leonerd@leonerd.org.uk

package CPS::Future;

use strict;
use warnings;

our $VERSION = '0.12';

use Carp;

=head1 NAME

C<CPS::Future> - represent an operation awaiting completion

=head1 SYNOPSIS

 my $future = CPS::Future->new;
 $future->on_ready( sub {
    say "The operation is complete";
 } );

 kperform_some_operation( sub {
    $future->done( @_ );
 } );

=head1 DESCRIPTION

An C<CPS::Future> object represents an operation that is currently in
progress, or has recently completed. It can be used in a variety of ways to
manage the flow of control, and data, through an asynchronous program.

Some futures represent a single operation (returned by the C<new>
constructor), and are explicitly marked as complete by calling the C<done>
method. Others represent a tree of sub-tasks (returned by the C<wait_all>
constructor), and are implicitly marked as complete when all of their
component futures are complete.

It is intended that library functions that perform asynchonous operations
would use C<CPS::Future> objects to represent outstanding operations, and
allow their calling programs to control or wait for these operations to
complete.

=cut

=head1 CONSTRUCTORS

=cut

=head2 $future = CPS::Future->new

Returns a new C<CPS::Future> instance to represent a leaf future. It will be
marked as complete by either of the C<done> or C<fail> methods.

=cut

sub new
{
   my $class = shift;
   return bless { ready => 0 }, $class;
}

=head2 $future = CPS::Future->wait_all( @subfutures )

Returns a new C<CPS::Future> instance that will indicate completion once
all of the sub future objects given to it indicate that they are complete.

=cut

sub wait_all
{
   my $self = shift->new;
   my $result = $self->{result} = [ (undef) x scalar @_ ];
   foreach my $idx ( 0 .. $#_ ) {
      my $sub = $_[$idx];
      $sub->on_ready( sub {
         $result->[$idx] = $_[0]; # capture the child future now ready
         defined $_ or return for @$result;
         $self->_mark_ready;
      } );
   }
   return $self;
}

=head1 METHODS

=cut

=head2 $ready = $future->is_ready

Returns true on a leaf future if a result has been provided to the C<done>
method or failed using the C<fail> method, true on a C<wait_all> future if all
the sub-tasks are ready, or false if it is still waiting.

=cut

sub is_ready
{
   my $self = shift;
   return $self->{ready};
}

=head2 $future->on_ready( $code )

If the future is not yet ready, adds a callback to be invoked when the future
is ready. If the future is already ready, invokes it immediately.

In either case, the callback will be passed the future object itself. The
invoked code can then obtain the list of results by calling the C<get> method.

 $on_ready->( $future )

=cut

sub on_ready
{
   my $self = shift;
   my ( $code ) = @_;

   if( $self->is_ready ) {
      $code->( $self );
   }
   else {
      push @{ $self->{on_ready} }, $code;
   }
}

=head2 $future->done( @result )

Marks that the leaf future is now complete, and provides a list of values as a
result. (The empty list is allowed, and still indicates the future as complete).
Cannot be called on a C<wait_all> future.

=cut

sub done
{
   my $self = shift;
   $self->is_ready and croak "$self is already complete and cannot be ->done twice";
   $self->{result} and croak "$self is not a leaf Future, cannot be ->done";
   $self->{result} = [ @_ ];
   $self->_mark_ready;
}

=head2 $task->fail( $exception )

Marks that the leaf future has failed, and provides an exception value. This
exception will be thrown by the C<get> method if called. If the exception is a
non-reference that does not end in a linefeed, its value will be extended by
the file and line number of the caller, similar to the logic that C<die> uses.

The exception must evaluate as a true value; false exceptions are not allowed.

=cut

sub fail
{
   my $self = shift;
   my ( $exception ) = @_;
   $self->is_ready and croak "$self is already complete and cannot be ->fail'ed";
   $self->{result} and croak "$self is not a leaf Future, cannot be ->fail'ed";
   $_[0] or croak "$self ->fail requires an exception that is true";
   if( !ref $exception and $exception !~ m/\n$/ ) {
      $exception .= sprintf " at %s line %d\n", (caller)[1,2];
   }
   $self->{failure} = $exception;
   $self->_mark_ready;
}

sub _mark_ready
{
   my $self = shift;
   $self->{ready} = 1;
   if( my $on_ready_list = $self->{on_ready} ) {
      $_->( $self ) for @$on_ready_list;
      delete $self->{on_ready}; # To drop references to parent
   }
}

=head2 @result = $future->get

If the future is complete, returns the list of results that had earlier been
given to the C<done> method. If not, will raise an exception.

If called on a C<wait_all> future, it will return a list of the futures it was
waiting on, in the order they were passed to the constructor.

=cut

sub get
{
   my $self = shift;
   $self->is_ready or croak "$self is not yet complete";
   die $self->{failure} if $self->{failure};
   return @{ $self->{result} };
}

=head2 $exception = $task->failure

Returns the exception passed to the C<fail> method, C<undef> if the task
completed successfully via the C<done> method, or raises an exception if
called on a task that is not yet complete.

Because the exception value must be true, this can be used in a simple C<if>
statement:

 if( my $exception = $task->failure ) {
    ...
 }
 else {
    my @result = $task->get;
    ...
 }

=cut

sub failure
{
   my $self = shift;
   $self->is_ready or croak "$self is not yet complete";
   return $self->{failure};
}

=head1 EXAMPLES

The following examples all demonstrate possible uses of a C<CPS::Future>
object to provide a fictional asynchronous API function called simply
C<koperation>.

=head2 Providing Results

By returning a new C<CPS::Future> object each time the asynchronous function
is called, it provides a placeholder for its eventual result, and a way to
indicate when it is complete.

 sub koperation
 {
    my %args = @_;

    my $future = CPS::Future->new;

    kdo_something(
       foo => $args{foo},
       on_done => sub { $future->done( @_ ); },
    );
 }

The caller may then use this future to wait for a result using the C<on_ready>
method, and obtain the result using C<get>.

 my $f = koperation( foo => "something" );

 $f->on_ready( sub {
    my $f = shift;
    say "The operation returned: ", $f->get;
 } );

=head2 Indicating Success or Failure

Because the stored exception value of a failued C<CPS::Future> may not be
false, the C<failure> method can be used in a conditional statement to detect
success or failure.

 my $f = koperation( foo => "something" );

 $f->on_ready( sub {
    my $f = shift;
    if( not my $e = $f->failure ) {
       say "The operation succeeded with: ", $f->get;
    }
    else {
       say "The operation failed with: ", $e;
    }
 } );

By using C<not> in the condition, the order of the C<if> blocks can be
arranged to put the successful case first, similar to a C<try>/C<catch> block.

Because the C<get> method re-raises the passed exception if the future failed,
it can be used to control a C<try>/C<catch> block directly. (This is sometimes
called I<Exception Hoisting>).

 use Try::Tiny;

 $f->on_ready( sub {
    my $f = shift;
    try {
       say "The operation succeeded with: ", $f->get;
    }
    catch {
       say "The operation failed with: ", $_;
    };
 } );

=head2 Merging Control Flow

A C<wait_all> future may be used to resynchronise control flow, while waiting
for multiple concurrent operations to finish.

 my $f1 = koperation( foo => "something" );
 my $f2 = koperation( bar => "something else" );

 my $f = CPS::Future->wait_all( $f1, $f2 );

 $f->on_ready( sub {
    say "Operations are ready:";
    say "  foo: ", $f1->get;
    say "  bar: ", $f2->get;
 } );

This provides an ability somewhat similar to C<CPS::kpar()> or
L<Async::MergePoint>.

=cut

=head1 TODO

Lots of things still need adding. API or semantics is somewhat unclear in
places.

=over 4

=item *

Allow futures to be cancellable. Give them a C<cancel> method, and some way to
hook code to run to cancel it. Should the canceller blocks accumulate, or
replace each other?

=item *

C<< CPS::Future->needs_all >>, which fails on the first failure of dependent
futures and cancels the outstanding ones.

=item *

C<< CPS::Future->needs_first >>, which succeeds on the first success of
dependent futures and cancels the outstanding ones, only fails if all the
dependents do.

=item *

Some way to do deferred futures that don't even start their operation until
invoked somehow. Ability to chain these together in a sequence, like
C<CPS::kseq()>.

=back

=head1 AUTHOR

Paul Evans <leonerd@leonerd.org.uk>

=cut

0x55AA;
