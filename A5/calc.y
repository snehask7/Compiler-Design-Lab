%{
#include <stdio.h>
#include<math.h>
void yyerror(char *);
%}
%token NUM
%token EOL
%token AND
%token OR
%token XOR
%token LS
%token RS
%token LTE
%token GTE
%token EQ
%token NE
%left AND
%left OR
%left EQ
%left NE
%left '<'
%left '>'
%left LS
%left RS
%left XOR
%left GTE
%left LTE
%left '+' '-'
%left '*' '/'
%right '^'
%left '(' ')'
%%

S:E EOL{printf("%d\n",$$);return;}
;

E:E'>'E     {$$=$1>$3;}
| E'<'E     {$$=$1<$3;}
| E'+'E     {$$=$1+$3;}
| E'-'E      {$$=$1-$3;}
| E'*'E      {$$=$1*$3;}
| E'/'E      {$$=$1/$3;}
| E'^'E  {$$=pow($1,$3);}
|'('E')' {$$=$2;} 
| E AND E   {$$=$1&$3;}
| E OR E   {$$=$1|$3;}
| E XOR E   {$$=$1^$3;}
| E LS E    {$$=$1<<$3;}
| E RS E    {$$=$1>>$3;}
| E GTE E    {$$=$1>=$3;}
| E LTE E    {$$=$1<=$3;}
| E EQ E    {$$=$1==$3;}
| E NE E    {$$=$1!=$3;}
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