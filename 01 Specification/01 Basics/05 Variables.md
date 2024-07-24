## Declaring and Assigning Variables
Lodge variable declarations work much like they do in C or Java. A variable declaration consists of a type followed by a variable name.

Assignment occurs using the `:=` operator, which often 

``` Lodge
Int value    !! Decalring a variable without defining it
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


## Variable Types
In Lodge, the type of a variable does not restrict the values that can be stored to just the type of the variable. Instead, any value with a [[04 Interface Compatibility|compatible interface]] can be stored in that variable. For example, a variable with the default `Int` type can store any integer value.

``` Lodge
!! Allowed
x := i8(-10)
x := u64(100)

!! Not Allowed
x := "10"
x := 10.5

```

The full behaviors of Lodge's type checking system is found in [[00 Typing|Chapter 04: Typing]].
## Union Types
Instead of creating a variable with just a single type, it is also possible in Lodge to define a variable with a composite type called a [[03 Type Unions|type union]]. This allows a variable to store any value that has a compatible interface with *any* type in the union.

``` Lodge
(Str | Int) x

!! Allowed
x := 10
x := "Hello World"

x := i8(-10)
```

Composite types can also be given names with the `as` keyword

``` Lodge
(Str | Int) as Strint
Strint x = "10"
```

## Auto Keyword

Since variables in lodge are defined entirely based on interface compatibility than particular concrete types, it is possible to automatically declare a variable whose type interface is defined by what members are ac

The auto keyword will look at the entire scope that it's variable is being bound in to see what members of that variable's interface are being accessed. That then becomes the interface of that variable.


Take this example:
```
fun functionName(auto arg) {
	arg.name = "Name"
	Float result = arg.takeAction(10)
}
```

For this function the `arg` variable will have the following interface:
```
Interface {
	Str name
	fun takeAction(Int) Float
}
```

# Literals
## Numerical Literals

* numerical literals
	* `10`, `1.5`, `.5`, `0xFF`, `0b1010`, etc.
* string literals
	* "Text inside quotations"
* operators
	* `+`, `-`, `*`, `/`, etc.
* keywords
	* Like `if`, `loop`, `class`, `fun`, etc.
* identifiers
	* Like the names of variables, types, classes, etc.


## Circular Type Definitions

There may be cases where a composite type declaration may want to refer to itself, which is allowed in Lodge. 


Here's an example of how a tuple containing two values can be used to create something akin to a linked list
``` Lodge 
(int, listelement)|None as listElement

listElement list = (0 (1, (2, (3, None))))
```
