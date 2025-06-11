# Declaring functions
Function declarations in lodge use the `fun` keyword. When declaring a function, the name, arguments, return type, and function body must be specified.

## Syntax

Defining a function with a name
``` Lodge
fun functionName returnType(type1 arg1, type2 arg2, ... ) {
	!! Function body	
}

!! Functions without return types may omit it, 
fun functionName(type1 arg1, type2 arg2, ... ) {
	!! Function body	
}
```

Defining an anonymous function:
``` Lodge
fun returnType(args) {
	!! Function body
}
 
!! Lambda notation for brevity
(args)=>{ !- Function body -! }
```
The lambda notation will infer the return type based on the type of the expression being returned.

Declaring a variable with the type of a function:
``` Lodge
!! Refer to the type of an existing function by name
functionName variableName := !! ...


!! Describe the signature of the function
(!- type expression -!) variableName := !! ...

!! Howvever, it  is less verbose to use var
var variableName := fun returnType(args)  { !-Function body-! }
var variableName := (args)=>{ !-Function body-! }

```

## Type Expression for a Function Type
The type expression for a function mirrors thy syntax for its arguments. The main difference  being that the positional and capture arguments do not take names. Optional arguments have a single equal sign `=` after them.

```
!! Full syntax
ReturnType(Type, Type=, ... | Type keyword, Type keyword=, ..., [Type], {|Type|})

!! Only positional arguments
ReturnType(Type, Type2=, ..., TypeN)

!! Only keyword arguments
ReturnType(| Type1 keyword1, Type2 keyword2=, ..., TypeN keywordN)

!! Only Captures
ReturnType([Type])
ReturnType({|Type|})

```

## Return Keyword
To return a value from a function, use the `return` keyword 
### Implicit Return
Absent the return keyword, a function will implicitly return the value of the final expression in the function body.

## Arguments 
### Optional Arguments / Default Values
Normally, a function expects to be provided with all of its arguments whenever it is called. However, it is possible to give a default value for an argument that it will take when not provided.

* You can give a function optional arguments by giving those arguments default values
* When calling the function, those arguments don't need to be given
	* If you want to specify only an argument that comes after an optional argument, you must fill the space of that argument with an asterisk `*`.

``` Lodge
fun f returnType(Int a = 10, Int? b = None) {
	!! Function body
}

f() !! case 1
f(1) !! case 2
f(*, 2) !! case 3
f(1, 2) !! case 4 
```

The order does not matter and optional 

### Providing Arguments by Keyword
By default, arguments can only be provided positionally.  If, however, one of the comma delimiters is replaced by `|` all following arguments will be keyword-only arguments. 

All non-optional keyword arguments must be provided exactly once. Failing to do so will result in a compiler error.
Optional keyword arguments need not be supplied.

```
fun functionName(Int x, Int y=10 | Int y, Int z=10){
	!! Function body
}

!! Legal
functionName(1, 2, y=3, z=4)
functionName(1, y=2)
functionName(1, *, y=2)

!! Not legal
functionName(1, z=3) !! Keyword argument 7 not provided
functionName(x=2, y=2, z=3) !! Positional argument x not provided and Unexpected keyword argument x
```


## Allowing Extra Arguments

### Capturing Extra Positional Arguments

* Define a function with variadic arguments by placing the argument inside square brackets. That name will then be treated like a list of that type within the function body.

``` Lodge
fun f(int x, [Int vargs]) returnType {}
	print(length(args))
	print(args[x])
}

f(1, 2, 3, 4, 5) !! prints 4, 3
f(4, 0, 0, 0, 0, 100, 0) !! prints 6, 100
```


### Capturing Extra Keyword Arguments
It is also possible to give keyword arguments to a function that doesn't have those names as positional arguments as long as that function has somewhere to capture those keywords. This is done using the ** token.

``` Lodge
fun functionName({|Int kwargs|}){
	print(kwarg["keyword"])
}

functionName(keyword="Hello World") !!Prints "Hello World"
```


## Argument Expansion

### List Expansion
You can pass sequences of values  into the arguments of a function with the `...` suffix. This only works if the types of the sequence match with the types of the corresponding arguments of the function and if the lengths can be verified to match at compile time.

``` Lodge
fun func1(Int a, Int b, Int c) {}
	!! ... 
}

fun func2(Int a, Str b, Int? c=None, [Int d]) {
	!! ...
}

!! Expanding arrays
[int] list := [1, 2, 3]
func1(list...) !! Type error because the number of arguments may not match for another value of list
func2(1, "2", list...) !! Success as the excess length of 
func2(*list) !! type error because the second argument type does not match 

!! Expanding a tuple with heterogenous types 
(Int, Str, Int) tuple := (1, "2", 3) 
func2(tuple...)

!! Passing a subset
[int] tuple2 := [1, 2] 
func1(arr2..., 3)
```

### Dictionary Expansion
It is also possible to do perform similar action with keyword arguments using the `...` suffix. Arguments provided this way much be optional as the contents of the dictionary cannot be verified at compile time.
With this, it is possible to supply the same argument multiple times. When that is the case, the latest provided value will be the final value of the argument. 

```
fun func1(Int? a=None, Int? b=None, Int? c=None){
	!! ...
}

fun func1(Int? a=None, {|Int kwargs|}){
	!! ...
}

{Str:Int} dict = {"a" : 1, "b": 2, "c":3}

func1(dict...) !! a=1, b=2, c=3

func1(dict...) !! a=1, b=2, c=3

```

## Generator Functions
[[Lodge Function Implementation#Generator Functions|generator function implementation]]

There is no special syntax for generator functions besides the yield keyword. Any function with the `yield` keyword in the function body can be a generator function.

When the yield keyword is encountered, that function instead returns a generator. This generator has a new [[Function Closures|function closure]] that represents the state of the function


When defining a generator function, the return type is expressed as a generator.
``` Lodge
<type>
```


Here's an example of a generator 
``` Lodge
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


## Function/Method Overloading

Lodge doesn't have function or method overloading explicitly as type information could not be used to unambiguously select between functions based on their signature. This is a limitation of the type system and must be worked around to achieve similar behavior.

The same techniques used for optional parameters can be used to mimic the behavior of function and method overloading. Essentially, the behavior a function can be configured to depend on the types of the given arguments and which arguments are given.