%{
#include <stdio.h>
#include<math.h>
extern FILE * yyin; 
void yyerror(char *);
int lineno;
%}
%token NUM
%token EOL
%token SP
%token INC
%token OP
%token id
%token KW
%token ASSIGN
%%

E: S {printf("\nSyntactically Correct!");}; 

S: LOOP S| IF S| STMT1 S| STMT2 S| SEP S| ELSE S |;

LOOP: KW SP id ASSIGN id SP id OP id SP id INC SP | KW SP id OP id SP {printf("LOOP");lineno++;};
IF: KW SP id OP id SP {printf("IF CONDITION");lineno++;};
STMT1: id ASSIGN id OP id SP {printf("STATEMENT");lineno++;};
STMT2: id ASSIGN id SP {printf("STATEMENT");lineno++;};
ELSE: KW {lineno++;};
SEP: SP {lineno++;}
;

%%
int main(){
    char ch;
    if( !(yyin = fopen("in.txt","r")) ){ 
        printf("cannot open file\n");exit(1);
    }
    yyparse();
    return(1);
}
void yyerror(char* str)
{
    printf("\nSyntax Error! Error at line %d\n",lineno+1);
}