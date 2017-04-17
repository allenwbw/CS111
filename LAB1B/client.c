//
//  client.c
//  cs111proj1b
//
//  Created by Wang Bowei on 10/9/16.
//  Copyright © 2016 Wang Bowei. All rights reserved.
//

#include <stdio.h>
#include <termios.h>
#include <mcrypt.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>
#include <getopt.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <netinet/in.h>
#include <netdb.h>
int encrypt_flag = 0;
int log_flag = 0;
char* log_dest;
int ffd;
pthread_t thread_id;
int sock_fd;
struct termios original_state;
struct termios noncan_state;
MCRYPT crypt_fd, decrypt_fd;
int key_length;

//fetch key from file for encryption and decryption
char* find_key(char* filename){
    
    struct stat filestat;
    int kfd = open(filename, O_RDONLY);
    if (fstat(kfd, &filestat)<0) {
        fprintf(stderr, "fstat error.");
        exit(EXIT_FAILURE);
    }
    key_length = filestat.st_size;
    char* key = malloc(filestat.st_size*sizeof(char));
    if (read(kfd, key, filestat.st_size) <= 0) {
        fprintf(stderr, "read error.");
        exit(EXIT_FAILURE);
    }
    return key;
}

//use blowfish ofd to encrypt buffer
void encrypt(char *buff, int crypt_len)
{
    if(mcrypt_generic(crypt_fd, buff, crypt_len) != 0) {
        perror("Error in encryption"); exit(EXIT_FAILURE);
    }
}

//use blowfish ofd to decrypt buffer
void decrypt(char * buff, int decrypt_len)
{
    if(mdecrypt_generic(decrypt_fd, buff, decrypt_len) != 0) {
        perror("Error in decryption"); exit(EXIT_FAILURE);
    }
}
//Initializes encryption modules
void encryption_init(char *key, int key_len)
{
    crypt_fd = mcrypt_module_open("blowfish", NULL, "ofb", NULL);
    if(crypt_fd == MCRYPT_FAILED) {
        perror("Error opening module");
        exit(EXIT_FAILURE);
    }
    if(mcrypt_generic_init(crypt_fd, key, key_len, NULL) < 0) {
        perror("Error while initializing encrypt");
        exit(EXIT_FAILURE);
    }
    decrypt_fd = mcrypt_module_open("blowfish", NULL, "ofb", NULL);
    if(decrypt_fd == MCRYPT_FAILED) {
        perror("Error opening module");
        exit(EXIT_FAILURE);
    }
    if(mcrypt_generic_init(decrypt_fd, key, key_len, NULL) < 0) {
        perror("Error while initializing decrypt");
        exit(EXIT_FAILURE);
    }
}

//Deinitializes encryption module
void encryption_deinit()
{
    mcrypt_generic_deinit(crypt_fd);
    mcrypt_module_close(crypt_fd);
    mcrypt_generic_deinit(decrypt_fd);
    mcrypt_module_close(decrypt_fd);
}





void restore()
{
    tcsetattr(STDIN_FILENO, TCSANOW, &original_state);
    if (encrypt_flag){
        encryption_deinit();
    }
}
//kill the program and close all connection
void terminate(int from_socket){
    if (from_socket) {
        close(sock_fd);
        restore();
        exit(1);
    }else{
        pthread_cancel(thread_id);
        close(sock_fd);
        restore();
        exit(0);
    }
}

//for conducting I/O to specified file descriptor
void in_n_out(int rfd, int wft, int log_enable, int from_socket){
    int nchar = 0;
    char buff[100];
    int i;
    while (nchar = read(rfd, buff, 100)) {
        if (!from_socket && log_enable) {
            dprintf(ffd,"SENT %d bytes: ",nchar);
        }
        if (from_socket&&log_enable) {
            dprintf(ffd,"RECEIVED %d bytes: ",nchar);
        }
        if (log_enable){
            write(ffd, buff, nchar);
        }
        if (encrypt_flag && from_socket) {
            decrypt(buff, nchar);
        }
        for (i=0; i<nchar; i++) {
            if (buff[i] == 0x04) {
                terminate(from_socket);
            }else{
                
                if (!from_socket){
                    write(STDOUT_FILENO, buff+i, 1);
                    if (encrypt_flag) {
                        encrypt(buff+i, 1);
                    }
                    if (log_enable)
                        write(ffd, buff+i, 1);
                    write(wft, buff+i, 1);
                }
                if (from_socket) {
                    write(wft, buff+i, 1);
                }
            }
        }
        if (log_enable) {
            dprintf(ffd,"\n");
        }
    }

}
//for conducting I/O in thread
void* read_from_socket(void* log_enable){
    in_n_out(sock_fd, STDOUT_FILENO, *(int *)log_enable, 1);
}

int main(int argc, char ** argv) {
    int opt = 0;
    int port_num;
    
    struct hostent* server;
    struct sockaddr_in serv_addr;
    sock_fd = socket(AF_INET, SOCK_STREAM, 0);
    static struct option long_opts[] =
    {
        {"port", required_argument, 0, 'p'},
        {"log", required_argument, 0, 'l'},
        {"encrypt", no_argument, 0, 'e'}
    };
    while (1) {
        opt = getopt_long(argc, argv, "p:l:e", long_opts, NULL);
        if (opt == -1) {
            break;
        }
        switch(opt)
        {
            case 'p':
                port_num = atoi(optarg);
                break;
            case 'e':
                encrypt_flag = 1;
                char* key = find_key("my.key");
                encryption_init(key, key_length);
                break;
            case 'l':
                log_dest = optarg;
                log_flag = 1;
                ffd = creat(log_dest, S_IRWXU);
                break;
            default:
                fprintf(stderr, "Wrong argument.");
                break;
                
        }
    }
    tcgetattr(STDIN_FILENO, &original_state);
    tcgetattr(STDIN_FILENO, &noncan_state);
    noncan_state.c_lflag &= ~(ECHO | ICANON);
    if (tcsetattr(STDOUT_FILENO, TCSANOW, &noncan_state) < 0) {
        perror("Set non-canonical mode fail.");
        exit(EXIT_FAILURE);
    }
    server = gethostbyname("localhost");
    serv_addr.sin_family = AF_INET;
    memcpy((char*)&serv_addr.sin_addr.s_addr, (char*)server->h_addr, server->h_length);
    serv_addr.sin_port = htons(port_num);
    if(connect(sock_fd,(struct sockaddr *) &serv_addr, sizeof(serv_addr)) < 0){
        perror("Error connecting");
        exit(0);
    }
    pthread_create(&thread_id, NULL, read_from_socket, &log_flag);
    in_n_out(STDIN_FILENO, sock_fd, log_flag, 0);
    
    
}
