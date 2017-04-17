SortedList.h: a header file containing interfaces for linked list operations.

SortedList.c:
the source for a C source module (SortedList.c) that compiles cleanly (with no errors or warnings), and implements insert, delete, lookup, and length methods for a sorted doubly linked list (described in the provided header file, including correct placement of pthread_yield calls).
the source for a C program (lab2_list.c) that  compiles cleanly (with no errors or warnings), and implements the specified command line options (--threads, --iterations, --yield, --sync, --lists), drives one or more parallel threads that do operations on a shared linked list, and reports on the final list and performance.

Makefile:
the file to build the deliverable programs, output, graphs, and tarball.  For your early testing you are free to run your program manually, but by the time you are done, all of the below-described test cases should be executed, the output captured, and the graphs produced automatically.  The higher level targets are:
build … compile all programs (default target)
tests … run all specified test cases to generate CSV results
profile … run tests with profiling tools to generate an execution profiling report
graphs … use gnuplot to generate the required graphs
tarball … create the deliverable tarball
clean … delete all generated programs and output
lab_2b_list.csv - containing your results for all of the Part-2 performance tests.
execution profiling report showing where time was spent :
In the un-partitioned mutex implementation, for 32 threads.
In the un-partitioned spin-lock implementation, for 32 threads.
graphs (.png files), created by gnuplot(1) on the above csv data showing:
lab2b_1.png … throughput vs number of threads for mutex and spin-lock synchronized adds and list operations.
lab2b_2.png … mean time per mutex wait and mean time per operation for mutex-synchronized list operations.
lab2b_3.png … number of successful iterations for each synchronization method.
lab2b_4.png … throughput vs number of threads for mutexes with partitioned lists.
lab2b_5.png … throughput vs number of threads for spin-locks with partitioned lists.

test.sh:
	test cases for generating graph.

profile.txt:
	a cpu profile analysis generated with gperftools.



QUESTION 2.3.1 - Cycles in the basic implementation:
Where do you believe most of the cycles are spent in the 1 and 2-thread tests (for both add and list)?  
Why do you believe these to be the most expensive parts of the code?
Where do you believe most of the time/cycles are being spent in the high-thread spin-lock tests?
Where do you believe most of the time/cycles are being spent in the high-thread mutex tests?

For 1 and 2 threads, the contention between threads can be small. So the most cycles are spent executing operations.
For high-thread spin-lock, the contention is big, so most cycles are spend by threads waiting for the lock.
For high-thread mutex, for add operations, most of the cycles is spend on locks. for lists, since the program has to go through the list to do insertion or lookup, which is performance consuming, most of the cycles are spend on doing these operations.

QUESTION 2.3.2 - Execution Profiling:
Where (what lines of code) are consuming most of the cycles when the spin-lock version of the list exerciser is run with a large number of threads?
Why does this operation become so expensive with large numbers of threads?

When there is large number of threads, most of cycles are spend on waiting for the lock. Because the contention is massive, many threads have to wasting cycles waiting for the lock.

QUESTION 2.3.3 - Mutex Wait Time:
Look at the average time per operation (vs # threads) and the average wait-for-mutex time (vs #threads).  
Why does the average lock-wait time rise so dramatically with the number of contending threads?
Why does the completion time per operation rise (less dramatically) with the
number of contending threads?
How is it possible for the wait time per operation to go up faster (or higher) than the completion time per operation?


QUESTION 2.3.3 - Mutex Wait Time:
Look at the average time per operation (vs # threads) and the average wait-for-mutex time (vs #threads).  
Why does the average lock-wait time rise so dramatically with the number of contending threads?
Why does the completion time per operation rise (less dramatically) with the
number of contending threads?
How is it possible for the wait time per operation to go up faster (or higher) than the completion time per operation?

Since there are many threads and only one lock, the total wait time for threads is dramatically increased when the threads number is high.

When the number of contending threads runs up, especially when there are more threads than cpu cores, the time overhead on waiting the lock is added to the program running time and thus increase the average time per operation.

Since the wait time is calculated by adding the wait time of every threads, some overlapped waiting time of threads is added seperately which makes the total waiting time goes up faster or even higher than the average time per operation.

QUESTION 2.3.4 - Performance of Partitioned Lists
Explain the change in performance of the synchronized methods as a function of the number of lists.
Should the throughput continue increasing as the number of lists is further increased?  If not, explain why not.
It seems reasonable to suggest the throughput of an N-way partitioned list should be equivalent to the throughput of a single list with fewer (1/N) threads.  Does this appear to be true in the above curves?  If not, explain why not.

The result of the test shows an improvement in throughput when the list number goes up. This is probably because the more the lists, the less contention amoung the threads which makes waiting time shorter.

It should not. The throughput is also limited by the number of cores in the cpu, the performance should be more consistant when the number of list is more than the number of the cpu cores.

According the graph generated by the test, it appears to be true

