# Filename	Makefile
# Date 		15 November 2019


# Declares the phony "files" to avoid running them after issuing the "make" command
.PHONY: clean run compile

OBJS = ./src/*.v
EXEC = ./bin/run.out 


all: $(EXEC)

$(EXEC): $(OBJS)
	iverilog -o $@ $(OBJS)
	vvp $@

# Instruction on how to clean the directory 
clean:
	rm -f ./bin/*.out $(EXEC)

run:
	vvp $(EXEC)

compile:
	iverilog -o $(EXEC) $(OBJS)
