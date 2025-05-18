A union between multiple interfaces is the result of a [[06 Type Intersections]]. 


Interface unions are somewhat more complex than [[08 Interface Intersection|interface intersections]], as there are cases where the union will fail due to incompatibility between 


## Process of interface union

Read [[08 Interface Intersection]] first as that page has more details and examples of this process.

To start with, all members from every participant are candidates for inclusion in the union

However, there may be some elements with shared names, that require special consideration for their types. This is also the way in which some interface unions may fail.

### Getters with shared names
An object that is [[04 Interface Compatibility|compatible]] with the union of multiple interfaces must be able to properly behave like any of the of the types in the interface union. For example, consider the [[06 Type Intersections|type intersection]] `(A & B)`. Any class that would be compatible with this interface union must be compatible with both A and B in every case. Thus, if both A and B have a getter of the same name, those two getters must be mutually compatible (A is compatible with B and B is compatible with A). Mutual compatibility requires that the two interfaces are identical.

If there are getters with shared names and all getters do not have the **same exact interface**, the interface union will **fail with a compiler error**.

For example, consider merging the two following interfaces:
``` Lodge
interface A {
	set val int
}

interface B {
	set val string
}
``` 
The line `(A & B)` would result in a compiler error.

The failure of union is a non-ideal outcome, thus it is best practice in lodge to avoid constructing classes that are likely to result in failures when unioned with interfaces that they are likely to be unioned with.
* Reducing the public interfaces of classes as much as possible
* Using distinctive names for members to reduce collisions

### Setters with shared names
Setters with shared names are somewhat simpler as the types of each setter is simply the type union of all the candidate setters.

Much like in [[08 Interface Intersection|interface intersection]], when the interface of a member becomes empty as the result of type unioning, that member is removed from the resulting interface.

For example, when merging the two following interfaces:
``` Lodge
interface A {
	get val int
}

interface B {
	get val string
}
``` 
The result of `(A & B) as C` would be the following:
```
interface C {
	get val (int | string)
}
```


### Methods with shared names

#expand

The behavior of method merging is somewhat complex and I haven't worked it out all the way yet.

