For types inside a type union, it may sometimes be useful to treat different types differently. To achieve this while maintaining type safety, type switches can be used. The difference between a type switch and a simple if-statement is that, within the switch, the variable will be treated as that type for the purposes of type checking. Example of a basic type switch. 

Inside each of those blocks, the programmer can reference the original variable as if it were the more specific type without breaking type safety.

``` Lodge
(List | Int | String) variable := !! Something
swype variable {
	List : { print(length(variable)) },
	Int  : { print(variable/2) } ,
	*    : { Catches the remaining cases },
}

```

#expand: The `*` case implies that the variable should have an interface  


```
(Int | String) var = "11"

Int var2 = swype var {Int: { var/10 }, String: { 0->Int / 10 } }

```


## Switching multiple types at once
This is particularly useful for imitating the behavior of [[01 Constructors#Method Overloading|Method Overloading]] 

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