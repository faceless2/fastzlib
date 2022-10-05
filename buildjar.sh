#!/bin/sh

mkdir -p classes
cd src/main/java
#ARGS="--source 7 --target 7"
javac $ARGS -d ../../../classes com/bluedevel/zlib/*java
cd  ../../..
jar cf fastzlib.jar natives -C classes com
