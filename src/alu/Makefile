IVERILOG = iverilog

TESTPROG = alu_test

TOPLEVEL = Testbench

FILES = src_file_list

DUMPFILE = alu.vcd

WAVEVIEWER = gtkwave

default: ${TESTPROG} ;

${TESTPROG}: ${FILES} ;
	${IVERILOG} -c ${FILES} -s ${TOPLEVEL} -o ${TESTPROG};

test: ${TESTPROG} ;
	./${TESTPROG};

wave: ${DUMPFILE} ;
	${WAVEVIEWER} ${DUMPFILE};

.PHONY: clean ;

clean: ;
	rm ${TESTPROG} ${DUMPFILE};