%{
#include <stdio.h>
#include<math.h>
void yyerror(char *);
%}
%left '+' '-'
%left '*' '/'
%right '^'
%left '(' ')'
%token NUM
%token EOL
%%

S:E EOL{printf("%d\n",$$);return;}
;
E:E'+'E     {$$=$1+$3;}
| E'-'E      {$$=$1-$3;}
| E'*'E      {$$=$1*$3;}
| E'/'E      {$$=$1/$3;}
| E'^'E  {$$=pow($1,$3);}
|'('E')' {$$=$2;} 
;
E:NUM {$$=$1;}
;


%%
int main(){
    yyparse();
    return(1);
}
void yyerror(char* str)
{
    printf("%s",str);
}