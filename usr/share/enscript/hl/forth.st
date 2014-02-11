/**
 * Name: forth
 * Description: Forth Programming Language.
 * Author: Brent Fulgham <bfulgham@debian.org>
 */

forth_builtins =
/* builtins */
  /\b(abort|bye|c(atch|o(ld|ntext))|d(rop|up)|f(d(rop|up)|nip|o(r(get|th)|ver)|rot\
|s(eal|wap)|tuck)|include|l(ink|oad)|n(ip|eeds)|o(rder|ver)|pick|ro(ll|t)|swap|t(hrow|uck)\
|within|2(drop|nip|dup|over|tuck|swap|rot)|3dup|4dup\
)\b/;

forth_types =
/* types */
  /\b(base|c(ell|har)|decimal|float|hex)\b/;
  
forth_keywords =
/* keywords */
  /\b(a(bs|gain|head|lso|nd)|begin|c(ase|onstant)|d(abs|efinitions|m(ax|in)|negate|o(|ne))\
|e(lse|nd(|case|if|of)|xit)|f(a(bs|cos(|h)|log|sin(|h)|tan(|2|h))|cos(|h)|exp(|m1)|l(n(|p1)\
|o(g|or)|s(in(|cos|h)|qrt)|tan(|h))|m(ax|in)|negate|or|round|sqrt)|h(ere|old)|i(f|nvert)\
|l(eave|oop)|m(ax|in|od)|n(e(gate|xt)|ot)|o(f|nly|r)|r(epeat|oot)|s(eal|ign)|then\
|un(til|loop)|v(ariable|oc(abulary|s))|while|xor\
)\b/;

state forth extends HighlightEntry
{
  /* Comments. */
  /\\\\/ {
    comment_face (true);
    language_print ($0);
    call (eat_one_line);
    comment_face (false);
  }

  /* keywords. */
  forth_keywords {
    keyword_face (true);
    language_print ($0);
    keyword_face (false);
  }

  /* Types. */
  forth_types {
    type_face (true);
    language_print ($0);
    type_face (false);
  }

  /* Builtins support */
  forth_builtins {
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

  /* character constants. */
  /'.'|'\\\\.'/ {
    string_face (true);
    language_print ($0);
    string_face (false);
  }

  /* symbols, etc. */
  />|>=|<=|<>|!|\+|\-|\^|\/|\*|\|/ {
    reference_face (true);
    language_print ($0);
    reference_face (false);
  }

  /*
   * function definitions, with args
   * fct_name (args...) is
   */
  /^(:[ \t]+)([^ ^\t]+)([ \t]*)/ {
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

