## Loops
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


### For Loop
The for-loop works like Python's for-loop or for-each loops in other languages. It accepts any object that is compatible with the iterator interface and loops. It uses the `from` keyword to associate a name with the element from the iterator. The type of the loop variable is inferred from the values in the container being iterated over.

``` Lodge
!! Print all of the characters in the list
loop for c := char_list
	print(c)
```

You can specify a generator expression in the head of a loop without `<>`
```
loop for i := 1:10 {
	print(i)
}
```

If you want to loop over multiple iterators of the same length at once, you can separate several associations with a comma as below.

``` Lodge
loop for a, b := list1, list2 {

	list3.append(a + b)
}
```


You can also add an option that will keep track of the index with the `at` keyword.
``` Lodge
!! Print all of the characters in the list
loop for c, i := char_list, 0: {
	print(c)
}
```


## Break and Continue

The keywords `break` and `continue` work as they do in similar languages.
`break` will exit the nearest loop that encapsulates it.
`continue` will skip to the beginning of the nearest loop that encapsulates it

### Conditional break/continue
Lodge also has the ` break if ` and ` continue if ` statements which act as conditional statements

For example, these two code blocks behave the same:
``` Lodge
loop for value := value_list {
	print(value)
	
	break if value == None
}

loop for value := value_list {
	print(value)

	if value == None {
		break
	}
}
```

### Deep break/continue
If the `break` or `continue` keywords is followed immediately by an integer literal, the statement will apply  to that many nested loops. The value 1 is equivalent to an unmodified statement
```
Float t = time()
loop for i := :100 {
	loop for j := :100 {
		print(i, j)
		break 2 if (time()-t > 10)
	}
}

```