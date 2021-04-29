%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <ctype.h>
    #include "y.tab.h"
%}

letter [a-zA-Z]
digit   [0-9]
%%
{digit}+  {return NUM;}
"for"   {return FOR;}
"if"    {return IF;}
"++"|"--"   {return INC;}
"else"  {return ELSE;}
"<="|">="|"=="|"<>"|"<"|">" {return RELOP;}
[+\-*/^] {return ARITHOP;}
"=" {return ASSIGN;}
"true"|"false"  {return BOOL;}
{letter}({letter}|{digit})*   {return ID;}
";" {return SC;}
[(){}, \t\n]   ;

%%

int yywrap()
{
    return 1;
}