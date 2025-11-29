#import "../shared.typ": * 

Lodge is a lexically-scoped language; blocks create new scopes, a variable defined in a block will go out of scope at the end of the scope, and each block's scope will inherit the variables from the enclosing scope.

Variables aren't accessible until after their declaration. However, they are considered to be in scope for the entirety of the block in which they are declared. If a variable is accessed before its definition, it will result in similar error to the case where the variable was not defined at all.



=== Variable Declarations

Variables created during a declaration don't enter the scope until after the statement that declares them. This allows a variable declaration which covers a variable in an enclosing scope to use that variable in its definition

```
fun functionName(Int val){
  Int val = val
}
```
=== Function Declarations

==== Function Hoisting
Function declarations differ from typical declarations in that they enter the scope at the beginning of the block regardless of where in the block they are defined. A `fun f` declaration introduces the name `f` at the beginning of its enclosing block, regardless of where the declaration appears. This behavior is called function hoisting. Functions inherit the scope that they are declared, which includes variables defined before the function declaration and functions decalred anywhere in the block. However, a function may not be called or allowed to escape the current scope before all of the values ir references are defined.

==== Escape Analysis
Any time that a function is able to enter a different scope is called an "escape". A function can escape by being returned, or by being assigned to a variable accessible from a higher scope. Escape analysis is the process by which the Lodge compiler checks when a function might escape the current scope. Escape analysis is important in verifying that a function can't reference undeclared variables.

==== Undeclared Variable Reference Checking
At any point where a function is called or where it escapes, the compiler checks that all of the values referenced by that function have been declared. This check includes values referenced by functions that are called by the function being checked. If a function directly or indirectly references an undeclared value, the function call or escape will result in a compiler error.

Functions cannot be called or be allowed to escape until all values they reference are declared.

Consider the following example:
```Lodge
fun foo(){
  bar()
}

!! Compiler Error: foo indirectly references x, which has not been declared yet.
foo() 

Int x = 10
fun bar(){
  print(x)
}
```

=== Scope Lifetimes

There are cases where a particular instance of a scope can continue to exist after program execution leaves that block. Namely, functions defined inside of a scope that have references to values in that scope can cause a scope to persist if that function is accessed elsewhere as. 


