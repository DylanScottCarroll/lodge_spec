## Type Interfaces
Every concrete type in Lodge automatically has an associated interface.

## Iterator
```
interface Iterator<T> {
	fun [] T()
	get length
}
```


## Generator

```
interface Generator<T> {
	fun () T()
}
```

Any 

## Iterable
```
interface Iterable<T> {
	get iterator (Iterator<T>|Generator<T>)

}
```


## Err Interface

``` Lodge
interface Err {
	get Str Type
	get Str Message


	!! ...
}
```

## Object Interface
``` Lodge
interface Object {
	!! ...
}
```


## None Interface
The None interface is a special case. It is defined as the interface that is compatible with no other interface and with which no other interface is compatible.

For the purpose of interface intersection, None is the empty interface. This would normally mean that every interface would compatible with  the interface. However, since None is specifically defined as the interface that no other interfaces are compatible with, only interfaces compatible with the other interfaces participating in the union would be compatible. This means that nonable types (like `Int?`) have the same set of compatible types, but the fields are inaccessible until the None case is handled.


```

(Int & None) val !! Results in 
(Int | None) val !! Allowed, 

```



## ContextManager Interface
This is the interface required to be used with a `while` block

```
interface ContextManager {
	fun context_enter Object([Object args])
	
	fun context_exit ()
}

```
