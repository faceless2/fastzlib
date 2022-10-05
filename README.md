# fastzlib
Fast zlib compression on the jvm

## Background

Currently the JVM provides a bundled version of zlib. Intel and Cloudflare have both provided customised tuned
codebases for the x86 platforms. Unfortunately, you cannot easily override this, which will hopefully be fixed
in jdk9. Nonetheless, for anyone not on jdk9, you cannot take advantage of faster compression options which
are available.

So, this project makes that possible.

## Setting up

(Modified from the original at https://github.com/jasonk000/fastzlib)

1. Compile zlib for your platform by running `compile-native.sh`. This will put native files
   under "natives". As many architectures as required can be in this folder.
2. Run "build-jar.sh". This will create "fastzlib.jar" with the native libraries included in the Jar

To use, add "fastzlib.jar" to the classpath and use `com.bluedevel.zlib.FastDeflater` where you would
normally use `java.util.zip.Deflater` - the new implementatioj extends this class, so they are
interchangeable.

## Results

(Modified from the original at https://github.com/jasonk000/fastzlib)

Some very rough numbers as of 2022-10-05

|Java and OS|Default Compression|Best Compression
|--|--|--
|Default JVM Zip, Java 8, Linux/x86_64|24479|18053
|Cloudflare Zip, Java 8, Linux x86_64|22576|16134
|Intel Zip, Java 8, Linux x86_64|22620|16158

|Default JVM Zip, Java 17, Linux/x86_64|18339|11849
|Cloudflare Zip, Java 17, Linux x86_64|17960|11468
|Intel Zip, Java 17, Linux x86_64|20308|13979

|Default JVM Zip, Java 17, macOS/Arm|9875|6435
|Cloudflare Zip, Java 8, Linux x86_64|10154|6390


Conclusion: it's not worth substituting the Deflator in the JVM in 2022, or I've done
something wrong.

