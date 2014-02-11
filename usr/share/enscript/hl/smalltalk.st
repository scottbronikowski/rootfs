/**
 * Name: Smalltalk
 * Description: Smalltalk Programming Language.
 * Author: Brent Fulgham <bfulgham@debian.org>
 */

smalltalk_keywords =
/* Keywords */
  /\b(class|false|inspect|isNil|new|nil|not(|Nil)|out|s(elf|uper)|true\
|do|whileTrue|whileFalse|ifTrue|ifFalse|put|to|at|add|new\
|for)\b/ ;

state smalltalk_quot_string extends Highlight
{
  /\\\\./ {
    language_print ($0);
  }
  /[\']/ {
    language_print ($0);
    return;
  }
}

state smalltalk extends HighlightEntry
{

  /* Comments. */
  /\"/ {
    comment_face (true);
    language_print ($0);
    call (c_string);
    comment_face (false);
  }

  /* Keywords. */
  smalltalk_keywords {
    keyword_face (true);
    language_print ($0);
    keyword_face (false);
  }

  /* Declarations */
  /[ \t]*\|.*\|/ {
    type_face (true);
    language_print ($0);
    type_face (false);
  }

  /* String constants. */
  /[\']/ {
    string_face (true);
    language_print ($0);
    call (smalltalk_quot_string);
    string_face (false);
  } 

  /* Symbols, etc. */
  /:=|>|>=|==|<=|<>|=|!|::|@|\+|\-|\^|\/|\*|\||\[|\]/ {
    reference_face (true);
    language_print ($0);
    reference_face (false);
  }

  /*
   * Function definitions, with args
   * fct_name (args...) is
   */
  /([ \t]*)(\w+)(:[ \t]*)/ {
    keyword_face (true);
    language_print ($1);
    keyword_face (false);
    function_name_face (true);
    face_on(face_bold);
    language_print ($2);
    face_off(face_bold);
    function_name_face (false);
    language_print ($3);
  }

}
