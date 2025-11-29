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
Method compatibility follows the same process as function compatibility.
