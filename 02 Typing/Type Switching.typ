#import "../shared.typ": *

It may sometimes be useful to differentiate between types in the set of types compatible with a particular interface. To achieve this while maintaining type safety, type switches can be used. The difference between a type switch and a value switch is that, within a type switch, the variable will be treated as matched type for the purposes of member visibility and type checking. Example of a basic type switch. 

Inside each of those blocks, the variable will have the interface of the type it was matched to. This allows members to be accessed inside the scope that would not be accessible outside of the scope.

```Lodge
(List | Int | String) variable := !! Something
swype variable {
	List : { print(length(variable)) }
	Int  : { print(variable/2) }
	*    : { Catches the remaining cases }
}

```

If a type is captured by the `*` case, will have the interface that the variable had in the enclosing scope.


Swype statements can also be place in-line using commas to separate the cases instead of newlines.
```
(Int | String) var = "11"

Int var2 = swype var {Int: { var/10 }, Str: { 0->Int / 10 } }

```


=== Switching multiple types at once

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

=== Switching the Type Created by a Constructor

#expand

I haven't settled on the syntax for this yet, but there should be some way to specify that an argument in a type switch should be treated as a constructor and the swype should look at the type produced by that constructor. Due to the fact that structs are a special kind of function, this would also let the programmer switch over the type returned by a function.


```
swype <<Con>> {
  Int : { !- The struct produces Ints -! }
  Str : { !- The struct produces Strs -! }
  *   : { !- The struct produces something else-! }
}

```