%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "y.tab.h"
%}

letter [a-zA-Z]
digit [0-9]
%%
{digit}+  {yylval.str=strdup(yytext);return NUM;}
"var"   {return VAR;}
"begin" {return BEG;}
"end"   {return END;}
"if"    {return IF;}
"else"  {return ELSE;}
"then"  {return THEN;}
"integer"|"float"|"char"    {yylval.str=strdup(yytext);return DT;}
{letter}({letter}|{digit})* {yylval.str=strdup(yytext);return ID;}
[ \n\t] ;
">"|"<" {yylval.str=strdup(yytext);return RELOP;}
"+"|"-" {yylval.str=strdup(yytext);return AOP;}
"*"|"/" {yylval.str=strdup(yytext);return MOP;}
.   {return *yytext;}
%%

int yywrap(){
    return 1;
}