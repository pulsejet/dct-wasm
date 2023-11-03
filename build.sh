#!/bin/bash

set -e
shopt -s globstar

# Install dependencies
# sudo apt update
# sudo apt install -y git python3 xz-utils make bison flex

# Get the Emmscripten SDK
if [ ! -d emsdk ]; then
    git clone --depth 1 https://github.com/emscripten-core/emsdk.git
    pushd emsdk
    ./emsdk install latest
    ./emsdk activate latest
    popd
fi

# Activate the Emmscripten SDK
source emsdk/emsdk_env.sh

# Get and build libsodium
if [ ! -d libsodium ]; then
    git clone --depth 1 https://github.com/jedisct1/libsodium -b 1.0.19

    # Build libsodium
    pushd libsodium
    emconfigure ./configure --enable-minimal --disable-ssp --disable-shared --without-pthreads
    emmake make -j$(nproc)
    popd
fi

# Clone
if [ ! -d DCT ]; then
    git clone https://github.com/pulsejet/DCT -b patch-driver
else
    rm -rf DCT/**/*.js DCT/**/*.wasm # cleanup
fi

# Copy our patched files
cp -r tools DCT

# Build DCT tools
pushd DCT/tools
make -j$(nproc)
popd

# Copy built files to dist folder
rm -rf dist
mkdir -p dist
cp DCT/tools/**/*.js DCT/tools/**/*.wasm dist
