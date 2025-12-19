A lodge program consists of series of statements. Losely, a statement is a line of code, but some statements span several lines, and some may contain a block of statements nested within them. Besides that, statements are typically terminated by newlines. Besides newlines, and where removing a space between two tokens of the same type would combine those tokens into a larger token of that type, Lodge is totally agnostic towards whitespace. 

Statements that span multiple lines take one of the following forms
1. A statement including a block, indicated with curly brackets `{}`, cointaining several statements. This includes constructs like branches and loops.
2. A statement including another type of bracket (`()`, `[]`, `{}`, or `<>`), which is closed on a later line.
3. A statement in which a newline is immediately preceded by an operator which expects a following operand.
4. A statement which is explicitly extended across multiple lines by escaping the terminating newline character with a backslash `\`.


#grid(columns: (1fr, auto, auto, 2fr), column-gutter: 20pt)[][
	```Lodge
	!! Examples of rule 2
	Int x := f(arg1,
		         arg2,
		         arg3)

	 [Int] l := [val1, val2,
		           val3, val4]	

	Int x := ( a
		       + b
		       + c
		       + d)

	```
][
	```Lodge
	!! Example of rule 1
	if x == 10 {
		print("X is 10")
	}

	!! Example of rule 3
	Int y := 1 +
	         2 +
		       3

	!! Example of rule 4
	Int z :=  4 \
	 				+ 5 \
					+ 6	\
	```
]


Lodge doesn't make a distinction between statements and expressions as all constructs in lodge evaluate to some value. This is discussed in more detail in #link(<Basics.Control_Flow>)[Control Flow]. In this document, a statement will be called an expression when the value it evaluates to is used.

The type an expression evaluates to is always known at compile time and is used by the #link(<The_Type_System.The_Lodge_Type_Checker>)[type checker] to ensure type correctness.
