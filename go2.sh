as --32 test.s -o test.o

ld -static \
   -o test \
   -L`gcc -print-file-name=`      \
   /usr/lib/i386-linux-gnu/crt1.o \
   /usr/lib/i386-linux-gnu/crti.o \
   test.o                         \
   /usr/lib/i386-linux-gnu/crtn.o \
     --start-group -lc -lgcc -lgcc_eh --end-group
