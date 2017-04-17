#define _GNU_SOURCE

#include <getopt.h>
#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <string.h>
#include "SortedList.h"
#include <time.h>

#define KEY_LEN 10
#define NUM_ALPHABETS 26


int iterations = 1, num_threads = 1, list_len = 0, total_runs = 0;
char *yield_modes;
int opt_yield = 0;
char sync_type = '\0';
char* syncopts = "none";
pthread_mutex_t mutex;
SortedList_t *list;
SortedListElement_t* element_pool;
int insert = 0;
int lookup = 0;
int delete = 0;
int list_num = 1;
char* yieldopts;
struct timespec mutex_insert_start[24];
struct timespec mutex_insert_end[24];
long mutex_insert_time[24];
struct timespec mutex_delete_start[24];
struct timespec mutex_delete_end[24];
long mutex_delete_time[24];
long mutex_time_per_thread[24];
long mutex_time_total = 0;
SortedList_t* list_parts;
int* indices;
int* spins;
pthread_mutex_t* mutexes;

unsigned long hash_function(const char* key)
{
	int prime[26] = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101};
	unsigned long uuid = 1;
	for(int i = 0; key[i] != '\0'; i++)
	{
		uuid *= prime[key[i] - 'a'];
	}
	return uuid % list_num;
}

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

void sync_initialize()
{
	//Initialize mutex if argument specified
	if(sync_type == 'm')
	{
		mutexes = malloc(list_num * sizeof(pthread_mutex_t));
		for(int i = 0; i < list_num; i++)
		{
			pthread_mutex_init(&mutexes[i], NULL);
		}
	} else if(sync_type == 's')
	{
		spins = malloc(list_num * sizeof(int));
		for(int i = 0; i < list_num; i++)
		{
			spins[i] = 0;
		}
	}
}

void lists_initialize(){
	list_parts = malloc(list_num * sizeof(SortedList_t));
	for (int i = 0; i < list_num; ++i)
	{
		list_parts[i].key = NULL;
		list_parts[i].next = &list_parts[i];
		list_parts[i].prev = &list_parts[i];
	}
}

void indices_initialize(){
	indices = malloc(total_runs * sizeof(int));
	for (int i = 0; i < total_runs; ++i)
	{
		indices[i] = hash_function(element_pool[i].key);
	}
}

void* insert_lookup_delete(void* n_threads)
{
	
	for(int i = *(int*)n_threads; i < total_runs; i += num_threads)
	{
		switch(sync_type)
		{
			case 'm':
				pthread_mutex_lock(&mutexes[indices[i]]);
				SortedList_insert(&list_parts[indices[i]], &element_pool[i]);
				pthread_mutex_unlock(&mutexes[indices[i]]);
				break;
			case 's':
				while(__sync_lock_test_and_set(&spins[indices[i]], 1));
				SortedList_insert(&list_parts[indices[i]], &element_pool[i]);
				__sync_lock_release(&spins[indices[i]]);
				break;
			default:
				SortedList_insert(&list_parts[indices[i]], &element_pool[i]);
				break;
		}
	}

	list_len = 0;
	switch(sync_type)
	{
		case 'm':
			for(int i = 0; i < list_num; i++)
			{
				pthread_mutex_lock(&mutexes[i]);
				list_len += SortedList_length(&list_parts[i]);
				pthread_mutex_unlock(&mutexes[i]);
			}
			break;
		case 's':
			for(int i = 0; i < list_num; i++)
			{
				while(__sync_lock_test_and_set(&spins[i], 1));
				list_len += SortedList_length(&list_parts[i]);
				__sync_lock_release(&spins[i]);
			}
			break;
		default:
			for(int i = 0; i < list_num; i++)
			{
				list_len += SortedList_length(&list_parts[i]);
			}
			break;
	}



	SortedListElement_t *temp;
	for(int i = *(int*)n_threads; i < total_runs; i += num_threads)
	{
		switch(sync_type)
		{
			case 'm':
				
				pthread_mutex_lock(&mutexes[indices[i]]);
				temp = SortedList_lookup(&list_parts[indices[i]], element_pool[i].key);
                if (temp == NULL) {
                    perror("Corrupt list.\n");
                }
				SortedList_delete(temp);
				pthread_mutex_unlock(&mutexes[indices[i]]);
				break;
			case 's':
				while(__sync_lock_test_and_set(&spins[indices[i]], 1));
				temp = SortedList_lookup(&list_parts[indices[i]], element_pool[i].key);
                if (temp == NULL) {
                    perror("Corrupt list.\n");
                }
				SortedList_delete(temp);
				__sync_lock_release(&spins[indices[i]]);
				break;
			default:
				temp = SortedList_lookup(&list_parts[indices[i]], element_pool[i].key);
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
	int opt = 0;
	struct timespec start, end;
	static struct option long_opts[] = 
	{
		{"threads", required_argument, 0, 't'},
		{"yield", required_argument, 0, 'y'},
		{"sync", required_argument, 0, 's'},
		{"iterations", required_argument, 0, 'i'},
		{"lists", required_argument, 0, 'l'}
	};

	while((opt = getopt_long(argc, argv, "t:i:s:y:l:", long_opts, NULL)) != -1)
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
			case 'l':
				list_num = atoi(optarg);
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
	element_pool = malloc(total_runs * sizeof(SortedListElement_t));
	lists_initialize();
	fill_pool();
	sync_initialize();
	indices_initialize();

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
	free(mutexes);
	free(spins);

	//Calculate overall time
	long tot_time = end.tv_nsec - start.tv_nsec;
	int num_ops = total_runs * 3;
	//Cost per operation
	long average = tot_time / num_ops;
    printf("list-%s-%s,%d,%d,%d,%ld,%ld,%ld\n",yieldopts,syncopts,num_threads,iterations,list_num,num_ops,tot_time,average);
    return 0;

}
