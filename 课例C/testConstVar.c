#include<stdio.h>


int main (int argc, const char *argv[])
{
    int myInt = 100;

    printf("the myint's value is %d\n",myInt);

    //anotherInt这个变量所代表的地址空间的值是不能改变的
    //如果非要更改这个值， 那么编译器会报错
    const int anotherInt = myInt;
    anotherInt = 200; 
    printf("the myint's value is %d\n",anotherInt);
    return 0;
}
