#import "../shared.typ": *

=== Declaring and Assigning Variables
A variable declaration consists of a #section-link("Type Expressions", "", "type expression"), a variable name, and an assignment. Variables cannot be declared without being assigned a value. If a variable has no sensible default value, consider using a #section-link("04 Errable and Nonable Types", "Nonable", "nonable") type.

Assignment occurs using the `:=` operator.

```Lodge
Int value2 := 10    !! Declaring an int variable and assigning it a value
```

Assignment also does not need to be a standalone statement, but can be an expression that returns a value. The value returned by an assignment expression is the assigned value.
```Lodge
!! Print out the characters from a file until the character 'a' is reached
Str c := ""
loop while (c := file.getChar()) != 'a' {
  print(c)
} 
```Lodge is garbage-collected, so created values do not need to be manually freed.

=== Variable Types
In Lodge, variables types are not defined by the concrete type they are declared with. Instead, the type of a variable is the public interface of that type. This means that a variable is not restricted to just the type it was declared with. Instead, any value with a #section-link("04 Interface Compatibility", "", "compatible interface") can be stored in that variable. For example, a variable with the default `Int` type can store any integer value.

Likewise, the type the programmer variable declares a variable with does not have to be a type with a defined constructor. It could also be an interface or a type expression.

=== Var Keyword

When variables are declared with the `var` keyword instead of a type, the variable being declared takes the same type as the value on the right side of the assignment.

```Lodge
Int a = 10
var b = a !! b has the type of Int

!! Literals have types that var infers
var value4 := "hello"


!! Generic types are also inferred
var arr := [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
!! arr has the type [Int]
```

=== Auto Keyword

#text(fill:red)[This feature will likely need to be removed as it makes the type system much more complex and would result in very opaque error messages :( ]

The `auto` keyword allows the programmer define the type of a variable automatically based on what the variable is used to do. When `auto` is used to define a variable, every get, set, and method call are collected together. The broadest possible interface for those accesses is used to create the type of the given variable 

Consider the following example:
```Lodge
fun function(auto a) {
	a.x = 10
	Float b = a.y
	Str c = a.function(1, 2, 3) 
}

```
The type of `a` would be the following interface:
```Lodge
Interface {
	set Int x
	get Float y
	fun function Str(Int _1, Int _2, Int _3 |)
}
```



The full behaviors of Lodge's type checking system is found in #link(<The_Type_System>)[The Type System]

=== Union Types
Instead of creating a variable with just a single type, it is also possible in Lodge to define a variable with a composite type called a #section-link("03 Type Unions", "", "type union"). This allows a variable to store any value that has a compatible interface with *any* type in the union.

```Lodge
(Str | Int) x

!! Allowed
x := 10
x := "Hello World"
```

Composite types can also be given names with the `as` keyword

```Lodge
(Str | Int) as StrInt
StrInt x = "10"
x = x->Int
```


=== Circular Type Definitions

There may be cases where a composite type declaration may want to refer to itself, which is allowed in Lodge. 


Here's an example of how a tuple containing two values can be used to create something akin to a linked list
```Lodge 
((int, listelement) | None) as listElement

listElement list = (0 (1, (2, (3, None))))
```
