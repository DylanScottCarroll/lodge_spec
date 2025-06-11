## Declaring and Assigning Variables
A variable declaration consists of a [[Type Expressions|type expression]], a variable name, and an assignment. Variables cannot be declared without being assigned a value. If a variable may not have a value, consider using a [[04 Errable and Nonable Types#Nonable|nonable]] type.

Assignment occurs using the `:=` operator.

``` Lodge
Int value2 := 10    !! Declaring an int variable and assigning it a value
```

Assignment also does not need to be a standalone statement, but can be an expression that returns the new value, like in C.
```Lodge
!! Print out the characters from a file until the character 'a' is reached
Str c
loop while (c := file.getChar()) != 'a'
	{ print(c) } 
```

Lodge is garbage-collected, so created values do not need to be manually freed.

## Var Keyword

When variables are declared with the `var` keyword instead of a type, 

``` Lodge
var value4 := "hello"    !! Declaring a variable as a string with an inferred type
var arr2 := [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]    !! Declaring a type with an inferred type variable
```

## Auto Keyword

The `auto` keyword allows the programmer define the type of a variable automatically based on what the variable is used to do. When `auto` is used to define a variable, every usage of that variable is analyzed for, gets, sets, and calls. The broadest possible interface for those accesses is used to create the type of the given variable 

Consider the following example:
```
fun function(auto a) {
	a.x = 10
	Float b = a.y
	Str c = a.function(1, 2, 3) 
}

```
The type of `a` would be the following interface:
```
Interface {
	Int x
	Float y
	fun function Str(Int _1, Int _2, Int _3 |)
}
```

## Variable Types
In Lodge, variables types are not defined by the concrete type they are declared with. Instead, the type of a variable is the public interface of that type. This means that a variable is not restricted to just the type it was declared with. Instead, any value with a [[04 Interface Compatibility|compatible interface]] can be stored in that variable. For example, a variable with the default `Int` type can store any integer value.

The full behaviors of Lodge's type checking system is found in [[00 Typing|Chapter 04: Typing]].
## Union Types
Instead of creating a variable with just a single type, it is also possible in Lodge to define a variable with a composite type called a [[03 Type Unions|type union]]. This allows a variable to store any value that has a compatible interface with *any* type in the union.

``` Lodge
(Str | Int) x

!! Allowed
x := 10
x := "Hello World"
```

Composite types can also be given names with the `as` keyword

``` Lodge
(Str | Int) as StrInt
StrInt x = "10"
```

## Auto Keyword

Since variables in lodge are defined entirely based on interface compatibility than particular concrete types, it is possible to automatically declare a variable whose type interface is defined by what members are ac

The auto keyword will look at the entire scope that it's variable is being bound in to see what members of that variable's interface are being accessed. That then becomes the interface of that variable.


Take this example:
```
fun functionName ReturnType(auto arg) {
	arg.name = "Name"
	Float result = arg.takeAction(10)
}
```

For this function the `arg` variable will have approximately the following interface:
```
Interface InterfaceName{
	Str name
	fun takeAction Float(Int)
}
```


## Circular Type Definitions

There may be cases where a composite type declaration may want to refer to itself, which is allowed in Lodge. 


Here's an example of how a tuple containing two values can be used to create something akin to a linked list
``` Lodge 
(int, listelement)|None as listElement

listElement list = (0 (1, (2, (3, None))))
```
