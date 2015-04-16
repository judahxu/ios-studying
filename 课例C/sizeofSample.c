#include<stdio.h>


int main (int argc, const char *argv[])
{
    int myInt = 100;
    size_t intSize  = sizeof (myInt);
    printf("the size of myInt is %ld\n",intSize);
    size_t intSizeSecond = sizeof (int);

    printf("the size of int is %ld\n",intSizeSecond);



    return 0;
}
