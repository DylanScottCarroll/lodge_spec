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
 
!! Arrow notation for brevity
(args) => { !- Function body -! }
```

Declaring a variable with the type of a function.
``` Lodge
fun (type1, type2, type3, ...) returnType variableName := !! ...

!! Howvever, it  is less verbose to use var
var variableName := fun (args) returnType { !-Function body-! }

```

## Variadic Functions (Variable number of arguments)

### Optional arguments
* You can give a function optional arguments by giving those arguments default values
* When calling the function, those arguments don't need to be given
	* If you want to specify only an argument that comes after an optional argument, you must give that argument with the `arg = val` syntax.


``` Lodge
fun f(?int a = None, ?int b = None) {
	swype a, b {
		None, None : { !- case 1: Called with no arguments -! }
		int, None  : { !- case 2: called with a only -! }
		None, int  : { !- case 3: called with b only -! }
		int, int   : { !- case 4 : called with both arguments -! }
	}
}

f() !! case 1
f(1) !! case 2
f(b=2) !! case 3
f(1, 2) !! case 4 
```

### Variadic Arguments
* Define a function with variadic arguments by placing `...` after the last argument. That name will then be treated like an array of those values within the function body. Other arguments
 
``` Lodge
fun f(int a, ints vargs...) returnType {}
	print(length(args))
	print(args[a])
}

f(1, 2, 3, 4, 5) !! prints 4, 3
f(4, 0, 0, 0, 0, 100, 0) !! prints 6, 100
```


## Function/Method Overloading

Lodge doesn't have function or method overloading explicitly as type information could not be used to unambiguously select between functions based on their signature.


The same techniques used for optional parameters can be used to mimic the behavior of function and method overloading. Essentially, the behavior a function can be configured to depend on the types of the given arguments and which arguments are given.

## Argument Expansion

You can pass sequences of values (lists, arrays, and tuples) into the arguments of a function with the * prefix. This only works if the types of the sequence match with the types of the corresponding arguments of the function. This also works for variadic functions. And the passing can be a subset of the arguments 

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
func1(*arr2, 3)
```


## Generator Functions
[[Lodge Function Implementation#Generator Functions|generator function implementation]]

There is no special syntax for generator functions besides the yield keyword. Any function with the yield keyword in the function body can be a generator function.

When the yield keyword is encountered, that function instead returns a generator alongside the value being. This generator is a new [[Function Closures|function closure]] that represents the state of the function


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






