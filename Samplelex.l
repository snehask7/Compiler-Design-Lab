/* To count number of positive numbers input */
%{ 
#include<stdio.h> 
#include<string.h> 
int count = 0; 
%} 
  
zero [0]  
negdigit ^[-][0-9]+
digit [0-9]+

/* Rules Section*/
%% 
{zero} {printf("Count: %d",count); return 1;}
{negdigit} {}
{digit} {count++;}
  
"\n" {} 
%% 
  
int yywrap(void){} 
  
int main() 
{    
    yylex(); 
  
    return 0; 
}