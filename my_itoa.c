#include <stdio.h>
#include <stdarg.h>
#include <string.h>

static void recurse_itoa( char *s, int v )
{
    if( v >= 10 ){
        printf("v/10 = %d\n", v/10);
        recurse_itoa(s,v/10);
        s++;
        printf("S%sEND\n", s);
    }
    
    s[0] = '0'+ (v % 10);
    s[1] = 0;

    printf("BUFFER%sEND\n", s);
}


static void my_itoa_error( char* str, int value )
{
    str = strchr( str, 0 );
    *str++ = ' ';

    if (value < 0)
    {
        *str++ = '-';
        value = -value;
    }

    recurse_itoa(str, value);
}

void my_itoa(char* str, int value)
{
    char result[25] = {0};
    char* presult = result;
    char temp[25] = {0};
    int index = 0;
    int new_val;
    int i;
    
    while (value >= 10)
    {
        new_val = value % 10;
        value /= 10;
        temp[index++] = '0' + new_val;
    }
    temp[index++] = '0' + value;
    
    printf("temp: %s\n", temp);
    
    for(i=0;i<25;i++)
    {
        result[i] = temp[25-i];
    }
    
    presult+=index;
    
    printf("result: %s\n", result);
    
    str = presult;
    str = strchr(str, 0);
    *str++ = ' ';
}

int main(void) {
    char buffer[25] = {0};
    // my_itoa(buffer, 1234);
    my_itoa_error(buffer, 1234);
    printf("RESULT%sEND\n", buffer);
    return 0;
}

