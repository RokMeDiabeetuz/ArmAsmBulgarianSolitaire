SOLITAIRE: comparison.o correctZeros.o fillArray.o getFinalArray.o main.o mod.o printArray.o subAndFillLast.o swap.o
	gcc -o SOLITAIRE comparison.o correctZeros.o fillArray.o getFinalArray.o main.o mod.o printArray.o subAndFillLast.o swap.o
comparison.o: comparison.s
	gcc -c comparison.s
correctZeros.o: correctZeros.s
	gcc -c correctZeros.s
fillArray.o: fillArray.s
	gcc -c fillArray.s
getFinalArray.o: getFinalArray.s
	gcc -c getFinalArray.s
main.o: main.s
	gcc -c main.s
mod.o: mod.s
	gcc -c mod.s
printArray.o: printArray.s
	gcc -c printArray.s
subAndFillLast.o: subAndFillLast.s
	gcc -c subAndFillLast.s
swap.o: swap.s
	gcc -c swap.s
clean:
	rm *.o SOLITAIRE

