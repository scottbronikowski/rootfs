# Copyrights 2001-2011 by Mark Overmeer.
#  For other contributors see ChangeLog.
# See the manual pages for details on the licensing terms.
# Pod stripped from pm file by OODoc 2.00.
use strict;
use warnings;

package Mail::Message::Field::Full;
use vars '$VERSION';
$VERSION = '2.099';

use base 'Mail::Message::Field';

use utf8;
use Encode ();
use MIME::QuotedPrint ();
use Storable 'dclone';

use Mail::Message::Field::Structured;
use Mail::Message::Field::Unstructured;
use Mail::Message::Field::Addresses;
use Mail::Message::Field::URIs;
use Mail::Message::Field::Date;

my $atext = q[a-zA-Z0-9!#\$%&'*+\-\/=?^_`{|}~];  # from RFC
my $atext_ill = q/\[\]/;     # illegal, but still used (esp spam)


use overload '""' => sub { shift->decodedBody };

#------------------------------------------


my %implementation;

BEGIN {
   $implementation{$_} = 'Addresses'
      for qw/from to sender cc bcc reply-to envelope-to
         resent-from resent-to resent-cc resent-bcc resent-reply-to
         resent-sender
         x-beenthere errors-to mail-follow-up x-loop delivered-to
         original-sender x-original-sender/;
   $implementation{$_} = 'URIs'
      for qw/list-help list-post list-subscribe list-unsubscribe
         list-archive list-owner/;
   $implementation{$_} = 'Structured'
      for qw/content-disposition content-type/;
   $implementation{$_} = 'Date'
      for qw/date resent-date/;
}

sub new($;$$@)
{   my $class  = shift;
    my $name   = shift;
    my $body   = @_ % 2 ? shift : undef;
    my %args   = @_;

    $body      = delete $args{body} if defined $args{body};
    unless(defined $body)
    {   (my $n, $body) = split /\s*\:\s*/s, $name, 2;
        $name = $n if defined $body;
    }
   
    return $class->SUPER::new(%args, name => $name, body => $body)
       if $class ne __PACKAGE__;

    # Look for best class to suit this field
    my $myclass = 'Mail::Message::Field::'
      . ($implementation{lc $name} || 'Unstructured');

    $myclass->SUPER::new(%args, name => $name, body => $body);
}

sub init($)
{   my ($self, $args) = @_;

    $self->SUPER::init($args);
    $self->{MMFF_name}       = $args->{name};

    my $body = $args->{body};

       if(!defined $body || !length $body || ref $body) { ; } # no body yet
    elsif(index($body, "\n") >= 0)
         { $self->foldedBody($body) }        # body is already folded
    else { $self->unfoldedBody($body) }      # body must be folded

    $self;
}

sub clone() { dclone(shift) }
sub name()  { lc shift->{MMFF_name}}
sub Name()  { shift->{MMFF_name}}

sub folded()
{   my $self = shift;
    return $self->{MMFF_name}.':'.$self->foldedBody
        unless wantarray;

    my @lines = $self->foldedBody;
    my $first = $self->{MMFF_name}. ':'. shift @lines;
    ($first, @lines);
}

sub unfoldedBody($;$)
{   my ($self, $body) = (shift, shift);

    if(defined $body)
    {    $self->foldedBody(scalar $self->fold($self->{MMFF_name}, $body));
         return $body;
    }

    $body = $self->foldedBody;
    $body =~ s/^ //;
    $body =~ s/\n//g;
    $body;
}

sub foldedBody($)
{   my ($self, $body) = @_;

    if(@_==2)
    {    $self->parse($body);
         $body =~ s/^\s*/ /;
         $self->{MMFF_body} = $body;
    }
    elsif(defined($body = $self->{MMFF_body})) { ; }
    else
    {   # Create a new folded body from the parts.
        $self->{MMFF_body} = $body
           = $self->fold($self->{MMFF_name}, $self->produceBody);
    }

    wantarray ? (split /^/, $body) : $body;
}

#------------------------------------------


sub from($@)
{   my ($class, $field) = (shift, shift);
    defined $field ?  $class->new($field->Name, $field->foldedBody, @_) : ();
}

#------------------------------------------


sub decodedBody()
{   my $self = shift;
    $self->decode($self->unfoldedBody, @_);
}

#------------------------------------------


sub createComment($@)
{   my ($thing, $comment) = (shift, shift);

    $comment = $thing->encode($comment, @_)
        if @_; # encoding required...

    # Correct dangling parenthesis
    local $_ = $comment;               # work with a copy
    s#\\[()]#xx#g;                     # remove escaped parens
    s#[^()]#x#g;                       # remove other chars
    while( s#\(([^()]*)\)#x$1x# ) {;}  # remove pairs of parens

    substr($comment, CORE::length($_), 0, '\\')
        while s#[()][^()]*$##;         # add escape before remaining parens

    $comment =~ s#\\+$##;              # backslash at end confuses
    "($comment)";
}


sub createPhrase($)
{   my $self = shift;
    local $_ = shift;
    $_ =  $self->encode($_, @_)
        if @_;  # encoding required...

    if( m/[^$atext]/ )
    {   s#\\#\\\\#g;
        s#"#\\"#g;
        $_ = qq["$_"];
    }

    $_;
}


sub beautify() { shift }

#------------------------------------------


sub _mime_word($$) { "$_[0]$_[1]?=" }
sub _encode_b($)   { MIME::Base64::encode_base64(shift, '')  }
sub _encode_q($)
{   my $chunk = shift;
    $chunk =~ s#([\x00-\x1F=\x7F-\xFF])#sprintf "=%02X", ord $1#ge;
    $chunk =~ s#([_\?])#sprintf "=%02X", ord $1#ge;
    $chunk =~ s/ /_/g;
    $chunk;
}

sub encode($@)
{   my ($self, $utf8, %args) = @_;

    my ($charset, $lang, $encoding);

    if($charset = $args{charset})
    {   $self->log(WARNING => "Illegal character in charset '$charset'")
            if $charset =~ m/[\x00-\ ()<>@,;:"\/[\]?.=\\]/;
    }
    else { $charset = 'us-ascii' }

    if($lang = $args{language})
    {   $self->log(WARNING => "Illegal character in language '$lang'")
            if $lang =~ m/[\x00-\ ()<>@,;:"\/[\]?.=\\]/;
    }

    if($encoding = $args{encoding})
    {   unless($encoding =~ m/^[bBqQ]$/ )
        {   $self->log(WARNING => "Illegal encoding '$encoding', used 'q'");
            $encoding = 'q';
        }
    }
    else { $encoding = 'q' }

    return $utf8
        if lc($encoding) eq 'q'
        && $utf8 =~ m/\A[\p{IsASCII}]+\z/ms
        && !$args{force};

    my $pre = '=?'. $charset. ($lang ? '*'.$lang : '') .'?'.$encoding.'?';

    my @result;
    if(lc($encoding) eq 'q')
    {   my $llen = 73 - length $pre;
        my $chunk  = '';
        while(length(my $chr = substr($utf8, 0, 1, '')))
        {   $chr  = _encode_q Encode::encode($charset, $chr, 0);
            if(bytes::length($chunk) + bytes::length($chr) > $llen)
            {   push @result, _mime_word($pre, $chunk);
                $chunk = '';
            }
            $chunk .= $chr;
        }
        push @result, _mime_word($pre, $chunk)
            if length($chunk);
    }
    else
    {    my $llen = int((73 - length($pre)) / 4) * 3;
         my $chunk  = '';
         while(length(my $chr = substr($utf8, 0, 1, '')))
         {   my $chr = Encode::encode($charset, $chr, 0);
             if(bytes::length($chunk) + bytes::length($chr) > $llen)
             {   push @result, _mime_word($pre, _encode_b($chunk));
                 $chunk = '';
             }
             $chunk .= $chr;
        }
        push @result, _mime_word($pre, _encode_b($chunk))
            if length $chunk;
    }

    join ' ', @result;
}


sub _decoder($$$)
{   my ($charset, $encoding, $encoded) = @_;
    $charset   =~ s/\*[^*]+$//;   # language component not used
    my $to_utf8 = Encode::find_encoding($charset || 'us-ascii');
    $to_utf8 or return $encoded;

    my $decoded;
    if($encoding !~ /\S/)
    {   $decoded = $encoded;
    }
    elsif(lc($encoding) eq 'q')
    {   # Quoted-printable encoded
        $encoded =~ s/_/ /g;   # specific to mime-fields
        $decoded = MIME::QuotedPrint::decode_qp($encoded);
    }
    elsif(lc($encoding) eq 'b')
    {   # Base64 encoded
        require MIME::Base64;
        $decoded = MIME::Base64::decode_base64($encoded);
    }
    else
    {   # unknown encodings ignored
        return $encoded;
    }

    $to_utf8->decode($decoded, Encode::FB_DEFAULT);  # error-chars -> '?'
}

sub decode($@)
{   my $self    = shift;
    my @encoded = split /(\=\?[^?\s]*\?[bqBQ]?\?[^?\s]*\?\=)/, shift;
    @encoded or return '';

    my %args    = @_;

    my $is_text = defined $args{is_text} ? $args{is_text} : 1;
    my @decoded = shift @encoded;

    while(@encoded)
    {   shift(@encoded) =~ /\=\?([^?\s]*)\?([^?\s]*)\?([^?\s]*)\?\=/;
        push @decoded, _decoder $1, $2, $3;

        @encoded or last;

        # in text, blanks between encoding must be removed, but otherwise kept
        if($is_text && $encoded[0] !~ m/\S/) { shift @encoded }
        else { push @decoded, shift @encoded }
    }

    join '', @decoded;
}

#------------------------------------------


sub parse($) { shift }


sub consumePhrase($)
{   my ($thing, $string) = @_;

    if($string =~ s/^\s*\" ((?:[^"\r\n\\]*|\\.)*) (?:\"|\s*$)//x )
    {   (my $phrase = $1) =~ s/\\\"/"/g;
        return ($phrase, $string);
    }

    if($string =~ s/^\s*([${atext}${atext_ill}\ \t.]+)//o )
    {   (my $phrase = $1) =~ s/\s+$//;
        return CORE::length($phrase) ? ($phrase, $string) : (undef, $_[1]);
    }

    (undef, $string);
}


sub consumeComment($)
{   my ($thing, $string) = @_;

    return (undef, $string)
        unless $string =~ s/^\s*\(((?:[^)\\]+|\\.)*)\)//;

    my $comment = $1;
    while(1)
    {   (my $count = $comment) =~ s/\\./xx/g;

        last if $count =~ tr/(//  ==  $count =~ tr/)//;

        return (undef, $_[1])
            unless $string =~ s/^((?:[^)\\]+|\\.)*)\)//;

        $comment .= ')'.$1;
    }

    $comment =~ s/\\([()])/$1/g;
    ($comment, $string);
}


sub consumeDotAtom($)
{   my ($self, $string) = @_;
    my ($atom, $comment);

    while(1)
    {   (my $c, $string) = $self->consumeComment($string);
        if(defined $c) { $comment .= $c; next }

        last unless $string =~ s/^\s*([$atext]+(?:\.[$atext]+)*)//o;

        $atom .= $1;
    }

    ($atom, $string, $comment);
}


sub produceBody() { $_[0]->{MMFF_body} }

#------------------------------------------



1;
