#import "../shared.typ": *

Interface intersection is the process by which multiple #section-link("02 Interfaces", "", "interfaces") are combined into one for the purposes of #section-link("03 Type Unions", "", "type unioning").

When several types exist in a union together, that type union will have its own interface that is the intersection of the public interfaces of all participating types where compatibility is determined by compatibility with all interfaces in a #section-link("10 Interface Set", "", "interface set").

It is worth noting that not every intersection is possible. Since any setters or method arguments require their types to be intersected, there is the chance that a namespace collision results in that type intersection being impossible.


The rules for determining an interface intersection are complex however, in most realistic situations, compatibility will be determined mostly by the presence or absence of fields.

=== Process of interface intersection


Each #section-link("02 Interfaces", "", "interface") contains a set of members that are either getters, setters, or methods.

During interface intersection, each member that has a corresponding member in every interface is a candidate for being included in the intersection. Candidate members do not need to have the same type, but they do need to be the same sort of member (getter / setter / method).

Notably, any member that doesn't have a matching name in all interfaces will not be included in the intersection at all.

Then, each candidate is evaluated to see how it can be merged together to form a member of the final intersected interface.

How this merging works depends on what kind of field, but the result of this merging is either an update of the member's set of types or a removal of the member from candidacy entirely.

==== Merging Candidate Getters

Any code dealing with the intersection of several getters must be able to handle the types from any of the getters matching the candidate. Thus, the type of the member in the final intersection is simply the type union made up of all of the members matching this candidate.

For example, when merging the two following interfaces:
```Lodge
interface A {
	get Int val
}

interface B {
	get Str val
}
``` 
The result of `(A | B) as C` would be the following:
```
interface C {
	get val (Int | Str)
}
```

In this case, when accessing the `val` getter from a variable of type C, the object stored behind the interface C could be either a B or an A, and `val` could either be an int or a string. This means that code that deals with C has to be able to handle the type of `val` regardless of what it is.

In the case where the type union of the getter types fails or results in an empty interface, that getter will be removed from interface of the union. 

==== Merging Candidate Setters

The type of a setter in the intersected interface must only be able to accept types that *all* setters matching the candidate can accept. Thus, the new type of the setter will be the #section-link("06 Type Intersections", "", "type intersection") (not interface intersection). 

For example, when merging the two following interfaces:
```Lodge
interface A {
	set val Int
}

interface B {
	set val Str
}
``` 
The result of `(A | B) as C` would be the following:
```
interface C {
	get val (Int & Str)
}
```
In the case where the type intersection of the setter types fails, that setter will be removed from the interface of the union. 



==== Merging Candidate Methods
See the section on #section-link("Interface of a Function", "Type Union", "function interfaces").



