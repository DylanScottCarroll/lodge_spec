#lodge_spec 

Lodge has four kinds of loops:
* plain loop
* while loops
* for loops
* over loops


## Plain Loop
A plain loop is a loop without any parameters. It is essentially the same as a `loop while true`, but it does not perform a comparison. It is usually used for replicating a do-while type pattern using a `break if` statement.
Here is an example.
``` Lodge
!! Read one charafter from the file onto the stack until a period is reached
loop
	c := file.read()
	stack.push(c)
	
	break if c == '.' ;
```


## While Loop
A while loop takes a bool conditional and will repeat its body code until the bool is false.
``` Lodge
!! Print all the values on the stack
loop while not stack.is_empty()
	ints val := stack.pop()
	print(val);
```

## For Loop

This kind of loop is merely for looping over ranges. Much like similar languages (besides python) this is basically just syntactic sugar for a declaration, a while loop, and an increment. The type of the loop variable must be specified  unless the variable exists already. If the variable exists already, its value will persist outside of the loop, otherwise it will fall out of scope at the end of the loop. It uses the keywords "from", "to", and "by" to control this range. All of these except to are optional. If from is left out, 0 is taken as the default, and if by is left out, the default is 1.
Here is an example. The top of the range is exclusive.
``` Lodge
!! Print all numbers less than 100 divisible by 3.
loop for int x from 0 to 100 by 3
	print(x);
```

## Over Loop
The over-loop works like Python's for-loop. It accepts any object that fulfills the iterator interface and loops. It uses the from keyword to associate a name with the element from the iterator.

``` Lodge
!! Print all of the characters in the list
loop over c from char_list
	print(c);
```

If you want to loop over multiple iterators of the same length at once, you can separate several associations with a comma as below.

``` Lodge
loop over a, b from list1, list2
	list3.append(a + b)
```


You can also add an option that will keep track of the index with the at keyword.
``` Lodge
!! Print all of the characters in the list
loop over c from char_list at i
	print(c);
```


## break and continue

break and continue work as they do in similar languages.
break will exit the nearest loop that encapsulates it.
continue will skip to the beginning of the nearest loop that encapsulates it

But lodge also has the ` break if ` and ` continue if ` statements which act as conditional statements
For example, these two code blocks act the same:
``` Lodge
loop over value from someList
	break if value = null
	print(value)
;

loop over value from someList
	if value = null
		break;
	print(value)
;
```