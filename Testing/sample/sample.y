%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <ctype.h>
    void yyerror(char *str);
    int yylex();
%}

%token NUM

%%
%%


void yyerror(char *str){
    printf("%s",str);
}

void main()
{
    yyparse();
}