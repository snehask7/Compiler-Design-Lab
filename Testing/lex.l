%{
        #include <stdio.h>
        #include <ctype.h>
        #include <stdlib.h>

        typedef struct ST 
        {
            int rowcount;
            char types[20][10];
            char ids[20][10];
            char values[20][10];
        }ST;

        void addSymbol(char* id);
        void displaySymbolTable();
        ST *s;

        char type[10];
        int found=0;
%}

digit [0-9] 
letter [a-zA-Z]
logop "&&"|"||"|"!"
dt "int"|"char"|"float"
kw "if"|"else"|"do"|"while"
%%
{digit}+ {printf("NUMCONST ");if(strcmp(type,"int")==0 && found==1)strcpy(s->values[s->rowcount-1],yytext);}
{kw}    {printf("KW");}
{dt}    {printf("KW");strcpy(type,yytext);found=1;}
{digit}+"."{digit}+ {printf("FRACT ");if(strcmp(type,"float")==0 && found==1)strcpy(s->values[s->rowcount-1],yytext);}
{letter}+"(".*")" {printf("FUNC ");}
{letter}({letter}|{digit})* {printf("ID ");if(found==1)addSymbol(yytext);}
"'"{letter}"'"  {printf("CHARCONST ");if(strcmp(type,"char")==0 && found==1)strcpy(s->values[s->rowcount-1],yytext);}
"\""{letter}+"\""  {printf("STRCONST ");}
{logop} {printf("LOGOP");}
"//"({letter}|{digit})+   {printf("SINGLE ");}
"/*"({letter}|{digit}|"\n")+"*/"    {printf("MULTI ");}
";" {if(found==1){found=0;}}
"\n"    {printf("\n");}
"=" {printf("ASSIGN ");}
","|"{"|"}"|"("|")" {}
">"|"<"|">="|"<="   {printf("LOGOP ");}
"+"|"-"|"*"|"/" {printf("ARITHOP ");}
%%

int yywrap()
{}
void main()
{
    s=malloc(sizeof(ST));
    s->rowcount=0;
    yyin=fopen("in.txt","r");
    yylex();
    displaySymbolTable();
}

void addSymbol(char* id )
{
    int index;
    index=s->rowcount;
    strcpy(s->types[index],type);
    strcpy(s->ids[index],id);
    strcpy(s->values[index],"0");
    s->rowcount=index+1;
}

void displaySymbolTable()
{
    int count;
    count=s->rowcount;
    int i;
    printf("\n");
    for(i=0;i<count;i++)
    {
        printf("%s %s %s\n",s->types[i],s->ids[i],s->values[i]);
    }
}