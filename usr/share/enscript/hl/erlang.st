/**
  * Name: erlang
  * Description: Erlang programming language.
  * Author: Sean Hinde 
  */


/* Erlang atom: ([a-z][a-zA-Z0-9_]*|\'[^\n]*\') */

state erlang extends HighlightEntry
{
   /* Comments */
   /%/ {
     comment_face (true);
     language_print ($0);
     call (eat_one_line);
     comment_face (false);
   }

   /* String constants. */
   /\"/ {
     string_face (true);
     language_print ($0);
     call (c_string);
     string_face (false);
   }

   /* Special -record(rec_name, {}).  pre-processor case */
   /(-record)(\([ \t]*)([a-z][a-zA-Z0-9_]*|\'[^\n]*\')/ {
     reference_face (true);
     language_print ($1);
     reference_face (false);
     language_print ($2);
     type_face (true);
     language_print ($3);
     type_face (false);
   }

   /* Special -define(Alter, "Hello").  pre-processor case */
   /(-define)(\([ 
\t]*)([a-z][a-zA-Z0-9_]*|\'[^\n]*\'|[A-Z_][a-zA-Z0-9_]*)/ {
     reference_face (true);
     language_print ($1);
     reference_face (false);
     language_print ($2);
     builtin_face (true);
     language_print ($3);
     builtin_face (false);
   }

   /* Pre-processor lines. */
   /^-([a-z][a-zA-Z0-9_]*)/ {
     reference_face (true);
     language_print ($0);
     reference_face (false);
   }

   /* Defines */
   /(\?)([a-z][a-zA-Z0-9_]*|\'[^\n]*\'|[A-Z_][a-zA-Z0-9_]*)/ {
     language_print ($1);
     builtin_face (true);
     language_print ($2);
     builtin_face (false);
   }

   /* Records */
   /(#)([a-z][a-zA-Z0-9_]*|\'[^\n]*\')/ {
     language_print ($1);
     type_face (true);
     language_print ($2);
     type_face (false);
   }

   /* Keywords.
      '(after begin case try catch end fun if of receive when)
      Regexp taken from emacs Erlang mode R9C
   */
   /\b(a(fter|ndalso)|begin|c(atch|ase)\
|end|fun|if|o(f|relse)|receive|try|when\
|query)\b/ {
     keyword_face (true);
     language_print ($0);
     keyword_face (false);
   }

   /* Guards.
    Regexp taken from emacs Erlang mode R9C
   */
   /\b((is_)*(atom|function|binary|constant|float\
|integer|list|number|p(id|ort)\
|re(ference|cord)|tuple))\b/ {
     builtin_face (true);
     language_print ($0);
     builtin_face (false);
   }

   /* Built in functions */

/\b(a(bs|live|pply|tom_to_list)\
|binary_to_(list|term)\
|concat_binary|d(ate|isconnect_node)\
|e(lement|rase|xit)\
|float(|_to_list)\
|g(arbage_collect|et(|_keys)|roup_leader)\
|h(alt|d)\
|i(nte(ger_to_list|rnal_bif)|s_alive)\
|l(ength|i(nk|st_to_(atom|binary|float|integer\
|pid|tuple)))\
|make_ref|no(de(|_(link|unlink)|s)|talive)\
|open_port\
|p(id_to_list|rocess(_(flag|info)|es)|ut)\
|r(egister(|ed)|ound)\
|s(e(lf|telement)|ize\
|p(awn(|_link)|lit_binary)|tatistics)\
|t(erm_to_binary|hrow|ime|l\
|r(ace|unc)|uple_to_list)\
|un(link|register)|whereis)\b/ {
     keyword_face (true);
     language_print ($0);
     keyword_face (false);
   }

   /*
    * Function definitions.
    */
   /^([a-z][a-zA-Z0-9_]*|'[^\n]*')/ {
     function_name_face (true);
     language_print ($1);
     function_name_face (false);
     language_print ($2);
   }

   /* Atom like strings */
   /('[^\n]*')/ {
     string_face (true);
     language_print ($0);
     string_face (false);
   }

   /* Characters */
   /(\$.)/ {
     string_face (true);
     language_print ($0);
     string_face (false);
   }

   /* Variable Names */
   /*  /([\{\(\,\[ \t]+)([A-Z_][a-zA-Z0-9_]*)/ { */
   /([^a-z0-9_\"])([A-Z_][a-zA-Z0-9_]*)/ {
     language_print ($1);
     variable_name_face (true);
     language_print ($2);
     variable_name_face (false);
   }
}

/*
Local variables:
mode: erlang
End:
*/
