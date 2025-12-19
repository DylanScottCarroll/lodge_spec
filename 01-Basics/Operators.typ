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
 `++`    ][ increment (postfix only) ][
 `--`    ][ decrement (postfix only) ][
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
 `#`     ][ hash                     ][
 `@`     ][ Unused                   ]

=== Broadcasting Operators
Using the `~` symbol after an operator indicates that the operation should be broadcast. At least one of the operands of a broadcast operator should be a sequence of some kind. Broadcast operators have the same precedence of the non-broadcast version


This can be used to expand mathematical operations.
```Lodge
[Int]  = [0:10]
[Int] powers_of_two = 2 **~ list
```

Function calls can also be broadcast.
```Lodge
<Float> values = ( <:314> /~ 100 )
<Float> mapped_values = cos~(values) !!This applys the cosine function to every value in values
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
When any operator is followed by a dollar sign, the operator is applied as if the order of the operands were reversed.

```Lodge
denominator /$ numerator
```

This syntax is also used in defining #link(<Basics.Constructors.Operator_Methods.Reverse_operator_methods>)[reverse operator methods].

=== Type Conversion Operator
The type conversion operator `->` is the main way of expressing the conversion from one type to another. The left hand side of the operator must be a value that has an operator method that accepts the resulting type of the type expression on the right hand side.


```Lodge
Str myStrRepr := myObj->Str

Int myInt := myFloat->Int
```


The type conversion operator is special in that the right hand side is a type expression. #link(<Basics.Type_Expressions>)[type expression] rather than a value expression. In that sense, it is not a normal operator and more of a type conversion directive. Also for that reason, there is no inverse type conversion operator ->~ because types cannot have methods. Like other operators, its behavior is determined by #link(<Basics.Constructors.Type_Conversion_Methods>, "operator methods"), but these methods have their own special semantics that differ from the other type conversion methods 



=== Error Resolution Operator
Lodge has a value-based error system that relies on type unions. The error resolution operator is shorthand for handling type unions that contain errors.

Errable functions are functions that have the potential to return an error, meaning that the return type is the union of some type and `Err`. In order to use the return value of an errable function, you need to handle the possibility of an error.

Often times, handling an error just consists of passing it further up the call stack for the caller do handle. For this, the unary `!` operator is used. It will evaluate to a non-Err value or return Err from the function.

Consider this pattern:
```Lodge
fun function() Int! {
	Int val := errableFunction()!
	!! ...
}

```
	This is equivalent to the following code without `!`.

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
Sometimes, instead of returning the error, it is better simply to have a default value in case of an error. For these cases, there is also a binary version of the error resolution operator, `!?`. 

```Lodge
fun function() Err! {
	Int val := errableFunction() !? -1
} 
```
This is equivalent to:
```
fun function() Int! {
	!Int result = errableFunction()
	Int val := swype result {
		Err : { -1 }
		Str : { result }
	}
} 

```

==== In Type Expressions
The `!` token is also used in type expressions to make an Errable type:

The following to declarations are equivalent:
```Lodge
fun errableFunction() (Err | Str) {
	!! ...
}

fun errableFunction() Str! {
	!! ...
}
```



=== None Resolution Operator
The None resolution operator applies to variables whose type is a union that contains None. It is essentially a shorthand for an otherwise common type switch.

The following two code snippets are equivalent:
```Lodge
Int variable = swype nonableFunction() {
	None  : { -1 }
	Int a : { a }
}
```

```Lodge
Int variable = nonableFunction() ? -1
```

Unlike the error resolution operator, there is no unary version of the None resolution operator

=== Operator Precedence
This section is mostly for parser reference, you can skip this.

Operators are listed in order of increasing precedence, categorized into groups, and given names for implementation purposes.

#review[To-do: make this section more readable.]

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

