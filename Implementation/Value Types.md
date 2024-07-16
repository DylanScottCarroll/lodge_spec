#lodge_implementation 

There is a potential wrinkle in some cases where, despite compatible interfaces, the programmer would not want a type to work with another.

## Value Types
Firstly, the ability for value types to work in lodge would be quite valuable given how much more expensive a reference is than a single small value (such as a char). However, because value should be able to work independently of [[Lodge Thing|things]] and [[Lodge ttable|ttables]], code that works with them would need to work fundamentally differently.

As a result value types are always stored in [[Concrete Variables]].



See [[Lodge Built-In Types]] for more information on the usage of value vs reference types.