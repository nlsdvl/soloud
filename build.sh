#!/bin/bash

# get GENie:  https://github.com/bkaradzic/bx/raw/master/tools/bin/linux/genie
genie="${GENIE:-genie}"
genie_cfg="${GENIE_CFG:-./genie_linux.lua}"

# clean up before building again
rm -rf ./glue/*
rm -rf ./build/gmake
rm -rf ./bin
rm -rf ./lib

git checkout -- src/c_api/soloud.def
git checkout -- src/c_api/soloud_c.cpp

set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT

# build soloud dynamic library and the codegen tool
pushd ./build
    $genie --file=$genie_cfg --platform=x64 --with-sdl2 --with-tools gmake
    cd ./gmake
    make clean
    make codegen
    make config=release64 SoloudDynamic
popd

# run the codegen tool
pushd ./bin
    ./codegen_x64_d go
popd

# generate the python bindings
pushd ./scripts
    python ./gen_python.py
popd

# copy the lib and bindings to a proper soloud python package
pushd ./glue
    mkdir soloud
    cp ../lib/*.so ./soloud/glue
    mv ./soloud.py ./__init__.py
popd

# now we can import soloud
cd ./glue
python -c "import soloud"