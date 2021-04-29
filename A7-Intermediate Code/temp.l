%{ 
    #include "y.tab.h"
	#include <stdio.h>
    #include <stdlib.h>
	extern YYSTYPE yylval;
%}

datatype    "int"|"real"|"char"
var         "var"
if          "IF"|"if"
then        "THEN"|"then"
endif       "ENDIF"|"endif"
else        "ELSE"|"else"
letter      [a-zA-Z]
letters     {letter}+
digit       [0-9]
digits      [+-]?{digit}+
optfrac     [.]{digits}
optexp      [E][+-]?{digits}
numconst    {digits}({optfrac}|{optexp})?
id          {letter}({letters}|{digits})?
arithop     ("+"|"-"|"*"|"/"|"%")
relop       ("<="|">="|">"|"<"|"=="|"!=")
logop       ("&&"|"||"|"!")
newl        [\n]
tabs        [\t]
spaces      [ ]

%%
{var}           { return VAR;}
{if}            { return IF;}
{then}          { return THEN;}
{else}          { return ELSE;}
{endif}         { return ENDIF;}
{datatype}      { return DT;}
{numconst}      { yylval = atoi(yytext); return NUMCONST;}
{id}            { yylval = yytext[0]; return ID;}
{arithop}       { yylval = yytext[0]; return ARITHOP;}
{relop}         { yylval = yytext[0];return RELOP;}
{logop}         { return LOGOP;}
{spaces}        {};
{newl}          {};
{tabs}          {};
.               {return *yytext;};
%%
int yywrap(){
	return 1;
}