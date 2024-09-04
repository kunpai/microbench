llc memory-latency.ll -o memory-latency.s
gcc -c print.c -o print.o
gcc memory-latency.s print.o -o memory-latency.bin
./memory-latency.bin