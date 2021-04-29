%{
    #include "y.tab.h"
    #include <stdio.h>
    #include <stdlib.h>
    void yyerror(char* str);
    extern YYSTYPE yylval;
%}
%%
\t  ;
"for"|"if"|"else"|"while" {return KW;}
[();,{}] {return SP;}
[a-zA-Z] {return id;}
[0-9]+ {return id;}
"++" {return INC;}
"=" {return ASSIGN;}
[<>+\-*%] {return OP;}
"==" {return OP;}
"<="|">=" {return OP;}
.   ;
%%
int yywrap(void)
{return 1;}

