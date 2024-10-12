%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"

int yylex(void);
void yyerror(const char *s);
%}

%token BOOLEAN_CONSTANTS BOOLEAN_OPERATORS LOCAL_VAR_DECLARATION VARIABLE_FUNCTION_TYPES ARITHMETIC_OPERATIONS PREDEFINED_FUNCTION

%%
program: define_fun program
       | print_expr
       ;

define_fun: "(define-fun" fun "(" var type_list ")" type expr ")"
          ;

print_expr: "(print" expr ")"
           ;

type_list: type_list type
          | /* empty */
          ;

type: VARIABLE_FUNCTION_TYPES
    ;

expr: term
    | "(if" fla term term ")"
    | "(fun" expr ")"
    | "(let" "(" var expr ")" term ")"
    ;

term: const
    | var
    | "(get-int)"
    | "(+" term term ")"
    | "(-" term term ")"
    | "(div" term term ")"
    | "(mod" term term ")"
    ;

fla: BOOLEAN_CONSTANTS
   | var
   | "(get-bool)"
   | "(=" term term ")"
   | "(<" term term ")"
   | "(<=" term term ")"
   | "(>" term term ")"
   | "(>=" term term ")"
   | "(not" fla ")"
   | "(and" fla fla ")"
   | "(or" fla fla ")"
   | "(if" fla fla fla ")"
   ;

%% 

int main(void) {
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Syntax error: %s\n", s);
}