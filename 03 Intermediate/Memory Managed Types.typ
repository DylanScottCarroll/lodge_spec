#import "../shared.typ": * 


Constructors automatically allocate just the amount of memory needed for the fields they contain. However, there are some cases in which the programmer might want more fine-grained control over the memory.

For such cases, lodge provides the `Data` and `Byte` types. Data looks like other types syntactically but specifically circumvents the type systems to allow things that wouldn't otherwise be able to be implemented with as much memory efficiency.  

When the present scope is a struct, it is legal to declare a Data field. Data fields use a special syntax only valid inside of a struct. The given name, which is a function that returns the type produced by the  can be referenced inside the struct's scope, but may not be placed in another variable or returned, and may not be public.

```
struct A {
  Data _name = size 
}
```

The primary way to interact with a Data field is to access it at a byte level using slice/index notation, which returns a Bytes object, which can be assigned and passed around. Unlike array bounds access, this does not return an errable value. If a Data field has an out-of-bounds access, lodge will simply crash #text(fill:red)[(maybe not?)] 

Additionally, the Bytes object defines a type conversion operator `->` capable of handling . If the Bytes object contains a number of bytes equal to the size of objects defined by the struct, it will produce. Likewise, it defines the reverse type conversion operator that any struct can be defined.

Both of these operator applications are a special case that only The Bytes implementation is capable of achieving. 

```
struct A {
  Data _data = 50

  !! Interpretin a segment of data as an integer  
  Bytes four_bytes := _data[0:4]!
  Int x := four_bytes->Int
  x *= 2
  four_bytes := x->Bytes
  _data[0:4] := four_bytes

  !! Or equivalentlyrse conversion is also a special case as it fills in t
  _data[0:4] := (_data[0:4]->Int! * 2)->Bytes!
}


```

This can be especially useful for making more compact array-like objects that don't have the overhead of type tags and padding.

```Lodge
struct IntArray(Int length) {
	Data data = length*4

	fun [get] Int!(Int index) {
    if (index < 0 | index >= length) { return IndexError() }
		return data[index*4:index*4+4]->Int
	}
	
	fun [set] Int!(Int index, Int val) {
		if (index < 0 | index >= length) { return IndexError() }
    
    data[index*4:index*4+4] = val->Bytes
	}
}
```
