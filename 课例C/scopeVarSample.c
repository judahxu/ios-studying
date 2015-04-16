#include<stdio.h>

void DrawDots( void );

int numDots;
int main (int argc, const char *argv[])
{
   // int  numDots;
   //
    {
        int scopeVar = 100;
    }
    printf("%d\n",scopeVar);
    numDots = 500;
    DrawDots();
    return 0;
}

void DrawDots( void ) {
    int  i;
    for ( i = 1; i <= numDots; i++ )
        printf( "." );
}
