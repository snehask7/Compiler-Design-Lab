/* To count number of positive numbers input */
%{ 
#include<stdio.h> 
#include<string.h> 
%} 

singleline [/]{2}.*
multiline "/*"([^*]|\*+[^*/])*\*+"/"
assign "="
keyword (if|else|do|while|void|int|float|char)
function [ ]*[a-zA-Z]+\(.*\).*
int [-+]?[0-9]+
float [-+]?[0-9]*[.][0-9]+
charconst \'.\'
strconst \".*\"
id [a-zA-z][a-zA-z0-9]*
arithop [+\-*/%]
relop [<>!=]{1,2}
logicalop &{2}|!|[|]{2}
seperator [();,{}]   

%%
{multiline} {printf("MULTILINE ");}
{singleline} {printf("SINGLELINE ");} 
{keyword} {printf("KW ");}
{function} {printf("FC ");}
{int} {printf("NUMCONST ");}
{float} {printf("NUMCONST ");}
{id} {printf("ID ");}
{assign} {printf("ASSIGN ");}
{charconst} {printf("CHARCONST");}
{strconst} {printf("STRCONST");}
{arithop} {printf("ARITHOP ");}
{relop} {printf("RELOP ");}
{logicalop} {printf("LOGICALOP ");}
{seperator} {printf("SP ");}
"\n" {printf("\n");} 
%% 
  
int yywrap(void){} 
  
int main() 
{    
    yyin = fopen("code.txt", "r"); 
    yylex(); 
  
    return 0; 
}
