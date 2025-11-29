#import "../shared.typ": *

The goal of Lodge's type system is to give the flexibility and feel of a dynamic type system while giving type annotations and full static type checking. To that end, every operation needs to be checked for type correctness at compile time.

These operations include: 
- _Variable Types_: Resolving the type and interface of every variable, return, and argument.
- _Expression types_: Resolving the type resulting from an expression
- Object field access: does a given object have the field being accessed as part of its public interface 
- _Assignment_: Are all of the values compatible with the type on right hand side of an assignment also compatible with the type on the left hand side 
- _Function invocation_: Is a function invocation valid for all of the combinations of concrete types compatible with the variables and expressions used to invoke the function as arguments.

#expand