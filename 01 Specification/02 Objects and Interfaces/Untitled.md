1Lodge hasn't really been designed with LL parsing in mind so far

Here's a draft rundown of the syntax spec
## Mathematical Operators
| op  | action                           |
| --- | -------------------------------- |
| +   | addition                         |
| -   | subtraction (and unary negation) |
| /   | division                         |
| //  | integer division                 |
| *   | multiplication                   |
| %   | modulus                          |
| **  | power                            |
|     |                                  |



## Logical Operators
The operators here that are words are reserved keywords

| op   | action                          |
| ---- | ------------------------------- |
| and  | Logical and                     |
| or   | Logical or                      |
| not  | unary logical negation operator |
| xor  | exclusive or                    |
| ==   | value equivalence               |
| is   | identity equivalence            |
| !=   | not value equivalent            |
| isnt | not identity equivalent         |
| >    | greater than                    |
| <    | less than                       |
| >=   | greater than or equal to        |
| <=   | less than or equal to           |

The value equivalence operator `==` should not be confused with the assignment operator `:=`, or the function keyword token `=`.

## Bitwise Operators
| op  | action                   |
| --- | ------------------------ |
| &   | bitwise and              |
| \|  | bitwise or               |
| ^   | bitwise xor              |
| -   | bitwise not (compliment) |
| >>  | right shift              |
| <<  | left shift               |

## Assignment Operators
| op  | action     |
| --- | ---------- |
| :=  | assignment |
| ++  | increment  |
| --  | decrement  |

There are also forms such as `+=`, `-=`, `*=`, `/=`, and `**=` that are shorthand for performing an operation and then assigning the result to the first operand (assuming that operand is an existing identifier). Any operator except assignment operators and unary operators followed by a = will be treated as being a part of this shorthand.

## Other Operators 
| op  | action                                                 |
| --- | ------------------------------------------------------ |
| :   | type conversion                                        |
| ()  | call as a function                                     |
| []  | indexing and slicing                                   |
| ->  | Virtual field (gets field? but falls back to indexing) |
| !   | Error Resolution                                       |
| ?   | None Resolution Operator                               |
| #   | hash                                                   |
| $   | broadcasting directive                                 |
| @   | other                                                  |


```
!! Assignment

:=  +=  -=  *=  /=  //=  ...

!! Logical

or
xor
and
not (unary)

==  !=  is  isnt


<  >  >= <=


!! Numerical

>>  <<


|
^
&


+ -


*  /  //   %


-  ~ (prefix)

**


!! Pre and post increment operators
++ -- 



!! Special Infix operators
!  ?


!! Special Prefix Operators
!

!! Special Postfix Operators
()  []   ->  :


.

```

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

## Literals
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
## Blocks

Blocks are opened and closed by curly brackets `{}`. Many statements such as if statements, loops, and class definitions require blocks.

Blocks in lodge create a new scope that can access variables from the outer scope, but whose variables only last during the scope of. 

``` Lodge
Int x := 0
loop while x <= 10 {
	if x%2 == 0 
		{ print(x) }	
	x++
}
```

Naked blocks can also be created without an opening statement simply to create a new scope and group together a sequence of statements.

### Block Expressions
If a block is placed in a location where it is evaluated as an expression rather than a standalone statement, the last statement of a block is treated as an expression that the entire block evaluates to.

For naked blocks, this can simply be used as a way to cluster a sequence of statements into a single unit that returns a value. It has essentially no impact on the way the code executes, but may be used for conceptual groupings of actions.

When an if statement is used as an expression, evaluating blocks can be used for constructs like ternaries.

When a loop is used in an assignment, each iteration of the loop is evaluated separately, and placed into a list that returns when the loop completes. 


## Conditionals

Conditionals use the `if` keyword, a boolean expression, and a block to create an if-statement. If the given boolean expression evaluates to true, the block is entered. Otherwise, it is skipped.
### If
``` Lodge
if boolean_expression {
	!! conditional body
}

```

### If / Else
You can also specify as block to enter if the boolean is false using the `else` keyword.
``` Lodge
if boolean_expression {
	!! Enter if true
} else {
	!! Enter if false
}

```


### If / Else If / Else
And you can also chain if statements using `else if`
``` Lodge
if exp1 {
	!! exp1 is true
}
else if exp2{
	!! exp1 is false and exp2 is true
}
else{
	!! exp1 is false and exp2 is false
}
```

### If Expressions
You can use if statements like an expression and the selected block will be evaluated
``` Lodge
Int x := 10
Int result := if(x < 0) {
	-1
} else if (x == 0) {
	0
} else {
	1
}

!! result = 1
```

## Loops

Lodge has four kinds of loops:
* plain loop
* while loops
* for loops
* over loops

### Plain Loop
A plain loop is a loop without any parameters. It is essentially the same as a `loop while true`, but it does not perform a comparison. It is usually used for replicating a do-while type pattern using a `break if` statement.
Here is an example.
``` Lodge
!! Read one charafter from the file onto the stack until a period is reached
loop {
	c := file.read()
	stack.push(c)
	
	break if c == '.'
}
```


### While Loop
A while loop takes a boolean expression and will repeat its body code until the expression evaluates to false.

``` Lodge
!! Print all the values on the stack
loop not stack.is_empty() {
	ints val := stack.pop()
	print(val)
}
```

### From Loop

This kind of loop is merely for looping over ranges of integers. Much like similar languages (besides python) this is essentially just syntactic sugar for a declaration, a while loop, and an increment. It uses the keywords `from`, `to`, and `by` to control this range. All of these except to are optional. If a starting is left out, the default is 0. If `by` is left out, the default is 1.

