# User defined variables
GNU-EFI_LOCALIZATION = ../gnu-efi

# Compilers & Linker
CXX = clang
CXXFLAGS = -Wextra -Wall -target x86_64-unknown-windows -ffreestanding -fshort-wchar -mno-red-zone
INCLUDE_HEADERS = -I include -I $(GNU-EFI_LOCALIZATION)/inc/ -I $(GNU-EFI_LOCALIZATION)/inc/x86_64 -I $(GNU-EFI_LOCALIZATION)/inc/protocol

LD = ld
LDFILE = kernel.ld 

# Files
SRCS := $(shell find src -name "*.c")

OBJ_DIR := obj
OBJS := $(patsubst src/%.c, $(OBJ_DIR)/%.o, $(SRCS))

BUILD_DIR = bin

# Linker
LDFLAGS = -T $(LDFILE) -static -Bsymbolic -nostdlib

all: $(OBJS) build

$(OBJ_DIR)/%.o: src/%.c
	@ mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDE_HEADERS) -c $< -o $@

build:
	@ mkdir -p $(BUILD_DIR)
	$(LD) $(LDFLAGS) -o $(BUILD_DIR)/kernel.elf $(OBJS)

clean:
	rm -rf $(OBJ_DIR)
	rm -rf $(BUILD_DIR)

.PHONY: all build clean
