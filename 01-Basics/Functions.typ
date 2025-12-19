#import "../shared.typ": *


=== Basic Syntax

Full function definitions are made of the following pieces: 1) The  `fun` keyword, 2) the function name, 3) optional type parameters surrounded by angle brackets, 4) optional return type, 5) the argument description list surrounded by parentheses, and 6) the function body consisting of a sequence of statements surrounded with curly brackets. This syntax defines a variable with the function's name in the current scope and evaluates as an expression to that function.


```Lodge
!! Full Syntax
fun functionName <Type T, Type T, ...> ReturnType(Type1 arg1, Type2 arg2, Type3 arg3) {
	!! Function body	
}

!! Type parameters are optional and are usually omitted
fun functionName ReturnType(Type1 arg1, Type2 arg2, Type3 arg3) {
	!! Function body	
}

!! Functions without return types may omit it, 
fun functionName(Type1 arg1, Type2 arg2, Type3 arg3) {
	!! Function body	
}

```


Alternatively, Lodge offers syntactic shorthand for defining anonymous functions. This form consists only of an argument list, the `=>` token, and the function body surrounded by curly brackets. This syntax does not declare a variable for the function. 
```
(Type arg, Type arg, ...)=>{ !- Function body -! }
```
==== Return Keyword
To return a value from a function, use the `return` keyword

Absent the return keyword, a function with a return type will implicitly return the value of the final expression in the function body.

=== Argument Description Lists
==== Positional Arguments
Every function declaration has an argument description list surrounded by parentheses. At its most basic, this is simply a comma-separated list of type expression and identifier pairs, which each identify a positional argument. Each argument in that list describes a variable that will be defined within the scope of the function.

```
(Type1 arg1, Type2, arg2, Type3 arg3)
```

==== Optional Positional Arguments
In addition to a type and a name, an argument description can include a default value in the form of an expression following an equal sign `=` (note, not the assignment operator `:=`). The presence of this default value also marks the argument as optional.

Optional arguments may be omitted when calling a function, while non-optional arguments may not. When not provided at the time of function invocation, the default value expression is evaluated and assigned to that argument.

```Lodge
fun f returnType(Int a = 10, Int? b = None) {
	!! Function body
}
```

When calling a function with optional positional arguments, trailing optional arguments may be omitted entirely. If an optional argument is not one of the final arguments, it must be explicitly skipped by replacing its expression with an asterisk `*`.

```Lodge
f() !! All optionals omitted 
f(1) !! Trailing optional omitted
f(*, 2) !! Positional optional skipped with *
f(1, 2) !! All arguments provided
```

==== Keyword Arguments
Positional arguments are identified purely by their order in the function signature and the name is purely for the variable defined in the scope of the function. This is important for the semantics of type checking function signatures. However, in some cases it might also be useful to identify arguments not by their positions but only by their names, particularly if there are a large number of 

By replacing one of the commas in an argument list with the pipe character `|`, all following arguments are interpreted as keyword arguments. Keyword arguments may also be optional and non-optional in the same way as positional arguments. 

```
fun functionName(Int x, Int y=10 | Int y, Int z=10){
	!! Function body
```

When calling a function with keyword arguments, the argument is given by providing the name of the keyword, the equal sign `=`, and the value of the argument. Keyword arguments must be provided after all positional arguments. Providing positional arguments after a keyword argument will result in a compiler error. Keyword arguments have no ordering and may not be provided positionally at function invocation. This is important for the semantics of type checking function signatures that use keyword arguments.

All non-optional keyword arguments must be provided exactly once. Failing to do so will result in a compiler error. This also means that non-optional arguments cannot be supplied via argument expansion. 



```Lodge
!! Legal
functionName(1, 2, y=3, z=4)
functionName(1, y=2)
functionName(1, *, y=2)

!! Not legal
functionName(1, 2, 3, 4) !! Keyword argument 7 not provided, and two unexpected positional arguments.
functionName(1, z=3) !! Keyword argument y not provided
functionName(x=2, y=2, z=3) !! Positional argument x not provided and Unexpected keyword argument x
```



At invocation time, if there is a variable in scope of the caller whose identifier matches one of the keyword arguments, there is a shorthand for providing that variable as a keyword argument that involves omitting the keyword argument name. 

```Lodge
fun foo(Int longVariableName = 10) { }
Int longVariableName = 20

!! The following are equivalent
foo(longVariableName = longVariableName)
foo(=longVariableName)
```

==== Positional Captures
Positional captures are special arguments that allow the function to accept an arbitrary number of extra positional arguments. When a positional capture argument is present, extra positional arguments at the function invocation will populate the positional capture as a list.


The positional capture argument must be placed as the last positional argument. It is indicated to be the positional capture by enclosing the entire argument description (type and identifier) in square brackets. Positional captures are always optional arguments and default values cannot be specified (the default value is simply the empty list when no extra positional arguments are given.)


```Lodge
fun f(int x, [Int vargs]) returnType {}
	print(length(args))
	print(args[x])
}

f(1, 2, 3, 4, 5) !! prints 4, 3
f(4, 0, 0, 0, 0, 100, 0) !! prints 6, 100
```


==== Keyword Captures
Like positional captures, keyword captures may be described by placing a keyword capture argument at the end of the keyword arguments. Keyword captures are indicated by enclosing the argument description in curly brackets.

```Lodge
fun functionName(|{Int kwargs}){
	print(kwarg["keyword"])
}

functionName(keyword="Hello World") !!Prints "Hello World"
```


==== Full Argument Description Syntax

