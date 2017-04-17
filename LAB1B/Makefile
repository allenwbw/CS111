.SILENT:

default: client server

client: client.c
	gcc -pthread -lmcrypt -o client client.c
server: server.c
	gcc -pthread -lmcrypt -o server server.c
clean:
	rm -rf client server
dist:
	tar -zcvf lab1b-704448696.tar.gz server.c client.c Makefile my.key README
