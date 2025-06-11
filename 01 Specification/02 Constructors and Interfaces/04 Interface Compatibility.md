Interface compatibility describes candidacy for polymorphism in Lodge. The concept of a compatible interface refers to the ability for an interface to be substituted for another without issue. In order for an interface to be compatible with another, that interface must be a superset of the other interface.

## Checking Compatibility

Consider interfaces A and B. Checking if B is compatible with A consists of the following:
### Getter compatibility
For every getter in A
* B must have a getter with the same name and a compatible type

### Setter compatibility
For every setter in A
* B must have a setter with the same name and a type that the setter in A is compatible with

### Method compatibility
For every method in A
* B must have a method with the same name with a compatible signature

Let's consider a method called B.f checking compatibility with method A.f
* The return type of B.f must be compatible with the return type of A.f
* B.f must have at least as many positional arguments as A.f
	* If B.f has more positional arguments than A.f, the extra must be optional
* B.f's set of keyword arguments must be the superset of A.f's
	* B.f's keyword arguments that aren't in A.f must be optional
* Arguments in A.f must be compatible with corresponding arguments in B.f
* If A.f has a positional capture, B.f must have a positional capture with a compatible type
* If A.f has a keyword capture, B.f must have a keyword capture with a compatible type