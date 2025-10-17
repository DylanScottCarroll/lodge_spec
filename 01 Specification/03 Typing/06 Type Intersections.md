A type intersection is the opposite of a [[03 Type Unions|type union]].
It is an important part of promising an interface, as the required public interface of a class that promises multiple interfaces is equivalent to the type intersection of those interface types.
## Syntax
`(type1 & type2)`

This form is most useful for combining component interfaces and requiring objects to promise several interfaces for compatibility with type intersections. For example, it might be the case that you want to require that a class promises an Iterable interface and also serializable with something like this: `(Iterable & Serializable)`

Thus, Lodge code is able to be fully agnostic to the concrete type of an object while still mandating the behavior it needs from the object.



## The Interface of a Type Union
The interface of a type union is represented by the [[08 Interface Union|interface union]] of all participating interfaces.
