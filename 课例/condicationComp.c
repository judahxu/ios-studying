#include<stdio.h>

#define DEBUG 

int main (int argc, const char *argv[])
{
    #if 0 
         printf("the first line \n");
    #else 
         printf("the second line \n");
    #endif 


    #if 0
         int a = 1000;
         int b = 2000;
         int sum = a + b ;
    #endif 

#undef DEBUG

#ifdef DEBUG
         printf("the test code\n");
#else
         printf("the release code\n");
#endif 

#ifndef RELEASE
         printf("Debug\n");
#else
         printf("Release\n");
#endif

#error this is error info

         printf("%s %s\n",__DATE__,__TIME__);//当前源文件创建的日期
         printf("%s\n",__FILE__);//当前源文件的名字（包括路径)
         printf("%d\n",__LINE__);//当前编译的源程序的行号
         if (__STDC__)
         {
             printf("stand c \n");
         } else {
            printf("no stand c \n");
        }
         printf("%s\n",__TIME__);

    return 0;
}
