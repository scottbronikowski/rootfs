/**
 * Name: icon
 * Description: Icon Programming Language.
 * Author: Brent Fulgham <bfulgham@debian.org>
 */

icon_builtins =
/* Builtins */
  /\b(break|create|default|fail|initial|l(ink|ocal)|not|s(tatic|uspend))\b/;

icon_types =
/* Types */
  /\b(char|error|function|integer|proc|procedure|real|variable)\b/;
  
icon_keywords =
/* Keywords */
  /\b(a(bs|cos|ny|rgs|sin|tan)|b(al|y)|c(a(llout|se)|enter|hdir|lose|o(llect|py|s)|set)\
|d(e(lay|lete|tab|isplay|tor)|o)|e(lse|n(d|tab)|rrorclear|very|xit|xp)|f(ind|lush)\
|get(|ch|che|env)|i(and|com|f|mage|nsert|or|shift|xor)|k(bhit|ey)|l(eft|ist|o(adfunc|g))\
|m(a(ny|p|tch)|ember|ove)|n(ame|ext|umeric)|o(f|pen|rd)|p(op|os|ull|ush|ut)\
|r(e(ad(|s)|move|name|p(eat|l)|turn|verse)|ight|tod|unerr)|s(ave|eek|eq|et|in|ort(|f)\
|qrt|top|tring|ystem)|t(a(b(|le)|n)|hen|o|rim|ype)|u(ntil|pto)|w(h(ere|ile)|rite(|s))\
)\b/;

state icon extends HighlightEntry
{
  /* Comments. */
  /#/ {
    comment_face (true);
    language_print ($0);
    call (eat_one_line);
    comment_face (false);
  }

  /* Keywords. */
  icon_keywords {
    keyword_face (true);
    language_print ($0);
    keyword_face (false);
  }

  /* Types. */
  icon_types {
    type_face (true);
    language_print ($0);
    type_face (false);
  }

  /* Structure support */
  icon_builtins {
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
  />|>=|:=|<=|#|=+|!|::|\+|\-|\^|\/|\*|\|/ {
    reference_face (true);
    language_print ($0);
    reference_face (false);
  }

  /*
   * Function definitions, with args
   * fct_name (args...) is
   */
  /([ \t]*procedure[ \t]+)(\w+)([ \t]*)/ {
    keyword_face (true);
    language_print ($1);
    keyword_face (false);
    function_name_face (true);
    face_on(face_bold_italic);
    language_print ($2);
    face_off(face_bold_italic);
    function_name_face (false);
    language_print ($3);
  }
}
