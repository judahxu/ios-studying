#include<stdio.h>

typedef struct 
{
    int age;                  //年龄
    int workExperience;      //工作年限
    double salary;          //工资
} EmployeeType;

struct 
{
    int age;                  //年龄
    int workExperience;      //工作年限
    double salary;          //工资
} softWareEngine;





int main (int argc, const char *argv[])
{
    int myInt = 100;
    int anotherInt = 200;
    anotherInt = myInt;


    //manager = softWareEngine;
    //
    //manager = softEngineer;
    //
    //struct employeeType eng1;
   // struct employeeType eng2;
   //
   EmployeeType eng1;
   EmployeeType eng2;
   eng1 = eng2;

    eng2 = eng1;

    return 0;
}
