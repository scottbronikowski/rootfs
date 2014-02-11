/**
 * Name: oz
 * Description: Mozart/Oz Programming Language.
 * Author: Brent Fulgham <bfulgham@debian.org>
 */

oz_builtins =
/* Builtins */
  /\b(export|import|local|require)\b/;

oz_types =
/* Types */
  /\b(attr|c(lass|atch)|f(eat|unctor)|nil|prop|raise|try)\b/;
  
oz_keywords =
/* Keywords */
  /\b(at|c(ase|hoice|ond)|d(e(clare|fine)|o|is)|e(lse(|case|if|of)|nd)\
|f(inally|or|rom|un)|i(f|n)|lock|meth|not|o(f|r)|p(repare|roc)|then\
|thread)\b/;
  
state oz extends HighlightEntry
{

  /* Comments. */
  /%/ {
    comment_face (true);
    language_print ($0);
    call (eat_one_line);
    comment_face (false);
  }

  /* Keywords. */
  oz_keywords {
    keyword_face (true);
    language_print ($0);
    keyword_face (false);
  }

  /* Types. */
  oz_types {
    type_face (true);
    language_print ($0);
    type_face (false);
  }

  /* Structure support */
  oz_builtins {
    reference_face (true);
    language_print ($0);
    reference_face (false);
  } 

  /* String constants. */
  /\"/ {
    string_face (true);
    language_print ($0);
    call (c_string);
    string_face (false);
  }

  /* Character constants. */
  /'.'|'\\\\.'/ {
    string_face (true);
    language_print ($0);
    string_face (false);
  }

  /* Symbols, etc. */
  /\.\.|=[=]|<\-|\\=|\|/ {
    reference_face (true);
    language_print ($0);
    reference_face (false);
  }

  /*
   * Function definitions, with args
   * fct_name (args...) is
   */
  /([ \t]*\{)(\w+)([\. \t]*)/ {
    language_print ($1);
    function_name_face (true);
    face_on(face_bold_italic);
    language_print ($2);
    face_off(face_bold_italic);
    function_name_face (false);
    language_print ($3);
  }

}
