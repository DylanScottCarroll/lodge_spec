
#lodge_spec 

## Type Unions and Type Intersections
[[Lodge Type Unions]]


The naming of type type unions and type intersections might seem counter-intuitive as the result of a type union is an interface intersection and vice versa. However, this naming is sensible when you consider the set of [[Lodge Compatible Interfaces|compatible]] types for a give type union/intersection:
* When you create a type union out of several types, the set of interfaces that are [[Lodge Compatible Interfaces|compatible]] with that type union is the mathematical union of the sets of types that are compatible with the types that participate in the union.
* When you create a type intersection out of several types, the set of interfaces that are [[Lodge Compatible Interfaces|compatible]] with that type intersection is the mathematical intersection of the sets of types that are compatible with the types that participate in the intersection.

This behavior is represented in the syntax of type unions and intersections:
* `(type1 | type2)` is reminiscent of the logical or, indicating that a type compatible with type1 or type2 would also be compatible with the type union. [[Lodge Type Unions]]
* `(type1 & type2)` is likewise reminiscent of logical and, indicating that a type must be compatible wit both type1 and type2. [[Lodge Type Intersection]]


## Interface Intersection and Interface Union
[[Lodge Interface Intersection]]
[[Lodge Interface Union]]

These operations differ somewhat from strict definitions of mathematical set operations as the equivalence of interface members is depended on both the name and types of the members. Additionally, the merging of two members is more complex than simply checking for their presence. See the pages on interface intersection and union for more information on this behavior.



