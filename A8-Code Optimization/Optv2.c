#include <stdio.h>
#include <string.h>
#include <ctype.h>

void CodeOptimizer();

int main()
{
    CodeOptimizer();
    return 0;
}
void CodeOptimizer()
{
    char file[10][128];
    int i = 0;
    FILE *fd = fopen("Code2.txt", "r");
    while (fgets(file[i], sizeof(file[i]), fd))
        i++;
    for (int j = 0; j < i; j++)
    {
        if (file[j][3] == '+') //addition
        {
            if (file[j][2] == '0')
            {
                if (file[j][0] != file[j][4])
                    printf("%c=%c\n", file[j][0], file[j][4]);
            }
            else if (file[j][4] == '0')
            {
                if (file[j][0] != file[j][2])
                    printf("%c=%c\n", file[j][0], file[j][2]);
            }
            else
                printf("%s", file[j]);
        }
        else if (file[j][3] == '*' && file[j][4] != '*') //multiplication
        {
            if (file[j][2] == '1')
            {
                if (file[j][0] != file[j][4])
                    printf("%c=%c\n", file[j][0], file[j][4]);
            }
            else if (file[j][4] == '1')
            {
                if (file[j][0] != file[j][2])
                    printf("%c=%c\n", file[j][0], file[j][2]);
            }
            else
                printf("%s", file[j]);
        }
        else if (file[j][3] == '-') //subtraction
        {
            if (file[j][4] == '0')
            {
                if (file[j][0] != file[j][2])
                    printf("%c=%c\n", file[j][0], file[j][2]);
            }
            else if (file[j][2] == '0')
            {
                printf("%c=-%c\n", file[j][0], file[j][4]);
            }
            else
                printf("%s", file[j]);
        }
        else if (file[j][3] == '/') //division
        {
            if (file[j][4] == '1')
            {
                if (file[j][0] != file[j][2])
                    printf("%c=%c\n", file[j][0], file[j][2]);
            }
            else
                printf("%s", file[j]);
        }
        else if (file[j][3] == file[j][4] && file[j][4] == '*')
        {
            if (file[j][5] == '2')
                printf("%c=%c*%c\n", file[j][0], file[j][2], file[j][2]);
            else
                printf("%s", file[j]);
        }
        else if (file[j][3] == file[j][4] && file[j][4] == '*')
        {
            if (file[j][5] == '2')
                printf("%c=%c*%c\n", file[j][0], file[j][2], file[j][2]);
            else
                printf("%s", file[j]);
        }
        else if (file[j][2] == 'p' && file[j][3] == 'o' && file[j][4] == 'w' && file[j][8] == '2')
        {
            printf("%c=%c*%c\n", file[j][0], file[j][6], file[j][6]);
        }
        else
        {
            printf("%s", file[j]);
        }
    }
}