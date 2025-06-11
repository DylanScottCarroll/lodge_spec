For types inside a type union, it may sometimes be useful to treat different types differently. To achieve this while maintaining type safety, type switches can be used. The difference between a type switch and a simple if-statement is that, within the switch, the variable will be treated as that type for the purposes of type checking. Example of a basic type switch. 

Inside each of those blocks, the variable will have the interface of the type it was matched to. This allows members to be accessed inside the scope that would not be accessible outside of the scope.

``` Lodge
(List | Int | String) variable := !! Something
swype variable {
	List : { print(length(variable)) }
	Int  : { print(variable/2) }
	*    : { Catches the remaining cases }
}

```

If a type is captured by the * case, will have the interface that the variable had in the enclosing scope.


Swype statements can also be place in-line using commas to separate the cases instead of newlines.
```
(Int | String) var = "11"

Int var2 = swype var {Int: { var/10 }, String: { 0->Int / 10 } }

```


## Switching multiple types at once
This is particularly useful for imitating the behavior of [[01 Constructors#Method Overloading|Method Overloading]] 

```
(Int | Str) a := 10
(Int | Str) b := "20"

swype a, b {
	Int, Int : { !- Code -! }
	Str, Str : { !- Code -! }
	Str, *   : { !- Code -! }
	*, Int   : { !- Code -! }
}
```