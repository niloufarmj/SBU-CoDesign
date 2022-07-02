#include <stdio.h>
#include <stdbool.h>

volatile long *n_out = (long *) 0x80000000;
volatile long *i_out = (long *) 0x80000008;
volatile long *j_out = (long *) 0x80000010;
volatile long *l1_out = (long *) 0x80000018;
volatile double *c1_out = (double *) 0x80000020;
volatile double *c1_in = (double *) 0x80000028;
volatile double *c2_out = (double *) 0x80000030;
volatile double *c2_in = (double *) 0x80000038;
volatile double *u1_out = (double *) 0x80000040;
volatile double *u2_out = (double *) 0x80000048;
volatile int *swap_req = (int *) 0x80000050;
volatile int *swap_ack = (int *) 0x80000054;
volatile int *c2_req = (int *) 0x80000058;
volatile int *c2_ack = (int *) 0x8000005c;
volatile int *c1_req = (int *) 0x80000060;
volatile int *c1_ack = (int *) 0x80000064;
volatile int *in_loop_req = (int *) 0x80000068;
volatile int *in_loop_ack = (int *) 0x8000006c;
volatile int *scale_req = (int *) 0x80000070;
volatile int *scale_ack = (int *) 0x80000074;
volatile int *in_ready = (int *) 0x80000078;
volatile int *done_out = (int *) 0x8000007c;

void show(const char * s, double bufr[], double bufi[]) {
	printf("%s", s);
    int i;
	for (i = 0; i < 8; i++)
		printf("%lf,%lf\n", bufr[i], bufi[i]);
}

int main () {

	double bufr[] = {1, 1, 0, 0, 1, 1, 0, 0};
	double bufi[] = {0, 0, 0, 0, 0, 0, 0, 0};
    double tx, ty, t1, t2;
    long i1;

    show("\nData:\n", bufr,bufi);

    while(true){

        if (*done_out) { // exit loop when hardware informs us that the computing is done 
            break;
        }

        if (*swap_req) { // do the swapping every time the hardware informs us with making swap req 1
            *swap_ack = 0;           
            tx = bufr[*i_out];
            ty = bufi[*i_out];
            bufr[*i_out] = bufr[*j_out];
            bufi[*i_out] = bufi[*j_out];
            bufr[*j_out] = tx;
            bufi[*j_out] = ty;
            *swap_ack = 1; // informing the hardware that swapping is done
            *swap_req = 0; // swap is done so no req untill hardware makes it 1 again
        }

        /********** the same logic of swap is used in other if blocks too *********/


        if (*c2_req) {
            *c2_ack = 0;
            *c2_in = sqrt((1.0 - *c1_out) / 2.0);
            *c2_ack = 1;
            *c2_req = 0;
        }

        if (*c1_req) {
            *c1_ack = 0;
            *c1_in = sqrt((1.0 - *c1_out) / 2.0);
            *c1_ack = 1;
            *c1_req = 0;
        }

        if (*in_loop_req) {
            *in_loop_ack = 0;
            i1 = *i_out + *l1_out;
            t1 = *u1_out * bufr[i1] - *u2_out * bufi[i1];
            t2 = *u1_out * bufi[i1] + *u2_out * bufr[i1];
            bufr[i1] = bufr[*i_out] - t1;
            bufi[i1] = bufi[*i_out] - t2;
            bufr[*i_out] += t1;
            bufi[*i_out] += t2;
            *in_loop_ack = 1;
            *in_loop_req = 0;
        }

        if (*scale_req) {
            *scale_ack = 0;
            bufr[*i_out] /= *n_out;
            bufi[*i_out] /= *n_out;
            *scale_ack = 1;
            *scale_req = 0;           
        }

    }

    show("\nFFT:\n", bufr, bufi);

    getchar();

    return 0;
}