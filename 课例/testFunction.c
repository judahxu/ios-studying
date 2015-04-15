#include<stdio.h>

//函数的声明
void MyFunction();
void anotherFunction();

int main (int argc, const char *argv[])
{
    //函数的调用
    MyFunction();
    anotherFunction();
    return 0;
}

//函数的定义
void MyFunction()
{
    printf("hello,MyFuntion\n");
}


void anotherFunction()
{
    printf("Hello,anotherFuntcion\n");
}
