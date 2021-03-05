%{
    #include "y.tab.h"
    #include <stdio.h>
    #include <stdlib.h>
    void yyerror(char* str);
    extern YYSTYPE yylval;
%}
%%
[0-9]+ {yylval=atoi(yytext);return NUM;}
[+\-*/\^()] {return *yytext;}
"\n" { return EOL; }
\t  ;

.   yyerror("inavlid");
%%
int yywrap(void)
{return 1;}