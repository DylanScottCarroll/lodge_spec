#lodge_spec

## Declaring and Assigning Variables
Lodge variable declarations work much like they do in C or Java. You simply list the type or type union. You can also use the keyword ` var ` to let the compiler infer the type. With var, the compiler will select the narrowest applicable type, i.e. no type unions.

Assignment occurs using the `:=` operator 

See [[Lodge Built-In Types]] for descriptions of these types

``` Lodge
int value    !! Decalring a variable without defining it

int value2 := 10    !! Declaring an int variable and assigning it a value

nums value3    !! Declaring a variablee with the "nums" unions, which means it could be any integer or float.

var value4 := "hello"    !! Declaring a variable as a string with an inferred type

(int | string) value4    !! Declaring a value with a type union

(int, string) tuple1 := (10, "hello")    !! Declaring a variable with the type of a tuple
(int,) tuple2 := (10,)    !! Declaring a single-value tuple an its corresponding tuple literal
(int: 5,) tuple3 := (1, 2, 3, 4, 5)    !! Shorthand for declaring tuples with all the same type 


[int: 10] arr1 := [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]    !! Declaring an array
var arr2 := [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]    !! Declaring a type with an inferred type variable
[(int | string) : 4] arr3 = [1, "hello", 2, "world"]    !! Declaring an array witht a union as its type

<int> aList := <0, 1, 2, 3, 4, 5, 6, 7, 8, 9>    !! Declaring a list. Note: lists do not have to have their size declared at compile time

{string : int} aDictionaty    !! Declaring a dictionary

{int} set1   !! Declaring a set of only integers
{(string | int | float)} set2    !! Declaring a set of strings, ints, and floats using a type union.
```


Assignment also does not need to be a standalone statement, but can be an expression that returns the new value, like in C.
```Lodge
!! Print out the characters from a file until the character 'a' is reached
loop while (c := file.getChar()) != 'a'
	print(c)
;
```


## Auto Keyword

Since variables in lodge are defined entirely based on their interface rather than any particular concrete type, it is possible to define a variable just exactly on the interface that variable uses.

The auto keyword will look at the entire scope that it's variable is being bound in to see what members of that variable's interface are being accessed. That then becomes the interface of that variable.

It will also take on the union of every type present in any type switches applied to it. (work out the details of this?)
#lodge_hole


Take this example:
```
fun functionName(auto arg)
	arg.name = "Name"
	Float result = arg.takeAction(10)
;
```

For this function the `arg` variable will have the following interface:
```
Interface
	Str name
	fun takeAction(Int) Float
;
```



There are a few details to be ironed out about the details of what assumptions are made about things like return types and literal types.

#lodge_hole


## Circular Type Definitions
#lodge_decision

Not sure if I want to enable circular type definitions like this
It could be useful in some instances like making a more functional generator, but it could also make the whole typing system more complex.

``` Lodge
 
(fun (args) (int, thisType) | None) as thisType
```
