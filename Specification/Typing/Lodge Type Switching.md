#lodge_hole 

For types inside a type union, it may sometimes be useful to treat different types differently. To achieve this while maintaining type safety, type switches can be used. The difference between a type switch and a simple if-statement is that, within the switch, the variable will be treated as that type for the purposes of type checking. Example of a basic type switch. 

Inside each of those blocks, the programmer can reference the original variable as if it were the more specific type without breaking type safety.


``` Lodge
(list|int) variable = !! Either a string or a list
swype variable list
	!- Outside of the switch, this wouldbe a compilation type error, because
	 the (list | int) union doesn't allow access to the length attribute -!
	
	print(length(variable));
	swype variable str print(variable);
```

## Switching multiple types at once
This is particularly useful for imitating the behavior of [[Lodge Classes#Method Overloading|Method Overloading]] 

```
(int | str) a = 10
(int | str) b = "20"

swype a int, b, int
	!- Code -! ;
swype str, str
	!- Code -! ;
swype int, str
	!- Code -! ;
```


