%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <ctype.h>
    #include "y.tab.h"
%}

%%
%%

int yywrap()
{
    return 1;
}