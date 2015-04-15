#include<stdio.h>
#include<stdlib.h>
#include<stdbool.h>


int main (int argc, const char *argv[])
{
    int myInt;
    bool isOK = true;
    myInt = 200;

    if (100 == myInt)
    {
        printf("the myint 's value is 100\n");
    }
    else
    {
        printf("the myInt's value is not 100\n");
    }
///让大家明白， 对于表达式来说，0为假， 非0为真
    if (-1)
    {
        printf("OK\n");
    }
    else
    {
        printf("False\n");
    }
//对于布尔变量的用法， 不要使用bool的值与布尔变量进行比较
    if (isOK)
    {
        printf("Yes\n");
    }else
    {
        printf("False\n");
    }
    return 0;
}
