## Statements
As lodge has no statement terminator, the end of statements is automatically inferred by newline characters in most cases. However, there are cases where multiple lines can be considered a single statement. This means that Lodge is not totally whitespace agnostic. It is still agnostic towards tab and space characters.

In Lodge, statement termination happens at newlines by default, but statements may be joined together based on some rules. 
1. If a line opens a bracket (such as: `( [ <` ), all lines until that bracket is closed will be treated as a single statement.
2. If a line ends with an operator that requires another following operand, the following line will be treated as part of the same statement.


``` Lodge
!! Examples of rule 1
Int x := f(arg1,
	       arg2,
	       arg3)

 [Int] l := [val1, val2,
	       val3, val4]	

Int x := ( a
		 + b
		 + c
		 + d )

!! Example of rule 2
Int y := 10 +
         11 +
	     12
```




