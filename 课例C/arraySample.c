#include<stdio.h>


int main (int argc, const char *argv[])
{
    //初始化：声明变量的同时赋值
    int array[10] = {0,1,2,3,4,5,6,7,8,9};
    
    for (int i = 0; i < 10; i++)
    {
        printf("%d\n",array[i]);
    }

    int secondArray[10] = {99,1,2,3,4};

    printf("the first item of secondArray is %d\n",secondArray[0]);
    printf("the last item of secondArrary is %d\n",secondArray[9]);
    int *pArray = secondArray;

    printf("the first item of secondArray is %d\n",*pArray);

    for (int j = 0; j < 10; j++)
    {
        printf("the item is %d\n",*pArray);
        pArray++;
    }

    /*
    float farray[10];

    {
        int size;
        scanf("%d",&size);
        double darray[size];
        printf("the value is %f\n",darray[20]);
    }
    */
    return 0;
}
