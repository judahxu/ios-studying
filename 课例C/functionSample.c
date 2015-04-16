#include<stdio.h>

//在这里声明一个函数，其功能是实现两个整数相加，把相加的结果返回
//
//
/*
int addOper(int oper1, int oper2 );

int main (int argc, const char *argv[])
{
    int result = addOper(100,200);
    printf("the result is %d\n",result);
    return 0;
}


int addOper(int oper1, int oper2)
{
    return (oper1 + oper2);
}
*/

#include <stdio.h>

void ChangeVarValue( int numDots ); 

void PChangeVarValue( int *numDots ); 

int main (int argc, const char * argv[]) {
    int    numDots;
    numDots = 30;
    ChangeVarValue( numDots );
    printf( "in main numDots’s value: %d\n",numDots );

    PChangeVarValue(&numDots);

    printf("after PChange the numDots's value is %d\n",numDots);

   return 0;
}

void  ChangeVarValue( int numDots ) 
{
    numDots = 40;
    printf( "numDots’s value is %d\n",numDots );
                                                                            
}

void  PChangeVarValue( int *numDots ) 
{
    *numDots = 40;
    return;
    printf( "numDots’s value is %d\n",*numDots );
                                                                            
}
