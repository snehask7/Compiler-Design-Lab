%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <ctype.h>
    void yyerror(char *str);
    int yylex();
%}

%token IF ELSE NUM ID FOR RELOP BOOL ARITHOP ASSIGN SC INC

%%
CODE: S {printf("Syntactically Correct");};

S: IFSTMT S | FORSTMT S |STMT;

FORSTMT: FOR ID ASSIGN NUM SC CONDITION SC ID INC S;

IFSTMT:IF CONDITION STMT ELSE STMT| IF CONDITION STMT;

CONDITION: ID RELOP ID|NUM RELOP ID|ID RELOP NUM| NUM RELOP NUM|BOOL;

STMT: ID ASSIGN ID ARITHOP NUM SC;    
%%


void yyerror(char *str){
    printf("%s",str);
}

void main()
{
    yyparse();
}