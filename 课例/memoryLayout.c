#include<stdio.h>

int global; //全局变量，未初始化数据区
int anotherInt = 100;//已初始化数据区
static int sglobal;//静态全局变量， 未初始化数据区
static int sanotherInt = 100; //已初始化数据区

//上述的两个100值，属于字面常量， 它们统一也放在已初始化数据区
//
//
void fun(void);
int main (int argc, const char *argv[])
{
    int myInt; //这个变量， 在栈区放着，它就是所谓局部变量

    int *p = (int*)malloc(20);//p所指向的内存就在堆区放着    

    return 0;
}

void fun(void)
{
    int thirdInt = 100;//栈区
    printf("the thirdInt's value is %d\n",thirdInt);

}
