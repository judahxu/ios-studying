#include<stdio.h>

//声明一个函数， 函数的名字叫func ,函数返回类型 int , 函数的参数是一个整型
int func (int );

int anotherFunc(int);
double dfunc (double , double );


int main (int argc, const char *argv[])
{
    //声明一个函数指针， 要求这个指针指向函数地址， 什么样的函数呢？返回类型是int , 参数是一个整型
    //声明了一个指针变量foo,foo将来指一个函数的地址， 这个函数必须是返回类型为int ,且只有一个整型的参数
    int (*foo)(int oper);

    foo = anotherFunc;//因为函数的名字， 表示的就是函数的地址，所以直接给foo赋值

   // foo = dfunc;

    int ret = foo(6);
    printf("the result is %d\n",ret);
    return 0;
}

//定义前面声明的这个函数
//
int func (int oper)
{
    oper = 200;
    return oper;
}

int anotherFunc(int oper)
{
    return oper * 100;
}

double dfunc (double operA, double operB)
{
    double result = operA + operB;
    return result;
}
