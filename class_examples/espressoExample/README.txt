EECS 362
Example: Logic Reduction with 'espresso'

'Espresso' is a heuristic-based boolean logic reduction algorithm.
The algorithm is designed to accept a truth table and produce
near-minimal PLA-compatible logic.
This version of espresso uses AND-OR PLA compatible truth tables.

If you've taken EECS 303, this should be familiar to you.
If not, don't worry; it's pretty simple to pick up.

Look through the example provided.


You start with a truth table. Each entry specifies inputs and outputs.
Each possible input should match an entry.

An example truth table is specified in 'decoder.pla'.
Simply run 'make' to generate an 'output' file.

#######################################################################
decoder.pla

This truth table converts a DLX opcode into three bits corresponding
to the associated instruction type (I/J/R).
An output of all '0's means the instruction is not implemented.

Obviously you are free to add outputs as you see fit to help with
instruction decoding, or create your own PLA file for other components.
Remember that 'espresso' optimizes assuming that outputs will be 'OR'd
together. You will probably want to double-check whatever logic is
provided anyway.

The table could be handy for testing; simply change the output in the
truth table to '000' for unimplemented instructions, and implement
logic to set some testing line when all bits are zero.

Use the '-' character to indicate an input which does not matter
("don't-care").


#######################################################################
Interpreting Output

Some implementations of Verilog permit PLA components, but these are
not necessary. A reduction of 'decoder.pla' from espresso looks like
this:
    .i 6
    .o 3
    .ilb i0 i1 i2 i3 i4 i5
    .ob isI isJ isR
    .p 9
    10---- 100
    -0-1-- 100
    0-1-0- 100
    00000- 001
    00001- 010
    01000- 010
    0-10-- 100
    010-1- 100
    0--100 100
    .e

Consider the logic for 'isR' output (third output bit).
There is only one line for that bit:
    00000- 001

What this means is that, for any incoming 6-bit opcode, if bits [0:5]
are all 0, then, regardless of the last bit, the instruction is R-type.
Looking at the opcode table, this does indeed make sense; opcodes
0x00 and 0x01 are for integer and FP register-register arithmetic.

The logic for this is also fairly simple:
    isR <= AND(NOT(opcode[0]), NOT(opcode[1]), NOT(opcode[2]), NOT(opcode[3]), NOT(opcode[4]))

Note that opcode[5] is unused here.

In the event when multiple output entries correspond to a signal, such
as isI or isJ, intermediate signals will need to be combined with an
OR gate:

    isJ0 <= AND(NOT(opcode[0]), NOT(opcode[1]), NOT(opcode[2]), NOT(opcode[3]), opcode[4])
    isJ1 <= AND(NOT(opcode[0]), opcode[1], NOT(opcode[2]), NOT(opcode[3]), NOT(opcode[4]))
    isJ <= OR(isJ0, isJ1)

You can see from this interpretation why espresso's PLA logic is
considered "AND-OR" form.


