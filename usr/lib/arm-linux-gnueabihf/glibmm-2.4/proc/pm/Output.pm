# Gtkmmproc Output module
#
# Copyright 2001 Free Software Foundation
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.
#
package Output;
use strict;
use open IO => ":utf8";

use DocsParser;

BEGIN { @Namespace::ISA=qw(main); }

# $objOutputter new()
sub new
{
  my ($m4path, $macrodirs) = @_;
  my $self = {};
  bless $self;

  $$self{out} = [];

  $$self{source} = "";
  $$self{tmpdir} = File::Spec->tmpdir();
  $$self{destdir} = "";
  $$self{objDefsParser} = undef; # It will be set in set_defsparser()

  $$self{m4path} = $m4path;
  $$self{m4args} = "-I";
  $$self{m4args} .= join(" -I", @$macrodirs);

  return $self;
}

sub set_defsparser($$)
{
  my ($self, $objDefsParser) = @_;

  $$self{objDefsParser} = $objDefsParser; #Remember it so that we can use it in our output methods.
}

sub m4args_append($$)
{
  my ($self, $str) = @_;
  $$self{m4args} .= $str;
}

sub append($$)
{
  my ($self, $str) = @_;

  push(@{$$self{out}}, $str);
}

# void output_wrap_failed($cname, $error)
# Puts a comment in the header about the error during code-generation.
sub output_wrap_failed($$$)
{
  my ($self, $cname, $error) = @_;

  my $str = sprintf("//gtkmmproc error: %s : %s", $cname, $error);
  print STDERR "Output.pm: $cname : $error\n";
  $self->append($str);
}

sub error
{
  my $format=shift @_;
  printf STDERR "Output.pm: $format",@_;
}

sub ifdef($$)
{
  my ($self, $ifdef) = @_;
  if ($ifdef)
  {
    $self->append("\n#ifdef $ifdef\n");
  }
}

sub endif($$)
{
  my ($self, $ifdef) = @_;
  if ($ifdef)
  {
    $self->append("\n#endif // $ifdef\n");
  }
}

### Convert _WRAP to a virtual 
# _VFUNC_H(signame,rettype,`<cppargs>')
# _VFUNC_PH(gtkname,crettype,cargs and names)
# void output_wrap_vfunc_h($filename, $line_num, $objCppfunc, $objCDefsFunc)
sub output_wrap_vfunc_h($$$$$$)
{
  my ($self, $filename, $line_num, $objCppfunc, $objCDefsFunc, $ifdef) = @_;

#Old code. We removed _VFUNC_H from the .m4 file
#  my $str = sprintf("_VFUNC_H(%s,%s,\`%s\',%s)dnl\n",
#    $$objCppfunc{name},
#    $$objCppfunc{rettype},
#    $objCppfunc->args_types_and_names(),
#    $objCppfunc->get_is_const()
#   );
#  $self->append($str);

  my $cppVfuncDecl = "virtual " . $$objCppfunc{rettype} . " " . $$objCppfunc{name} . "(" . $objCppfunc->args_types_and_names() . ")";
  if($objCppfunc->get_is_const())
  {
    $cppVfuncDecl .= " const";
  }

  $self->ifdef($ifdef);
  $self->append("  $cppVfuncDecl;\n");
  $self->endif($ifdef);

  #The default callback, which will call *_vfunc, which will then call the base default callback.
  #Declares the callback in the private *Class class and sets it in the class_init function.

  my $str = sprintf("_VFUNC_PH(%s,%s,\`%s\',%s)dnl\n",
    $$objCDefsFunc{name},
    $$objCDefsFunc{rettype},
    $objCDefsFunc->args_types_and_names(),
    $ifdef
   );
  $self->append($str);
}

# _VFUNC_CC(signame,gtkname,rettype,crettype,`<cppargs>',`<cargs>')
sub output_wrap_vfunc_cc($$$$$$$)
{
  my ($self, $filename, $line_num, $objCppfunc, $objCFunc,
      $custom_vfunc, $custom_vfunc_callback, $ifdef) = @_;

  my $cname = $$objCFunc{name};

  # e.g. Gtk::Button::draw_indicator:

  #Use a different macro for Interfaces, to generate an extra convenience method.

  if (!$custom_vfunc)
  {
    my $refreturn = "";
    $refreturn = "refreturn" if($$objCppfunc{rettype_needs_ref});

    my $str = sprintf("_VFUNC_CC(%s,%s,%s,%s,\`%s\',\`%s\',%s,%s,%s)dnl\n",
      $$objCppfunc{name},
      $cname,
      $$objCppfunc{rettype},
      $$objCFunc{rettype},
      $objCppfunc->args_types_and_names(),
      convert_args_cpp_to_c($objCppfunc, $objCFunc, 0, $line_num), #$objCppfunc->args_names_only(),
      $objCppfunc->get_is_const(),
      $refreturn,
      $ifdef);

    $self->append($str);
  }

  # e.g. Gtk::ButtonClass::draw_indicator():

  if (!$custom_vfunc_callback)
  {
    my $refreturn_ctype = "";
    $refreturn_ctype = "refreturn_ctype" if($$objCFunc{rettype_needs_ref});

    my $str = sprintf("_VFUNC_PCC(%s,%s,%s,%s,\`%s\',\`%s\',\`%s\',%s,%s,%s)dnl\n",
      $$objCppfunc{name},
      $cname,
      $$objCppfunc{rettype},
      $$objCFunc{rettype},
      $objCFunc->args_types_and_names(),
      $objCFunc->args_names_only(),
      convert_args_c_to_cpp($objCFunc, $objCppfunc, $line_num),
      ${$objCFunc->get_param_names()}[0],
      $refreturn_ctype,
      $ifdef);

    $self->append($str);
  }
}

