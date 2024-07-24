The broadest possible interface. Every single object in lodge can be placed inside of a variable defined as object.


## Type Interfaces
Every concrete type in Lodge automatically has an associated interface.
## Int interface
## Float Interface

## Err Interface

``` Lodge
interface Err {
	get Str Type
	get Str Message

	fun $() T

	!! ...
}
```

## Object Interface
``` Lodge
interface Object {
	fun repr() Str

	!! ...
}
```


## None Interface
The None interface is completely empty. Its used in situations where a value might not exist.

``` Lodge
interface None {}
```

