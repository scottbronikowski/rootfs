# Copyrights 2001-2011 by Mark Overmeer.
#  For other contributors see ChangeLog.
# See the manual pages for details on the licensing terms.
# Pod stripped from pm file by OODoc 2.00.
use strict;
use warnings;

package Mail::Message::Field::Attribute;
use vars '$VERSION';
$VERSION = '2.099';

use base 'Mail::Reporter';
use 5.007003;
use Encode ();

use Carp;


sub new($$@)
{   my ($class, $attr) = (shift, shift);
    my $value = @_ % 2 == 1 ? shift : undef;
    $class->SUPER::new(attr => $attr, value => $value, @_);
}

sub init($$)
{   my ($self, $args)  = @_;
    $self->SUPER::init($args);

    my ($attr, $value, $cont) = @$args{ qw/attr value use_continuations/ };

    my $name  = ($attr =~ m/^(.*?)(?:\*\d+)?\*?\=/ ? $1 : $attr);
    $self->log(WARNING => "Illegal character in parameter name '$name'.")
        if $name !~ m/^[!#-'*+\-.0-9A-Z^-~]+$/;

    $self->{MMFF_name}     = $name;
    $self->{MMFF_usecont}  = defined $cont ? $cont : 1;
    $self->{MMFF_charset}  = $args->{charset}  if defined $args->{charset};
    $self->{MMFF_language} = $args->{language} if defined $args->{language};

    $self->value($value)       if defined $value;
    $self->addComponent($attr) unless $attr eq $name;

    $self;
}

#------------------------------------------


sub name() { shift->{MMFF_name} }


sub value(;$)
{   my $self = shift;
    if(@_)
    {   delete $self->{MMFF_cont};
        return $self->{MMFF_value} = shift;
    }
      
    exists $self->{MMFF_value} ? $self->{MMFF_value} : $self->decode;
}


sub addComponent($)
{   my ($self, $component) = @_;
    delete $self->{MMFF_value};

    my ($name, $value) = split /\=/, $component, 2;
    if( substr($name, -1) eq '*' && $value =~ m/^([^']*)\'([^']*)\'/ )
    {   $self->{MMFF_charset}  = length $1 ? $1 : undef;
        $self->{MMFF_language} = length $2 ? $2 : undef;
    }

    if( $name =~ m/\*([0-9]+)\*?$/ )
         { $self->{MMFF_cont}[$1] = $component }
    else { $self->{MMFF_cont}     = [ $component ] }

    $component;
}


sub charset() { shift->{MMFF_charset} }


sub language() { shift->{MMFF_language} }


sub string()
{   my $self = shift;
    my $cont = $self->{MMFF_cont} || $self->encode;
    return @$cont if wantarray;
    return [] unless @$cont;

    local $" = "; ";
    "; @$cont";
}

#------------------------------------------


sub encode()
{   my $self  = shift;
    my $value = $self->{MMFF_value};

    my @lines;
    my ($pre, $encoded);

    my $charset  = $self->{MMFF_charset}  || '';
    my $lang     = $self->{MMFF_language} || '';
    my $name     = $self->{MMFF_name};
    my $cont     = $self->{MMFF_usecont};

    if($charset || $lang)
    {   $pre     = "$name*0*=$charset'$lang'";
        $value   = Encode::encode($charset, $value, 0);
        $encoded = 1;
    }
    elsif(grep m/[^\x20-\x7E]/, $value)
    {   $pre     = "$name*0*=''";
        $encoded = 1;
    }
    else
    {   $pre     = "$name*0=";
        $value   =~ s/"/\\"/g;
        $encoded = 0;
    }

    if($encoded)
    {   # Use encoding
        my @c    = split //, $value;
        while(@c)
        {   my $c = shift @c;
            $c = '%'. sprintf "%02X", ord $c
               unless $c =~ m/[a-zA-Z0-9]/;

            if($cont && length($pre) + length($c)> 76)
            {   push @lines, $pre;
                $pre = $name . '*' . @lines . '*=' . $c;
            }
            else { $pre .= $c }
        }
        push @lines, $pre;
    }
    elsif($cont)
    {   # Simple string, but with continuations
        while(1)
        {   push @lines, $pre.'"'. substr($value, 0, 75-length($pre), '') .'"';
            last unless length $value;
            $pre = $name . '*' . @lines . '=';
        }
            
    }
    else
    {   # Single string only
        push @lines, $pre . $value;
    }

    $lines[0] =~ s/\*0// if @lines==1;
    $self->{MMFF_cont} = \@lines;
}


sub decode()
{   my $self  = shift;
    my $value = '';

    foreach my $cont (  @{$self->{MMFF_cont}} )
    {   unless(defined $cont)
        {   $value .= "[continuation missing]";
            next;
        }

        (my $name, local $_) = split /\=/, $cont, 2;

        if(substr($name, -1) eq '*')
        {   s/^[^']*\'[^']*\'//;
            s/\%([a-fA-F0-9]{2})/chr hex $1/ge;
        }
        elsif( s/^\"(.*)\"$/$1/ ) { s/\\\"/"/g }
        elsif( s/^\'(.*)\'$/$1/ ) { s/\\\'/'/g }

        $value .= $_;
    }

    my $charset = $self->{MMFF_charset};
    $value = Encode::decode($charset, $value, 0) if $charset;

    $self->{MMFF_value} = $value;
}

#------------------------------------------


sub mergeComponent($)
{   my ($self, $comp) = @_;
    my $cont  = $self->{MMFF_cont}
       or croak "ERROR: Too late to merge: value already changed.";

    defined $_ && $self->addComponent($_)
        foreach @{$comp->{MMFF_cont}};

    $self;
}

1;
