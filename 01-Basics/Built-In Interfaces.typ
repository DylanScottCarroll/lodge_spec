#import "../shared.typ": *


=== Iterator
```
interface Iterator<T> {
	fun [] T()
	get length
}
```


=== Generator

```
interface Generator<T> {
	fun next T()
}
```


=== Iterable
```
interface Iterable<T> {
	fun iterator (Iterator<T>|Generator<T>)

}
```


=== Err Interface

```Lodge
interface Err {
	get Str Type
	get Str Message


	!! There are probable more fields useful in an error, but I can't think of it
}
```

=== Object Interface
```Lodge
interface Object {
	!! probably stuff like string casting and such? Will add as I find it useful
}
```

=== None Interface
The None interface is a special case. It is defined as the interface that is compatible with no other interface and with which no other interface is compatible.

For the purpose of interface intersection, None is the empty interface, but for interface compatibility, has special properties. This would normally mean that every interface would compatible with  the interface. However, since None is specifically defined as the interface that no other interfaces are compatible with, only interfaces compatible with the other interfaces participating in the union would be compatible. This means that nonable types (like `Int?`) have the same set of compatible types (plus specifically None), but the fields are inaccessible until the None case is handled.


```

(Int & None) val !! Failed set operation, and compile error if in a type expression.
(Int | None) val !! Allowed, 

```



=== ContextManager Interface
This is the interface required to be used with a `while` block

```
interface ContextManager {
	fun context_enter Object([Object args])
	
	fun context_exit ()
}

```
