TARGETS = tests/adder_test_simple tests/adder_test_var tests/adder_test_pattern

# If no target is specified when calling 'make', then the first rule in
# the file is used. Here, the default is to build all tests.
.PHONY: all
all: ${TARGETS} autotests ;

# for 'Clean', use .PHONY, and be sure to only delete generated files!
.PHONY: clean
clean: ;
	rm -f ${TARGETS} ${TARGETS_AUTO}

#######################################################################
# Simple Makefile: generates output file based on inputs

tests/adder_test_simple: adder.v tests/adder_test.v ;
	@echo "Simple Build"
	/vol/eecs362/iverilog/bin/iverilog -o tests/adder_test_simple -s testbench adder.v tests/adder_test.v


#######################################################################
# Variables
# http://www.gnu.org/software/make/manual/make.html#Using-Variables
#
# By assigning variables in Makefiles, rules can be easier to read.
# Parens () or Brackets {} may be used for isolation or commands.

IVERILOG = /vol/eecs362/iverilog/bin/iverilog
TARGET_VAR = tests/adder_test_var
INPUTS_VAR = adder.v tests/adder_test.v

${TARGET_VAR}: ${INPUTS_VAR} ;
	@echo "Variables in Make"
	${IVERILOG} -o ${TARGET_VAR} -s testbench ${INPUTS_VAR}


#######################################################################
# Pattern Rules
# http://www.gnu.org/software/make/manual/make.html#Pattern-Rules
#
# Pattern rules can match a prerequisite based on a wildcard.
# Patterns are particularly useful if the target is based on the
# prerequisite name, and the same commands will be used for each
# matching target (ex. "%.o : %.c ;" is often used in Makefiles for C)
#
#  %    Matched wildcard
#  $<   First prerequisite (right of colon)
#  $@   Triggering target (left of colon)

IVERILOG = /vol/eecs362/iverilog/bin/iverilog
INPUTS_PAT = adder.v

# Requesting the target
#       tests/adder_test_pattern
# matches with wildcard "adder_test", so this rule can apply if
#       tests/adder_test.v
# exists (which it does).

tests/%_pattern : tests/%.v  ${INPUTS_PAT} ;
	@echo "Build on pattern: $@ $<"
	${IVERILOG} -o $@ -s testbench ${INPUTS_PAT} $<

#######################################################################
# Automatic Target Generation
# 
# Check for existing files, then build corresponding targets.
#

INPUTS_AUTO = adder.v counter.v
# Use a wildcard to select multiple files in a variable
# http://www.gnu.org/software/make/manual/make.html#Wildcards
TESTFILES = $(wildcard tests/*.v)
TARGETS_AUTO= $(patsubst %.v,%_auto,$(TESTFILES))
.PHONY: autotests
autotests: $(TARGETS_AUTO);
	@echo "Building auto tests ($(TARGETS_AUTO))"

tests/%_auto : tests/%.v $(INPUTS_AUTO);
	@echo "Build on pattern: $@ $<"
	${IVERILOG} -o $@ -s testbench ${INPUTS_AUTO} $<
