# Makefile

BINDIR := bin
LIBDIR := lib

CCFLAGS := -std=c++20 -Wall -Wextra -Wpedantic -Wshadow

CC := g++-12 

# src/ (declaracoes de funcoes, de classes + codigo)
# main/ (programas principais)
# bin/ (temporarios, .o, .exe)
# lib/ (bibliotecas) biblioteca MyLib

# making library
# - static: .a
# - shareable: .so

VPATH = main:src

#Include src
INCSRC = -I src

#SDL2 flags
SDL2INC = $(shell sdl2-config --cflags)
SDL2LIB = $(shell sdl2-config --libs)

#SDL2_image flags
#SDL2IMGINC = $(shell sdl2_image-config --cflags)
#SDL2IMGLIB = $(shell sdl2_image-config --libs)

SRC := $(wildcard src/*.cpp)
OBJ := $(patsubst %.cpp, $(BINDIR)/%.o, $(notdir $(SRC)))
INC := $(wildcard src/*.h)

lib: $(LIBDIR)/libGaspar.a

$(LIBDIR)/libGaspar.a: $(OBJ) 
	@echo make lib...
	ar ruv $@ $^
	ranlib $@

%.exe: $(BINDIR)/%.o $(LIBDIR)/libGaspar.a 
	@echo compiling and linking... 
	$(CC) $(CFLAGS) $(INCSRC) $< -o $(BINDIR)/$@ -L $(LIBDIR) -l Gaspar $(SDL2LIB) -l SDL2_image -l SDL2_ttf

$(BINDIR)/%.o: %.cpp | $(INC)
	@echo compiling... $<
	$(CC) $(CFLAGS) $(INCSRC) $(SDL2INC) -c $< -o $@

# g++-12 -std=c++20 -Wall -Wextra -Wpedantic -Wshadow -I /opt/homebrew/include/SDL2 -D_THREAD_SAFE -I src src/Gaspar.cpp main/Window.cpp -o bin/Window.exe -L /opt/homebrew/lib -l SDL2

######### clean

tilde := $(wildcard */*~) $(wildcard *~)
exe := $(wildcard */*.exe) $(wildcard *.exe)
obj := $(wildcard */*.o) $(wildcard *.o) $(wildcard */*.so) $(wildcard */*.pcm) $(wildcard */*.d)

clean:
	@echo cleaning dir...
	rm -f $(exe) $(obj) $(tilde) $(LIBDIR)/libGaspar.a	
