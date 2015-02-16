IVERILOG = iverilog

TESTPROG = control_test

TOPLEVEL = Testbench

FILES = control.v control_tb.v

DUMPFILE = control.vcd

WAVEVIEWER = gtkwave

default: ${TESTPROG} ;

${TESTPROG}: ${FILES} ;
	${IVERILOG} -s ${TOPLEVEL} -o ${TESTPROG} ${FILES};

test: ${TESTPROG} ;
	./${TESTPROG};

wave: ${DUMPFILE} ;
	${WAVEVIEWER} ${DUMPFILE};

.PHONY: clean ;

clean: ;
	rm ${TESTPROG} ${DUMPFILE};