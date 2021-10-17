#include <stdio.h>

// loop asm info
// https://www.felixcloutier.com/x86/loop:loopcc
int loop( int count, int startNum ) {
    int result ;
    __asm__ __volatile__ ( "movl %2, %%eax;"
                          "CONTD: "
                            "inc %%eax;"
                          "loop CONTD;"        // loop use rcx anmd decrement the value
                          "movl %%eax, %0;" 
                          : "=g" (result)  // output operand
                          : "g" (count), "g" (startNum) // input operand
                          // : clobber
                          );
    return result ;
}

int main() {
    int count = 10;
    int startNum = 0;

    printf( "Count from of %d with counter value of %d is %d\n", startNum, count, loop(count, startNum) ) ;

    return 0 ;
}