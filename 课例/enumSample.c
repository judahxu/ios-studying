#include<stdio.h>

//此程序是根据输入的结果是星期几
//如果输入0代表的时星期一 1代表是星期二
//
/*
int main (int argc, const char *argv[])
{

    int value;
    printf("please input the day\n");
    scanf("%d",&value);
    switch (value)
    {
        case 0:
            printf("work\n");
            break;
        case 1:
            printf("work:coding\n");
            break;
        case 2:
            printf("work:meeting\n");
            break;
        case 3:
            printf("work: commit code\n");
            break;
        case 4:
            printf("work:tell with leader\n");
            break;
        case 5:
            printf("play game\n");
            break;
        case 6:
            printf("sleep \n");
            break;
        default:
            printf("no this day\n");
    }

    return 0;
}
*/
//声明了一体枚举类型
typedef enum weekDays 
{ 
    Monday = 1,
    Tuesday,
    Wednesday,
    Thursday = 100,
    Friday,
    Saturday,
    Sunday
}WeekDaysType;

typedef unsigned long ulongInt;
typedef int QYInt;

int main (int argc, const char *argv[])
{
    WeekDaysType value;
    ulongInt  myULInt;
    printf("please input the day\n");

    QYInt myInt = 100;
    scanf("%d",&value);
    switch (value)
    {
        case Monday:
            printf("work\n");
            break;
        case Tuesday:
            printf("work:coding\n");
            break;
        case Wednesday:
            printf("work:meeting\n");
            break;
        case Thursday:
            printf("work: commit code\n");
            break;
        case Friday:
            printf("work:tell with leader\n");
            break;
        case Saturday:
            printf("play game\n");
            break;
        case Sunday:
            printf("sleep \n");
            break;
        default:
            printf("no this day\n");
    }

    return 0;
}
