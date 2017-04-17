.SILENT:

default: build

build:
	gcc -pthread -lrt -o lab2-list -g lab2_list.c SortedList.c -std=c99
	gcc -pthread -lrt -o lab2_add -g lab2_add.c -std=c99

test: build
	rm -rf *.csv
	chmod u+x *.sh
	./test_add.sh
	./test_list.sh

tarball: test
	tar -zcvf lab2a-704448696.tar.gz *.png *.c *.h *.csv *.sh *.gp Makefile README.txt

graph: test
	chmod u+x *.gp
	./lab2_add.gp
	./lab2_list.gp
clean:
	rm -rf *.png lab2_add lab2-list *.csv