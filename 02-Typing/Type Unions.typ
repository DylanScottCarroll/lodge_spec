#import "../shared.typ": *

Type unions are an important component of Lodge's typing system. A type union consists of one or more types that are combined into a single type that allows for the inclusion of any type specified in the union. The interface for a given type union must be represented as an #section-link("08 Interface Intersection", "", "interface intersection") and  #section-link("10 Interface Set", "", "interface set") of the participating interfaces. Any value #section-link("04 Interface Compatibility", "", "compatible") with every interface in the set may be placed in any variable or container with that union as its type 

=== Defining type unions


A type union can be defined by combining several types with the `|` character in a type expression. 


```Lodge
(Int | Str) variable := ...    !! Declaring a variable with an unnamed union
```
An unnamed type union refers to all cases where the type union is not bound to a name such as the case below where the variable is being declared to have a type which is the union if int and string


It is also possible in lodge to bind a type union to a name using the `as` keyword. After defining a name for a type union, that name can be used as shorthand to refer to the union after the name definition statement and in all enclosed scopes. The name can be used in any case where the type union could have been used including variable declaration, #section-link("05 Type Switching", "", "type switching"), and even the definition of further type unions.
```Lodge
(Int | Str) as Intstr

Intstr variable := ...
```


=== The Interface of a Type Union
The interface of a type union is represented by the #section-link("08 Interface Intersection", "", "interface intersection") of all participating interfaces.

Adding more types to a union decreases the number of members in that union, the set of types compatible with that interface may grow beyond just the set of participating types. However, compatibility with a type union requires compatibility with at least one of the participating interfaces. Thus, for the sake of determining compatibility, type unions must also maintain the set of participating interfaces.