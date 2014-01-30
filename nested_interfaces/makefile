DXX := gdc

PROGRAM := main.elf

SOURCE_DIR := .

SOURCE_FILES := $(shell find $(SOURCE_DIR) -name "*.d" -type f)

COMPILATION_FLAGS := -funittest

all: program

program:
	$(DXX) -I$(SOURCE_DIR) $(SOURCE_FILES) $(COMPILATION_FLAGS) -o $(PROGRAM)

clean:
	rm -f $(PROGRAM)

