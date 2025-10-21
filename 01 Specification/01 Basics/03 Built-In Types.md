# Basic Types
## Integer
value type
<u>Int</u>
* Defaults to 64 bit integer value
* Interface does not allow float values

## Floating Point
value type

<u>Float</u>
* Defaults to 64 bit floating point value
* Interface also allows Int values
## Booleans
value type
<u>Bool</u>


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
The None type has the special property of being compatible with no interface besides None, having no other interface be compatible with it besides None.

Uses
* Indicate that something does not exist in cases where using null doesn't make sense.
* When a variable has a None in its union, the interface is empty and you would need to check that the value is not None in a [[05 Type Switching|type switch]] before you could do any operations with it.
* If variables don't have an initial value, setting the value to None is the only option, forcing a check.
* Used as a default value for function arguments when that argument doesn't always need to be present. This is useful for [[08 Functions#Variadic Functions|variatic functions and optional parameters]].


## Data
value type
This circumvents the typical type system as Data values are the only values that don't exist in a [[Lodge Thing|thing]]. Because of this, Data variables can only contain data values and data values can only be placed into Data variables.
#expand


# Data Structure Types
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


The interface for a particular tuple type contains fields for each of its elements:
- tuple.item0
- tuple.item1
- ...
- tuple.itemN 

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
* literal: `{> key1 : value1, key2 : value2 }`
* type definition: `{> Type1 : Type2}`
* Mutable reference type
* Implemented as a hash table

```
{> Str : Int} map1 := {> "A" : 1, "B" : 20 }
```


## Set
* literal: `{$ value1, value2, value3}`
* type definition: `{$ Type}`
* Implemented as a hash set

``` Lodge
{Int} set1 = {$ ~2, 4, 6, 8 }
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

For smaller value types like bools and bytes, there are wasted bytes in the high end of the value portion of the thing. 
