=== Loops
==== Plain Loop
A plain loop is a loop without any parameters. It is essentially the same as a `loop while true`, but it does not perform a comparison. It is usually used for replicating a do-while type pattern using a `break if` statement.
Here is an example.
```
!- Read one character from the file onto the stack,
   stopping after a period is processed
   until a period is reached -!
loop {
	c := file.read()
	stack.push(c)
	
	break if c == '.'
}
```


==== Conditional Loop
A conditional loop takes a boolean expression and will repeat its body code until the expression evaluates to false.

```Lodge
!! Print all the values on the stack
loop not stack.is_empty() {
	Int val := stack.pop()
	print(val)
}
```


==== For Loop
The for-loop works like a for-each loop. It accepts any object that is compatible with the Iterable interface and loops over each element. The type of the loop variable is inferred from the values in the container being iterated over.

```Lodge
!! Print all of the characters in the list
loop for c = char_list {
  print(c)
}
```

If you want to loop over multiple iterators of the same length at once, you can separate several associations with a comma as below.

```Lodge
loop for a, b = list1, list2 {
	list3.append(a + b)
}
```


Using an unbounded iterator, you can keep track of indices like so:
```Lodge
!! Print all of the characters in the list
loop for c, i = char_list, <0:> {
	print(c, "at", i)
}
```


=== Break and Continue

The keywords `break` and `continue` work as they do in similar languages.
`break` will exit the nearest loop that encapsulates it.
`continue` will skip to the beginning of the nearest loop that encapsulates it

==== Conditional break/continue
Lodge also has the ` break if ` and ` continue if ` statements which act as conditional statements. The following two snippets are equivalent:

#grid(columns:(1fr, 1fr))[
	```Lodge
	loop for value = value_list {
		break if value == None
		print(value)
	}
```
][
	```Lodge
	loop for value = value_list {
		if value == None { break }
		print(value)
	}
	```
]

==== Deep break/continue
If the `break` or `continue` keywords is followed immediately by an integer literal, the statement will apply  to that many nested loops. The value 1 is equivalent to an unspecified depth. This will result in an error if there are fewer than that many nested loops in the current function.
```Lodge
Float t = time()
loop for i := :100 {
	loop for j := :100 {
		print(i, j)
		break 2 if (time()-t > 10)
  }
}
```

