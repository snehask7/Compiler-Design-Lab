%{
    #include <stdio.h>
    #include <stdlib.h>
    void yyerror(char *str);
    int yylex();

    struct node{
        char var[10];
        char code[300];
        char true[3];
        char out[3];
    };
    typedef struct node ele;

    ele *init(){
        ele *temp;
        temp=(ele*)malloc(sizeof(ele));
        return temp;
    }
    int count=0;
    int tac=1;
%}

%token NUM VAR ID DT BEG END IF THEN RELOP AOP MOP ELSE WHILE DO

%union{
    char *str;
    int num;
    struct node *strct;
}

%type <str> DT ID VAR NUM RELOP AOP MOP
%type<strct> DEC DECS S IFSTMT BODY CONDITION STMT F E T WHILESTMT
%right MOP
%left AOP

%%
S:DECS BEG BODY END{$$=init();sprintf($$->code,"%s\n%s",$1->code,$3->code);printf("%s",$$->code);};
DECS: DEC DECS {$$=init();sprintf($$->code,"%s\n%s",$1->code,$2->code);}
      |DEC  {$$=$1;};
DEC:  VAR ID ':' DT ';' {$$=init();sprintf($$->code,"%s %s;",$4,$2);}|
        VAR ID ':' DT '=' NUM ';' {$$=init();sprintf($$->code,"%s %s=%s;",$4,$2,$6);};
BODY: IFSTMT {$$=$1;}| WHILESTMT {$$=$1;};
WHILESTMT : WHILE CONDITION DO STMT {$$=init();sprintf($$->code,"while %s goto %s\ngoto %s\n%s:%s\n%s:",$2->code,$2->true,$2->out,$2->true,$4->code,$2->out);}
IFSTMT: IF CONDITION THEN STMT{$$=init();sprintf($$->code,"if %s goto %s\ngoto %s\n%s: %s\n%s:",$2->code,$2->true,$2->out,$2->true,$4->code,$2->out);}|
        IF CONDITION THEN STMT ELSE STMT{$$=init();sprintf($$->code,"if %s goto %s\n%s\ngoto %s\n%s: %s\n%s:",$2->code,$2->true,$6->code,$2->out,$2->true,$4->code,$2->out);};
CONDITION: '(' ID RELOP ID ')'  {$$=init();sprintf($$->code,"%s %s %s",$2,$3,$4);sprintf($$->true,"L%d",count++);sprintf($$->out,"L%d",count++);};
STMT: ID '=' E ';' {$$=init();sprintf($$->code,"%s\n%s=%s",$3->code,$1,$3->var);};
E: F MOP E {$$=init();   
            sprintf($$->var, "t%d", tac++);
            sprintf($$->code, "%s%s\n%s = %s %s %s\n", $1->code, $3->code, $$->var, $1->var,$2, $3->var);
           }
  | F {$$=$1;};
F: F AOP T  {$$=init();   
            sprintf($$->var, "t%d", tac++);
            sprintf($$->code, "%s%s\n%s = %s %s %s\n", $1->code, $3->code, $$->var, $1->var,$2, $3->var);
           }
    | T {$$=$1;};
T: ID {$$=init();sprintf($$->var,"%s",$1);};
%%

void yyerror(char *str){
    printf("%s",str);
}
void main(){
    yyparse();
}