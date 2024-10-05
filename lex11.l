%{
#include "y.tab.h"
#include <stdio.h>
%}

%%

"true"          { return TRUE; }
"false"         { return FALSE; }
"and"           { return AND; }
"or"            { return OR; }
"not"           { return NOT; }
"let"           { return LET; }
"int"           { return INT; }
"bool"          { return BOOL; }
"div"           { return DIV; }
"mod"           { return MOD; }
"get-bool"      { return GET_BOOL; }
"define-fun"    { return DEFINE_FUN; }
"print"         { return PRINT; }
"get-int"       { return GET_INT; }
"if"            { return IF; }

"("             { return LPAREN; }
")"             { return RPAREN; }
"+"             { return PLUS; }
"*"             { return TIMES; }
"-"             { return MINUS; }
"="             { return EQUALS; }
"<"             { return LESS; }
"<="            { return LESS_EQ; }
">"             { return GREATER; }
">="            { return GREATER_EQ; }

[a-zA-Z][a-zA-Z0-9]*  { return IDENTIFIER; }
[0-9]+          { return NUMBER; }

[ \t\n]+        ; /* ignore whitespace */

.               { printf("Lexical error: unexpected character %s\n", yytext); }

%%

int yywrap(void) {
    return 1;
}
