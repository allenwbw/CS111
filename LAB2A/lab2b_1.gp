#!/u/cs/grad/zhou/iloveos/gnuplot
# general plot parameters
set terminal png
set datafile separator ","

# how many threads/iterations we can run without failure (w/o yielding)
set title "List and Add: throughput vs threads"
set xlabel "Threads"
set logscale x 2
set ylabel "Throughput (Ops/s)"
set logscale y 10
set output 'lab2b_1.png'
# grep out only single threaded, un-protected, non-yield results
plot \
     "< grep -E 'list-none-m,([1-8][2-6]*),1000,' lab2_list.csv" using ($2):($7) \
	title 'list mutex' with linespoints lc rgb 'red', \
     "< grep -E 'list-none-s,([1-8][2-6]*),1000,' lab2_list.csv" using ($2):(1/(($7)/1000000000)) \
	title 'list spin' with linespoints lc rgb 'green', \
     "< grep -E 'add-m,([1-8][2-6]*),10000,' lab2_add.csv" using ($2):($6) \
	title 'add mutex' with linespoints lc rgb 'red', \
     "< grep -E 'add-s,([1-8][2-6]*),10000,' lab2_add.csv" using ($2):(1/(($6)/1000000000)) \
	title 'add spin' with linespoints lc rgb 'green'

set title "Time waiting for lock vs. number of competing threads"
set xlabel "Threads"
set logscale x 2
set ylabel "Throughput (Ops/s)"
set logscale y 10
set output 'lab2b_2.png'
plot \
     "< grep 'list-none-m,' lab_2b_list.csv" using ($2):($7) \
	title 'average time per operation' with linespoints lc rgb 'red', \
     "< grep 'list-none-m,' lab_2b_list.csv" using ($2):($8) \
	title 'wait for lock time' with linespoints lc rgb 'green'

set title "average time per op vs. threads"
set xlabel "Threads"
set logscale x 2
set ylabel "Throughput (Ops/s)"
set logscale y 10
set output 'lab2b_3.png'
plot \
     "< grep -E 'list-id-none,' lab_2b_list.csv" using ($2):($7) \
	title 'unprotected' with linespoints lc rgb 'red', \
     "< grep -E 'list-id-m,([1-8][1-6]*),([1-8]0),' lab_2b_list.csv" using ($2):($7) \
	title 'mutex' with linespoints lc rgb 'green', \
	"< grep -E 'list-id-s,([1-8][1-6]*),([1-8]0),' lab_2b_list.csv" using ($2):($7) \
	title 'spin' with linespoints lc rgb 'blue' 

set title "throughput vs. number of competing threads (m)"
set xlabel "Threads"
set logscale x 2
set ylabel "Throughput (Ops/s)"
set logscale y 10
set output 'lab2b_4.png'
plot \
     "< grep -E 'list-none-m,([1-8][1-2]*),1000,1' lab_2b_list.csv" using ($2):(1000000000/($7)) \
	title 'average time per operation' with linespoints lc rgb 'red', \
     "< grep -E 'list-none-m,([1-8][1-2]*),1000,4' lab_2b_list.csv" using ($2):(1000000000/($7)) \
	title 'wait for lock time' with linespoints lc rgb 'green',\
	"< grep -E 'list-none-m,([1-8][1-2]*),1000,8' lab_2b_list.csv" using ($2):(1000000000/($7)) \
	title 'wait for lock time' with linespoints lc rgb 'blue',\
	"< grep -E 'list-none-m,([1-8][1-2]*),1000,16' lab_2b_list.csv" using ($2):(1000000000/($7)) \
	title 'wait for lock time' with linespoints lc rgb 'black'

set title "throughput vs. number of competing threads (s)"
set xlabel "Threads"
set logscale x 2
set ylabel "Throughput (Ops/s)"
set logscale y 10
set output 'lab2b_5.png'
plot \
     "< grep -E 'list-none-s,([1-8][1-2]*),1000,1' lab_2b_list.csv" using ($2):(1000000000/($7)) \
	title 'average time per operation' with linespoints lc rgb 'red', \
     "< grep -E 'list-none-s,([1-8][1-2]*),1000,4' lab_2b_list.csv" using ($2):(1000000000/($7)) \
	title 'wait for lock time' with linespoints lc rgb 'green',\
	"< grep -E 'list-none-s,([1-8][1-2]*),1000,8' lab_2b_list.csv" using ($2):(1000000000/($7)) \
	title 'wait for lock time' with linespoints lc rgb 'blue',\
	"< grep -E 'list-none-s,([1-8][1-2]*),1000,16' lab_2b_list.csv" using ($2):(1000000000/($7)) \
	title 'wait for lock time' with linespoints lc rgb 'black'

