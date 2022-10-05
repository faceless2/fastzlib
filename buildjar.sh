#!/bin/sh

mkdir -p classes
cd src/main/java
javac --source 7 --target 7 -d ../../../classes com/bluedevel/zlib/*java
cd  ../../..
jar cf fastzlib.jar natives -C classes com
