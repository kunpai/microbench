llc float-latency.ll -o float-latency.s
gcc -c print.c -o print.o
gcc float-latency.s print.o -o float-latency
./float-latency