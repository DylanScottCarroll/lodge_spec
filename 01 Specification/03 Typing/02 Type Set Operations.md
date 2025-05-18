## Type Unions and Type Intersections
Type unions and type intersections are two ways of creating composite types out of multiple other types.

[[03 Type Unions|Type unions]] are the most common and allow the programmer to create a flexible variable that hold multiple different concrete types, while still being fully type checked. 

[[06 Type Intersections|Type intersections]] allow the programmer to create a variable that can only contain values that satisfy multiple interfaces. This use case is less common, but allows variables to be entirely 


This behavior is represented in the syntax of type unions and intersections:
* `(Type1 | Type2)` is reminiscent of the logical or, indicating that a type compatible with Type1 or Type2 would also be compatible with the type union.
* `(type1 & type2)` is likewise reminiscent of logical and, indicating that a type must be compatible wit both Type1 and Type2.