### Convert _WRAP to a signal
# _SIGNAL_H(signame,rettype, `<cppargs>', ifdef)
# _SIGNAL_PH(gtkname,crettype, cargs and names, ifdef, deprecated)
# void output_wrap_default_signal_handler_h($filename, $line_num, $objCppfunc,
#      $objCDefsFunc, $ifdef, $deprecated)
sub output_wrap_default_signal_handler_h($$$$$$$)
{
  my ($self, $filename, $line_num, $objCppfunc, $objCDefsFunc, $ifdef, $deprecated) = @_;

  # The default signal handler is a virtual function.
  # It's not hidden by deprecation, since that would break ABI.
  my $str = sprintf("_SIGNAL_H(%s,%s,\`%s\',%s)dnl\n",
    $$objCppfunc{name},
    $$objCppfunc{rettype},
    $objCppfunc->args_types_and_names(),
    $ifdef
   );
  $self->append($str);


  #The default callback, which will call on_* or the base default callback.
  #Declares the callback in the private *Class class and sets it in the class_init function.
  #This is hidden by deprecation.
  $str = sprintf("_SIGNAL_PH(%s,%s,\`%s\',%s,%s)dnl\n",
    $$objCDefsFunc{name},
    $$objCDefsFunc{rettype},
    $objCDefsFunc->args_types_and_names(),
    $ifdef,
    $deprecated
   );
  $self->append($str);
}

# _SIGNAL_CC(signame, gtkname, rettype, crettype,`<cppargs>',`<cargs>', const, refreturn, ifdef)
sub output_wrap_default_signal_handler_cc($$$$$$$$$)
{
  my ($self, $filename, $line_num, $objCppfunc, $objDefsSignal, $bImplement,
      $bCustomCCallback, $bRefreturn, $ifdef, $deprecated) = @_;
  my $cname = $$objDefsSignal{name};
  # $cname = $1 if ($args[3] =~ /"(.*)"/); #TODO: What's this about?

  # e.g. Gtk::Button::on_clicked:
  if($bImplement eq 1)
  {
    my $refreturn = "";
    $refreturn = "refreturn" if($bRefreturn eq 1);

    # The default signal handler is a virtual function.
    # It's not hidden by deprecation, since that would break ABI.
    my $str = sprintf("_SIGNAL_CC(%s,%s,%s,%s,\`%s\',\`%s\',%s,%s,%s)dnl\n",
      $$objCppfunc{name},
      $cname,
      $$objCppfunc{rettype},
      $$objDefsSignal{rettype},
      $objCppfunc->args_types_and_names(),
      convert_args_cpp_to_c($objCppfunc, $objDefsSignal, 0, $line_num), #$objCppfunc->args_names_only(),
      $$objCppfunc{const},
      $refreturn,
      $ifdef);
    $self->append($str);
  }


  # e.g. Gtk::ButtonClass::on_clicked():

  #Callbacks always take the object instance as the first argument:
#  my $arglist_names = "object";
#  my $arglist_names_extra = $objDefsSignal->args_names_only();
#  if ($arglist_names_extra)
#  {
#    $arglist_names .= ", ";
#    $arglist_names .= $arglist_names_extra;
#  }

  if($bCustomCCallback ne 1)
  {
    #This is hidden by deprecation.
    my $str = sprintf("_SIGNAL_PCC(%s,%s,%s,%s,\`%s\',\`%s\',\`%s\',\`%s\',%s,%s)dnl\n",
      $$objCppfunc{name},
      $cname,
      $$objCppfunc{rettype},
      $$objDefsSignal{rettype},
      $objDefsSignal->args_types_and_names(),
      $objDefsSignal->args_names_only(),
      convert_args_c_to_cpp($objDefsSignal, $objCppfunc, $line_num),
      ${$objDefsSignal->get_param_names()}[0],
      $ifdef,
      $deprecated);
    $self->append($str);
  }
}

