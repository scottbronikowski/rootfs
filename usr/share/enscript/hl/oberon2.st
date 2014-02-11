/**
 * Name: oberon2
 * Description: Oberon 2 Programming Language.
 * Author: Brent Fulgham <bfulgham@debian.org>
 */

oberon2_builtins =
/* Builtins */
  /\b(CONST|IMPORT)\b/;

oberon2_types =
/* Types */
  /\b(ARRAY|B(OOLEAN|YTE)|CHAR|INTEGER|LONG(|INT|REAL)|MODULE|NIL\
|P(OINTER|ROCEDURE)|RE(AL|CORD)|SHORT(|INT))\b/;
  
oberon2_keywords =
/* Keywords */
  /\b(A(BS|ND|SH)|BEGIN|C(A(P|SE)|HR)|D(O|EC|IV)\
|E(LS(E|IF)|N(D|TIER)|X(CL|IT))|F(ALSE|OR)|HALT|I(F|S|N(|C(|L)))\
|L(EN|OOP)|M(AX|IN|OD)|NEW|O(F|DD|R(|D))|S(ET|IZE)|T(HEN|O|RUE|YPE)\
|UNTIL|RE(PEAT|TURN)|VAR|W(HILE|ITH))\b/;

state oberon2_comment extends Highlight
{
  /\*\)/ {
    language_print ($0);
    return;
  }
}

state oberon2 extends HighlightEntry
{
  /* Comments. */
  /\(\*/ {
    comment_face (true);
    language_print ($0);
    call (oberon2_comment);
    comment_face (false);
  }

  /* Keywords. */
  oberon2_keywords {
    keyword_face (true);
    language_print ($0);
    keyword_face (false);
  }

  /* Types. */
  oberon2_types {
    type_face (true);
    language_print ($0);
    type_face (false);
  }

  /* Structure support */
  oberon2_builtins {
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
  /\->|>|>=|:=|<=|#|=|!|::|\+|\-|\^|\/|\*|\|/ {
    reference_face (true);
    language_print ($0);
    reference_face (false);
  }

  /*
   * Function definitions, with args
   * fct_name (args...) is
   */
  /([ \t]*PROCEDURE[ \t]+)(\w+)([ \t]*)/ {
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

  /([ \t]*END[ \t]+)(\w+)([ \t]*[;\.])/ {
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
