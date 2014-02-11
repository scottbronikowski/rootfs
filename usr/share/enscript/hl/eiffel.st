/**
 * Name: eiffel
 * Description: Eiffel programming language.
 * Author: Julien Lemoine <speedblue@happycoders.org>
 *         Brent Fulgham <bfulgham@debian.org>
 */

eiffel_types =
/* Types */
  /\b(ABSTRACT_(FRACTION|INTEGER)|ANY|AR(GUMENTS|RAY(|2|3|ED_COLLECTION))\
|BASIC_(DIRECTORY|TIME)|BINARY_FILE_(READ|WRITE)|BIT_(N|STRING)|BOOLEAN\
|CHARACTER(|_CONSTANTS)|CLOCK|COLLECTION(|2|3|_SORTER)|COMPARABLE\
|COUNTER|DICTIONARY(|_NODE)|D(IRECTORY|OUBLE)|EXCEPTIONS|FILE(|_TOOLS)\
|FIXED_ARRAY(|2|3)|GE(NERAL|N_RAND)|HASH(ABLE|_TABLE_SIZE)|INPUT_STREAM\
|INTEGER(|_8|_16|_32|_64|_FRACTION|_GENERAL)\
|ITERATOR(|_ON_(COLLECTION|DICTIONARY(_ITEMS|_KEYS)|LINKED_LIST|SET\
|STRING|TWO_WAY_LINKED_LIST|UNICODE_STRING))\
|LARGE(|_NEGATIVE|_POSITIVE)_INTEGER|LINK(|2|ED(_COLLECTION|_LIST))\
|MATH_CONSTANTS|MEMO(|RY)|MICROSECOND_TIME|MINI_PARSER_BUFFER\
|MIN_STAND|MUTABLE_BIG_INTEGER|NATIVE_ARRAY|NULL_(INPUT|OUTPUT)\
|NUMBER(|_FRACTION|_TOOLS)|NUMERIC|OUTPUT_STREAM|PLATFORM|POINTER\
|REAL|REVERSE_COLLECTION_SORTER|SAFE_EQUAL|SCOOP_UTILITIES|SET(|_NODE)\
|SMALL_INTEGER|STD_(ERROR|FILE_(READ|READ_WRITE|WRITE)|INPUT(|_OUTPUT)\
|OUTPUT|RAND)|STRING(|_HANDLER)|SYSTEM|TIME(|_IN_(ENGLISH|FRENCH|GERMAN\
|ITALIAN|SOME_LANGUAGE|SPANISH))|TWO_WAY_LINKED_LIST\
|UNICODE_STRING(|_HANDLER)|UTF8_PARSER)\b/;

eiffel_keywords =
/* Keywords */
  /\b(agent|a(ll|lias)|and|as(|sign)|check|class|convert|create|Current|debug\
|deferred|do|else(|if)|en(d|sure)|ex(panded|port|ternal)|False\
|feature|fro(m|zen)|if|implies|in(dexing|fix|herit|spect|variant)\
|is|like|local|loop|not|o(r|bsolete|ld|nce)|prefix|Precursor|pure\
|re(define|ference|name|quire|scue|try)|Result|separate|then|True\
|TUPLE|un(define|til)|creation)\b/;

state eiffel extends HighlightEntry
{

  /* One line comments. */
  /\-\-/ {
    comment_face (true);
    language_print ($0);
    call (eat_one_line);
    comment_face (false);
  }

  /* Keywords. */
  eiffel_keywords {
    keyword_face (true);
    language_print ($0);
    keyword_face (false);
  }

  /* Types. */
  eiffel_types {
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
  /:=|==|<=|>=|=|!=|\/=|!|!!/ {
    reference_face (true);
    language_print ($0);
    reference_face (false);
  }

  /* Type declarations */
  /([ \t])*([a-zA-Z]+[, \ta-zA-Z0-9_]*):[^=]/ {
    reference_face (true);
    language_print ($0);
    reference_face (false);
  }
  

  /*
   * Function definitions, with args
   * fct_name (args...) is
   */
  /^([ \t]*[a-zA-Z_][a-zA-Z_0-9]*[ \t]*)(\([ \t]*[ \ta-z,A-Z_0-9]+)(:[ \ta-zA-Z0-9_\[\]]+)?(\)[ \t]*)(:[ \ta-zA-Z0-9_\[\]]+)?([ \t]+is)[ \t]*$/ {
    function_name_face (true);
    face_on(face_bold_italic);
    language_print ($1);
    face_off(face_bold_italic);
    function_name_face (false);
    language_print ($2);
    type_face (true);
    language_print ($3);
    type_face (false);
    language_print ($4);
    type_face (true);
    language_print ($5);
    type_face (false);
    keyword_face (true);
    language_print ($6);
    keyword_face (false);
    language_print ($7);
  }

  /*
   * Function definitions, without args
   * fct_name is
   */
  /^([ \t]*[a-zA-Z_][a-zA-Z_0-9]*)([ \t]*)(is)[ \t]*$/ {
    function_name_face (true);
    face_on(face_bold_italic);
    language_print ($1);
    face_off(face_bold_italic);
    function_name_face (false);
    language_print(" ");
    keyword_face (true);
    language_print ($3);
    keyword_face (false);
  }

}