### Convert _WRAP to a method
#  _METHOD(cppname,cname,cpprettype,crettype,arglist,cargs,const)
#  void output_wrap_meth($filename, $line_num, $objCppFunc, $objCDefsFunc, $cppMethodDecl, $documentation, $ifdef)
sub output_wrap_meth($$$$$$$)
{
  my ($self, $filename, $line_num, $objCppfunc, $objCDefsFunc, $cppMethodDecl, $documentation, $ifdef) = @_;
  my $objDefsParser = $$self{objDefsParser};

  my $cpp_param_names = $$objCppfunc{param_names};
  my $cpp_param_types = $$objCppfunc{param_types};
  my $cpp_param_mappings = $$objCppfunc{param_mappings};

  my $num_args_list = $objCppfunc->get_num_possible_args_list();

  my $output_var_name;
  my $output_var_type;

  if(defined($$cpp_param_mappings{"OUT"}))
  {
    $output_var_name = $$cpp_param_names[$$cpp_param_mappings{"OUT"}];
    $output_var_type = $$cpp_param_types[$$cpp_param_mappings{"OUT"}];
  }

  for(my $arg_list = 0; $arg_list < $num_args_list; $arg_list++)
  {
    # Allow the generated .h/.cc code to have an #ifndef around it, and add
    # deprecation docs to the generated documentation.
    my $deprecated = "";
    if($$objCDefsFunc{deprecated})
    {
      $deprecated = "deprecated";
    }

    #Declaration:
    if($deprecated ne "")
    {
      $self->append("\n_DEPRECATE_IFDEF_START");
    }

    if($arg_list == 0)
    {
      # Doxygen documentation before the method declaration:
      $self->output_wrap_meth_docs_only($filename, $line_num, $documentation);
    }
    else
    {
      $self->append("\n\n  /// A $$objCppfunc{name}() convenience overload.\n");
    }

    $self->ifdef($ifdef);

    $self->append("  " . $objCppfunc->get_declaration($arg_list));

    $self->endif($ifdef);


    if($deprecated ne "")
    {
      $self->append("\n_DEPRECATE_IFDEF_END\n");
    }

    my $refneeded = "";
    if($$objCDefsFunc{rettype_needs_ref})
    {
      $refneeded = "refreturn"
    }

    my $errthrow = "";
    if($$objCDefsFunc{throw_any_errors})
    {
      $errthrow = "errthrow"
    }

    my $constversion = ""; #Whether it is just a const overload (so it can reuse code)
    if($$objCDefsFunc{constversion})
    {
      $constversion = "constversion"
    }

    #Implementation:
    my $str;
    if ($$objCppfunc{static}) {
      $str = sprintf("_STATIC_METHOD(%s,%s,`%s\',%s,\`%s\',\`%s\',%s,%s,%s,%s,%s,%s,%s)dnl\n",
        $$objCppfunc{name},
        $$objCDefsFunc{c_name},
        $$objCppfunc{rettype},
        $objCDefsFunc->get_return_type_for_methods(),
        $objCppfunc->args_types_and_names($arg_list),
        convert_args_cpp_to_c($objCppfunc, $objCDefsFunc, 1, $line_num,
          $errthrow, $arg_list), #1 means it's static, so it has 'object'.
        $refneeded,
        $errthrow,
        $deprecated,
        $ifdef,
        $output_var_name,
        $output_var_type,
        $line_num
        );
    } else {
      $str = sprintf("_METHOD(%s,%s,`%s\',%s,\`%s\',\`%s\',%s,%s,%s,%s,%s,\`%s\',%s,%s,%s,%s)dnl\n",
        $$objCppfunc{name},
        $$objCDefsFunc{c_name},
        $$objCppfunc{rettype},
        $objCDefsFunc->get_return_type_for_methods(),
        $objCppfunc->args_types_and_names($arg_list),
        convert_args_cpp_to_c($objCppfunc, $objCDefsFunc, 0, $line_num,
          $errthrow, $arg_list),
        $$objCppfunc{const},
        $refneeded,
        $errthrow,
        $deprecated,
        $constversion,
        $objCppfunc->args_names_only($arg_list),
        $ifdef,
        $output_var_name,
        $output_var_type,
        $line_num
        );
    }
    $self->append($str);
  }
}

### Convert _WRAP to a method
#  _METHOD(cppname,cname,cpprettype,crettype,arglist,cargs,const)
#  void output_wrap_meth($filename, $line_num, $documentation)
sub output_wrap_meth_docs_only($$$$)
{
  my ($self, $filename, $line_num, $documentation) = @_;
  my $objDefsParser = $$self{objDefsParser};

  # Doxygen documentation before the method declaration:
  $self->append("\n${documentation}");
}

