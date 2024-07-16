#lodge_spec 

See [[Lodge Function Implementation]]

Defining a function with a name
``` Lodge
fun functionName(type1 arg1, type2 arg2, ... ) returnType
	!! Function body	
;
```

Defining an anonymous function
``` Lodge

!! multi-line
fun (args) returnType
	!! Function body
;

!! single-line - The single line syntax can only have a single statement
fun (args) returnType !-Function body-! ;

```

Declaring a variable with the type of a function.
``` Lodge
fun (type1, type2, type3, ...) returnType variableName = ...

!! Howvever, it  is less verbose to use var
var variableName = fun (args) returnType !-Function body-! ;

```

## Variadic Functions

Optional arguments
* You can give a function optional arguments by giving those arguments default values
* When calling the function, those arguments don't need to be given
	* If you want to specify only an argument that comes after an optional argument, you must give that argument with the `arg = val` syntax.


``` Lodge
fun f((int| None) a = None, (int|None) b = None)
	swype a None, b None
		!- case 1: Called with no arguments -! ;
	swype a int, b None
		!- case 2: called with a only -! ;
	swype a None, b int
		!- case 3: called with b only -! ;
	swype a int, b int
		!- case 4 : called with both arguments -! ; 
; 

f() !! case 1
f(1) !! case 2
f(b = 2) !! case 3
f(1, 2) !! case 4 
```

Variadic Arguments
* Define a function with variadic arguments by placing `...` after the last argument. That name will then be treated like an array of those values within the function body. Other arguments
 
``` Lodge
fun f(int a, ints vargs...) returnType
	print(length(args))
	print(args[a])
;

f(1, 2, 3, 4, 5) !! prints 4, 3
f(4, 0, 0, 0, 0, 100, 0) !! prints 6, 100
```


## Function/Method Overloading

Lodge doesn't have function or method overloading explicitly.
The same techniques used for optional parameters can be used to mimic the behavior of function and method overloading. 

Essentially, which behavior a function has would depend on the types of the supplied arguments or which arguments were supplied at all.

## List Argument Expansion

You can pass sequences of values (lists, arrays, and tuples) into the arguments of a function with the * prefix. This only works if the types of the sequence match with the types of the corresponding arguments of the function. This also works for variadic functions. And the passing can be a subset of the arguments 

``` Lodge
fun func1(int a, int b, int c)
	!! ... 
;

fun func2(int a, str b, int c)
	!! ...
; 

!! Expanding arrays
[int: 3] arr1 = [1, 2, 3]
func1(*arr) 
func2(*arr) !! type error because the second argument type does not match 

!! Expanding a tuple with heterogenous types 
(int, str, int) tuple = (1, "2", 3) 
func2(*tuple)

!! Passing a subset
[int: 2] arr2 = [1, 2] 
func1(*arr2, 3)
```

## Function Closures
[[Function Closures]]

## Class Methods
[[Lodge Classes#Class Methods|Class Methods]]


## Generator Functions
[[Lodge Function Implementation#Generator Functions|generator function implementation]]

There is no special syntax for generator functions besides the yield keyword. Any function with the yield keyword in the function body can be a generator function.


When the yield keyword is encountered, that function instead returns a generator alongside the value being. This generator is a new [[Function Closures|function closure]] that represents the state of the function


When defining a generator function, the return type is expressed as the following generic: ```
``` Lodge
Generator<type>
```




I don't know if I want generators to be a persistent object that you call repeatedly or something that returns itself to be called again. The first is simpler and more practical, but the latter is more satisfying from a functional programming perspective. 







