%{
    #include<stdio.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include "y.tab.h"
    extern YYSTYPE yylval;
%}
%%
[0-9]+ {yylval=atoi(yytext);return NUM;}
[+\-*/\^()><] {return *yytext;}
\n { return EOL; }
[\t  ;] ;
.   yyerror("inavlid");
%%

int yywrap(){
    return 1;
}