### Convert _WRAP_CTOR to a ctor
#  _METHOD(cppname,cname,cpprettype,crettype,arglist,cargs,const)
#  void output_wrap_ctor($filename, $line_num, $objCppFunc, $objCDefsFunc, $cppMethodDecl)
sub output_wrap_ctor($$$$$)
{
  my ($self, $filename, $line_num, $objCppfunc, $objCDefsFunc, $cppMethodDecl) = @_;
  my $objDefsParser = $$self{objDefsParser};

  my $num_args_list = $objCppfunc->get_num_possible_args_list();

  for(my $arg_list = 0; $arg_list < $num_args_list; $arg_list++)
  {
    if ($arg_list > 0)
    {
      $self->append("\n\n  /// A $$objCppfunc{name}() convenience overload.\n");
    }

    #Ctor Declaration:
    #TODO: Add explicit.
    $self->append("  explicit " . $objCppfunc->get_declaration($arg_list) . "\n");

    #Implementation:
    my $str = sprintf("_CTOR_IMPL(%s,%s,\`%s\',\`%s\')dnl\n",
      $$objCppfunc{name},
      $$objCDefsFunc{c_name},
      $objCppfunc->args_types_and_names($arg_list),
      get_ctor_properties($objCppfunc, $objCDefsFunc, $line_num, $arg_list)
    );

    $self->append($str);
  }
}

sub output_wrap_create($$$)
{
  my ($self, $args_type_and_name_with_default_values, $objWrapParser) = @_;

  #Re-use Function in a very hacky way, to separate the argument types_and_names.
  my $fake_decl = "void fake_func(" . $args_type_and_name_with_default_values . ")";

  my $objFunction = &Function::new($fake_decl, $objWrapParser);

  my $num_args_list = $objFunction->get_num_possible_args_list();

  for(my $arg_list = 0; $arg_list < $num_args_list; $arg_list++)
  {
    my $args_names_only = $objFunction->args_names_only($arg_list);
    my $args_type_and_name_hpp =
      $objFunction->args_types_and_names_with_default_values($arg_list);
    my $args_type_and_name_cpp = $objFunction->args_types_and_names($arg_list);

    if ($arg_list > 0) {
      $self->append("\n  /// A create() convenience overload.");
    }

    my $str = sprintf("_CREATE_METHOD(\`%s\',\`%s\',\`%s\')dnl\n",
                $args_type_and_name_hpp, , $args_type_and_name_cpp, $args_names_only);

    $self->append($str)
  }
}

# void output_wrap_sig_decl($filename, $line_num, $objCSignal, $objCppfunc, $signal_name, $bCustomCCallback, $ifdef, $merge_doxycomment_with_previous, $deprecated, $deprecation_docs)
# custom_signalproxy_name is "" when no type conversion is required - a normal templates SignalProxy will be used instead.
sub output_wrap_sig_decl($$$$$$$$$$)
{
  my ($self, $filename, $line_num, $objCSignal, $objCppfunc, $signal_name, $bCustomCCallback, $ifdef, $merge_doxycomment_with_previous, $deprecated, $deprecation_docs) = @_;

# _SIGNAL_PROXY(c_signal_name, c_return_type, `<c_arg_types_and_names>',
#               cpp_signal_name, cpp_return_type, `<cpp_arg_types>',`<c_args_to_cpp>',
#               refdoc_comment)

  # Get the signal name with underscores only (to look up docs -- they are
  # stored that way).
  my $underscored_signal_name = $signal_name;
  $underscored_signal_name =~ s/-/_/g;

  # Get the existing signal documentation from the parsed docs.
  my $documentation =
    DocsParser::lookup_documentation("$$objCSignal{class}::$underscored_signal_name", $deprecation_docs);

  # Create a merged Doxygen comment block for the signal from the looked up
  # docs (the block will also contain a prototype of the slot as an example).
  my $doxycomment = $objCppfunc->get_refdoc_comment($documentation);

  # If there was already a previous doxygen comment, we want to merge this
  # one with the previous so it is one big comment. If it were two separate
  # comments, doxygen would ignore the first one. If
  # $merge_doxycomment_with_previous is nonzero, the first comment is
  # already open but not yet closed.
  if($merge_doxycomment_with_previous)
  {
    # Strip leading whitespace
    $doxycomment =~ s/^\s+//;

    # We don't have something to add, so just close the comment.
    if($doxycomment eq "")
    {
      $doxycomment = "   */";
    }
    else
    {
      # Append the new comment, but remove the first three leading characters
      # (which are /**) that mark the beginning of the comment.
      $doxycomment = substr($doxycomment, 3);
      $doxycomment =~ s/^\s+//;
      $doxycomment = "   " . $doxycomment;
    }
  }

  my $str = sprintf("_SIGNAL_PROXY(%s,%s,\`%s\',%s,%s,\`%s\',\`%s\',\`%s\',\`%s\',%s)dnl\n",
    $signal_name,
    $$objCSignal{rettype},
    $objCSignal->args_types_and_names_without_object(),
    $$objCppfunc{name},
    $$objCppfunc{rettype},
    $objCppfunc->args_types_only(),
    convert_args_c_to_cpp($objCSignal, $objCppfunc, $line_num),
    $bCustomCCallback, #When this is true, it will not write the *_callback implementation for you.
    $deprecated,
    $doxycomment,
    $ifdef
  );

  $self->append($str);
}

