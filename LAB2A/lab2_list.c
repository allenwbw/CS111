#define _GNU_SOURCE

#include <getopt.h>
#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <string.h>
#include "SortedList.h"
#include <time.h>

#define BIL 1000000000L
#define KEY_LEN 10
#define NUM_ALPHABETS 26

//GLOBAL VARIABLES
//Defaults the number of iterations and threads to 1 and sets list len to 0 
//and the exclusion flag (used in test and set) to 0
int iterations = 1, num_threads = 1, list_len = 0, total_runs = 0, exclusion = 0;
char *yield_modes;
//Set the extern opt_yield to zero to begin with
int opt_yield = 0;
//Stores the argument specified for the option for syncing
char sync_type = '\0';
char* syncopts = "none";
//Mutex
pthread_mutex_t mutex;
//List
SortedList_t *list;
//Element Array
SortedListElement_t* element_pool;
int insert = 0;
int lookup = 0;
int delete = 0;
int list_num = 1;
char* yieldopts;

//Update the opt_yield to hold the defined macros based on the passed in arguments
//to yield
void yield_mode(char* modes){
    for (int i = 0; modes[i] != '\0'; i++) {
        switch (modes[i]) {
            case 'i':
                opt_yield |= INSERT_YIELD;
                insert = 1;
                break;
            case 'd':
                opt_yield |= DELETE_YIELD;
                delete = 1;
                break;
            case 'l':
                opt_yield |= LOOKUP_YIELD;
                lookup = 1;
                break;
            default:
                exit(EXIT_FAILURE);
        }
    }
    
    
}

void set_yieldopts(){
    if (insert && delete && lookup){
        yieldopts = "idl";
    }else if (insert && !delete && !lookup){
        yieldopts = "i";
    }else if (!insert && delete && !lookup){
        yieldopts = "d";
    }else if (!insert && !delete && lookup){
        yieldopts = "l";
    }else if (insert && delete && !lookup){
        yieldopts = "id";
    }else if (insert && !delete && lookup){
        yieldopts = "il";
    }else if (!insert && delete && lookup){
        yieldopts = "dl";
    }else{
        yieldopts = "none";
    }
}
void* insert_lookup_delete(void* n_threads)
{
	
	for(int i = *(int*)n_threads; i < total_runs; i += num_threads)
	{
		switch(sync_type)
		{
			case 'm':
				pthread_mutex_lock(&mutex);
				SortedList_insert(list, &element_pool[i]);
				pthread_mutex_unlock(&mutex);
				break;
			case 's':
				while(__sync_lock_test_and_set(&exclusion, 1));
				SortedList_insert(list, &element_pool[i]);
				__sync_lock_release(&exclusion);
				break;
			default:
				SortedList_insert(list, &element_pool[i]);
				break;
		}
	}

	list_len = SortedList_length(list);
	SortedListElement_t *temp;
	//Lookup and delete based on locking, with the same indexing as before
	for(int j = *(int*)n_threads; j < total_runs; j += num_threads)
	{
		switch(sync_type)
		{
			case 'm':
				pthread_mutex_lock(&mutex);
				temp = SortedList_lookup(list, element_pool[j].key);
                if (temp == NULL) {
                    perror("Corrupt list.\n");
                }
				SortedList_delete(temp);
				pthread_mutex_unlock(&mutex);
				break;
			case 's':
				while(__sync_lock_test_and_set(&exclusion, 1));
				temp = SortedList_lookup(list, element_pool[j].key);
                if (temp == NULL) {
                    perror("Corrupt list.\n");
                }
				SortedList_delete(temp);
				__sync_lock_release(&exclusion);
				break;
			default:
				temp = SortedList_lookup(list, element_pool[j].key);
                if (temp == NULL) {
                    perror("Corrupt list.\n");
                }
				SortedList_delete(temp);
				break;
		}
	}
	list_len = SortedList_length(list);
	return NULL;
}

void fill_pool()
{
	
	srand(time(NULL));

	for(int t = 0; t < total_runs; t++)
	{
		
		int rand_length = rand() % KEY_LEN + 5;
		int rand_letter = rand() % NUM_ALPHABETS;
		char* rand_key = malloc((rand_length+1) * sizeof(char));
		for(int i = 0; i < rand_length; i++)
		{
			rand_key[i] = 'a' + rand_letter;
			rand_letter = rand() % 26;
		}
		rand_key[rand_length] = '\0';	
        element_pool[t].key = rand_key;
	}
}

int main(int argc, char **argv)
{
	//The exit status defaults to 0 unless of error
	int opt = 0, exit_status = 0;
	struct timespec start, end;
	static struct option long_opts[] = 
	{
		{"threads", required_argument, 0, 't'},
		{"yield", required_argument, 0, 'y'},
		{"sync", required_argument, 0, 's'},
		{"iterations", required_argument, 0, 'i'}
	};

	while((opt = getopt_long(argc, argv, "t:i:s:y:", long_opts, NULL)) != -1)
	{
		switch(opt)
		{
			case 't':
				num_threads = atoi(optarg);
				break;
			case 'i':
				iterations = atoi(optarg);
				break;
			case 'y':
				yield_mode(optarg);
				break;
			case 's':
				if(strlen(optarg) == 1 && optarg[0] == 'm') {
                    sync_type = 'm';
                    syncopts = "m";
                }else if(strlen(optarg) == 1 && optarg[0] == 's') {
                    sync_type = 's';
                    syncopts = "s";
                }else {
                    fprintf(stderr, "Incorrect argument. Available argument for sync: m, s\n");
                    exit(1);
                }
				break;
			default:
				fprintf(stderr, "Usage [ti] default threads is 1 and iterations is 1\n");
				exit(1);
		}
	}
    set_yieldopts();
	if(sync_type == 'm') {
        pthread_mutex_init(&mutex, NULL);
    }

	total_runs = num_threads * iterations;

	list = malloc(sizeof(SortedList_t));
	list->key = NULL;
	list->next = list;
	list->prev = list;

	element_pool = malloc(total_runs * sizeof(SortedListElement_t));

	fill_pool();

	pthread_t *threads = malloc(num_threads * sizeof(pthread_t));

	int* tids = malloc(num_threads * sizeof(int));

	if(clock_gettime(CLOCK_MONOTONIC, &start) == -1) { perror("Time Start Error"); exit(1); }
	for(int t = 0; t < num_threads; t++)
	{
		tids[t] = t;
		int status = pthread_create(threads + t, NULL, insert_lookup_delete, &tids[t]);
		if(status) { perror("Creation Error"); exit(1); } 
	}
	for(int t = 0; t < num_threads; t++)
	{
		int status = pthread_join(threads[t], NULL);
		if(status) { perror("Creation Error"); exit(1); } 
	}
	if(clock_gettime(CLOCK_MONOTONIC, &end) == -1) { perror("Time End Error"); exit(1); }

	free(tids);
	free(element_pool);
	free(threads);

	//Calculate overall time
	long tot_time = end.tv_nsec - start.tv_nsec;
	int num_ops = total_runs * 3;
	//Cost per operation
	long average = tot_time / num_ops;

	if(list_len != 0)
	{
		fprintf(stderr, "Corrupted list\n", list_len);
        exit(1);
	}
    printf("list-%s-%s,%d,%d,%d,%ld,%ld,%ld\n",yieldopts,syncopts,num_threads,iterations,list_num,num_ops,tot_time,average);
    return 0;

}
