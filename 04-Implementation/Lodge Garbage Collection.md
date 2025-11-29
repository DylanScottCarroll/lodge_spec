
Lodge will use a Garbage Collection system.

I haven't decided between a [[Reference-Counting Garbage Collector]] or a [[Tracing garbage collector.]] The decision may come down to trying both and profiling, but that would be a lot of work.

I am considering the possibility of using a Reference-counting garbage collector that occasionally employs a tracing algorithm to collect objects with cyclical references.


Alternatively, I could use an off-the-shelf garbage collector