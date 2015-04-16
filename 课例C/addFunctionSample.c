#include<stdio.h>

//封装一个函数， 实现两个数的加法
//要知道实现哪两个数值的相加?
//如果有了结果， 如何让函数调用的地方知道
//
//
int addFuntion(int firstOper, int secondOper);

int main (int argc, const char *argv[])
{
    int result;
    int firstValue = 200;
    int secondValue = 300;

    result = addFunction(firstValue,secondValue);


    result = addFunction(300,400);

    return 0;
}


int addFunction(int firstOper, int secondOper)
{
    return firstOper + secondOper;
}
