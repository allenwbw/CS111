#include <math.h>
#include <time.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <string.h>
#include <fcntl.h>
#include <netinet/in.h>
#include <netdb.h>
#include <mraa/aio.h>
#include <sys/select.h>
#include <signal.h>

#define F 0
#define C 1

int frequency = 3;
int SCALE = F;
char unit = 'F';
mraa_aio_context tmpr;
FILE* logFp;
int socket_fd;
const int B=4275; 
int stop = 0;
float convert_to_tmpr(uint16_t value){
    float R = 1023.0/((float)value)-1.0;
    R = 100000.0*R;

    float temperature=1.0/(log(R/100000.0)/B+1/298.15)-273.15;//convert to temperature via datasheet ;
    return temperature;
}

void alarm_handler(int sig){
    if (stop){
        alarm(frequency);
        return;
    }
    time_t rawtime;
    struct tm *info;
    uint16_t value = 0;
    time(&rawtime);
    info = localtime(&rawtime);
    value = mraa_aio_read(tmpr); 
    float temp = convert_to_tmpr(value);
    if (SCALE == F)
        temp = temp * 1.8 + 32;
    printf("%d:%d:%d %0.1f %c\n", info->tm_hour, info->tm_min, info->tm_sec, temp, unit);
    fprintf(logFp, "%d:%d:%d %0.1f %c\n", info->tm_hour, info->tm_min, info->tm_sec, temp, unit);
    fflush(logFp);
    dprintf(socket_fd, "704448696 TEMP=%0.1f\n",temp);
    alarm(frequency);

}


int main(int argc, char** argv)
{
    logFp = fopen("log_part2.txt", "w");
	int port_num = 16000;
	socket_fd = socket(AF_INET, SOCK_STREAM, 0);
	struct hostent* server;
    struct sockaddr_in serv_addr;
    server = gethostbyname("lever.cs.ucla.edu");
    serv_addr.sin_family = AF_INET;
    memcpy((char*)&serv_addr.sin_addr.s_addr, (char*)server->h_addr, server->h_length);
    serv_addr.sin_port = htons(port_num);
    printf("connceting.\n");
    if(connect(socket_fd, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) < 0)
    {
    	perror("Error connceting to server.\n");
    	exit(1);
    }
    printf("connected.\n");
    char writebuf[] = "Port request 704448696";
    int newport = 0;
    printf("requesting\n");
    write(socket_fd, writebuf, sizeof(writebuf));
    printf("requested\n");
    printf("reading\n");
    read(socket_fd, &newport, 4);
    printf("received\n");
    close(socket_fd);
    serv_addr.sin_port = htons(newport);
    socket_fd = socket(AF_INET, SOCK_STREAM, 0);
    printf("Connecting to new port number %d\n", newport);
    if(connect(socket_fd, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) < 0)
    {
        perror("Error connceting to server.\n");
        exit(1);
    }
    printf("connected\n");
    tmpr = mraa_aio_init(0); 
    struct timeval waittime;
    waittime.tv_sec = 3;
    waittime.tv_usec = 0;
    fd_set readset;
    FD_ZERO(&readset);
    FD_SET(socket_fd, &readset);
    char read_buf[40];
    int i;
    for(i = 0; i < 40; i++)
        read_buf[i] = '\0';
    int nchar;
    printf("start recording\n");
    signal(SIGALRM, alarm_handler);
    alarm(frequency);
    while(1){
        select(socket_fd + 1, &readset, NULL, NULL, NULL);
        if (FD_ISSET(socket_fd, &readset))
        {
            for(i = 0; i < 40; i++)
                read_buf[i] = '\0';
            nchar = read(socket_fd, read_buf, 40);
            if (!strcmp(read_buf, "OFF"))
            {
                fprintf(logFp, "OFF\n");
                fflush(logFp);
                printf("OFF\n");
                close(socket_fd);
                fclose(logFp);
                exit(0);
            }else if (!strcmp(read_buf, "STOP"))
            {
                fprintf(logFp, "STOP\n");
                fflush(logFp);
                printf("STOP\n");
                if (!stop)
                {
                    stop = 1;
                } 
            }else if (!strcmp(read_buf, "START"))
            {
                fprintf(logFp, "START\n");
                fflush(logFp);
                printf("START\n");
                if (stop)
                {
                    stop = 0;
                }
            }else if (!strcmp(read_buf, "SCALE=F"))
            {
                fprintf(logFp, "SCALE=F\n");
                fflush(logFp);
                printf("SCALE=F\n");
                SCALE = F;
                unit = 'F';
            }else if (!strcmp(read_buf, "SCALE=C"))
            {
                fprintf(logFp, "SCALE=C\n");
                fflush(logFp);
                printf("SCALE=C\n");
                SCALE = C;
                unit = 'C';
            }else if (!strncmp(read_buf, "FREQ=", 5))
            {
                char* end;
                int new_freq = (int)strtol(read_buf+5, &end, 10);
                if (*end == '\0')
                {
                    if (frequency != new_freq)
                    {
                        frequency = new_freq;
                        alarm(frequency);
                    }
                    fprintf(logFp, "FREQ=%d\n",frequency);
                    fflush(logFp);
                    printf("FREQ=%d\n",frequency);
                }else{
                    fprintf(logFp, "%s I\n", read_buf);
                    printf("%s I\n", read_buf);
                }
            }else{
                fprintf(logFp, "%s I\n", read_buf);
                printf("%s I\n", read_buf);
            }
        }
    }
}
