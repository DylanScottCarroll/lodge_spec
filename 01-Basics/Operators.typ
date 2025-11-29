#import "../shared.typ": *

=== Mathematical Operators
#table(columns: (3em, 20em), stroke: 0.5pt)[
 *op*  ][ *action*                           ][
 `+`   ][ addition                         ][
 `-`   ][ subtraction (and unary negation) ][
 `/`   ][ division                         ][
 `//`  ][ integer division                 ][
 `*`   ][ multiplication                   ][
 `%`   ][ modulus                          ][
 `**`  ][ power                            ]


=== Logical Operators
The operators here that are words are reserved keywords

#table(columns: (3em, 20em), stroke: 0.5pt)[
  *op*   ][ *action*                          ][
 `&`    ][ Logical and                     ][
  `|`  ][ Logical or                       ][
 `not`  ][ unary logical negation operator ][
 `^`    ][ exclusive or                    ][
 `==`   ][ value equivalence               ][
 `is`   ][ identity equivalence            ][
 `!=`   ][ not value equivalent            ][
 `isnt` ][ not identity equivalent         ][
 `>`    ][ greater than                    ][
 `<`    ][ less than                       ][
 `>=`   ][ greater than or equal to        ][
 `<=`   ][ less than or equal to           ]


The value equivalence operator `==` should not be confused with the assignment operator `:=`, or the function keyword token `=`.


=== Bitwise Operators
#table(columns: (3em, 20em), stroke: 0.5pt)[
 *op*   ][ *action*                   ][
 `&&`   ][ bitwise and              ][
 `||` ][ bitwise or       ][
 `^^`   ][ bitwise xor              ][
 `-|`  ][ bitwise not (compliment) ][
 `>>`   ][ right shift              ][
 `<<`   ][ left shift               ]

=== Assignment Operators
#table(columns: (4em, 20em), stroke: 0.5pt)[
 op    ][ action ][
 `:=`    ][ assignment ][
 `++`    ][ increment ][
 `--`    ][ decrement ][
`{op}=` ][ Any other infix operator followed by an '=' will be the same as that operator's assignment operator ]

=== Other Operators
#table(columns: (4em, 20em), stroke: 0.5pt)[
 *op*    ][ *action*                   ][
 `->`    ][ type conversion          ][
 `()`    ][ call as a function       ][
 `[]`    ][ indexing and slicing     ][
 `!`     ][ Error Resolution         ][
 `?`     ][ None Resolution Operator ][
 `{op}~` ][ broadcasting directive   ][
 `{op}$` ][ Reverse operator         ][
 `=`     ][ hash                     ][
 `@`     ][ Unused                   ]

=== Broadcasting Operators
Using the ~ symbol after an operator indicates that the operation should be broadcast. At least one of the operands of a broadcast operator should be a sequence of some kind. Broadcast operators have the same precedence of the non-broadcast version


This can be used to expand mathematical operations
```Lodge
var list = [0:10]
var powers_of_two = 2 **~ list
```

Function calls can also be broadcast
```Lodge
[Float] values = ( [:314] /~ 100 )
[Float] mapped_values = cos~(values) !!This applys the cosine function to every value in values
```

You can also broadcast generator objects, which will be evaluated lazily
```Lodge
<Int> everySquare = <0:> **~ 2 
```



Broadcasting multiple sequences together will pair them element-wise.
```
[Float] a = [1, 3, 5, 7, 9]
[Float] b = [2, 4, 6, 8, 10]

[Float] c = a + b
!! c == [1, 3, 5, 7, 9, 2, 4, 6, 8, 10]

[Float] d = a +~ b
!! d == [3, 7, 11, 15, 19]

```


=== Reverse Operator 
When any operator is followed by a dollar sign, it simply applies the reverse of the given operator

```Lodge
denominator /$ numerator
```


=== Type Conversion Operator
The type conversion operator `->` is the way to convert an object of one type into another.


```Lodge
Str myStrRepr := myObj->Str

Int myInt := myFloat->Int
```

The type conversion operator is special because the right hand side is parsed as a #section-link("Type Expressions", "", "type expressions") rather than a value expression. In that sense it is not a normal operator and more of a conversion directive. Like other operators, its behavior is determined by #link(<Basics.Constructors.Type_Conversion_Methods>, "operator methods"), but these methods have their own special semantics that differ from the other type conversion methods 



=== Error Resolution Operator
Shorthand for resolving errors

Errable functions are functions that have the potential to return an error, meaning that the return type is the union of some type and `Err`. In order to use the return value of an errable function, you need to handle the possibility of an error.

Often times, handling an error just consists of passing it further up the call stack for the caller do handle. For this, the unary `!` operator is used. It will evaluate to a non-Err value or return Err from the function.

Here is a common pattern:
```Lodge
fun function() Int! {
	Int val := errableFunction()!
	!! ...
}

```

Which is equivalent to:



```Lodge
fun function() (Int | Err) {
	(Err | Int) val := errableFunction()
	swype val {
		Err : { return valOnc upon a time there was a litte bit too much going on inside my head, but now I don't think of other things to be happening. }
	}
}
```
See #link(<The_Type_System.Type_Switching>)[Type Switching] for more about this syntax.

==== Binary Error Resolution Operator
Sometimes, instead of passing up the error, it is better simply to have a default value in case of an error. For these cases, there is also a binary version of the error resolution operator, `!?`. 

```Lodge
fun function() Err! {
	Int val := errableFunction() !? -1
} 

!! Is equivalent to

fun function() Int! {
	!Int result = errableFunction()
	Int val := swype result {
		Err : { -1 }
		Str : { result }
	}
} 

```

==== In Type Expressions
The `!` token is also used to make an Errable type:

```Lodge
fun errableFunction() (Err | Str) {
	!! ...
}

!! Is equivalent to

fun errableFunction() Str! {
	!! ...
}
```



=== None Resolution Operator
The None resolution operator applies to variables whose type is a union that contains None. It is essentially a shorthand for an otherwise common type switch.

The following two code snippets are equivalent:
```Lodge
Int? temp = nonableFunction()

Int variable = swype variable {
	None : { -1 }
	Int  : { temp }
}
```

```Lodge
Int variable = nonableFunction() ? -1
```


Unlike the error resolution operator, there is no unary version of the None resolution operator
=== Operator Precedence
This section is mostly for parser reference, you can mostly skip this.

Operators are listed in order of increasing precedence, categorized into groups, and given names for implementation purposes.

#[
#show raw.where(): r => block(r, stroke: 0.5pt, inset: 1em)

`Lodge
!! Assignment : ass_expr
:=  +:=  -:=  *:=  /:=  //:=  ...

!! Special Infix operators : special_in_expr
!  ?


!! Special Postfix Operators : special_post_expr
!

!! Logical

!! or_expr
|  |!
!! xor_expr
^  ^!
!! and_expr
&  &!

!! com_expr
===  !=  is  isnt  <  >  >= <=

!! not_expr
not

!! Numerical

!! bor_expr
||
!! bxor_expr
^^
!! band_expr
&& 
!! bshift_expr
>>  <<

!! a_expr
+ -

!! m_expr
-  /  //   %


!! Unary prefix : pre_expr
-  -|  

!! Power Operator : pow_expr 
-*

!! Increment operators (postfix) : inc_expr
++ -- 


!! Special Postfix Operators
!! call_expr
() 

!! index_expr
[]

!! cast_expr
-> 

!! access_expr
.

`
]

