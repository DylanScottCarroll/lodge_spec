#import "../shared.typ": *

=== Declaring and Assigning Variables

A variable declaration consists of a #link(<Basics.Type_Expressions>)[type expression], a variable name, the assignment operator `:=`, and an expression. After the variable declaration statement, a name bound to the value of the expression will exist in the enclosing scope until that scope ends. In the most comon case, the type expression takes the form of a single type.

Variables cannot be declared without being assigned a value. Variables that need a default value should use something like `None` and be defined with a #link(<The_Type_System.Errable_and_Nonable_Types>, "nonable type").

```Lodge
Int value2 := 10    !! Declaring an int variable and assigning it a value
```

Like all statements, declarations (like assignments) may be expressions, returning the value the variable was assigned to.
```Lodge
!! Print out the characters from a file until the character 'a' is reached
loop while (Str c := file.getChar()) != 'a' {
  print(c)
} 
```

=== Variable Types
The type of a variable determines what values may be assigned to that variable. The values that can be assigned to a given variable are not restricted only to values of the declared type. Instead, any value whose public interface is the superset of that of the declared type may be assigned to that variable. In other words, a variable may contain any value with a #link(<The_Type_System.Interface_Compatibility>)[compatible interface]. Likewise, the type the a variable is declared with does not have to be a type with a defined constructor: it could also be an interface or a type expression.


The full behaviors of Lodge's type checking system is found in #link(<The_Type_System>)[The Type System]

=== Var Keyword

When variables are declared with the `var` keyword instead of a type, the variable's type is inferred from the right hand side of the assignment.  f

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




