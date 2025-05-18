## Blocks

Blocks are opened and closed by curly brackets `{}`. Many statements such as if statements, loops, and class definitions require blocks.

Blocks in lodge create a new scope that can access variables from the outer scope, but whose variables only last during the scope of. 

``` Lodge
Int x := 0
loop while x <= 10 {
	if x%2 == 0 
		{ print(x) }	
	x++
}
```

Naked blocks can also be created without an opening statement simply to create a new scope and group together a sequence of statements.

### Block Expressions
If a block is placed in a location where it is evaluated as an expression rather than a standalone statement, the last statement of a block is treated as an expression that the entire block evaluates to.

For naked blocks, this can simply be used as a way to cluster a sequence of statements into a single unit that returns a value. It has essentially no impact on the way the code executes, but may be used for conceptual groupings of actions.

When an if statement is used as an expression, evaluating blocks can be used for constructs like ternaries.

When a loop is used in an assignment, each iteration of the loop is evaluated separately, and placed into a list that returns when the loop completes. 


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

## Loops

Lodge has four kinds of loops:
* plain loop
* while loops
* for loops
* over loops

### Plain Loop
A plain loop is a loop without any parameters. It is essentially the same as a `loop while true`, but it does not perform a comparison. It is usually used for replicating a do-while type pattern using a `break if` statement.
Here is an example.
``` Lodge
!! Read one charafter from the file onto the stack until a period is reached
loop {
	c := file.read()
	stack.push(c)
	
	break if c == '.'
}
```


### While Loop
A while loop takes a boolean expression and will repeat its body code until the expression evaluates to false.

``` Lodge
!! Print all the values on the stack
loop not stack.is_empty() {
	ints val := stack.pop()
	print(val)
}
```

### From Loop

This kind of loop is merely for looping over ranges of integers. Much like similar languages (besides python) this is essentially just syntactic sugar for a declaration, a while loop, and an increment. It uses the keywords `from`, `to`, and `by` to control this range. All of these except to are optional. If a starting is left out, the default is 0. If `by` is left out, the default is 1.

The type of the loop variable does not need to specified and will need to be determined by implementation later.
If the variable exists already, its type will remain the same and its value will be assigned to the loop values.


Here is an example. The top of the range is exclusive.

``` Lodge
loop from x to 100 {
	print(x)
}

!! Print all numbers from size and less than 100 that are divisible by 3.
loop from x := 6 to 100 by 3 {
	print(x)
}


loop from x := 0 {
	print(x)
}

```


<u>This section needs to be expanded.</u>
It would be cool if the loop variable could be any l-value, but I haven't thought through the logical and implementation repercussions of that.

### For Loop
The over-loop works like Python's for-loop or for-each loops in other languages. It accepts any object that is compatible with the iterator interface and loops. It uses the `from` keyword to associate a name with the element from the iterator.

``` Lodge
!! Print all of the characters in the list
loop for c := char_list
	print(c)
```

If you want to loop over multiple iterators of the same length at once, you can separate several associations with a comma as below.

``` Lodge
loop for a, b := list1, list2
	list3.append(a + b)
```


You can also add an option that will keep track of the index with the `at` keyword.
``` Lodge
!! Print all of the characters in the list
loop for c := char_list at i
	print(c)
```


## Loop Expressions

<u>This section needs to be expanded.</u>
Will this actually be something you can do?
* It is cool to have the loop syntax reused fro other useful expressions, which makes the language feel more expressive and composible
* It is verbose syntax that might be better done by other things
* If this can only live in loops, maybe the loops should have different syntax that can also be put elsewhere

```
(0 to 100 by 3)
```

## Break and Continue

The keywords `break` and `continue` work as they do in similar languages.
`break` will exit the nearest loop that encapsulates it.
`continue` will skip to the beginning of the nearest loop that encapsulates it

Lodge also has the ` break if ` and ` continue if ` statements which act as conditional statements

For example, these two code blocks behave the same:
``` Lodge
loop over value from someList {
	print(value)
	
	break if value == None
}

loop over value from someList {
	print(value)

	if value == None {
		break
	}
}
```

### Multiple break
If the `break` keyword is followed immediately by an integer literal, the break statement will break out of that many nested loops. This value is 1 by default.
```
loop for i to 100

```