# void output_wrap_enum($filename, $line_num, $cpp_type, $c_type, $comment, @flags)
sub output_wrap_enum($$$$$$$)
{
  my ($self, $filename, $line_num, $cpp_type, $c_type, $comment, @flags) = @_;

  my $objEnum = GtkDefs::lookup_enum($c_type);
  if(!$objEnum)
  {
    $self->output_wrap_failed($c_type, "enum defs lookup failed.");
    return;
  }

  $objEnum->beautify_values();

  my $no_gtype = "";
  my $elements = $objEnum->build_element_list(\@flags, \$no_gtype, "  ");

  if(!$elements)
  {
    $self->output_wrap_failed($c_type, "unknown _WRAP_ENUM() flag");
    return;
  }

  my $value_suffix = "Enum";
  $value_suffix = "Flags" if($$objEnum{flags});

  my $str = sprintf("_ENUM(%s,%s,%s,\`%s\',\`%s\',\`%s\')dnl\n",
    $cpp_type,
    $c_type,
    $value_suffix,
    $elements,
    $no_gtype,
    $comment
  );

  $self->append($str);
}

# void output_wrap_gerror($filename, $line_num, $cpp_type, $c_enum, $domain, @flags)
sub output_wrap_gerror($$$$$$$)
{
  my ($self, $filename, $line_num, $cpp_type, $c_enum, $domain, @flags) = @_;

  my $objDefsParser = $$self{objDefsParser};

  my $objEnum = GtkDefs::lookup_enum($c_enum);
  if(!$objEnum)
  {
    $self->output_wrap_failed($c_enum, "enum defs lookup failed.");
    return;
  }

  # Shouldn't happen, and if it does, I'd like to know that.
  warn if($$objEnum{flags});

  $objEnum->beautify_values();

  # cut off the module prefix, e.g. GDK_
  my $prefix = $domain;
  $prefix =~ s/^[^_]+_//;

  # Chop off the domain prefix, because we put the enum into the class.
  unshift(@flags, "s#^${prefix}_##");

  my $no_gtype = "";
  my $elements = $objEnum->build_element_list(\@flags, \$no_gtype, "    ");

  my $str = sprintf("_GERROR(%s,%s,%s,\`%s\',%s)dnl\n",
    $cpp_type,
    $c_enum,
    $domain,
    $elements,
    $no_gtype
  );

  $self->append($str);
}

# _PROPERTY_PROXY(name, cpp_type)
# void output_wrap_property($filename, $line_num, $name, $cpp_type, $deprecated, $deprecation_docs)
sub output_wrap_property($$$$$$$$)
{
  my ($self, $filename, $line_num, $name, $cpp_type, $c_class, $deprecated, $deprecation_docs) = @_;

  my $objDefsParser = $$self{objDefsParser};

  my $objProperty = GtkDefs::lookup_property($c_class, $name);
  if($objProperty eq 0) #If the lookup failed:
  {
    $self->output_wrap_failed($name, "property defs lookup failed.");
  }
  else
  {
    # We use a suffix to specify a particular Glib::PropertyProxy* class.
    my $proxy_suffix = "";

    # Read/Write:
    if($objProperty->get_construct_only() eq 1)
    {
      # construct-only functions can be read, but not written.
      $proxy_suffix = "_ReadOnly";

      if($objProperty->get_readable() ne 1)
      {
        $self->output_wrap_failed($name, "attempt to wrap write-only and construct-only property.");
        return;
      }
    }
    elsif($objProperty->get_readable() ne 1)
    {
      $proxy_suffix = "_WriteOnly";
    }
    elsif($objProperty->get_writable() ne 1)
    {
       $proxy_suffix = "_ReadOnly";
    }

    # Convert - to _ so we can use it in C++ method and variable names:
    my $name_underscored = $name;
    $name_underscored =~ tr/-/_/;

    # Get the property documentation, if any, and add m4 quotes.
    my $documentation = $objProperty->get_docs($deprecation_docs);
    add_m4_quotes(\$documentation) if ($documentation ne "");

    #Declaration:
    if($deprecated ne "")
    {
      $self->append("\n_DEPRECATE_IFDEF_START\n");
    }
    
    my $str = sprintf("_PROPERTY_PROXY(%s,%s,%s,%s,%s,`%s')dnl\n",
      $name,
      $name_underscored,
      $cpp_type,
      $proxy_suffix,
      $deprecated,
      $documentation
    );
    $self->append($str);
    $self->append("\n");

    # If the property is not already read-only, and the property can be read,
    # then add a second const accessor for a read-only propertyproxy:
    if( ($proxy_suffix ne "_ReadOnly") && ($objProperty->get_readable()) )
    {
      my $str = sprintf("_PROPERTY_PROXY(%s,%s,%s,%s,%s,`%s')dnl\n",
        $name,
        $name_underscored,
        $cpp_type,
        "_ReadOnly",
        $deprecated,
        $documentation
      );
      $self->append($str);
    }
    
    if($deprecated ne "")
    {
      $self->append("\n_DEPRECATE_IFDEF_END");
    }
  }
}

