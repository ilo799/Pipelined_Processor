
SRC = fib.asm
GEN = $(SRC).exe instr.hex data.hex
DLXASM = /vol/eecs362/scripts/dlxasm

.PHONY: default clean

default: instr.hex data.hex ;

clean: ;
	rm -f $(GEN)

$(GEN): $(SRC) $(DLXASM) ;
	$(DLXASM) -C instr.hex -D data.hex $(SRC)


