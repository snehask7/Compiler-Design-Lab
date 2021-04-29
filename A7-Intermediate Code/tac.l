%{ 
    #include "y.tab.h"
	#include <stdio.h>
    #include <stdlib.h>
	extern YYSTYPE yylval;
%}

%%
"var"						{return VAR;}
"integer"|"real"|"char"		{return DT;}
"IF"|"if"            		{ return IF;}
"THEN"|"then"         		{ return THEN;}
"ELSE"|"else"       		{ return ELSE;}
"END IF"|"end if"      		{ return ENDIF;}
"begin"						{ return BEG;}
"end"						{ return END;}
[0-9]+      				{ return NUM;}
[a-zA-Z]        			{ yylval = yytext[0]; return ID;}
"+"|"-"						{yylval = yytext[0]; return ADD;}
"*"|"/"						{yylval = yytext[0]; return MUL;}
"<="|">="|">"|"<"|"=="|"!=" { yylval = yytext[0];return RELOP;}
[ ]							;
\t 							;
.               			{return *yytext;};
%%
int yywrap(){
	return 1;
}