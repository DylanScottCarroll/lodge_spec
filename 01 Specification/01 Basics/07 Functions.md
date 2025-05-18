## Declaring functions
Function declarations in lodge use the `fun` keyword. When declaring a function, the name, arguments, return type, and function body must be specified.

## Synyax

Defining a function with a name
``` Lodge
fun functionName(type1 arg1, type2 arg2, ... ) returnType {
	!! Function body	
}
```

Defining an anonymous function
``` Lodge
fun (args) returnType {
	!! Function body
}
 
!! Lambda notation for brevity
(args){ !- Function body -! }
```

Declaring a variable with the type of a function.
``` Lodge
fun (type1, type2, type3, ...) returnType variableName := !! ...

!! Howvever, it  is less verbose to use var
var variableName := fun (args) returnType { !-Function body-! }

```

```
Int x = {
	for i=0
}
```

## Return Keyword
To return a value from a function, use the `return` keyword 

### Implicit Return
<u>This section needs to be expanded.</u>

## Auto Arguments

```
fun function(auto a) {
	!!
}

```
<u>This section needs to be expanded.</u>

## Optional Arguments / Default Values
Normally, a function expects to be provided with all of its arguments whenever it is called. However, it is possible to give a default value for an argument that it will take when not provided.

* You can give a function optional arguments by giving those arguments default values
* When calling the function, those arguments don't need to be given
	* If you want to specify only an argument that comes after an optional argument, you must give that argument with the `arg = val` syntax.

``` Lodge
fun f(int a = 10, ?int b = None) {
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
fun f(int x, Int vargs...) returnType {}
	print(length(args))
	print(args[x])
}

f(1, 2, 3, 4, 5) !! prints 4, 3
f(4, 0, 0, 0, 0, 100, 0) !! prints 6, 100
```


### Capturing Extra Keyword Arguments
It is also possible to give keyword arguments to a function that doesn't have those names as positional arguments as long as that function has somewhere to capture those keywords. This is done using the ** token.

``` Lodge
fun functionName(**kwargs){
	print(kwarg["keyword"])
}

functionName(keyword="Hello World") !!Prints "Hello World"
```


### Positional-Only Arguments
There are some cases in which it may be desirable to have positional arguments that cannot be provided through keywords or through dictionary expansion.

```
fun func(Int x | Int y, Int **kwargs){
	!! ...
}

func(1, 2) 
func(1, y=2) 
func(x=1, y=2) !! Compile error, x not provided
func(1, 2, x=3) !! Allowed, "x" will be a key in the kwargs dict


var dict =  Dict{"x":1, "y":2}

func(1, **dict) !! x=1, y=2, and "x" is a key in the kwargs dict 
func(**dict) !! Compile error x not provided

```

## Function/Method Overloading

Lodge doesn't have function or method overloading explicitly as type information could not be used to unambiguously select between functions based on their signature.


The same techniques used for optional parameters can be used to mimic the behavior of function and method overloading. Essentially, the behavior a function can be configured to depend on the types of the given arguments and which arguments are given.

## Argument Expansion

### List Expansion
You can pass sequences of values (lists, arrays, and tuples) into the arguments of a function with the `...` suffix. This only works if the types of the sequence match with the types of the corresponding arguments of the function. This also works for variadic functions. And the passing can be a subset of the arguments 

``` Lodge
fun func1(int a, int b, int c) {}
	!! ... 
}

fun func2(int a, str b, int c) {
	!! ...
}

!! Expanding arrays
[int] arr1 := [1, 2, 3]
func1(*arr) 
func2(*arr) !! type error because the second argument type does not match 

!! Expanding a tuple with heterogenous types 
(int, str, int) tuple := (1, "2", 3) 
func2(*tuple)

!! Passing a subset
[int] arr2 := [1, 2] 
func1(arr2..., 3)
```

### Dictionary Expansion
It is also possible to do a similar action with keyword arguments using the `...` suffix.
With this, it is possible to supply the same argument multiple times. When that is the case, the latest provided value will be the final value of the argument. 

```
fun func1(Int a, Int b, int c){
	!! ...
}

fun func1(Int a, Int **kwargs){
	!! ...
}

{Str:Int} dict = {"a" : 1, "b": 2, "c":3}

func1(dict...) !! a=1, b=2, c=3

func1(dict...) !! a=1, b=2, c=3

```


## Function argument Syntax
Bringing each piece together, functions are made up of positional arguments and keyword arguments. There are rules for how the function can be specified.




## Generator Functions
[[Lodge Function Implementation#Generator Functions|generator function implementation]]

There is no special syntax for generator functions besides the yield keyword. Any function with the yield keyword in the function body can be a generator function.

When the yield keyword is encountered, that function instead returns a generator. This generator has a new [[Function Closures|function closure]] that represents the state of the function


When defining a generator function, the return type is expressed as the following generic: ```
``` Lodge
Generator<type>
```


Here's an example of a generator 
``` Lodge
fun FibonacciGenerator() Generator<Int>{
	a, b := (0, 1) 
	loop {
		a, b := (b, a+b)
		yield b
	} 
}


Generator<int> gen = FibonacciGenerator()

print(gen.next()) !! 1
print(gen.next()) !! 1
print(gen.next()) !! 2
print(gen.next()) !! 3
print(gen.next()) !! 5
```






