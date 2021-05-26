#include <cpuid.h>  // GCC-provided
#include <stdio.h>
#include <stdint.h>

int main(void) {
    uint32_t eax, ebx, ecx, edx;
    if (__get_cpuid(0x80000006, &eax, &ebx, &ecx, &edx)) {
        printf("Line size: %d B, Assoc. Type: %d; Cache Size: %d KB.\n", ecx & 0xff, (ecx >> 12) & 0x07, (ecx >> 16) & 0xffff);
        return 0;
    }
    else {
        fputs(stderr, "CPU does not support 0x80000006");
        return 2;
    }
}

EAX = 80000