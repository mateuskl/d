GDC  := gdc
DXX  := dmd

PROGRAM := main.elf

FILES := main.d

all: gdc_version

gdc_version:
	$(GDC) $(FILES) -I. -o $(PROGRAM) 

dmd_version:
	$(DXX) -unittest $(FILES) -I. -of$(PROGRAM) 

clean:
	rm -f *~ $(PROGRAM) *.o

