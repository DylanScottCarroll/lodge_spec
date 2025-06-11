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


## Logical Operators
The operators here that are words are reserved keywords

| op   | action                          |
| ---- | ------------------------------- |
| &    | Logical and                     |
| \|   | Logical or                      |
| not  | unary logical negation operator |
| ^    | exclusive or                    |
| ==   | value equivalence               |
| is   | identity equivalence            |
| !=   | not value equivalent            |
| isnt | not identity equivalent         |
| >    | greater than                    |
| <    | less than                       |
| >=   | greater than or equal to        |
| <=   | less than or equal to           |


The value equivalence operator `==` should not be confused with the assignment operator `:=`, or the function keyword token `=`.

is_good & is_bad

## Bitwise Operators
| op   | action                   |
| ---- | ------------------------ |
| &&   | bitwise and              |
| \|\| | bitwise or               |
| ^^   | bitwise xor              |
| -\|  | bitwise not (compliment) |
| >>   | right shift              |
| <<   | left shift               |

## Assignment Operators
| op    | action                                                                                              |
| ----- | --------------------------------------------------------------------------------------------------- |
| :=    | assignment                                                                                          |
| ++    | increment                                                                                           |
| --    | decrement                                                                                           |
| {op}= | Any other infix operator followed by an '=' will be the same as that operator's assignment operator |

## Other Operators 
| op    | action                   |
| ----- | ------------------------ |
| ->    | type conversion          |
| ()    | call as a function       |
| []    | indexing and slicing     |
| !     | Error Resolution         |
| ?     | None Resolution Operator |
| {op}~ | broadcasting directive   |
| {op}$ | Reverse operator         |
| #     | hash                     |
| @     | Unused                   |

## Broadcasting Operator
Using the ~ symbol after an operator indicates that the operation should be broadcast. One of the operands of a broadcast operator must be  


This can be used to expand mathematical operations
```
var list = [0:10]
var powers_of_two = 2 ~** list
```

Function calls can also be broadcast
```
[Float] values = ( [:314] ~/ 100 )
[Float] mapped_values = cos~(values) !!This applys the cosine function to every value in values
```

You can also broadcast generator objects, which will be evaluated lazily
``` Lodge
<Int> everySquare = <:> ~** 2 
```

Broadcast operators have the same precedence of the non-broadcast version

## Reverse Operator 
When any operator is followed by a dollar sign, it simply applies the 

```
10 :=$ variable
```


## Type Conversion Operator
The type conversion operator `->` is the way to convert an object of one type into another.

It is particularly useful for conversion into strings for representational purposes:
``` Lodge
Str myStrRepr := myObj->str
```


Or for conversions between numerical types
``` Lodge
Int myInt := myFloat->int
```

## Error Resolution Operator
Shorthand for resolving errors

Errable functions are functions that have the potential to return an error, meaning that the return type is the union of some type and `Err`. In order to use the return value of an errable function, you need to handle the possibility of an error.

Often times, handling an error just consists of passing it further up the call stack for the caller do handle. For this, the unary `!` operator is used. It will evaluate to a non-Err value or return Err from the function.

Here is a common pattern:
``` Lodge
fun function() Int! {
	Int val := errableFunction()!
	return val
}

```

Which is equivalent to:

``` Lodge
fun function() (Err | Int) {
	(Err | Int) val := errableFunction()
	return swype val {
		Err : { Err }
		*   : { val }
	}
}
```
### Binary Error Resolution Operator
Sometimes, instead of passing up the error, it is better simply to have a default value in case of an error. For these cases, the error resolution operator can also be used as a binary operator.

``` Lodge
fun function() !Err {
	Int val := errableFunction() ! -1
} 
```
Is equivalent to
``` Lodge
fun function() !Int {
	!Int result = errableFunction()
	Int val := swype result {
		Err : { -1 }
		Str : { result }
	}
} 

```

### In Type Definitions
The `!` token is also used to make an Errable type:

``` Lodge
fun errableFunction() (Err | Str) {
	!! ...
}
```

``` Lodge
fun errableFunction() Str! {
	!! ...
}
```



## None Resolution Operator
The None resolution operator applies to variables whose type is a union that contains None. It is essentially a shorthand for an otherwise common type switch.

The following two code blocks are equivalent:
```
?Int temp = nonableFunction()

Int variable = swype variable {
	None : { -1 }
	Int  : { temp }
}
```

``` Lodge
Int variable = nonableFunction() ? -1
```


Unlike the error resolution operator, there is no unary version of the None resolution operator
## Operator Precedence

`|^&+-*/%`

```
!! Assignment

:=  +=  -=  *=  /=  //=  ...

!! Logical

| 
^
&

==  !=  is  isnt  <  >  >= <=

not

!! Numerical

||
^^
&& 
>>  <<

!! a_exp
+ -

!! m_exp
*  /  //   %


!! Unary prefix
-  -|  

!! Power Operator
**

!! Increment operators (postfix)
++ -- 


!! Special Infix operators
!  ?


!! Special Postfix Operators
!

!! Special Postfix Operators
()  []   -> 


.

```

