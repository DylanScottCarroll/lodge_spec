## Mathematical Operators
| op  | action           |
| --- | ---------------- |
| +   | addition         |
| -   | subtraction (and unary negation)    |
| /   | division         |
| //  | integer division |
| *   | multiplication   |
| %   | modulus          |
| **  | power            |
| /^  | root             |

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
| ~   | bitwise not (compliment) |
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
| op  | action                   |
| --- | ------------------------ |
| :   | type conversion          |
| ()  | call as a function       |
| []  | indexing and slicing     |
| !   | Error Resolution         |
| ?   | None Resolution Operator |
| #   | hash                     |
| $   | other                    |
| @   | other                    |


## Type Conversion Operator
The type conversion operator `:` is the way to convert an object of one type into another.

It is particularly useful for conversion into strings for representational purposes:
``` Lodge
Str myStrRepr := myObj:str
```


Or for conversions between numerical types
``` Lodge
Int myInt := myFloat:int
```

## Error Resolution Operator
Shorthand for resolving errors

``` Lodge
fun function (Err | Str) {
	(Err | Str) val := errableFunction()
	swype val Err {
		return Err
	} swype * {
		!! Operations on val as a Str
	}
}
```

Is equivalent to

``` Lodge
fun function (Err | Str) {
	Str val := !errableFunction()
	
	!! Operations on val as a Str
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
fun errableFunction() $Str {
	!! ...
}
```



## None Resolution Operator
The None resolution operator applies to variables whose type is a union that contains None. It is essentially a shorthand for an otherwise common type switch.

The following two code blocks are equivalent:
```
?Int temp = nonableFunction()

Int variable = swype variable {
	None : {-1}
	*    : { temp }
}
```

``` Lodge
Int variable = nonableFunction() ? -1
```