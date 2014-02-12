#============================================================= -*-Perl-*-
#
# Template::Plugin::XML::View
#
# DESCRIPTION
#   Template Toolkit plugin to parse XML and generate a view by raising
#   events to a Template::View object for each element in the XML source.
#
#   -- UNDER CONSTRUCTION -- NOT INCLUDED IN THE MAIN DISTRIBUTION --
#
# AUTHOR
#   Andy Wardley   <abw@cpan.org>
#
# COPYRIGHT
#   Copyright (C) 2001-2004 Andy Wardley.  All Rights Reserved.
#
#   This module is free software; you can redistribute it and/or
#   modify it under the same terms as Perl itself.
#
# REVISION
#   $Id: View.pm,v 2.4 2003/03/17 22:29:16 abw Exp $
#
#============================================================================

package Template::Plugin::XML::View;

require 5.004;

use strict;
use Template::Plugin;
use XML::Parser;

use base qw( Template::Plugin );
use vars qw( $VERSION $DEBUG $XML_PARSER_ARGS $ELEMENT );

$VERSION = sprintf("%d.%02d", q$Revision: 2.4 $ =~ /(\d+)\.(\d+)/);
$DEBUG   = 0 unless defined $DEBUG;
$XML_PARSER_ARGS = {
    ErrorContext  => 4,
    Namespaces    => 1,
    ParseParamEnt => 1,
    NoExpand      => 1,
};

$ELEMENT = 'Template::Plugin::XML::View::Element';

#------------------------------------------------------------------------
# new($context, $file_or_text, \%config)
#------------------------------------------------------------------------

sub new {
    my $class   = shift;
    my $context = shift;
    my $args    = ref $_[-1] eq 'HASH' ? pop(@_) : { };
    my ($input, $about);

    # determine the input source from a positional parameter (may be a 
    # filename or XML text if it contains a '<' character) or by using
    # named parameters which may specify one of 'file', 'filename', 'text'
    # or 'xml'

    if ($input = shift) {
        if ($input =~ /\</) {
            $about  = 'xml text';
        }
        else {
            $about = "xml file $input";
            $input = $class->file_contents($input);
        }
    }
    elsif ($input = $args->{ text } || $args->{ xml }) {
        $about = 'xml text';
    }
    elsif ($input = $args->{ file } || $args->{ filename }) {
        $about = "xml file $input";
        $input = $class->file_contents($input);
    }
    else {
        $class->throw('no filename or xml text specified');
    }
    
    # munge input to protect entity refs
    $input =~ s/&/&amp;/g;
    
    my $xpargs = {
        map { exists $args->{$_} 
              ? ( $_, $args->{ $_ } )
                  : ( $_, $XML_PARSER_ARGS->{ $_ } ) }
        keys %$XML_PARSER_ARGS,
    };
    
    my $parser = XML::Parser->new(
        %$xpargs,
        Style    => 'Template::Plugin::XML::View::Parser',
        Handlers => {
            Init => sub {
                my $expat = shift;
                DEBUG("[Init]\n") if $DEBUG;
                $expat->{ _TT2_XVIEW_TEXT    }  = '';
                $expat->{ _TT2_XVIEW_RESULT  }  = '';
                $expat->{ _TT2_XVIEW_CONTEXT }  = $context;
                $expat->{ _TT2_XVIEW_STACK   }  = [ ];
            },
        },
    );
    my $result = $parser->parse($input);

    DEBUG("result: $result\n") if $DEBUG;
    return $result;
}


sub file_contents {
    my ($self, $file) = @_;
    my $text;
    local *FP;
    local $/ = undef;
    open(FP, $file) || $self->throw("cannot read XML file $file: $!");
    $text = <FP>;
    close(FP);
    return $text;
}
    

#------------------------------------------------------------------------
# _throw($errmsg)
#
# Raise a Template::Exception of type XML.View via die().
#------------------------------------------------------------------------

sub throw {
    my ($self, $error) = @_;
    die (Template::Exception->new('XML.View', $error));
}

sub DEBUG { print STDERR @_ };


#========================================================================
# Template::Plugin::XML::View::Parser
#
# Package defines subroutines which are called by the XML::Parser
# instance.  They manipulate a stack of T-::P-::XML::View::Element
# objects which each represent nested elements currently under parse
# at any time, with the innermost element object on top of the stack.
# These subs call the element() 
#========================================================================

package Template::Plugin::XML::View::Parser;
use vars qw( $DEBUG $ELEMENT );

*DEBUG   = \*Template::Plugin::XML::View::DEBUG;
$ELEMENT = 'Template::Plugin::XML::View::Element';


