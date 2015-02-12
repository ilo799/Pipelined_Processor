#! /usr/bin/env sh

/vol/eecs362/iverilog/bin/iverilog -o tests/adder_test -s testbench adder.v tests/adder_test.v

## Example for automated testing
#./tests/adder_test > ./tests/adder_test.output
#diff -q ./tests/adder_test.output ./tests/baseline/adder_test.output
