IVERILOG = iverilog

TESTPROG = mult_test

TOPLEVEL = Testbench

FILES = src_file_list

DUMPFILE = mult.vcd

WAVEVIEWER = gtkwave

default: ${TESTPROG} ;

${TESTPROG}: $(shell cat ${FILES}) ;
	${IVERILOG} -c ${FILES} -s ${TOPLEVEL} -o ${TESTPROG};

test: ${TESTPROG} ;
	./${TESTPROG};

wave: ${DUMPFILE} ;
	${WAVEVIEWER} ${DUMPFILE};

.PHONY: clean ;

clean: ;
	rm ${TESTPROG} ${DUMPFILE};