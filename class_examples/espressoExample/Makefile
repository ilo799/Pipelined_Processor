
ESPRESSO = /vol/eecs362/scripts/espresso

output: ${ESPRESSO} decoder.pla ;
	${ESPRESSO} -Dexact -t decoder.pla > output.tmp
	mv output.tmp output

.PHONY: clean

clean: ;
	rm -f output.tmp output
