CC = gcc
CFLAGS = -g
OUTFILE = ya
LIBS = -lm



all: parser.c lexer.c
	$(CC) $(CFLAGS) parser.c lexer.c -o $(OUTFILE) $(LIBS)

parser.c: ya.y
	bison -y -d -v ya.y -o parser.c

lexer.c: ya.lex
	flex -o lexer.c ya.lex


run1: $(OUTFILE)
	./$(OUTFILE) < ./example1.ya

run2: $(OUTFILE)
	./$(OUTFILE) < ./example2.ya

run3: $(OUTFILE)
	./$(OUTFILE) < ./example3.ya


clean: 
	rm -rf parser.c lexer.c parser.h
	rm -f *~
	rm -f *.o
	rm -f ya