Here, the ellipses `...` descrive repetition rather than indicating language syntax. 

```
(Type pos_arg, ..., [Type PosCapture] | Type kw_arg, ..., {Type KeywordCapture} )
```

=== Argument Expansion

==== List Expansion
You can pass sequences of values  into the arguments of a function with the `...` suffix. This only works if the types of the sequence match with the types of the corresponding arguments of the function and if the lengths can be verified to match at compile time.

```Lodge
fun func1(Int a, Int b, Int c) {}
	!! body 
}

fun func2(Int a, Str b, Int? c=None, [Int d]) {
	!! body
}

!! Expanding arrays
[int] list := [1, 2, 3]
func1(list...) !! Type error because the number of arguments may not match if list had a different value.
func2(1, "2", list...) !! Success as the excess length of the list can be caputed by the sequence capturing arugment, d.
func2(list...) !! type error because the second argument type does not match

!! Expanding a tuple with heterogenous types 
(Int, Str, Int) tuple := (1, "2", 3) 
func2(tuple...)

!! Passing a subset
[int] tuple2 := [1, 2] 
func1(arr2..., 3)
```

=== Type Expression for a Function Interface
The type expression for a function mirrors the anonymous function syntax with a return type instead of a body, and with type names instead of identifiers for non-keyword arguments. Arguments are marked as optional by placing an equal sign after the argument, but default values are not specified in an interface.

```Lodge
!! Full syntax
(Type, Type=, ... | Type keyword, Type keyword=, ..., [Type], {Type})=>ReturnType

!! Only positional arguments
(Type, Type, ..., Type)=>ReturnType

!! Only keyword arguments
(| Type keyword, Type keyword=, ..., Type keyword)=>ReturnType

!! Only Captures
([Type])=>ReturnType
({>Type})=>ReturnType

```

There is also syntax for marking the function interface as non-callable. If the first token in a function type expression is an asterisk `*`, the function interface is non-callable. Non-callable function interfaces allow participation by functions even if the interface is missing mandatory arguments of the participating function.

```Lodge
(*)=>Any !! Allows participation by any function

(* Int)=>Str !! Allows participation by any function that takes an Int as its first argument, and returns a Str.
```


==== Map Expansion
It is also possible to do perform similar action with keyword arguments using the `...` suffix. Arguments provided this way much be optional as the contents of the map cannot be verified at compile time.
With this, it is possible to supply the same argument multiple times. When that is the case, the latest provided value will be the final value of the argument. 

```Lodge
fun func1(Int? a=None, Int? b=None, Int? c=None){
	!! ...
}

fun func1(Int? a=None, {Int kwargs}){
	!! ...
}

{> Str:Int} dict = {> "a" : 1, "b": 2, "c":3}

func1(dict...) !! a=1, b=2, c=3

```

=== Generator Functions
#section-link("Lodge Function Implementation", "Generator Functions", "generator function implementation")

There is no special syntax for generator functions besides the yield keyword. Any function with the `yield` keyword in the function body can be a generator function.

When the yield keyword is encountered, that function instead returns a generator. This generator has a new #section-link("Function Closures", "", "function closure") that represents the state of the function


When defining a generator function, the return type is expressed as a generator.
```Lodge
<Type>
```


Here's an example of a generator 
```Lodge
fun FibonacciGenerator <Int>() {
	a, b := (0, 1) 
	loop {
		a, b := (b, a+b)
		yield b
	} 
}


<Int> gen = FibonacciGenerator()

print(gen.next()) !! 1
print(gen.next()) !! 1
print(gen.next()) !! 2
print(gen.next()) !! 3
print(gen.next()) !! 5
```


// === Function/Method Overloading

// Lodge doesn't have function or method overloading explicitly as type information could not be used to unambiguously select between functions based on their signature. This is a limitation of the type system and must be worked around to achieve similar behavior.

// The same techniques used for optional parameters can be used to mimic the behavior of function and method overloading. Essentially, the behavior a function can be configured to depend on the types of the given arguments and which arguments are given.


=== Generic Functions

Functions may also be declared with type parameters that allow multiple instances of the function that vary only be their argument and return types. 


```Lodge
fun funName<T> T(T arg){
  !! ...
} 
```

Take for example this simplistic implementation of a map function without generics.
```Lodge
fun map [Obj]([Obj] seq, (Obj)=>{Obj} f) {
    return loop for val = seq { f(val) }
}
```
Since the type checker has no assurance that anything besides objects are being passed around here, the programmer is forced to perform numerous cumbersome unsafe swype operations to invoke any particular functionality.
```
fun square Obj(Obj x) {
  return swype x {Int: {x**2}, *: { panic() }}
}

[Obj] objs = map([1, 2, 3, 4, 5], square)
[Int] result = swype result objs { [Int]: { objs }, *: { panic() }}
```

Instead, functions declared with type parameters tell the type checker that the input is the same as the output.

```Lodge
fun map<S, T> T([S] seq, (S)=>{T} f){
  return loop for val = seq { f(val) }
}

fun square Int(Int x){ return x**2 }
[Int] result = map<Int, Int>([1, 2, 3, 4, 5], square)
```

Additionally, explicit type parameters can be omitted if the type parameters can all be inferred from argument types. #review[I felt really smart for coming up with this until I later learned that java does this as well.]

In the following example, the type `T` is inferred from the value of the first argument and the type `S` is inferred from the return type of the second argument.
```Lodge
fun square Int(Int x){ return x**2 }
result = map[1, 2, 3, 4, 5], square)
```
