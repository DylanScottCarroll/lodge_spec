There are several situations where treating classes as objects might be useful.

It can be useful in dependency injection where a given object still maintains the responsibility of instancing an object, but it shouldn't have to worry about what the specific class of that object is.

Additionally, it is useful in the definition of the [[Type Conversion Operator]] operator, which should be able to take a class as an argument.


# Type of a Type object
<u>This section needs to be expanded</u>

From the perspective of interaction, types look like functions that are called to create instances, but also have static fields. 

This makes type objects complex to put into the rest of the type system.