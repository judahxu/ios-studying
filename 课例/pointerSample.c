#include<stdio.h>


int main (int argc, const char *argv[])
{
    int myInt = 100;
    int *pMyInt = &myInt;

    printf("%d\n",*pMyInt);

    *pMyInt = 200;
    printf("the myint's value is %d\n",myInt);
    return 0;
}
