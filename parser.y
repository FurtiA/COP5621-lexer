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
program:
    | program define_fun
    | program print_expr
    ;

define_fun:
    "(define-fun" VAR "(" params ")" type expr ")"
    {
        // Function definition handling (optional)
    }
    ;

params:
    | params VAR type
    ;

print_expr:
    "(print" expr ")"
    ;

type:
    INT
    | BOOL
    ;

expr:
    term
    | expr '+' term
    | expr '-' term
    | expr '*' term
    | expr DIV term
    | expr MOD term
    | '(if' fla term term ')'
    | '(fun' expr* ')'
    | '(let' '(' VAR expr ')' term ')'
    ;

term:
    CONST
    | VAR
    | '(get-int)'
    ;

fla:
    TRUE
    | FALSE
    | VAR
    | '(get-bool)'
    | '(= ' term term ')'
    | '(<' term term ')'
    | '(<= ' term term ')'
    | '(>' term term ')'
    | '(>= ' term term ')'
    | '(not' fla ')'
    | '(and' fla fla ')'
    | '(or' fla fla ')'
    | '(if' fla fla fla ')'
    | '(fun' expr* ')'
    | '(let' '(' VAR expr ')' fla ')'
    ;

%%

void yyerror(const char *s) {
    fprintf("5s\n", s);
}
int main() {
    return yyparse();
}
