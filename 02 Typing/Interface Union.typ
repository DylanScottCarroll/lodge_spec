#import "../shared.typ": *

A union between multiple interfaces is the result of a #section-link("06 Type Intersections", "", ""). 


=== Process of interface union
To start with, an interface is formed by placing the members of all participating interfaces together. However, there may be some elements with shared names, that require special consideration for their types. This is also the way in which some interface unions may fail.

==== Getters with shared names
An object that is #section-link("04 Interface Compatibility", "", "compatible") with the union of multiple interfaces must be able to properly behave like any of the of the types in the interface union. For example, consider the #section-link("06 Type Intersections", "", "type intersection") `(A & B)`. Any class that would be compatible with this interface union must be compatible with both A and B in every case. Thus, if both A and B have a getter of the same name, those two getters must be mutually compatible (A is compatible with B and B is compatible with A). Mutual compatibility requires that the two interfaces are identical.

If there are getters with shared names and all getters do not have the *same exact interface*, the interface union will *fail with a compiler error*. #text(fill:red)[Is this true???]

For example, consider merging the two following interfaces:
```Lodge
interface A {
	get val Int
}

interface B {
	get val Str
}
``` 
The line `(A & B)` would result in a compiler error.

The failure of union is a non-ideal outcome, thus it is best practice in lodge to avoid constructing classes that are likely to result in failures when unioned with interfaces that they are likely to be unioned with.
- Using distinctive names for members to reduce collisions
- Reducing the public interfaces of classes as much as possible

==== Setters with shared names
Setters with shared names are somewhat simpler as the types of each setter is simply the type union of all the candidate setters.

Much like in #section-link("08 Interface Intersection", "", "interface intersection"), when the interface of a member becomes empty as the result of type unioning, that member is removed from the resulting interface.

For example, when merging the two following interfaces:
```Lodge
interface A {
	get val Int
}

interface B {
	get val Str
}
``` 
The result of `(A & B) as C` would be the following:
```
interface C {
	get val (Int | Str)
}
```


==== Methods with shared names
See the section on #section-link("Interface of a Function", "Type Intersections", "function interfaces").