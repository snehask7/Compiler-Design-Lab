%{
	#include <stdio.h>
	#include <math.h>
    extern FILE * yyin; 
	#define YYSTYPE struct node*
	void yyerror();

	struct node {
		char var[3];
		char code[200];
	};

	int err_flag = 0;
	int count=0;
	int linecount=0;
	struct node* newtemp(char id);
%}

%token IF 
%token THEN 
%token ELSE 
%token ENDIF
%token DT
%token ID
%token ARITHOP
%token NUMCONST
%token VAR
%token RELOP
%token LOGOP
%right '*' '/'
%left '+' '-'
%%

 
S : S ID'='E 
		{
			printf("%s\n%c = %s\n", $4->code,$2, $4->var);
		}
    | S IF'('ID RELOP ID')' THEN {printf("if %c %c %c then goto ",$4,$5,$6);}
    | S ELSE {printf("else");}
   
|;

E : F ARITHOP E	
		{
			$$ = newtemp('t'); 
            sprintf($$->code,"%s\n%s = %s %c %s",$3->code,$$->var,$1->var,$2,$3->var);
		}
 	| F 
	  	{
            strcpy($$->code,$1->code);
		  	$$ = $1;
		}

F : ID 	
		{
			$$ = newtemp($1);
		}
;

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
	printf("================================\nIntermediate Code Generation\n================================\n");
    if( !(yyin = fopen("in.txt","r")) ){ 
        printf("cannot open file\n");exit(1);
    }
    yyparse();
}
