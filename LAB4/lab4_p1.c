#include <math.h>
#include <mraa/aio.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <time.h>

const int B=4275;                 // B value of the thermistor
const int R0 = 100000;            // R0 = 100k

float convert_to_tmpr(uint16_t value){
	float R = 1023.0/((float)value)-1.0;
    R = 100000.0*R;

    float temperature=1.0/(log(R/100000.0)/B+1/298.15)-273.15;//convert to temperature via datasheet ;
    return temperature;
}
int main(int argc, char** argv)
{
	time_t rawtime;
    struct tm *info;
    FILE* logFp = fopen("log_part1.txt", "w");
	uint16_t value = 0;
	mraa_aio_context tmpr = mraa_aio_init(0); //initializing sensor
	float fahrenheit;
	while(1)
	{
		time( &rawtime );
    	info = localtime( &rawtime );
		value = mraa_aio_read(tmpr); //value got here is not temperature
		float celc = convert_to_tmpr(value);
		fahrenheit = celc * 1.8 + 32;
		printf("%d:%d:%d %0.1f\n", info->tm_hour, info->tm_min, info->tm_sec, fahrenheit);
		fprintf(logFp, "%d:%d:%d %0.1f\n", info->tm_hour, info->tm_min, info->tm_sec, fahrenheit);
		fflush(logFp);
		sleep(1);
	}
	fclose(logFp);
}