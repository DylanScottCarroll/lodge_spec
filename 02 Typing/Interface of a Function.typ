#import "../shared.typ": *

The interface of a function for the purposes of defining variables is an interface only containing the calling operator method.
```
!! The syntax doesn't exist for defining this as a generic, but here is an example
interface function {
	fun () ReturnType(args ...)
}
```

=== Type Operations on Function Types
==== Type Unions / Interface Intersection
- The return type is the union of all return types

- Iterate over the functions' shared positional arguments. For each argument:
	- Names are ignored
	- The type is the type intersection of all the types
	- If at least one is required, the resulting argument is required
- If one function has more arguments than another
	- If any of the following arguments are required
		- The functions with fewer arguments must have a positional capture compatible with all required extra arguments, otherwise reject
	- These arguments don't make it into the new signature
		- Unless the functions missing it have compatible positional captures
	
- For each keyword argument in all signatures
	- If the argument is not in all signatures
		- If any argument is required
			- Functions missing this argument must have a keyword capture compatible with it, otherwise reject
		- These arguments don't make it into the new signature
			- Unless the functions missing it have compatible keyword captures
	- The type is the intersection of all the types 
	- If at least one is required, the argument is required

- Positional captures
	- The name is ignored
	- The type is a list of the type intersection of the types of the values being captured

- Keyword captures captures
	- The name is ignored
	- The type is a dictionary
		- keys are strings
		- values are the type intersection of the types of the values being captured
==== Type Intersections / Interface Union
- The return types must all have the exact same interface

- Iterate over the functions' shared positional arguments. For each argument:
	- Names are ignored
	- The optionality of all corresponding positional arguments must match, otherwise reject
	- The type is the type union of all the types
- If one function has more arguments than another
	- Reject unless the functions missing it have a compatible positional capture
	- They must all be optional, otherwise reject
	
- For each keyword argument in all signatures
	- If the argument is not in all signatures
		- Reject unless the functions missing it have a compatible keyword capture
		- They must all be optional, otherwise reject
	- The optionality of all corresponding keyword arguments must match, otherwise reject
	- The type is the union of all the types 

- Positional captures
	- The name is ignored
	- If one has a positional capture, they both must, otherwise reject
	- The type is a list of the type union of the types of the values being captured

- Keyword captures captures
	- The name is ignored
	- If one has a keyword capture, they both must, otherwise reject
	- The type is a dictionary
		- keys are strings
		- values are the type union of the types of the values being captured