sub add_m4_quotes($)
{
  my ($text) = @_;

  # __BT__ and __FT__ are M4 macros defined in the base.m4 file that produce
  # a "`" and a "'" resp. without M4 errors.
  my %m4_quotes = (
    "`" => "'__BT__`",
    "'" => "'__FT__`",
  );

  $$text =~ s/([`'])/$m4_quotes{$1}/g;
  $$text = "`" . $$text . "'";
}

# vpod output_temp_g1($filename, $section) e.g. output_temp_g1(button, gtk)
sub output_temp_g1($$)
{
  my ($self, $section) = @_;

  # Write out *.g1 temporary file
  open(FILE, '>', "$$self{tmpdir}/gtkmmproc_$$.g1");  # $$ is the Process ID

  print FILE "include(base.m4)dnl\n";

  my $module = $section;
  my $module_canonical = Util::string_canonical($module); #In case there is a / character in the module.
  print FILE "_START($$self{source},$module,$module_canonical)dnl\n";
  print FILE join("", @{$$self{out}});
  print FILE "_END()\n";
  close(FILE);
}

sub make_g2_from_g1($)
{
  my ($self) = @_;

  # Execute m4 to get *.g2 file:
  system("$$self{m4path} $$self{m4args} \"$$self{tmpdir}/gtkmmproc_$$.g1\" > \"$$self{tmpdir}/gtkmmproc_$$.g2\"");
  return ($? >> 8);
}

# void write_sections_to_files()
# This is where we snip the /tmp/gtkmmproc*.g2 file into sections (,h, .cc, _private.h)
sub write_sections_to_files()
{
  my ($self) = @_;

  my $fname_h  = "$$self{destdir}/$$self{source}.h";
  my $fname_ph = "$$self{destdir}/private/$$self{source}_p.h";
  my $fname_cc = "$$self{destdir}/$$self{source}.cc";

  open(INPUT, '<', "$$self{tmpdir}/gtkmmproc_$$.g2"); # $$ is the process ID.

  # open temporary file for each section
  open(OUTPUT_H,  '>', "$fname_h.tmp");
  open(OUTPUT_PH, '>', "$fname_ph.tmp");
  open(OUTPUT_CC, '>', "$fname_cc.tmp");

  my $oldfh = select(OUTPUT_H);
  my $blank = 0;

  while(<INPUT>)
  {
    # section switching
    if(/^#S 0/) { select(OUTPUT_H);  next; }
    if(/^#S 1/) { select(OUTPUT_PH); next; }
    if(/^#S 2/) { select(OUTPUT_CC); next; }

    # get rid of bogus blank lines
    if(/^\s*$/) { ++$blank; } else { $blank = 0; }
    next if($blank > 2);

    print $_;
  }

  select($oldfh);
  close(INPUT);
  close(OUTPUT_H);
  close(OUTPUT_PH);
  close(OUTPUT_CC);

  foreach($fname_h, $fname_ph, $fname_cc)
  {
    # overwrite the source file only if it has actually changed

    # Win32 does fail at this, so we do the two steps separately:
    #system("cmp -s '$_.tmp' '$_' || cp '$_.tmp' '$_'" ; rm -f '$_.tmp');

    system("cmp -s '$_.tmp' '$_' || cp '$_.tmp' '$_'");
    system("rm -f '$_.tmp'");
  }
}


sub remove_temp_files($)
{
  my ($self) = @_;

  system("rm -f \"$$self{tmpdir}/gtkmmproc_$$.g1\"");
  system("rm -f \"$$self{tmpdir}/gtkmmproc_$$.g2\"");
}



# procedure for generating CONVERT macros
# $string convert_args_cpp_to_c($objCppfunc, $objCDefsFunc, $static, $wrap_line_number,$automatic_error, $index = 0)
# The optional index specifies which arg list out of the possible combination
# of arguments based on whether any arguments are optional. index = 0 ==> all
# the arguments.
sub convert_args_cpp_to_c($$$$$)
{
  my ($objCppfunc, $objCDefsFunc, $static, $wrap_line_number, $automatic_error, $index) = @_;

  $automatic_error = "" unless defined $automatic_error;
  $index = 0 unless defined $index;

  my $cpp_param_names = $$objCppfunc{param_names};
  my $cpp_param_types = $$objCppfunc{param_types};
  my $cpp_param_optional = $$objCppfunc{param_optional};
  my $cpp_param_mappings = $$objCppfunc{param_mappings};
  my $c_param_types = $$objCDefsFunc{param_types};
  my $c_param_names = $$objCDefsFunc{param_names};

  my @result;

  my $num_c_args_expected = scalar(@{$c_param_types});
  if( !($static) ) { $num_c_args_expected--; } #The cpp method will need an Object* paramater at the start.

  my $num_cpp_args = scalar(@{$cpp_param_types});

  my $has_output_param = 0;
  my $output_param_index;

  # See if there is an output parameter.  If so, temporarily decrement the
  # number of C++ arguments so that the possible GError addition works and
  # note the existence.
  if(defined($$cpp_param_mappings{"OUT"}))
  {
    $num_cpp_args--;
    $has_output_param = 1;
    $output_param_index = $$cpp_param_mappings{"OUT"};
  }

  # add implicit last error parameter;
  if ( $automatic_error ne "" &&
       $num_cpp_args == ($num_c_args_expected - 1) &&
       ${$c_param_types}[-1] eq "GError**" )
  {
    $num_cpp_args++;
    $cpp_param_names = [@{$cpp_param_names},"gerror"];
    $cpp_param_types = [@{$cpp_param_types},"GError*&"];
    $cpp_param_optional = [@{$cpp_param_optional}, 0];

    # Map from the C gerror param name to the newly added C++ param index.
    # The correct C++ index to map to (from the C name) depends on if there
    # is an output parameter since it will be readded.
    my $cpp_index = $num_cpp_args - 1;
    $cpp_index++ if($has_output_param);
    $$cpp_param_mappings{@$c_param_names[$num_c_args_expected]} = $cpp_index;
  }

  if ( $num_cpp_args != $num_c_args_expected )
  {
    Output::error( "convert_args_cpp_to_c(): Incorrect number of arguments. (%d != %d)\n",
             $num_cpp_args,
             $num_c_args_expected );
    $objCppfunc->dump();
    $objCDefsFunc->dump();

    return "";
  }

  # If there is an output variable it must be processed so re-increment (now)
  # the number of C++ arguments.
  $num_cpp_args++ if($has_output_param);

  # Get the desired argument list combination.
  my $possible_arg_list = $$objCppfunc{possible_args_list}[$index];

  # Loop through the parameters:
  my $i;
  my $cpp_param_max = $num_cpp_args;
  # if( !($static) ) { $cpp_param_max++; }

  for ($i = 0; $i < $cpp_param_max; $i++)
  {
    # Skip the output parameter because it is handled in output_wrap_meth().
    next if($has_output_param && $i == $output_param_index);

    #index of C parameter:
    my $iCParam = $i;
    if( !($static) ) { $iCParam++; }

    # Account for a possible C++ output param in the C++ arg list.
    $iCParam-- if($has_output_param && $i > $output_param_index);

    my $c_param_name = @$c_param_names[$iCParam];
    my $cpp_param_index = $i;
    $cpp_param_index = $$cpp_param_mappings{$c_param_name} if(defined($$cpp_param_mappings{$c_param_name}));

    my $cppParamType = $$cpp_param_types[$cpp_param_index];
    $cppParamType =~ s/ &/&/g; #Remove space between type and &
    $cppParamType =~ s/ \*/*/g; #Remove space between type and *

    my $cppParamName = $$cpp_param_names[$cpp_param_index];
    my $cParamType = $$c_param_types[$iCParam];

    if(!($possible_arg_list =~ /\b$cpp_param_index\b/))
    {
      # If the C++ index is not found in the list of desired parameters, pass
      # NULL to the C func unless the param is not optional (applies to a
      # possibly added GError parameter).
      if ($$cpp_param_optional[$cpp_param_index])
      {
        push(@result, "0");
        next;
      }
    }

    if ($cppParamType ne $cParamType) #If a type conversion is needed.
    {


      push(@result, sprintf("_CONVERT(%s,%s,%s,%s)",
                  $cppParamType,
                  $cParamType,
                  $cppParamName,
                  $wrap_line_number) );
    }
    else
    {
      push(@result, $cppParamName);
    }
  }

  return join(", ", @result);
}

# procedure for generating CONVERT macros
# Ignores the first C 'self' argument.
# $string convert_args_c_to_cpp($objCDefsFunc, $objCppFunc, $wrap_line_number)
sub convert_args_c_to_cpp($$$)
{
  my ($objCDefsFunc, $objCppfunc, $wrap_line_number) = @_;

  my $cpp_param_types = $$objCppfunc{param_types};
  my $c_param_types = $$objCDefsFunc{param_types};
  my $c_param_names = $$objCDefsFunc{param_names};

  my @result;

  my $num_c_args = scalar(@{$c_param_types});

  my $num_cpp_args = scalar(@{$cpp_param_types});

  if ( ($num_cpp_args + 1) !=  $num_c_args )
  {
    Output::error( "convert_args_c_to_cpp(): Incorrect number of arguments. (%d != %d)\n",
             $num_cpp_args + 1,
             $num_c_args);
    $objCppfunc->dump();
    $objCDefsFunc->dump();

    return "";
  }


  # Loop through the c parameters:
 my $i;
 my $c_param_max = $num_c_args;

 for ($i = 1; $i < $c_param_max; $i++)
 {
   #index of C parameter:
   my $iCppParam = $i - 1;

   my $cppParamType = $$cpp_param_types[$iCppParam];
   $cppParamType =~ s/ &/&/g; #Remove space between type and &.
   $cppParamType =~ s/ \*/*/g; #Remove space between type and *

   my $cParamName = $$c_param_names[$i];
   my $cParamType = $$c_param_types[$i];

   if ($cParamType ne $cppParamType) #If a type conversion is needed.
   {
     push(@result, sprintf("_CONVERT(%s,%s,%s,%s)\n",
                  $cParamType,
                  $cppParamType,
                  $cParamName,
                  $wrap_line_number) );
    }
    else
    {
      push(@result, $cParamName);
    }
  }

  return join(", ",@result);
}


# generates the XXX in g_object_new(get_type(), XXX): A list of property names and values.
# Uses the cpp arg name as the property name.
# The optional index specifies which arg list out of the possible combination
# of arguments based on whether any arguments are optional. index = 0 ==> all
# the arguments.
# $string get_ctor_properties($objCppfunc, $objCDefsFunc, $wrap_line_number, $index = 0)
sub get_ctor_properties($$$$$)
{
  my ($objCppfunc, $objCDefsFunc, $wrap_line_number, $index) = @_;

  $index = 0 unless defined $index;

  my $cpp_param_names = $$objCppfunc{param_names};
  my $cpp_param_types = $$objCppfunc{param_types};
  my $cpp_param_optional = $$objCppfunc{param_optional};
  my $cpp_param_mappings = $$objCppfunc{param_mappings};
  my $c_param_types = $$objCDefsFunc{param_types};
  my $c_param_names = $$objCDefsFunc{param_names};

  my @result;

  my $num_args = scalar(@{$c_param_types});

  my $num_cpp_args = scalar(@{$cpp_param_types});
  if ( $num_cpp_args != $num_args )
  {
    Output::error("get_ctor_properties(): Incorrect number of arguments. (%d != %d)\n",
             $num_cpp_args,
             $num_args );
    return "";
  }


  # Get the desired argument list combination.
  my $possible_arg_list = $$objCppfunc{possible_args_list}[$index];

  # Loop through the parameters:
  my $i = 0;

  for ($i = 0; $i < $num_args; $i++)
  {
    my $c_param_name = @$c_param_names[$i];
    my $cpp_param_index = $i;
    $cpp_param_index = $$cpp_param_mappings{$c_param_name} if(defined($$cpp_param_mappings{$c_param_name}));

    my $cppParamType = $$cpp_param_types[$cpp_param_index];
    $cppParamType =~ s/ &/&/g; #Remove space between type and &
    $cppParamType =~ s/ \*/*/g; #Remove space between type and *

    my $cppParamName = $$cpp_param_names[$cpp_param_index];
    my $cParamType = $$c_param_types[$i];

    # Property name:
    push(@result, "\"" . $cppParamName . "\"");

    if(!($possible_arg_list =~ /\b$cpp_param_index\b/))
    {
      # If the C++ index is not found in the list of desired parameters, pass
      # NULL to the C func unless the param is not optional.
      if ($$cpp_param_optional[$cpp_param_index])
      {
        push(@result, "0");
        next;
      }
    }

   # C property value:
    if ($cppParamType ne $cParamType) #If a type conversion is needed.
    {
      push(@result, sprintf("_CONVERT(%s,%s,%s,%s)",
                  $cppParamType,
                  $cParamType,
                  $cppParamName,
                  $wrap_line_number) );
    }
    else
    {
      push(@result, $cppParamName);
    }
  }

  return join(", ", @result);
}

### Convert _WRAP to a corba method
# _CORBA_METHOD(retype, method_name,args, arg_names_only) - implemented in libbonobomm.
#  void output_wrap_corba_method($filename, $line_num, $objCppFunc)
sub output_wrap_corba_method($$$$)
{
  my ($self, $filename, $line_num, $objCppfunc) = @_;

  my $str = sprintf("_CORBA_METHOD(%s,%s,\`%s\',\`%s\')dnl\n",
      $$objCppfunc{rettype},
      $$objCppfunc{name},
      $objCppfunc->args_types_and_names(),
      $objCppfunc->args_names_only()
   );

  $self->append($str);
}

sub output_implements_interface($$)
{
  my ($self, $interface, $ifdef) = @_;

  my $str = sprintf("_IMPLEMENTS_INTERFACE_CC(%s, %s)dnl\n",
      $interface,
      $ifdef);

  $self->append($str);
}

1; # indicate proper module load.
