#lodge_spec 

There are several situations where treating classes as objects might be useful.

It can be useful in dependency injection where a given object still maintains the responsibility of instancing an object, but it shouldn't have to worry about what the specific class of that object is.

Additionally, it is useful in the definition of the [[Type Conversion Operator]] operator, which should be able to take a class as an argument.


# Type of a Type object

The existence of class objects
raises the confusing question of what the type of a class object would be. 

The reason that this is confusing is that it is not sensible to instance a type in Lodge, so Type objects are essentially singletons. 

<u>Solution restrictions</u>
1. Types should be able to be passed around freely without worrying about compatibility.
2. We need to sometimes worry about the compatibility of constructors
	1. When holding an unknown type in a variable, how do we check for type safety of the constructor?

#lodge_hole 