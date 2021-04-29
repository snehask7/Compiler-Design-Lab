%{
    #include<stdio.h>
    #include <stdlib.h>
    int yyerror(char* str);
    int yylex();
%}


%token NUM EOL
%left '+'


%%
S: E EOL{printf("%d",$$);};
E:E'+'E {$$=$1+$3;} ;
E:NUM {$$=$1;};

%%

int yyerror(char* str)
{
    printf("%s",str);
}
void main(){
    yyparse();
}
