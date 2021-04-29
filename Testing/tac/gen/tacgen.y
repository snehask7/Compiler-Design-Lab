%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    void yyerror(char *str);
    int yylex();

    struct node{
        char var[10];
        char code[300];
        char true[3];
        char out[3];
        char mcode[300];
    };
    typedef struct node ele;

    ele *init(){
        ele *temp;
        temp=(ele*)malloc(sizeof(ele));
        strcpy(temp->mcode," ");
        return temp;
    }
    int count=0;
    int tac=1;
%}

%token NUM VAR ID DT BEG END IF THEN RELOP AOP MOP ELSE 

%union{
    char *str;
    int num;
    struct node *strct;
}

%type <str> DT ID VAR NUM RELOP AOP MOP
%type<strct> DEC DECS S IFSTMT BODY CONDITION STMT F E T
%right MOP
%left AOP

%%
S:DECS BEG BODY END{$$=init();sprintf($$->code,"%s\n%s",$1->code,$3->code);sprintf($$->mcode,"%s\n%s",$1->mcode,$3->mcode);printf("%s\n%s",$$->code,$$->mcode);};

DECS: DEC DECS {$$=init();sprintf($$->code,"%s\n%s",$1->code,$2->code);sprintf($$->mcode,"%s\n%s",$1->mcode,$2->mcode);}
      |DEC  {$$=$1;};

DEC:  VAR ID ':' DT ';' {$$=init();sprintf($$->code,"%s %s;",$4,$2);}|
        VAR ID ':' DT '=' NUM ';' {$$=init();sprintf($$->code,"%s %s=%s;",$4,$2,$6);sprintf($$->mcode,"MOV #%s ,%s",$6,$2);};

BODY: IFSTMT {$$=$1;};

IFSTMT: IF CONDITION THEN STMT{$$=init();sprintf($$->code,"if %s goto %s\ngoto %s\n%s: %s\n%s:",$2->code,$2->true,$2->out,$2->true,$4->code,$2->out);sprintf($$->mcode,"if %s goto %s\ngoto %s\n%s: %s\n%s:",$2->code,$2->true,$2->out,$2->true,$4->mcode,$2->out);}|
        IF CONDITION THEN STMT ELSE STMT{$$=init();sprintf($$->code,"if %s goto %s\n%s\ngoto %s\n%s: %s\n%s:",$2->code,$2->true,$6->code,$2->out,$2->true,$4->code,$2->out);};

CONDITION: '(' ID RELOP ID ')'  {$$=init();sprintf($$->code,"%s %s %s",$2,$3,$4);sprintf($$->true,"L%d",count++);sprintf($$->out,"L%d",count++);};

STMT: ID '=' E ';' {$$=init();sprintf($$->code,"%s\n%s=%s",$3->code,$1,$3->var);sprintf($$->mcode,"%s\n%s=%s",$3->mcode,$1,$3->var);};

E: F MOP E {$$=init();   
            sprintf($$->var, "t%d", tac++);
            sprintf($$->code, "%s%s\n%s = %s %s %s\n", $1->code, $3->code, $$->var, $1->var,$2, $3->var);
           }
  | F {$$=$1;};

F: F AOP T  {$$=init();   
            sprintf($$->var, "t%d", tac++);
            char opt[100];
            if(strcmp($1->var,"0")==0)
            {
                if(strcmp($$->var,$3->var)==0 && (strcmp($2,"+")==0))
                {
                    opt[0]='\0';
                }
                else if(strcmp($2,"+")==0)
                {
                    sprintf(opt,"%s=%s",$$->var,$3->var);
                }
                else 
                {
                    sprintf(opt,"%s=-%s",$$->var,$3->var);
                }
            }
            else if(strcmp($3->var,"0")==0)
            {
                if($$->var==$1->var)
                {
                    opt[0]='\0';
                }
                else
                {
                sprintf(opt,"%s=%s",$$->var,$1->var);
                }
            }
            else
                sprintf(opt,"%s=%s+%s",$$->var,$1->var,$3->var);
        
            sprintf($$->code, "%s%s\n%s\n", $1->code, $3->code, opt);
           }
    | T {$$=$1;};
T: ID {$$=init();sprintf($$->var,"%s",$1);} | NUM {$$=init();sprintf($$->var,"%s",$1);};
%%

void yyerror(char *str){
    printf("%s",str);
}
void main(){
    yyparse();
}