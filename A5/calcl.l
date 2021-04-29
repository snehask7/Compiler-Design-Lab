%{
    #include "y.tab.h"
    #include <stdio.h>
    #include <stdlib.h>
    void yyerror(char* str);
    extern YYSTYPE yylval;
%}
%%
[0-9]+ {yylval=atoi(yytext);return NUM;}
"&&" {return AND;}
"||" {return OR;}
"XOR" {return XOR;}
"<<" {return LS;}
">>" {return RS;}
[+\-*/\^()><] {return *yytext;}
">=" {return GTE;}
"<=" {return LTE;}
"\n" { return EOL; }
"==" {return EQ;}
"!=" {return NE;}
\t  ;
.   yyerror("inavlid");
%%
int yywrap(void)
{return 1;}

