# Building Soloud w/ SDL2 on Linux - Ubuntu/Debian

the project is built using **gcc**, version >= 6.5.0 on Ubuntu 18.04


## openGL, Alsa, SDL2 dev libraries and headers

```
apt-get update &&
apt-get install \
 libglu1-mesa-dev \
 freeglut3-dev \
 mesa-common-dev \
 libasound2-dev \
 libsdl2-dev
```

In case you run into issues with these dependencies, please check your package version.

eg. for libsdl2-dev, run :   `apt-cache policy libsdl2-dev`


## gmake project generation

Soloud uses [GENie](https://github.com/bkaradzic/GENie#download-stable) to generate projects for different development/compilation environments.

download the latest released, extract it to your directory of choice : `/path/to/genie`

## Python3

python2 having reached end of life, python3 is required.

```
which python
```


## Build

the build steps to build soloud and its python bindings are aggregated in a single script for your convenience.

assuming you have installed all dependencies:

get the code
```

export GENIE=/path/to/genie/bin/linux/genie
./build.sh
```

`soloud` is now available as a python module in `./glue`

```
cd ./glue && python3 -c import 
```

update your python path, or copy the soloud directory into your project

_________________________________________________


SoLoud
======

SoLoud is an easy to use, free, portable c/c++ audio engine for games.

![ScreenShot](https://raw.github.com/jarikomppa/soloud/master/soloud.png)

Zlib/LibPng licensed. Portable. Easy.

Official site with documentation can be found at:
 http://soloud-audio.com
