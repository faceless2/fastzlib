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

Results in a doubling of compression throughput using Cloudflare libraries vs standard JVM libraries.

```
Benchmark                              Mode  Cnt   Score   Error  Units
BenchmarkCompressors.compressFastJvm  thrpt    5  43.760 ± 5.566  ops/s
BenchmarkCompressors.compressJvm      thrpt    5  19.533 ± 2.931  ops/s
```


