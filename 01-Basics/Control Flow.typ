#import "../shared.typ": *

=== Blocks

Blocks are opened and closed by curly brackets `{}`. Many statements such as if statements, loops, and class definitions require blocks.

Blocks in lodge create a new scope that can access variables from the outer scope, but whose variables only last during the inner scope.

```Lodge
Int x := 0
loop x <= 10 {
	if x%2 == 0 
		{ print(x) }	
	x++
}
```

Naked blocks can also be created without an opening statement simply to create a new scope and group together a sequence of statements.

==== Block Expressions
If a block is in a position to be evaluated as an expression (rather than a statement where the value would be discarded), the entire block evaluates to the value of  last expression in the block. For if-statements, the value of the path taken is returned. For loops, the values from multiple iterations are accumulated into a list.

```Lodge
Str parity = if x%2 == 0 { "even" } else { "odd" }
```


```
(Int, Int) x = (0, 1)
[Int] fibonacci_vals = loop {
  break if x > 100
  x := (x[1], x[0]+x[1])
} 

```
#review[Another idea is for, loop values could be folded together with the `+` operator. This would allow for loops to automatically do things like sum integers, concatenate strings, etc. It could still make lists by having the loop block to evaluate to a single element but it would make the more common case of list comprehension a bit clunkier.]

==== Naked Blocks
#text(fill:red)[This feature is neat, but may be removed in favor of allowing other syntax to use bare curly brackets.]

Blocks without any keyword, also known as naked blocks, can simply be used as a way to cluster a sequence of statements into a single unit that returns a value. It has essentially no impact on the way the code executes, but may be used for conceptual groupings of actions.

```Lodge
Int x = {
	Int a = 200
	Int b = 10
    a / b
}

!! x == 20
```

=== Conditionals

Conditionals use the `if` keyword, a boolean expression, and a block to create an if-statement. If the given boolean expression evaluates to true, the block is entered. Otherwise, it is skipped.
==== If
```Lodge
if boolean_expression {
	!! conditional body
}

```

==== If / Else
You can also specify as block to enter if the boolean is false using the `else` keyword.
```Lodge
if boolean_expression {
	!! Enter if true
} else {
	!! Enter if false
}

```


==== If / Else If / Else
And you can also chain if statements using `else if`
```Lodge
if expr1 {
	!! exp1 is true
} else if expr2{
	!! exp1 is false and exp2 is true
} else {
	!! exp1 is false and exp2 is false
}
```

==== If Expressions
You can use if statements like an expression and the selected block will be evaluated
```Lodge
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



=== Switch Statements

Switch statements use basic pattern matching to select between a set of optional blocks. The simplest case of a switch statement is matching a single value. 

```Lodge
Int x = 10
switch x {
  -1 : { !- x is  -1 -! }
   0 : { !- x is 0 -! }
   1 : { !- x is 1 -! }
   * : { !- x is any other value -! }
}
```

A switch statement can also match multiple values at the same time.

```Lodge
Int x = 10
Int y = 0

switch x, y {
  10, 10 : { !- Both 10 -! }
  10, *  : { !- First 10, second not -! }
  *, 10  : { !- Second 10, First not -! }
  *, *  : { !- Neither 10 -! }
  
}
```

Additionally, sequences such as tuples and lists can be matched.

#review[This is going to be similar syntax and logic to when I get around to describing tuple unwrapping for assignment.]
```Lodge
(Int, Str) x = (1, "Hello")
switch x {
	(0, *)       : { !- x == (0, anything) -!  } 
	(*, "World") : { !- x == (anything, "world") -!  }
	(*, *)       : { !- x == (anything, anything) -!  }
}
 
```


Instead of using \* for the wildcard match, using a name will assign the matched value to that name. This works for sequence matchng as well. 
```Lodge
x = 10
y = 15

switch x, y {
  10, b : { !- b == 15 -!}
  !! etc.
}

```
