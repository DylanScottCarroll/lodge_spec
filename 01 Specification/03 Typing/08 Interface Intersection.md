Interface intersection is the process by which multiple [[02 Interfaces|interfaces]] are combined into one for the purposes of [[03 Type Unions|type unioning]].

When several types exist in a union together, that type union will have its own interface that is the intersection of the public interfaces of all participating types where compatibility is determined by compatibility with all interfaces in a [[10 Interface Set|interface set]].

It is worth noting that not every intersection is possible. Since any setters or method arguments require their types to be intersected, there is the chance that a namespace collision results in that type intersection being impossible.
## Process of interface intersection

Each [[02 Interfaces|interface]] contains a set of members that are either getters, setters, or methods with arguments.

During interface intersection, each member that has a corresponding member in every interface is a candidate for being included in the intersection. Candidate members do not need to have the same type, but they do need to be the same sort of member (getter / setter / method).

Notably, any member that doesn't have a matching name in all interfaces will not be included in the intersection at all.

Then, each candidate is evaluated to see how it can be merged together to form a member of the final intersected interface.

How this merging works depends on what kind of field, but the result of this merging is either an update of the member's set of types or a removal of the member from candidacy entirely.

### Merging Candidate Getters

Any code dealing with the intersection of several getters must be able to handle the types from any of the getters matching the candidate. Thus, the type of the member in the final intersection is simply the type union made up of all of the members matching this candidate.

For example, when merging the two following interfaces:
``` Lodge
interface A {
	get Int val
}

interface B {
	get String val
}
``` 
The result of `(A | B) as C` would be the following:
```
interface C {
	get val (int | string)
}
```

In this case, when accessing the `val` getter from a variable of type C, the object stored behind the interface C could be either a B or an A, and `val` could either be an int or a string. This means that code that deals with C has to be able to handle the type of `val` regardless of what it is.

In the case where the type union of the getter types results in an empty interface, that getter will be removed from the union. If that getter refers to a field in the class, that field becomes, write-only.

### Merging Candidate Setters

The type of a setter in the intersected interface must only be able to accept types that **all** setters matching the candidate can accept. Thus, the new type of the setter will be the [[06 Type Intersections|type intersection]] (not interface intersection). 

It may be the case that the necessary interface union fails, in which case the candidate member setter will not be present in the inrerface.

For example, when merging the two following interfaces:
``` Lodge
interface A {
	set val int
}

interface B {
	set val string
}
``` 
The result of `(A | B) as C` would be the following:
```
interface C {
	get val (int & string)
}
```

### Merging Candidate Methods
See the section on [[Interface of a Function#Type Union|function interfaces]].



