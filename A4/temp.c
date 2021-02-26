    // int i;
    // FILE *fptr;
    // fptr = fopen("functions.txt", "w");
    // char start = newProduction[0][0];
    // 
    // printf("%s%c%s", "\nint main()\n{\n\t", start, "();\n\tif(lookahead=='$)\n\t\tprintf(\"Parsing Successful\");\n}\n");
    // for (i = 0; i < count; i++)
    // {
    //     int j = 0;
    //     printf("\n");
    //     while (newProduction[i][j] != '-')
    //     {
    //         printf("%c", newProduction[i][j]);
    //         j++;
    //     }
    //     j += 3;
    //     printf("()\n{\n");
    //     int start = 1;
    //     int indent = 0;
    //     int match = 0;
    //     while (j < strlen(newProduction[i]))
    //     {
    //         if ((newProduction[i][j]) == '|' || (newProduction[i][j] == '\n'))
    //         {
    //             printf( "\t}\n");
    //             j++;
    //             match = 0;
    //         }
    //         else if (checkterminal(newProduction[i][j]) == 0)
    //         {
    //             if (indent == 1)
    //                 printf("\t");
    //             if (newProduction[i][j + 1] != '\'')
    //             {
    //                 printf("\t%c();\n", newProduction[i][j]);
    //                 j++;
    //             }
    //             else
    //             {
    //                 printf("\t%c'();\n", newProduction[i][j]);
    //                 j += 2;
    //             }
    //         }
    //         else //terminal
    //         {
    //             if (match == 0)
    //             {
    //                 match = 1;
    //                 if (newProduction[i][j] == 'e')
    //                 {
    //                     printf("\telse\n\t\treturn;\n");
    //                 }
    //                 else if (start == 1) //first if condition
    //                 {
    //                     printf("\tif(lookahead==\'%c\')\n\t{\n\t\tmatch(\'%c\');\n", newProduction[i][j], newProduction[i][j]);
    //                     indent = 1;
    //                     start = 0;
    //                 }
    //                 else
    //                 {
    //                     printf( "\telse if(lookahead==\'%c\')\n\t{\n\t\tmatch(\'%c\');\n", newProduction[i][j], newProduction[i][j]);
    //                     indent = 1;
    //                 }
    //             }
    //             else
    //             {
    //                 printf("\t\tmatch(\'%c\');\n", newProduction[i][j]);
    //             }
    //             j++;
    //         }
    //     }
    //     if (i == count - 1)
    //         printf("\t}\n");
    //     printf("}\n");
    // }
    // printf("\n\n");