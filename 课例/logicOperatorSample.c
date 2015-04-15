#include<stdio.h>
#include<stdbool.h>


int main (int argc, const char *argv[])
{
    int myInt = 0;
    int anotherInt = 100;
#if 0
    bool bIsOK = false;
    bool bIsAnotherOK = false;
    if (!myInt)
    {
        printf("true\n");
    }else
    {
        printf("false\n");
    }


    if (bIsOK && bIsAnotherOK)
    {
        printf("OK\n");
    }else
    {
        printf("False\n");
    }

    if (bIsOK || bIsAnotherOK)
    {
        printf("OK\n");
     }
    else
    {
        printf("false\n");
    }
#endif
    if ((myInt == 1) && ++anotherInt)
    {
        printf("OK,%d\n",anotherInt);
        printf("hahaha\n");
    }
    else
        printf("false\n");


    printf("the anotherInt's value is %d",anotherInt);

    return 0;
}
