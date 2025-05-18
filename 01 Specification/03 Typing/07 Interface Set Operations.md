## Interface Intersection and Interface Union
These operations differ somewhat from strict definitions of mathematical set operations as the equivalence of interface members is depended on both the name and types of the members. Additionally, the merging of two members is more complex than simply checking for their presence. See the pages on [[08 Interface Intersection|interface intersection]] and [[09 Interface Union|interface union]] for more information on this behavior.



The naming of type type unions and type intersections might seem counter-intuitive as the result of a type union is an interface intersection and vice versa. However, this naming is sensible when you consider the set of [[04 Interface Compatibility|compatible]] types for a give type union/intersection:
* When you create a type union out of several types, the set of interfaces that are [[04 Interface Compatibility|compatible]] with that type union is the mathematical union of the sets of types that are compatible with the types that participate in the union.
* When you create a type intersection out of several types, the set of interfaces that are [[04 Interface Compatibility|compatible]] with that type intersection is the mathematical intersection of the sets of types that are compatible with the types that participate in the intersection.
