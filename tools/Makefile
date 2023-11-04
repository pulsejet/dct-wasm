CXX = em++

CXXFLAGS += -O3 -std=c++20 -I../include

CXXFLAGS += \
	-fwasm-exceptions \
	-s USE_BOOST_HEADERS=1 \
	-s EXPORTED_RUNTIME_METHODS=callMain,FS \
	-s ALLOW_MEMORY_GROWTH \
	-s MODULARIZE \
	-lidbfs.js

CXXFLAGS += -isystem../../libsodium/src/libsodium/include/
LDFLAGS += -L../../libsodium/src/libsodium/.libs/
LIBS += -lsodium

.DEFAULT_GOAL = all

TOOLS = schema_compile bld_dump bundle_info ls_bundle \
	make_bundle make_cert schema_cert schema_dump schema_info

all: $(TOOLS)

schema_cert: schema_cert.cpp
	$(CXX) $(CXXFLAGS) -o $@.js $< $(LDFLAGS) $(LIBS) -s EXPORT_NAME="$@"

schema_dump: schema_dump.cpp
	$(CXX) $(CXXFLAGS) -o $@.js $< $(LDFLAGS) $(LIBS) -s EXPORT_NAME="$@"

schema_info: schema_info.cpp
	$(CXX) $(CXXFLAGS) -o $@.js $< $(LDFLAGS) $(LIBS) -s EXPORT_NAME="$@"

make_cert: make_cert.cpp
	$(CXX) $(CXXFLAGS) -o $@.js $< $(LDFLAGS) $(LIBS) -s EXPORT_NAME="$@"

make_bundle: make_bundle.cpp
	$(CXX) $(CXXFLAGS) -o $@.js $< $(LDFLAGS) $(LIBS) -s EXPORT_NAME="$@"

ls_bundle: ls_bundle.cpp
	$(CXX) $(CXXFLAGS) -o $@.js $< $(LDFLAGS) $(LIBS) -s EXPORT_NAME="$@"

bundle_info: bundle_info.cpp
	$(CXX) $(CXXFLAGS) -o $@.js $< $(LDFLAGS) $(LIBS) -s EXPORT_NAME="$@"

bld_dump: bld_dump.cpp
	$(CXX) $(CXXFLAGS) -o $@.js $< $(LDFLAGS) $(LIBS) -s EXPORT_NAME="$@"

schema_compile:
	make -C compiler

clean:
	rm -rf *.dSYM *.js *.wasm
