#define _GNU_SOURCE
#include <getopt.h>
#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <string.h>
#include <time.h>

long long total_sum = 0;
int iterations = 1;
int num_threads = 1;
int yield = 0;
char sync_type;
pthread_t thread_id[12];
int lock = 0;
pthread_mutex_t mutex;

void add(long long *pointer, long long value) {
    long long sum = *pointer + value;
    if (yield)
        pthread_yield();
    *pointer = sum;
}

void* wrapper(void* data){
	for (int i = 0; i < iterations; ++i)
	{
        if (sync_type == 's') {
            while (__sync_lock_test_and_set(&lock, 1));
            add(&total_sum, 1);
            __sync_lock_release(&lock);
        } else if (sync_type == 'm'){
            pthread_mutex_lock(&mutex);
            add(&total_sum, 1);
            pthread_mutex_unlock(&mutex);
        } else if (sync_type == 'c'){
            long long prev;
            long long sum_c;
            do{
                prev = total_sum;
                sum_c = prev + 1;
                if (yield) {
                    pthread_yield();
                }
            }while(__sync_val_compare_and_swap(&total_sum,prev,sum_c) != prev);
        } else{
            add(&total_sum, 1);
        }
	}
	for (int i = 0; i < iterations; ++i)
	{
        if (sync_type == 's') {
            while (__sync_lock_test_and_set(&lock, -1));
            add(&total_sum, -1);
            __sync_lock_release(&lock);
        } else if (sync_type == 'm'){
            pthread_mutex_lock(&mutex);
            add(&total_sum, -1);
            pthread_mutex_unlock(&mutex);
        } else if (sync_type == 'c'){
            long long prev;
            long long sum_c;
            do{
                prev = total_sum;
                sum_c = prev - 1;
                if (yield) {
                    pthread_yield();
                }
            }while(__sync_val_compare_and_swap(&total_sum,prev,sum_c) != prev);
        } else{
            add(&total_sum, -1);
        }
	}
    return NULL;
}

int main(int argc, char** argv){
	struct timespec time_start, time_end;

	int opt = 0;
  	static struct	option long_opts[] =
    {
        {"threads", optional_argument, 0, 't'},
        {"iterations", optional_argument, 0, 'i'},
        {"yield", no_argument, 0, 'y'},
        {"sync", required_argument, 0, 's'}

    };
  	while (1){
    	int option_index = 0;
    	opt = getopt_long(argc, argv, "t:i:", long_opts, &option_index);
    	if (opt == -1)
      	break;
  		switch(opt){
    		case 't':
    			num_threads = atoi(optarg);
    			break;
    		case 'i':
    			iterations = atoi(optarg);
    			break;
            case 'y':
                yield = 1;
                break;
            case 's':
                if (strlen(optarg) == 1 && optarg[0] == 'm') {
                    sync_type = 'm';
                } else if (strlen(optarg) == 1 && optarg[0] == 's'){
                    sync_type = 's';
                } else if (strlen(optarg) == 1 && optarg[0] == 'c'){
                    sync_type = 'c';
                } else {
                    fprintf(stderr, "Incorrect argument. Available argument for sync: m, s, c\n");
                    exit(1);
                }
                break;
                
    		default:
    			fprintf(stderr,"wrong argument\n");
    			break;
    	}
    }
    if (clock_gettime(CLOCK_MONOTONIC, &time_start) == -1)
    {
    	perror("Recording starting time error.");
    	exit(1);
    }
    for (int i = 0; i < num_threads; ++i)
        pthread_create(thread_id+i,NULL,wrapper, NULL);

    for (int i = 0; i < num_threads; ++i)
    	pthread_join(thread_id[i],NULL);
    if (clock_gettime(CLOCK_MONOTONIC, &time_end) == -1)
    {
    	perror("Recording ending time error.");
    	exit(1);
    }
    long run_time = time_end.tv_nsec - time_start.tv_nsec;
    long num_ops = num_threads * iterations * 2;
    long average = run_time / num_ops;
    if (yield) {
        if (sync_type == 's') {
            printf("add-yield-s,%d,%d,%ld,%ld,%ld,%lld\n", num_threads,iterations,num_ops,run_time,average,total_sum);
        } else if (sync_type == 'c'){
            printf("add-yield-c,%d,%d,%ld,%ld,%ld,%lld\n", num_threads,iterations,num_ops,run_time,average,total_sum);
        } else if (sync_type == 'm'){
            printf("add-yield-m,%d,%d,%ld,%ld,%ld,%lld\n", num_threads,iterations,num_ops,run_time,average,total_sum);
        } else {
            printf("add-yield-none,%d,%d,%ld,%ld,%ld,%lld\n", num_threads,iterations,num_ops,run_time,average,total_sum);
        }
    } else {
        if (sync_type == 's') {
            printf("add-s,%d,%d,%ld,%ld,%ld,%lld\n", num_threads,iterations,num_ops,run_time,average,total_sum);
        } else if (sync_type == 'c'){
            printf("add-c,%d,%d,%ld,%ld,%ld,%lld\n", num_threads,iterations,num_ops,run_time,average,total_sum);
        } else if (sync_type == 'm'){
            printf("add-m,%d,%d,%ld,%ld,%ld,%lld\n", num_threads,iterations,num_ops,run_time,average,total_sum);
        } else {
            printf("add-none,%d,%d,%ld,%ld,%ld,%lld\n", num_threads,iterations,num_ops,run_time,average,total_sum);
        }
    
    }
    return 0;



}
