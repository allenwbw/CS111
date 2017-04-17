//
//  main.c
//  cs111proj1b
//
//  Created by Wang Bowei on 10/8/16.
//  Copyright © 2016 Wang Bowei. All rights reserved.
//
#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <getopt.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <netinet/in.h>
#include <mcrypt.h>


int key_length;
int encrypt_flag = 0;
int port_num;
int socket_fd;
int newsocket_fd;
int p_to_shell[2];
int p_from_shell[2];
pid_t process_id;
pthread_t thread_id;
MCRYPT crypt_fd, decrypt_fd;

//fetch key from file for decryption and encryption
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

//encrypt a buffer with blowfish algorithm
void encrypt(char *buff, int crypt_len)
{
    if(mcrypt_generic(crypt_fd, buff, crypt_len) != 0) { perror("Error in encryption"); exit(EXIT_FAILURE); }
}

//decrypt a buffer
void decrypt(char * buff, int decrypt_len)
{
    if(mdecrypt_generic(decrypt_fd, buff, decrypt_len) != 0) { perror("Error in decryption"); exit(EXIT_FAILURE); }
}
//Initializes encryption module
void encryption_init(char *key, int key_len)
{
    crypt_fd = mcrypt_module_open("blowfish", NULL, "ofb", NULL);
    if(crypt_fd == MCRYPT_FAILED) { perror("Error opening module"); exit(EXIT_FAILURE); }
    if(mcrypt_generic_init(crypt_fd, key, key_len, NULL) < 0) { perror("Error while initializing encrypt"); exit(EXIT_FAILURE); }
    
    decrypt_fd = mcrypt_module_open("blowfish", NULL, "ofb", NULL);
    if(decrypt_fd == MCRYPT_FAILED) { perror("Error opening module"); exit(EXIT_FAILURE); }
    if(mcrypt_generic_init(decrypt_fd, key, key_len, NULL) < 0) { perror("Error while initializing decrypt"); exit(EXIT_FAILURE); }
}

//Deinitializes encryption module
void encryption_deinit()
{
    mcrypt_generic_deinit(crypt_fd);
    mcrypt_module_close(crypt_fd);
    
    mcrypt_generic_deinit(decrypt_fd);
    mcrypt_module_close(decrypt_fd);
}



//for execute shell
void shell_exec(){
    close(0);
    dup(p_to_shell[0]);
    close(1);
    dup(p_from_shell[1]);
    close(2);
    dup(p_from_shell[1]);
    if (execlp("/bin/bash","/bin/bash",NULL) == -1)
    {
        perror("exec failed.");
        exit(EXIT_FAILURE);
    }
}

// for terminating program and close all connection
void terminate(int from_client){
    close(socket_fd);
    close(0);
    close(1);
    close(2);
    close(p_from_shell[0]);
    close(p_to_shell[0]);
    close(p_from_shell[1]);
    close(p_to_shell[1]);
    kill(process_id,SIGKILL);
    if (from_client) {
        exit(1);
    }else{
        exit(2);
    }
}

//for conducting I/O with specified file descriptor
void in_n_out(int ifd, int ofd, int from_client){
    char buff[100];
    int nchar = 0;
    int i;
    while((nchar = read(ifd, buff, sizeof(buff)))){
        if (from_client && encrypt_flag) {
            decrypt(buff, nchar);
        }
        for (i = 0; i < nchar; i++) {
            if (buff[i] == 0x04) {
                terminate(from_client);
            } else{
                if (!from_client && encrypt_flag) {
                    encrypt(buff+i, 1);
                }
                write(ofd, buff+i, 1);
            
            }
        }
    
    }

}

//for conduting I/O in threading
void* send_to_client(void* arg){
    in_n_out(p_from_shell[0], 1, 0);
    return NULL;
}

int main(int argc, char ** argv) {
    int opt = 0;
    static struct option long_opts[] =
    {
        {"port", required_argument, 0, 'p'},
        {"encrypt", no_argument, 0, 'e'}
    };
    
    while(1){
        opt = getopt_long(argc, argv, "p:e", long_opts, NULL);
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
                default:
                    fprintf(stderr, "Wrong argument.");
                    break;
        
        }
    }
    
    socket_fd = socket(AF_INET, SOCK_STREAM,0);
    struct sockaddr_in serv_addr, client_addr;
    memset((char*)&serv_addr, 0, sizeof(serv_addr));
    serv_addr.sin_addr.s_addr = INADDR_ANY;
    serv_addr.sin_port = htons(port_num);
    if (bind(socket_fd, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0) {
        perror("Unable to bind socket.");
        exit(1);
    }
    int client_len;
    int p1 = pipe(p_to_shell);
    int p2 = pipe(p_from_shell);
    if (p1 == -1 || p2 == -1)
    {
        perror("Uable to create pipe.");
        exit(EXIT_FAILURE);
    }
    listen(socket_fd, 5);
    newsocket_fd = accept(socket_fd, (struct sockaddr*)&client_addr, &client_len);
    process_id = fork();
    if (process_id<0) {
        perror("Error forking.");
        exit(1);
    } else if (process_id == 0){
        shell_exec();
    } else {
        dup2(newsocket_fd, 0);
        dup2(newsocket_fd, 1);
        dup2(newsocket_fd, 2);
        close(newsocket_fd);
        pthread_create(&thread_id, NULL, send_to_client, NULL);
        
        in_n_out(0, p_to_shell[1], 1);
    }
    
    encryption_deinit();
    return 0;
    
    
    
    
}
