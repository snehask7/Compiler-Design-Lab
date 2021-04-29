%{
	#include <stdio.h>
	#include <math.h>
    extern FILE * yyin; 
	#define YYSTYPE struct node*
	void yyerror();

	struct node {
		char var[3];
		char code[200];
		char true[3];
		char out[3];
	};

	int err_flag = 0;
	int count=0;
	int labelcount=0;
	struct node* newtemp(char id);
%}

%token IF 
%token THEN 
%token ELSE 
%token ENDIF
%token DT
%token ID
%token NUM
%token ARITHOP
%token RELOP
%token ADD
%token MUL
%token BEG
%token END
%token VAR
%left MUL
%right ADD
%%

START : DECL BEG B END ;

DECL : VAR ID':'DT'='NUM';' DECL 
	|VAR ID':'DT'='ID';' DECL 
	|VAR ID':'DT';' DECL 
	|;
	
B : IF '('C')' THEN S ELSE S ENDIF 
		{
			printf("%s\n%s\ngoto %s\n%s:\n%s%s:",$3->code,$8->code,$3->out,$3->true,$6->code,$3->out);
		};
	|IF '('C')' THEN S ENDIF 
		{
			printf("%s\ngoto %s\n%s:\n%s%s:",$3->code,$3->out,$3->true,$6->code,$3->out);
		};

C : ID RELOP ID
		{
			$$ = newtemp('o'); 
			sprintf($$->true,"L%d",labelcount++);
			sprintf($$->out,"L%d",labelcount++);
			sprintf($$->out,"L%d",labelcount++);
			sprintf($$->code,"if %c %c %c goto %s",$1,$2,$3,$$->true);
		};

S : ID'='E';' 
		{
			$$ = newtemp('o'); 
			sprintf($$->code,"%s\n%c = %s\n", $3->code,$1, $3->var);
		}  ;

E : T MUL E
		{
			$$ = newtemp('t'); 
            sprintf($$->code,"%s%s\n%s = %s %c %s",$1->code,$3->code,$$->var,$1->var,$2,$3->var);
		}
 	|T 
	  	{
		  	$$ = $1;
		};

T : T ADD F
		{
			$$ = newtemp('t'); 
            sprintf($$->code,"%s\n%s = %s %c %s",$1->code,$$->var,$1->var,$2,$3->var);
		}
	|F
		{
		  	$$ = $1;
		};

F : ID 	
		{
			$$ = newtemp($1);
		};

%%

struct node* newtemp(char id) {
	struct node *temp;
	temp = malloc(sizeof(struct node));  
    temp->var[0]=id;
    if(id=='t')
    {
        count++;
        temp->var[1]='0'+count;
        temp->var[2]='\0';
    }
    else
        temp->var[1]='\0';
    strcpy(temp->code,"");
	return temp;
}

void yyerror()
{
	return;
}

void main()
{
    if( !(yyin = fopen("in.txt","r")) ){ 
        printf("cannot open file\n");exit(1);
    }
    yyparse();
}
