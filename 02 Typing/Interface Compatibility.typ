#import "../shared.typ": *

Interface compatibility in Lodge is the process by which the type checker determines if the one value can be substituted for another without violating the expected interface. For one interface to be compatible with another, the interface must contain a superset of the other interface's members.


=== Checking Compatibility

Consider interfaces A and B. Checking if B is compatible with A consists of evaluating all of the members of A and checking for suitable matching members of B. Recall that interfaces don't really have fields, as fields are the same as getter/setter pairs.

Firstly, for each member in A, there must be a member of B with the same name. Secondly, that member must be compatible with its corresponding member of A.

==== Getter compatibility
Getters are covariant: for B to be compatible with A,  the type of each getter in B must be compatible with the corresponding getter in A.

==== Setter compatibility
Setters are contravariant: For B to be compatible with A, the type of each setter in A must be compatible with the corresponding getter in B. 

For every setter in A
- B must have a setter with the same name and a type that the setter in A is compatible with

==== Method compatibility
For methods, both covariance and contravariance apply; the return types are covariant, and the argument types are contravariant. 

This is complicated by the nuances of variadic method and keyword arguments.

Let's consider a method called B.f checking compatibility with method A.f

_Return Type_ \
The return type of B.f must be compatible with the return type of A.f.

_Positional Arguments_ \
B.f must have at least as many positional arguments as A.f. If B.f has more positional arguments than A.f, the extra must be optional.\

Contravariance: Positional arguments in A.f must be compatible with corresponding (same position) positional arguments in B.f.

_Keyword Arguments_ \
B.f's set of keyword arguments must be the superset of A.f's. B.f's keyword arguments that aren't in A.f must be optional.

Contravariance: Keyword arguments in A.f must be compatible with corresponding (same name) arguments in B.f.

_Argument Captures_ \
If A.f has a positional capture, B.f must have a positional capture with a compatible type. If A.f has a keyword capture, B.f must have a keyword capture with a compatible type
