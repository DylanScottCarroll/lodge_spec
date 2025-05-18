Interface intersection is the process by which multiple [[02 Interfaces|interfaces]] are combined into one for the purposes of [[03 Type Unions|type unioning]].

When several types exist in a union together, that type union will have its own interface that is the intersection of the public interfaces of all participating types.

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
#expand

For merging methods, candidacy is still determined by the name of the method, but the type of a method is more complex.

For the sake of flexibility, the names of method arguments are not considered at all, only their types. Due to their similarities arguments are treated as setters, and return values are treated as getters.

#### Merging Argument Types
The merging of method arguments begins at the first pair of positional arguments and merges their types, continuing until their is a failure or until one method is out of arguments.

If one function has more positional arguments than another, the merge will fail unless the excess arguments are optional (have default values)

#### Merging Keyword arguments
If 



#### Implementation Note:

Keyword arguments supplied statically in the code are compiled in the same way as arguments provided by keyword. 




