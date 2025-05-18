## Declaring functions
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

Defining an anonymous function
``` Lodge
var functionName = fun returnType(args)  {
	!! Function body
}
 
!! Lambda notation for brevity
(args)=>{ !- Function body -! }
```

Declaring a variable with the type of a function.
``` Lodge
!! Refer to the type of an existing function by name
functionName variableName := !! ...


!! Describe the signature of 
fun returnType(type1, type2, type3, ...) variableName := !! ...

!! Howvever, it  is less verbose to use var
var variableName := fun returnType(args)  { !-Function body-! }
var variableName := (args)=>{ !-Function body-! }

```

## Return Keyword
To return a value from a function, use the `return` keyword 
### Implicit Return
Absent the return keyword, a function will implicitly return the value of the final expression in the function body.

## Auto Arguments

```
fun function(auto a) {
	!!
}

```
#expand

## Optional Arguments / Default Values
Normally, a function expects to be provided with all of its arguments whenever it is called. However, it is possible to give a default value for an argument that it will take when not provided.

* You can give a function optional arguments by giving those arguments default values
* When calling the function, those arguments don't need to be given
	* If you want to specify only an argument that comes after an optional argument, you must give that argument with the `arg = val` syntax.

``` Lodge
fun f returnType(int a = 10, Int? b = None) {
	!! Function body
}

f() !! case 1
f(1) !! case 2
f(b=2) !! case 3
f(1, 2) !! case 4 
```

## Providing Arguments by Keyword

In addition to passing positional arguments by their position, it is also possible to specify the name.

All non-optional arguments must be provided exactly once, whether that be positionally or by keyword. Failing to do so will result in a compiler error.

```
fun functionName(Int x, Int y=2, ?Int z=None){
	!! Function body
}

!! Legal
functionName(1, 2, 3)
functionName(x=1, y=2, z=3)
functionName(1, z=3)

!! Not legal
functionName(y=2, z=3) !! x not provided
```


## Capturing Extra Arguments

### Capturing Extra Positional Arguments

* Define a function with variadic arguments by placing `...` after the last argument. That name will then be treated like an array of those values within the function body. Other arguments. The type of this value will be an array of values with the specified type.

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
fun functionName({Int kwargs}){
	print(kwarg["keyword"])
}

functionName(keyword="Hello World") !!Prints "Hello World"
```


### Positional-Only Arguments
There are some cases in which it may be desirable to have positional arguments that cannot be provided through keywords or through dictionary expansion.

```
fun func(Int x | Int y, {Int kwargs}){
	!! ...
}

func(1, 2) 
func(1, y=2) 
func(x=1, y=2) !! Compile error, x not provided
func(1, 2, x=3) !! Allowed, "x" will be a key in the kwargs dict


var dict =  {"x":1, "y":2}

func(1, dict...) !! x=1, y=2, and "x" is a key in the kwargs dict 
func(dict...) !! Compile error x not provided

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

fun func1(Int? a=None, {Int kwargs}){
	!! ...
}

{Str:Int} dict = {"a" : 1, "b": 2, "c":3}

func1(dict...) !! a=1, b=2, c=3

func1(dict...) !! a=1, b=2, c=3

```

## Generator Functions
[[Lodge Function Implementation#Generator Functions|generator function implementation]]

There is no special syntax for generator functions besides the yield keyword. Any function with the yield keyword in the function body can be a generator function.

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

Lodge doesn't have function or method overloading explicitly as type information could not be used to unambiguously select between functions based on their signature.


The same techniques used for optional parameters can be used to mimic the behavior of function and method overloading. Essentially, the behavior a function can be configured to depend on the types of the given arguments and which arguments are given.