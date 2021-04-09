%{
	#include <stdio.h>
	#include <math.h>
    extern FILE * yyin; 
	#define YYSTYPE struct info*
	void yyerror();

	struct info {
		char var[3];
		char *code;
	};

	int err_flag = 0;
	int count=0;
	struct info* newtemp(char id);
%}

%token ID

%%

S : ID'='E {char temp[5]; temp[0]=$1; temp[1]='\0'; printf("%s = %s\n", temp, $3->var);}
E : E'+'F{$$ = newtemp('t'); ; printf("%s = %s + %s\n", $$->var, $1->var, $3->var);}
  | F {$$ = $1;}
F : ID {$$ = newtemp($1);}

%%

struct info* newtemp(char id) {
	struct info *temp;
	temp = malloc(sizeof(struct info));  
    temp->var[0]=id;
    if(id=='t')
    {
        count++;
        temp->var[1]='0'+count;
        temp->var[2]='\0';
    }
    else
        temp->var[1]='\0';
	return temp;
}

void yyerror()
{
	return;
}

void main()
{
	printf("Intermediate Code Generation\n");
    if( !(yyin = fopen("in.txt","r")) ){ 
        printf("cannot open file\n");exit(1);
    }
    yyparse();
}