sub Start {
    my ($expat, $name, %attr) = @_;
    my $attr = \%attr;

    # flush any character content
    Text($expat) if length $expat->{ _TT2_XVIEW_TEXT };

    if ($DEBUG) {
        my $iattr = join(' ', map { "$_=\"$attr{$_}\"" } keys %attr);
        $attr = " $attr" if $attr;
        DEBUG("[Start] <$name$attr>\n");
    }

    my $stack = $expat->{ _TT2_XVIEW_STACK };

    my $element = $ELEMENT->new($name, \%attr)
        || $stack->[-1]->throw($ELEMENT->error());
    
    push(@$stack, $element);
}

sub End {
    my ($expat, $name) = @_;

    # flush any character content
    Text($expat) if length $expat->{ _TT2_XVIEW_TEXT };

    DEBUG("[End] </$name>\n") if $DEBUG;

    my $stack = $expat->{ _TT2_XVIEW_STACK };
    my $top = pop(@$stack);
    my $end = $top->end($expat, $name)
        || $top->throw($top->error());
    if (@$stack) {
        $stack->[-1]->child($expat, $name, $end);
    }
    else {
        DEBUG("popped last handler off stack\n") if $DEBUG;
#        die "corrupt stack\n";
        $expat->{ _TT2_XVIEW_RESULT } = $end;
    }
}

sub Char {
    my ($expat, $char) = @_;

    DEBUG("[Char] [$char]\n") if $DEBUG;

    # push character content onto buffer
    $expat->{ _TT2_XVIEW_TEXT } .= $char;

}


#------------------------------------------------------------------------
# Text()
#
# This is an extension subroutine which we're using to buffer chunks
# of Char input into complete text blocks.  These then get notified to 
# the parent in one happy bundle rather than several scraggly lumps.
#------------------------------------------------------------------------

sub Text {
    my $expat = shift;
    my $text  = $expat->{ _TT2_XVIEW_TEXT };

    if ($DEBUG) {
        my $dbgtext = $text;
        $dbgtext =~ s/\n/\\n/g;
        DEBUG("[Text] [$dbgtext]\n") if $DEBUG;
    }

    $expat->{ _TT2_XVIEW_STACK }->[-1]->text($expat, $text);
    $expat->{ _TT2_XVIEW_TEXT } = '';
}


sub Final {
    my $expat = shift;
    return $expat->{ _TT2_XVIEW_RESULT } || die "no result\n";

    my $stack = $expat->{ _TT2_XVIEW_STACK };
    my $top = pop(@$stack) || die "corrupt stack in Final";
    my $end = $top->end($expat)
        || $top->throw($top->error());
    my $r = $expat->{ _TT2_XVIEW_RESULT } || die "no result\n";# $end;
    DEBUG("[Final] => [$r]\n") if $DEBUG;
    return $r;
}



#========================================================================
# Template::Plugin::XML::View::Element
#
# Implements a parser handler for representing each element in the 
#========================================================================

package Template::Plugin::XML::View::Element;


sub new {
    my ($class, $name, $attr) = @_;
    bless {
        name    => $name,
        attr    => $attr,
        content => [ ],
    }, $class;
}

# called to receive character content
sub text {
    my $self = shift;
    my $expat = shift;
    push(@{ $self->{ content } }, @_);
}

# called to receive completed child element
sub child {
    my ($self, $expat, $name, $child) = @_;
    push(@{ $self->{ content } }, $child);    
}

# called at end of element
sub end {
    my ($self, $expat, $name) = @_;
    return $self;
}

# generate element as XML
sub xml {
    my $self = shift;
    my $name = $self->{ name };

    # generate XML representation of attributes
    my $attr = $self->{ attr };
    $attr = join(' ', map {
        "$_=\"$attr->{$_}\"";
    } keys %$attr);
    $attr = " $attr" if length $attr;

    # generate XML representation of content
    my $content = $self->{ content };
    $content = join(' ', map {
        ref $_ ? $_->xml() : $_;
    } @$content);

    # generate complete XML element
    return length $content 
        ? "<${name}${attr}>$content</$name>"
        : "<${name}${attr} />";
}


sub present {
    my ($self, $view) = @_;
    my $vars = {
        %$self,
        %{ $self->{ attr } },
        element => $self,
        content => sub { $self->content($view) },
    };
    $view->include($self->{ name }, $vars)
}

sub content {
    my ($self, $view) = @_;
    return $self->{ content } unless $view;
    my $output = '';
    foreach my $node (@{ $self->{ content } }) {
	$output .= ref $node ? $node->present($view) : $node;
    }
    return $output;
}


1;

__END__

