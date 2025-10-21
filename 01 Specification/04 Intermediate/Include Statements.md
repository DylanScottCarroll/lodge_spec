Maybe in a future version:

Brings all of the values from a specified namespace into a given scope

```
fun Myfunc (SomeType value) {
	value include * 
	!! All of the accessible public members of value are now local variables in this function
}

```