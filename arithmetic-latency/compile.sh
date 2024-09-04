llc arithmetic-latency.ll -o arithmetic-latency.s
gcc -c print.c -o print.o
gcc arithmetic-latency.s print.o -o arithmetic-latency.bin
./arithmetic-latency.bin