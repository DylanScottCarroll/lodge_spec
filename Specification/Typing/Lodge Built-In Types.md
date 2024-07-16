#lodge_spec

# Value Types

## Integers
| size | signed  | Unsigned |
|:---- |:------- |:-------- |
| 8    | `byte`  | `ubyte`  |
| 16   | `short` | `ushort` |
| 32   | `int`   | `uint`   |
| 64   | `long`  | `ulong`  |

## Floats

| size | name   |
|:---- |:------ |
| 32   | float  |
| 64   | double | 


<u>Technical note:</u> 
Value types can be stored directly in memory rather than being part of a [[Lodge Thing|thing]] in order to save memory. Code that deals with value types must not work in the same way other Lodge code does/


<u>Reference versions of value types</u>
It might be odd if there's no way to way to place a value type into any other field without changing its value, so having some way of creating a reference type out of it would be useful.

But having two different versions of a given type might be confusing. However, since value types are kind of a niche thing to begin with, so maybe it wouldn't matter.


From a syntax perspective: maybe like references in C++ or like question mark types in C#.
#lodge_decision 

<u>Inclusion of value types in the default namespace</u>
Value types might need to be imported in order to emphasize that they are only supposed to be used when they substantively improve performance

With the fact that value types don't work well with Lodge's typically flexible type system, usage of numerical reference types is preferable when the performance benefits of value types is not strictly necessary.

# Reference Types

## Numerical Reference Types


Int
* Only whole numbers
* Size
	* Probably 64-bit to start out with
	* Stretch goal: Not of a limited size? (much like Python3)
* Immutable

Float
* Object version of float
* 64-bit floating point representation
* Immutable

## Booleans
Booleans have a very sparse public interface so it is as easy as possible for any object to be treatable as a Boolean

## Strings

### char
* Chars are probably not a type on their own, but rather maybe more of an alias for a ubyte
* Char literals are defined using single quotes 
``` Lodge
char aChar := '\n'
```
* In Lodge's type checking they may or may not be treated as two separate types but still have all the same behavior behind the scene.

### Str
* A reference type object much like strings in other languages
* Basically just an immutable array of chars
* [[Lodge Text Encoding]]
* String literals are created using text surrounded by double quotes like this:
``` Lodge
Str aString := "A new string literal"
```

### None
Lodge None type can only have a single value: None

The None type has a totally empty interface. 

Uses
* Indicate that something does not exist in cases where using null doesn't make sense.
* When a variable has a None in its union, the interface is empty and you would need to check that the value is not None in a [[Lodge Type Switching|type switch]] before you could do any operations with it.
* If that variable is always initialized to None, it could eliminate the chance of null pointer exceptions by forcing the None value check.
* Used as a default value for function arguments when that argument doesn't always need to be present. This is useful for [[Lodge Functions#Variadic Functions|variatic functions and optional parameters]].

## Data Structure Types

### Tuple
* literal: `(value1, value2, value3)`
	* `(value,)` for a single value
* type definition: `(type1, type2, type3)`
	* `(type : size)` when it's all the same type
* immutable value types
* You must declare the type for each variable in the tuple


### Array
* literal: `[value1, value2, value3]`
* type definition: `[type : size]`
	* note: arrays can only have one type (or union)
* mutable reference types
* Cannot grow or shrink
* The type (union) must be the same for each element in the array


### List 
* literal: `<value1, value2, value3>`
* type definition: `<type>`
* mutable reference type
* can grow and shrink

### Dictionary
* literal: `{ key1 : value1, key2 : value2}`
* type definition: `{type1 : type2}`
* Mutable reference type
* Implemented as a hash table

### Set
* literal: `{value1, value2, value3}`
* type definition: `{type}`
* Implemented as a hash set

See [[Lodge Typing Syntax]] for examples of declaring all of these

## Type Unions
See [[Lodge Type Unions]]

