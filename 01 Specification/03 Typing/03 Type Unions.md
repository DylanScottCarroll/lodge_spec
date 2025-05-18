Type unions are a fundamental component of Lodge's typing system. A type union consists of one or more types that are combined into a single type that allows for the inclusion of any type. The interface for a given type union is the [[08 Interface Intersection|intersection]] of the public [[02 Interfaces|interface]] for all of the types in the union. Any value [[04 Interface Compatibility|compatible]] with the intersected interface of the type un ion may be placed in any variable or argument whose type is the type of the union.

The only types that cannot be included in type unions are [[Concrete Variables]].

## Defining type unions


A type union can be defined by separating several types with the `|` (pipe) character. This is a special syntax for type unions and **not** an example of the `|` operator operating on type objects.

``` Lodge
(int | string) variable := ...    !! Declaring a variable with an unnamed union
```
An unnamed type unions refers to all cases where the type union is not bound to a name such as the case below where the variable is being declared to have a type which is the union if int and string



It is also possible in lodge to bind a type union to a name using the `as` keyword. After defining a name for a type union, that name can be used as shorthand to refer to the union after the name definition statement and in all enclosed scopes. The name can be used in any case where the type union could have been used including variable declaration, [[05 Type Switching|type switching]], and even the definition of further type unions.
``` Lodge
(int | string) as intstr

intstr variable := ...
```


## The Interface of a Type Union
The interface of a type union is the [[08 Interface Intersection|interface intersection]] of the interfaces of all of the types that make up the union.