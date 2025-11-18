#import "../shared.typ": *

A type intersection is the opposite of a #section-link("03 Type Unions", "", "type union").
It is important for type checking relating to multiple interface promising, as the required public interface of a class that promises multiple interfaces is equivalent to the type intersection of those interface types.
=== Syntax
`(Type1 & Type2)`

This form is most useful for combining component interfaces and requiring objects to promise several interfaces for compatibility with type intersections. For example, it might be the case that you want to require that a class promises an Iterable interface and also serializable with something like this: `(Iterable & Serializable)`

Thus, Lodge code is able to be fully agnostic to the concrete type of an object while still mandating the behavior it needs from the object.



=== The Interface of a Type Intersections
The interface of a type union is represented by the #section-link("08 Interface Union", "", "interface union") of all participating interfaces.

Type Intersections do not need to maintain an interface set as compatibility with the combined interface is enough to determine compatibility with the type intersection.