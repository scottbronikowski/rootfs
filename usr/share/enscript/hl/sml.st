/**
 * Name: sml
 * Description: Standard ML Programming Language.
 * Author: Brent Fulgham <bfulgham@debian.org>
 */

sml_builtins =
/* Builtins */
  /\b(functor|lambda|s(ig(|nature)|truct(|ure))|NONE|SOME)\b/;

sml_types =
/* Types */
  /\b(\'(a|b|c|d)|array|bool|char|int|list|real|string|unit|vector|word)\b/;
  
sml_keywords =
/* Keywords */
  /\b(a(bs(traction|type)|nd(|also)|s|toi)|before|c(ase|oncat)|d(o|atatype)\
|e(lse|nd|qtype|xception)|f(n|un(|sig))|handle|i(f|n(|clude|fix|fixr))\
|l(et|ocal)|nonfix|o(|f|p(|en)|relse|verload)|print|r(aise|ec|ef)|sharing\
|t(hen|ype)|val|w(h(ere|ile)|ith(|type)))\b/ ;

state sml_comment extends Highlight
{
  /\*\)/ {
    language_print ($0);
    return;
  }
}

state sml extends HighlightEntry
{

  /* Comments. */
  /\(\*/ {
    comment_face (true);
    language_print ($0);
    call (sml_comment);
    comment_face (false);
  }

  /* Keywords. */
  sml_keywords {
    keyword_face (true);
    language_print ($0);
    keyword_face (false);
  }

  /* Types. */
  sml_types {
    type_face (true);
    language_print ($0);
    type_face (false);
  }

  /* Structure support */
  sml_builtins {
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
  /:=|>|>=|==|<=|<>|=|!|::|@|\+|\-|\^|\/|\*|\||\b(quot|rem|div|mod\
|hd|tl)\b/ {
    reference_face (true);
    language_print ($0);
    reference_face (false);
  }

  /*
   * Function definitions, with args
   * fct_name (args...) is
   */
  /([ \t]*f[u]n[ \t]+)(\w+)([ \t]*)/ {
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
