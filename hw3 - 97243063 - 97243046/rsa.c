#include <stdio.h>

volatile unsigned int *gcd_out         = (unsigned int *) 0x80000000;
volatile unsigned int *gcd_strb        = (unsigned int *) 0x80000004;
volatile unsigned int *pow_out         = (unsigned int *) 0x80000008;
volatile unsigned int *pow_strb        = (unsigned int *) 0x8000000C;
volatile unsigned int *point1_out      = (unsigned int *) 0x80000010;
volatile unsigned int *point1_strb     = (unsigned int *) 0x80000014;
volatile unsigned int *point2_out      = (unsigned int *) 0x80000018;
volatile unsigned long int *point2_strb     = (unsigned int *) 0x8000001C;
volatile unsigned long int *e_out           = (unsigned int *) 0x80000020;
volatile unsigned long int *z_out           = (unsigned int *) 0x80000024;
volatile unsigned long int *d_out           = (unsigned int *) 0x80000028;


int main() {

    unsigned int p = 23;
    unsigned int q = 2;
    unsigned int n = p * q;
    unsigned int e = 2;
    unsigned int z = (p - 1) * (q - 1);
    unsigned int d = 2;

    /*   *   *   *   *   *   *   *   *   *   point 1   *   *   *   *   *   *   *   *   *   */
    *e_out = e;
    *z_out = z;
    while (! *point1_strb) {}

    // final e 
    e = *point1_out;


    /*   *   *   *   *   *   *   *   *   *   point 2   *   *   *   *   *   *   *   *   *   */
    *d_out = 2;
    *e_out = e;
    *z_out = z;
    while (! *point2_strb) {}
    d = *point2_out;


    /*   *   *   *   *   *   *   *   *   *   point 3   *   *   *   *   *   *   *   *   *   */
    unsigned int msg = 20;
    printf("Message data = %d", msg);


    /*   *   *   *   *   *   *   *   *   *   point 4   *   *   *   *   *   *   *   *   *   */
    *e_out = msg;
    *z_out = e;
    while (! *pow_strb);
    unsigned long long c = pow_out;
    c = c % n;
    printf("\n Encrypted data = %ld", c);


    /*   *   *   *   *   *   *   *   *   *   point 5   *   *   *   *   *   *   *   *   *   */
    *e_out = c;
    *z_out = d;
    while (! *pow_strb);
    unsigned long long m = pow_out;
    m = m % n;
    printf("\nOriginal message sent = %ld", m);
    

    return 0;
}