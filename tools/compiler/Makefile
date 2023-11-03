include ../Makefile

BISON = bison
FLEX = flex

CXXFLAGS += -I../../include
CXXFLAGS += -DCOMPILER_VERSION='"$(shell git describe --first-parent --all --long)"'

HEADERS = dag.hpp driver.hpp names.hpp output.hpp symtab.hpp semantics.hpp
SRCS = parser.ypp scanner.lpp

.DEFAULT_GOAL = schemaCompile

all: schemaCompile $(TOOLS)

%.cpp %.hpp: %.ypp
	$(BISON) -Wall $(BISONFLAGS) -o $*.cpp $<

%.cpp: %.lpp
	$(FLEX) $(FLEXFLAGS) -o$@ $<

schemaCompile: parser.cpp scanner.cpp $(HEADERS)
	$(CXX) $(CXXFLAGS) -o $@.js parser.cpp scanner.cpp -s EXPORT_NAME="$@"

.SECONDARY: parser.cpp scanner.cpp

clean:
	rm -f parser.o scanner.o parser.cpp parser.hpp scanner.cpp location.hpp schemaCompile *.wasm *.js
	rm -rf schemaCompile.dSYM
