

The power of Lodge's typing system comes from it's strict, yet flexible type checker and [[Automatic Interfacing]].

At runtime, no type checks are performed, which not only is good for performance, but means that difficult-to-debug runtime type errors are eliminated. This is achieved by ensuring that all operations performed on variables are valid for all types that variable can hold. 



<u>Concrete vs Non-Concrete Types</u>
Lodge makes a particularly strong distinction between concrete types and non-concrete types.

A concrete type is the particular type that a value in memory has. This type is usually a specific class and determines how the data for that piece of memory is arranged and how it behaves.


Non-concrete types are the types that containers have. These types can also be types like classes, but they can also be [[Lodge Type Unions|type unions]] and [[Lodge Interfaces|interfaces]]. 

However, a container with one of these types is not like an object having a type. A variable with a class for it's type can hold more than just objects of that concrete type. And both type unions and interfaces have no corresponding concrete type at all.
What these three things have in common is that they have an interface.

So really, containers like variables and arguments have no specific type at all. Typing for containers is a convenience for the programmer for conceptual sake. In reality, these non-concrete types are defined by their interface.


<u>Interface Types</u>

Candidacy for whether an object of a given concrete type can be placed into a given container is determined by whether that container has a [[Lodge Compatible Interfaces|compatible interface]] with the type that object has.