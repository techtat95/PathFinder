
#
# "make" will create an executable called pa05
# 
# "make test" will run the three input files 
# 
# input: inputs/testinput1; output: id1, first1, last1
# input: inputs/testinput2; output: id2, first2, last2
# input: inputs/testinput3; output: id3, first3, last3
# 
# compare your program's output with the expected ouputs by
# using the "diff" command in Linux
#
# "make memory" calls valgrind to check memory errors
#
# "make clean" remove .o and all output files
CFLAGS = -std=c99 -g -Wall -Wshadow --pedantic -Wvla -Werror
COVFLAGS = -fprofile-arcs -ftest-coverage
PROFFLAG = -pg
DEFINES = -DTEST_READ -DTEST_WRITE -DTEST_SORTID -DTEST_SORTFIRSTNAME -DTEST_SORTLASTNAME
VALGRIND = valgrind --tool=memcheck --leak-check=full
VALGRIND += --verbose --log-file=
GCC = gcc $(CFLAGS) $(COVFLAGS)
OBJS = pa07.o student.o msort.o

all: pa07

pa07: pa07.o maze.o path.o
	$(GCC) pa07.o maze.o path.o -o pa07 -lm

pa07.o: pa07.c maze.h path.h
	$(GCC) -c pa07.c -o pa07.o

maze.o: maze.c maze.h
	$(GCC) -c maze.c -o maze.o

path.o: path.c path.h
	$(GCC) -c path.c -o path.o

test: pa07
	for n in 1 2 3 4 5 ; do \
	  echo "Testing Maze #$$n" ; \
	./pa07 inputs/maze$$n inputs/path$$n ; \
	done

clean: 
	/bin/rm -f *.o
	/bin/rm -f testgen
	/bin/rm -f *.gcda *.gcno gmon.out *gcov
	/bin/rm -f pa07
	/bin/rm -f vallog

memory: pa07
	$(VALGRIND)vallog ./pa07 inputs/maze1 inputs/path1


