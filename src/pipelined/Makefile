#Target
TESTPROG = processor
#Top verilog module
TOPLEVEL = Testbench
#Source
VERILOGFILES = src_file_list
# Full path to tools (avoids path issues)
IVERILOG = iverilog
# Generated Files
TEST_GENERATED = ${TESTPROG}

WAVEVIEWER = gtkwave

DUMPFILE = processor.vcd

default: ${TEST_GENERATED} ;

${TESTPROG}: $(shell cat ${VERILOGFILES}) ;
	${IVERILOG} -c  ${VERILOGFILES} -s ${TOPLEVEL} -o ${TESTPROG};

test: ${TESTPROG} ;
	./${TESTPROG}

wave: ${DUMPFILE} ;
	${WAVEVIEWER} ${DUMPFILE}

.PHONY: clean
clean: ;
	rm -f ${TEST_GENERATED} ${DUMPFILE}
