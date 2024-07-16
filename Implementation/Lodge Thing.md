#lodge_implementation 

In Lodge, all values correspond to a simple structure in memory called a ``thing`` that holds that variable's value.

A thing is a pair of two fields. The first holds the actual value that the thing represents and the second field is a reference that refers to the type of the object.

The type field of the thing is also a pointer that points to a structure in memory that points to the [[Lodge ttable|ttable]] of that concrete type.



## Value Types

See [[Value Types]]

Unlike reference types, values with value types are not stored inside [[Lodge Thing|things]].
This means that value types are all stored in [[Concrete Variables]] and do not take advantage of Lodge's flexible typing system.
