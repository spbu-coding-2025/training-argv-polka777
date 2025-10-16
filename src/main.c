#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>

int is_low = 0;
int is_up = 0;

int main(int argc, char * argv[]) {
        int low = 0;
        int up = 0;
        static struct option long_options[] = {
                {"lower_bound=", 1, &is_low, 1}, 
                {"upper_bound=", 1, &is_up, 1}
        };
        while (getopt_long(argc, argv, "", long_options, NULL)!=-1){
                if (is_low==1) {
                        low = atoi(optarg);
                        is_low = 3;
                }
                if (is_up==1) {
                        up = atoi(optarg);
                        is_up = 3;
                }
        }
        if (is_low==0 && is_up==0) {
                fprintf(stderr, "No flags found.\n");
                return 1;

        }
        if (is_low==3 && is_up==0) {
                fprintf(stderr, "Flag --upper_bound is missing.\n");
                return 1;
        }
        if (is_low==0 && is_up==3) {
                fprintf(stderr, "Flag --lower_bound is missing.\n");
                return 1;
        }
        if (low > up) {
                fprintf(stderr, "The lower bound is greater than the upper bound.\n");
                return 1;
        }
        else {
                for (int i = low; i <= up; i++) {
                        printf("%d ", i);
                }
        }
}
