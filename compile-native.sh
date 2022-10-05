#!/bin/sh


# Will build the native libraries for the current architecture
# and copy them to the folder "native". Will check out "cloudlare/zlib" 

KERNEL=$(uname -s)
ARCH=$(uname -m)
if [ "$KERNEL" = "Darwin" ] ; then
    IPATH="darwin"
    OPATH="macos_${ARCH}"
    SUFFIX=dylib
elif [ "$KERNEL" = "Linux" ] ; then
    if [ "$JAVA_HOME" = "" ] ; then
        JAVA_HOME=/usr/lib/jvm/default
    fi
    IPATH="linux"
    OPATH="linux_${ARCH}"
    SUFFIX=so
fi
INCLUDE="-I${JAVA_HOME}/include/ -I${JAVA_HOME}/include/${IPATH}/"
OPATH="natives/${OPATH}"
CXX="g++ -std=c++11 -shared -fPIC -O3 -Wall -Werror ${INCLUDE}"
CC="gcc -fPIC -shared -Wall -Werror ${INCLUDE}"

mkdir -p ${OPATH}
$CC src/native/src/com/bluedevel/zlib/FastDeflater.c -o ${OPATH}/libfastdeflater.${SUFFIX} -lz

if [ ! -f ${OPATH}/libz.${SUFFIX} ] ; then
    if [ ! -d zlib ] ; then
        git clone https://github.com/cloudflare/zlib
    fi
    cd zlib
    ./configure
    make
    cd ..
    cp zlib/libz.${SUFFIX} ${OPATH}
fi
