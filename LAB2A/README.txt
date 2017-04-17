Answer:

QUESTION 2.1.1 - causing conflicts:
Why does it take many iterations before errors are seen?
Why does a significantly smaller number of iterations so seldom fail?

With higher iterations, the chance of collision increases, which results in more consistent failures.

QUESTION 2.1.2 - cost of yielding:
Why are the --yield runs so much slower?  Where is the additional time going?  Is it possible to get valid per-operation timings if we are using the --yield option?  If so, explain how.  If not, explain why not.

When yielding occurs, the thread is interrupted for other threads to run, which will incur context switching. The constant context switching will slow down performance drastically. It is possible when we count the number of yielding and subtract the time of context switching from the overall runtime.

QUESTION 2.1.3 - measurement errors:
Why does the average cost per operation drop with increasing iterations?
If the cost per iteration is a function of the number of iterations, how do we know how many iterations to run (or what the “correct” cost is)?

With small number of iterations, the time consumed in creating each threads is large comparing to the time of running actual operations, which makes the average time per operation larger than large number of iterations. 

QUESTION 2.1.4 - costs of serialization:
Why do all of the options perform similarly for low numbers of threads?
Why do the three protected operations slow down as the number of threads rises?
Why are spin-locks so expensive for large numbers of threads?

For small number of threads, the time used for each option in locking and waiting to run critical section is roughly the same, which results in similar performance.

As the number of threads rise all three options have to find some way of dealing with making other threads busy/wait while the critical section is locked or the data is being updated. This thus adds blocking/waiting times and slows down the operations.

Spin-locks makes other threads spin which is CPU consuming. When threads number exceed the number of cores in cpu, the resources wasted by spinning can slow down the operation massively.

QUESTION 2.2.1 - scalability of Mutex
Compare the variation in time per protected operation vs the number of threads (for mutex-protected operations) in Part-1 and Part-2, commenting on similarities/differences and offering explanations for them.

Differences:
1. the critical section in part2 is much larger than part1 which results in higher number of operations is trapped in mutex lock.

2. since the critical sections are larger, the number of blocked threads of part2 is larger than part1, which results in slower performance.

Similarity:
1. the performance of both part slows down when too many threads are created(comparing to the number of cores of cpu).

QUESTION 2.2.2 - scalability of spin locks
Compare the variation in time per protected operation vs the number of threads for Mutex vs Spin locks, commenting on similarities/differences and offering explanations for them.

the time per operation for both types of locks stay around the same but as the ratio of threads to lists increases spin lock seems to do a better job. The reason for this is possibly because in Linux mutexes are implemented under the ideology of futexes which have some overhead
in the few system calls made to put a thread to sleep, while for relatively for small number of operations
spin-locks can work effectively.

Makefile:
	This makefile contains four targets:
	build: compile lab2-list and lab2_add
	test: using over 200 test cases to generate two csv files for graphing
	tarball: make a tarball of all the sorce files and graphs
	clean: delete all generated files.

README:
	anwsers for the questions.

lab2_add.c:
	the source code for part1.

lab2_list.c SortedList.c SortedList.h:
	lab2_list.c contains the main program for part2.
	SortedList.c contains the functions for a double linked list defined in Sortedlist.h

*.png:
	graphs generated with gunplot with data generated with test cases in makefile.

*.gp:
	script for generating graphs with gunplot.
	
