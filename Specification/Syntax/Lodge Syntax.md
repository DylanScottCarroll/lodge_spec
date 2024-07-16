#lodge_spec

## Tokens
Types of Tokens
* numerical literals
	* 10
	* 1.5
	* .5
	* 0xFF
	* 0b1010
* string literals
* operators
* keywords
* identifiers
	* Like the names of variables, types, classes, etc.

## Expressions

Expressions work much like any C-like language with mathematical infix notation
[[Lodge Operators]]

For example, this expression represents the vey similar mathematical expression $x + (y^2)$:
`x + (y**2)`


Expressions can be composed of determiners, literals, operators, and function calls.
`f(5) + (x/10)`


# Statements

Each statement is composed of one or more expressions and usually takes some action or has some side effect.

As lodge has no statement terminator, the end of statements must be inferred automatically. In most cases, this division happens at the end of a line, however, there are cases where multiple lines can be considered. 

This means that Lodge is not totally whitespace agnostic like other languages. However, in order to simplify the parser, it will probably be the case that these statement Separation rules will probably happen before the parser, so that the parser can still be whitespace agnostic.


In Lodge, the statement termination happens at newlines by default, but statements may be joined together based on some rules. 
1. If a line opens a bracket (such as: `( { [ <` ), all lines until that bracket is closed will be treated as a single statement. However, the closing bracket will only be searched for until the end of the current block (as terminated by a ;).
2. If a line ends with an operator that requires another following operand, the following line will be treated as part of the same statement.
3. If a line begins with an operator that requires an operand beforehand, the previous line will be treated as part of the same statement.

``` Lodge
!! Examples of rule 1
int x = f(arg1,
	      arg2,
	      arg3)

list l = <val1, val2,
	val3, val4>	

!! Example of rule 2
int y = 10 +
        11 +
	    12

!! Example of rule 3

int z = 10
      + 11
      + 12
```


## Comments
Comments are created with the `!!` token. Everything after the `!!` until the next newline will be considered a comment
You can create bounded comments  with `!-` and `-!` at the beginning and end of the comment

## Blocks

loops, if statements, switches functions, class definitions, structure definitions, etc. all implicitly open a block.

Indentation does not matter in Lodge, but is strongly encouraged for readability
Bodies are closed with semicolons as shown below. The placement of the semicolon can either be at the end of the last line in the block when vertical space is important, such as with small bodies. Placement of the semicolon can alternatively be on the next line when delineating the end of a scope clearly is more important. Both ways are showed in the example below

``` Lodge
nums x := 0
loop while x <= 10
	if x %2 = 0 
		print(x);	
	x++
;
```


## [[Lodge Typing Syntax]]


## [[Lodge Loops]]
Lodge has four kinds of loops:
* plain loop
* while loops
* for loops
* over loops

For more detail see the dedicated page on this


## If-statements
If-statements work just as they do in many other languages. With else and else if as well
``` Lodge
if x < 10
	print("The value is less than 10.");
else if x < 20
	print("The value is between 10 and 20.");
else
	print("The value is greater or equal to than 20");
```



## [[Lodge Functions]]


## [[Lodge Classes]]


## [[Lodge Interfaces]]