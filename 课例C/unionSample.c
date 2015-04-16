#include<stdio.h>
#include<stdbool.h>


union 
{
    int a;
    char c;
}myUnion;

bool isLittleEdian();
int main (int argc, const char *argv[])
{

    myUnion.a = 1;
    if (myUnion.c == 1)
    {
        printf("the cpu is litteEdian\n");
    }else
    {
        printf("the cpu is bigEdian\n");
    }

/*
    if (isLittleEdian())
    {
        printf("little edian\n");
    }
    else
    {
        printf("BIG edain\n");
    }
*/
    return 0;
}


bool isLittleEdian()
{
    short int myVar = 0x1234;
    //取出myVar的地址 &myVar
    //(char*)&myVar 现在只取myVar变量的第一个字节的地址
   //*((char*)&myVar) 表示访问的是myVar变量地址的首字节的内容
   //
   if (*((char*)&myVar) == 0x12) //低地址存放的是高位数据的值
   {
       return false;
   }
   else
   {
       return true;
   }
}
