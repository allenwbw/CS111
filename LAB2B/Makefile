.SILENT:


default: biuld

build: 
	gcc -pthread -lrt -o lab2_list -g  lab2_list.c SortedList.c -std=c99

profile: build
	LD_PRELOAD=/u/eng/ugrad/bowei/cs111proj2a/final/gperftools-2.5/.libs/libprofiler.so.0 CPUPROFILE=/u/eng/ugrad/bowei/cs111proj2a/final/raw.perf ./lab2_list --threads=12 --iterations=1000 --sync=s
	pprof -text lab2_list raw.perf >> profile.txt
	pprof -list lab2_list raw.perf >> profile.txt

test: build
	rm -rf *.csv
	chmod u+x test.sh
	./test.sh
graph: test
	chmod u+x lab2b.gp
	./lab2b.gp
clean:
	rm -rf lab2_list *.png *.csv

tarbal: 
	tar -zcvf lab2b-704448696.tar.gz *.png *.sh *.c *.h *.txt *.csv