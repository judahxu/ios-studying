#include<stdio.h>

#define STUDENT_COUNT 100

#define ABS(X)  ((X) < 0 ? -(X):(X))

#define MIN(X,Y) ((X > Y) ? Y : X)

#define AREA(x,y) printf("长为"#x",宽为"#y"的长方形的面积：%d\n",(x)*(y))
int main (int argc, const char *argv[])
{
    int students[STUDENT_COUNT];

    for (int i = 0; i < STUDENT_COUNT; i++)
        students[i] = 100+i;

    for (int j = 0; j < STUDENT_COUNT; j++)
    {
        printf("%d\n",students[j]);
    }

    int result = ABS(-1);
    //((-1) < 0 ? -(-1):(1))
    printf("the result is %d\n",result);


    int myVar = 100;
    int anotherInt = 200;
    int ret =  MIN (myVar++,anotherInt++);
    printf("the ret is %d\n",ret);

    AREA(10,20);
    return 0;
}
