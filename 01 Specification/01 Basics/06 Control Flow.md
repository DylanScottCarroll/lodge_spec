## Blocks

Blocks are opened and closed by curly brackets `{}`. Many statements such as if statements, loops, and class definitions require blocks.

Blocks in lodge create a new scope that can access variables from the outer scope, but whose variables only last during the inner scope.

``` Lodge
Int x := 0
loop x <= 10 {
	if x%2 == 0 
		{ print(x) }	
	x++
}
```

Naked blocks can also be created without an opening statement simply to create a new scope and group together a sequence of statements.

### Block Expressions
If a block is placed in a location where it is evaluated as an expression rather than a standalone statement, the last statement of a block is treated as an expression that the entire block evaluates to.

### Naked Blocks
Blocks without any keyword, also known as naked blocks, can simply be used as a way to cluster a sequence of statements into a single unit that returns a value. It has essentially no impact on the way the code executes, but may be used for conceptual groupings of actions.

``` Lodge
# naked blocks
Int x = {
	Int a = 200
	Int b = 10
    a / b
}

!! x == 20
```

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



