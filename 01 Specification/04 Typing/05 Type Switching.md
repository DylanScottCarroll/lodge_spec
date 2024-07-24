For types inside a type union, it may sometimes be useful to treat different types differently. To achieve this while maintaining type safety, type switches can be used. The difference between a type switch and a simple if-statement is that, within the switch, the variable will be treated as that type for the purposes of type checking. Example of a basic type switch. 

Inside each of those blocks, the programmer can reference the original variable as if it were the more specific type without breaking type safety.

``` Lodge
swype variable {
	List : { print(length(variable)) }
	Int  : { print(variable) } 
	*    : { !- If there were other possible cases, the * captures all of them -! }
}

```

## Switching Concrete Types
By default, type switching simply tests if the object being switched is compatible with the interface. 

## Switching multiple types at once
This is particularly useful for imitating the behavior of [[01 Classes#Method Overloading|Method Overloading]] 

```
(int | str) a := 10
(int | str) b := "20"

swype a, b {
	int, int : { !- Code -! }
	str, str : { !- Code -! }
	str, *   : { !- Code -! }
	*, int   : { !- Code -! }
}
```