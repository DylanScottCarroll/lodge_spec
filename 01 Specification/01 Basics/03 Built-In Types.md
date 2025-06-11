## Int
value type

| size | signed | Unsigned |
| :--- | :----- | :------- |
| 8    | `I8`   | `U8`     |
| 16   | `I16`  | `U16`    |
| 32   | `I32`  | `U32`    |
| 64   | `I64`  | `U64`    |

## Float
value type

| size | name  |     |
| :--- | :---- | --- |
| 32   | `F32` |     |
| 64   | `F64` |     |

## Booleans
value type
**Bool**

## Strings
reference type
### Str
* A reference type object much like strings in other languages
* Basically just an immutable array of chars
	* Potentially just a chunk of data, allowing for various representations
	* [[Lodge Text Encoding]]
* String literals are created using text surrounded by double quotes like this:
``` Lodge
Str aString := "A new string literal"
```

## None
value type

The concrete type of the none constructor is a singleton

The None type has a totally empty interface. 

Uses
* Indicate that something does not exist in cases where using null doesn't make sense.
* When a variable has a None in its union, the interface is empty and you would need to check that the value is not None in a [[05 Type Switching|type switch]] before you could do any operations with it.
* If that variable is always initialized to None, it could eliminate the chance of null pointer exceptions by forcing the None value check.
* Used as a default value for function arguments when that argument doesn't always need to be present. This is useful for [[08 Functions#Variadic Functions|variatic functions and optional parameters]].



## Data Structure Types
All data structure types are reference types


## Tuple
* literal: `(value1, value2, value3)`
	* `(value,)` for a single value
* type definition: `(type1, type2, type3)`
	* `(Type : size)` when it's all the same type
	
* You must declare the type for each variable in the tuple

``` Lodge
(Int, Str) tuple1 := (10, "hello") 
(Int,) tuple2 := (10,) 
(Int: 5,) tuple3 := (1, 2, 3, 4, 5)
(Int: 2, Str) tuple3 := (1, 2, "a", b")
```


## List
* literal: `[value1, value2, value3]`
* type definition: `[Type]`
	* The type of all elements of a list must match
* The type (union) must be the same for each element in the array

```
[Int] list1 := [0, 1, 2, 3, 4]
var list2 := [0, 1, 2, 3, 4]
```


## Map
* literal: `{| key1 : value1, key2 : value2 |}`
* type definition: `{|Type1 : Type2|}`
* Mutable reference type
* Implemented as a hash table

```
{|Str : Int|} aDictionaty := {| "A" : 1, "B" : 20|}
```


## Set
* literal: `{value1, value2, value3}`
* type definition: `{Type}`
* Implemented as a hash set

``` Lodge
{|Int|} set1 = {| ~2, 4, 6, 8 |}
```


## Generator
* Literal: No direct literal, but range expressions can be used
	- <start:stop:end>
- Type
	- \<Type\>

``` Lodge
<Int> allSquares = <:>**2
```

## Value Types vs Reference Types
All values in Lodge are represented in memory by a [[Lodge Thing|thing]]. 
The thing contains a field for the value and a field for type information.

For value types, the value field is the value itself, but for reference types the value is a reference to the object in memory. 

For smaller value types like `I8`s, there are wasted bytes in the high end of the value portion of the thing. To combat this, some types such as arrays may be implemented in such a way as to store raw values rather than things when the type is restricted to that of a value type. 