#lodge_implementation 

Ttables in lodge are the fundamental way that it's typing system is implemented.

When a reference type is held inside of a variable it's [[Lodge Thing|thing]] points to that value in memory as well as pointing to the entry in its ttable that translates from the interface of that container to the fields and methods of that value's concrete type.


In compiled Lodge code, object members are accessed via field IDs that are specific to the given interface of the container that the value is in. The ttable is used at runtime to take these IDs and translate them into offsets within the structure in memory that represents that particular object
The result of this is that every single access to a field in Lodge results in an extra memory access required to get the offset from the ttable.


Here is a diagram depicting the relationship between [[Lodge Thing|thing]], [[Lodge ttable|ttables]], and the structure in memory that represents a given instance object:
![[ttable_diagram.svg]]



