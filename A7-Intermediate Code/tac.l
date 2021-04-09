%{ 
    #include "y.tab.h"
	#include <stdio.h>
    #include <stdlib.h>
	extern YYSTYPE yylval;
%}

%%

[a-zA-Z0-9] {yylval = yytext[0]; return ID;}
[\t] ;
[\n] return 0;
. return yytext[0];

%%

int yywrap(){
	return 1;
}