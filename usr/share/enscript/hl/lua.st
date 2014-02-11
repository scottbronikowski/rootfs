/**
 * Name: lua
 * Description: Lua Programming Language template for Enscript.
 * Author: Brent Fulgham <bfulgham@debian.org>
 */

lua_builtins =
/* Builtins */
  /\b(assert|call|foreach|globals|print|require|to(number|string))\b/;

lua_keywords =
/* Keywords */
  /\b(and|break|do|e(nd|lse(|if))|f(alse|or|unction)|i(f|n)|local\
|or|n(il|ot)|re(peat|turn)|t(hen|rue)|until|while\
)\b/;
  
state lua extends HighlightEntry
{

  /* One line comments. */
  /\-\-|^#!/ {
    comment_face (true);
    language_print ($0);
    call (eat_one_line);
    comment_face (false);
  }

  /* Keywords. */
  lua_keywords {
    keyword_face (true);
    language_print ($0);
    keyword_face (false);
  }

  /* Types. */
  lua_builtins {
    type_face (true);
    language_print ($0);
    type_face (false);
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
  /+|-|\*|=|!=|==|<|>|<=|>=|~=|!/ {
    reference_face (true);
    language_print ($0);
    reference_face (false);
  }

  /* Class references */
  /([ \t])*([a-zA-Z]+[, \ta-zA-Z0-9_]*):[^=]/ {
    reference_face (true);
    language_print ($0);
    reference_face (false);
  }
  
  /*
   * Function definitions, with args
   * function fct_name (args...)
   */
  /^([ \t]*function[ \t]+)([a-zA-Z_][a-zA-Z_:0-9]*)([ \t]*)(\([^)]*\)[ \t]*)[ \t]*$/ {
    keyword_face (true);
    language_print ($1);
    keyword_face (false);
    function_name_face (true);
    face_on(face_bold_italic);
    language_print ($2);
    face_off(face_bold_italic);
    function_name_face (false);
    language_print(" ");
    language_print ($3);
    keyword_face (true);
    language_print ($4);
    keyword_face (false);
  }

}