The type of the loop variable does not need to specified and will need to be determined by implementation later.
If the variable exists already, its type will remain the same and its value will be assigned to the loop values.


Here is an example. The top of the range is exclusive.

``` Lodge
loop from x to 100 {
	print(x)
}

!! Print all numbers from size and less than 100 that are divisible by 3.
loop from x := 6 to 100 by 3 {
	print(x)
}


loop from x := 0 {
	print(x)
}

```


<u>This section needs to be expanded.</u>
It would be cool if the loop variable could be any l-value, but I haven't thought through the logical and implementation repercussions of that.

### For Loop
The over-loop works like Python's for-loop or for-each loops in other languages. It accepts any object that is compatible with the iterator interface and loops. It uses the `from` keyword to associate a name with the element from the iterator.

``` Lodge
!! Print all of the characters in the list
loop for c := char_list
	print(c)
```

If you want to loop over multiple iterators of the same length at once, you can separate several associations with a comma as below.

``` Lodge
loop for a, b := list1, list2
	list3.append(a + b)
```


You can also add an option that will keep track of the index with the `at` keyword.
``` Lodge
!! Print all of the characters in the list
loop for c := char_list at i
	print(c)
```


## Loop Expressions

<u>This section needs to be expanded.</u>
Will this actually be something you can do?
* It is cool to have the loop syntax reused fro other useful expressions, which makes the language feel more expressive and composible
* It is verbose syntax that might be better done by other things
* If this can only live in loops, maybe the loops should have different syntax that can also be put elsewhere

```
(0 to 100 by 3)
```

## Break and Continue

The keywords `break` and `continue` work as they do in similar languages.
`break` will exit the nearest loop that encapsulates it.
`continue` will skip to the beginning of the nearest loop that encapsulates it

Lodge also has the ` break if ` and ` continue if ` statements which act as conditional statements

For example, these two code blocks behave the same:
``` Lodge
loop over value from someList {
	print(value)
	
	break if value == None
}

loop over value from someList {
	print(value)

	if value == None {
		break
	}
}
```

### Multiple break
If the `break` keyword is followed immediately by an integer literal, the break statement will break out of that many nested loops. This value is 1 by default.
```
loop for i to 100

```
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


## Class Definition Syntax

### Basic Syntax
``` Lodge
class ClassName  {
	promises Interface1, Class1
	uses ParentClass1, !ParentClass2
	
	Int field
	
	fun Method() ReturnType {
		!! Method Body 
	}
}
```

### Anonymous Classes
Classes can also be created without names in order to allow the creation of an object without needing to write a dedicated named class for it.

The anonymous class will participate in the typing system as normal, and can even be placed in other variables using the `var` keyword.

``` Lodge
var anonObj := class {
	!! Class body
}()
```

Even though the class does not have a defined name, it will still have an internal name and interface like any other class.

## Promising

``` Lodge
class ClassName  {
	promises Interface1, Class1
	
	!! Class Body
}
```

## Using

``` Lodge
class ClassName  {
	promises Interface1, Class1
	uses ParentClass1, !ParentClass2

	!! Class Body
}
```

## Public/Private Methods and Fields

``` Lodge
class A {
	int _a := 0 !! Private/Internal field
	int a := 10 !! Public/External field
	
	fun F(int arg) int {
		!! External function
	}
	
	fun _F(int) int {
		!! Internal functions
	}
	
}
```

The difference between external and internal class members is that internal members will not be considered as part of the class's interface for the purposes of promising, automatic interfacing, and type union definition.

Internal members can be accessed from inside the class, but also from within concrete [[05 Type Switching|type switches]] that switch on the specific concrete class.

## Properties

Defining properties is done using the get and set keywords

``` Lodge

class A {
	get propertyName Type {
		!! Code for getting the value
	}
	set propertyName Type {
		!! Code for setting the value
	}
}
```

The get and set type for a given property do not have to be the same. In fact, the get and set properties act pretty much independently from eachother despite the fact that they have thee same name.

Behind the scenes, properties are compiled as functions. Properties cannot be internal, but they can still be accessed from within the class.

From the outside, properties act just like fields.

``` Lodge
A a := new A()
print(a.propertyName)
a.properyName := 10
a.propertyName += 10
```

## Generics

``` Lodge
class A<T> {
	T field := .... 
}

A<int> a := new A<int>()
int val := a.field
```



``` Lodge
class A<Iterable T> {
	...
}

class B<(int | str | list) T> {
	...
}
```



``` Lodge
class A {
	(Int|Str) field 
}

class B<(Int|Str) T> {
	T field
}

A a := new A()
B<int> bInt:= new B<Int>()
B<string> bStr := new B<Str>()

a.field := 10
a.field := "string"

b1.field := 10
b1.field := "string"    !!Compile error

b2.field := 10          !!Compile error
b2.field := "string" 

```

 In class A, both strings and integers can be placed into the field regardless, but with class B, only the generic type specified at the creation of the object can be placed in the field.


## Nested Classes


``` Lodge
class A {
	fun F() B {
		b := new B()
		return b
	}
		
	class B {
		int v := 10
	}
}

A a := new A() 
A.B b := a.F()
```


## Operator Methods

``` Lodge
class A {
	fun + (auto other) int {
		!! Logic for adding objects
	}
}

A var1 := new A()
A var2 := new A()
A var3 := var1 + var2
```

The syntax of the format `fun + () ...` is only legal within classes.

``` Lodge
interface InterfaceName {
	Int fieldName

	fun FunctionName(Int arg1, Str arg2) Int

	get propertyName Int
	set propertyName Int
}

```


## Generic Interface
```
interface A<T> {
	T fieldName 
}

``` 