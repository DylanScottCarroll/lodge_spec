#import "../shared.typ": *


The interface of a function consists of its signature: arguments and return types.

The return type is simple and follows the rules of covariance. The argument types follow contravatince, but the rules are more complex given the existence, of optional arguments, keyword arguments, and argument captures.

The names of positional arguments in a function signature do not make it into the interface, but those of keyword arguments do. Each keyword and positional argument is marked as either optional or required. 


=== Function Compatibility
For functions, both covariance and contravariance apply; the return types are covariant, and the argument types are contravariant. 

Let's consider a function called B checking compatibility with function A

==== Return Type
The return type of B must be compatible with the return type of A.

==== Positional Arguments
B must have at least as many positional arguments as A. If B has more positional arguments than A, the extra must be optional.\

Contravariance: Positional arguments in A must be compatible with corresponding (same position) positional arguments in B.

==== Keyword Arguments
B's set of keyword arguments must be the superset of A's. B's keyword arguments that aren't in A must be optional.

Contravariance: Keyword arguments in A must be compatible with corresponding (same name) arguments in B.

==== Argument Captures
If A has a positional capture, B must have a positional capture with a compatible type. If A has a keyword capture, B must have a keyword capture with a compatible type


=== Non-Callable Function Interfaces
There are cases in which applying a type operation to a functional interface results in an argument list that is not valid for any of the participating functions. In this case, the function cannot be callable as there are no set of arguments that would be type safe. In this case, the function interface is marked as non-callable. In order to call the function, it must first be passed through a type switch to reveal a signature that is callable.

Non-callable function interfaces allow participation by functions even if the interface is missing mandatory arguments of the participating function.


=== Type Unions / Interface Intersection
==== Return Type

For a type union (which corresponds to an interface intersection), the resulting return type is simply the type union of the return types of all participating functions.

==== Positional Arguments

For positional arguments, only arguments that appear in all participating signatures are considered. The names of these positional arguments are ignored. For each shared position, the resulting argument’s type is the type intersection of all corresponding argument types. If any participating function marks that argument as required, the resulting argument is also required.

When some functions have additional positional arguments beyond those shared among all signatures, those additional arguments are not included in the resulting interface unless every function missing them provides a positional capture compatible with the extra arguments. If any of those extra arguments are required, the resulting function interface becomes non-callable.

==== Keyword Arguments

For keyword arguments, the intersection is taken over all keyword names appearing in any of the participating signatures. A keyword argument only appears in the resulting interface if it appears in all signatures, unless the signatures missing it have keyword captures compatible with that argument. If a participating function marks a keyword argument as required, then any function missing that keyword must have a keyword capture compatible with the required argument. Otherwise the resulting interface becomes non-callable.

When a keyword argument does appear in all signatures or can be captured, its resulting type is the type intersection of all corresponding argument types, and it is marked as required if any participating signature marks it as required.

==== Positional Capture

If positional captures exist, the resulting interface includes a positional capture with the type of the type intersection of all captures in the participating functions.

==== Keyword Capture

If keyword captures exist, the resulting interface includes a keyword capture wit hthe type of the intersection of all captures in the participating functions.

=== Type Intersections / Interface Union
==== Return Type

For a type intersection (which corresponds to an interface union), the resulting return type is the type intersection of the return types of all participating functions.

==== Positional Arguments

For each positional argument shared across all signatures, the names are ignored, and all corresponding arguments must agree on optionality. If their optionalities differ, the resulting interface becomes non-callable. The resulting type is the type union of the argument types in that position.

If some signatures contain additional positional arguments not present in others, the resulting interface is non-callable unless every signature missing those arguments provides a positional capture compatible with them. Furthermore, all such extra arguments must be optional; if any are required, the interface is non-callable.

==== Keyword Arguments

A keyword argument appears in the resulting interface only if it is present in all participating signatures or if the signatures missing it have keyword captures compatible with it. As with positional arguments, all corresponding keyword arguments must agree on optionality; if they do not, the interface is rejected. When the argument is valid for inclusion, its resulting type is the type union of all participating argument types.

If the argument is required in some signatures but optional in others, this mismatch results in a non-callable interface unless the rules above for captures apply.

==== Positional Capture

For positional captures, the resulting interface includes one only if every participating signature includes a positional capture; otherwise, the interface is non-callable. The capture’s type is a list whose element type is the type union of all captured element types.

==== Keyword Capture

For keyword captures, the resulting interface includes a keyword capture only if all signatures include one; otherwise, the interface is non-callable. Its type is a dictionary mapping strings to value types, where each value type is the type union of the corresponding captured types.
