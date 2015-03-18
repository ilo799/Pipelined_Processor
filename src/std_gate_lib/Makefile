#Define aliases 

#Target
TESTPROG = std_lib_test
#Top verilog module
TOPLEVEL = Testbench
#Source 
VERILOGFILES = src_file_list
# Full path to tools (avoids path issues)
IVERILOG = iverilog
# Generated Files
TEST_GENERATED = ${TESTPROG}

default: ${TEST_GENERATED} ;

${TESTPROG}: ${VERILOGFILES} ;
	${IVERILOG} -c ${VERILOGFILES} -s ${TOPLEVEL} -o ${TESTPROG};

.PHONY: clean
clean: ;
	rm -f ${TEST_GENERATED}
