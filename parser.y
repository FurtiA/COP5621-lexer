%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);

void yyerror(const char *s);
%}

%token TRUE FALSE AND OR NOT LET INT BOOL DIV MOD GET_BOOL
%token DEFINE_FUN PRINT GET_INT IF LPAREN RPAREN
%token PLUS MINUS TIMES EQUALS LESS LESS_EQ GREATER GREATER_EQ
%token IDENTIFIER NUMBER

%%
program
    : define_fun program
    | print
    ;

define_fun
    : '(' DEFINE_FUN IDENTIFIER '(' param_list ')' type expr ')'
    ;

param_list
    : /* empty */
    | param param_list
    ;

param
    : IDENTIFIER type
    ;

print
    : '(' PRINT expr ')'
    ;

type
    : INT
    | BOOL
    ;

expr
    : term
    | fla
    ;

term
    : NUMBER
    | IDENTIFIER
    | '(' GET_INT ')'
    | '(' PLUS term term_list ')'
    | '(' TIMES term term_list ')'
    | '(' MINUS term term ')'
    | '(' DIV term term ')'
    | '(' MOD term term ')'
    | '(' IF fla term term ')'
    | '(' IDENTIFIER expr_list ')'
    | '(' LET '(' IDENTIFIER expr ')' term ')'
    ;

term_list
    : term
    | term term_list
 ;

fla
    : TRUE
    | FALSE
    | IDENTIFIER
    | '(' GET_BOOL ')'
    | '(' EQUALS term term ')'
    | '(' LESS term term ')'
    | '(' LESS_EQ term term ')'
    | '(' GREATER term term ')'
    | '(' GREATER_EQ term term ')'
    | '(' NOT fla ')'
    | '(' AND fla fla_list ')'
    | '(' OR fla fla_list ')'
    | '(' IF fla fla fla ')'
    | '(' IDENTIFIER expr_list ')'
    | '(' LET '(' IDENTIFIER expr ')' fla ')'
    ;

fla_list
    : fla
    | fla fla_list
    ;

expr_list
    : /* empty */
    | expr expr_list
    ;

%%

void yyerror(const char *s) {
    fprintf("5s\n", s);
}
int main() {
    return yyparse();
}
