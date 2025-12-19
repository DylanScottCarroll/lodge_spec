#import "../shared.typ": *

=== Integer -- `Int`
	The default representation of an integer is a 64-bit signed value. The interfaces compatible with the `Int` interface are those whose members imply whole-numbers. 

	Integer Literals consist of any number of digits 0-9 such that the number is within the bounds represented. Literals may be interpreted with different bases by adding a prefix. The prefix "0b" specifies binary and the prefix "0x" specifies hexadecimal.

=== Float -- `Float`
	The default representation of a float is a 64-bit floating point value. The inteface of `Float` allows for any real number, which includes integer values.

	Float literals consist of any number (including zero) digits 0-9, a period `.`, and any number of digits 0-9.  


=== Number -- `Num`
	Number is not a concrete type but rather an interface indicating a number of any kind. #review[(This could be removed as float already does this)]


=== Boolean -- Bool
	Represents either the logical value "true" or the logical value "false". Likewise, boolean literals are simply either the special token `true` or the token `false`.

	Logical comparison operators in lodge must evaluate to something compatible with booleans. #review[What can the interface of a boolean do to promise true/false -ness?]


=== String -- `Str`
	Strings are used for any text and are represented internally using utf-8 #review[(probably?)].

	Strings are created using any text surrounded by double quotes `"`. Strings support a typical set of escape sequences such as `\0` for null characters, `\n` for newline charaters, and `\t` for tabs. 

	There are also some special string literals indicated by prefixing the opening quotation mark with a letter. A string prefixed with an `f` is a "format string". Any set of curly brackets `{}` will interpret whatever is inside the brackets as a lodge expression to be evaluate. The resulting value converted into a string and inserted into the format string 

	A string prefixed with an `r` is a "raw string". All characters in the string are interpreted literally and any escape sequences are ignored.

=== None -- `None`
	None is a singleton type with only a single value. It has the special property of being compatible with no interface besides None, and having no other interface be compatible with it besides None.
	
	It is used to indicate that a value does not exisit. When a type union is created with none, the interface is empty and needs to be checked before any operation can be performed on it. In that way, the None construct is similar to `null` in other languages, but forces explicit checks.


=== Tuple
	A tuple is an immutable sequence of heterogeneously-typed values. 

	Tuple literals consist of comma-separated expressions enclosed in a pair of parentheses `()`.

	The interface for a particular tuple type contains fields for each of its elements:
	```
	interface Tuple {
		Type0 item0
		Type1 item1
		...
		TypeN itemN
	}
	```

	The type expression for a tuple mirrors the literal and is a comma-separated sequence of types enclosed in parentheses. Repeated types can be replaced by that typed followed but the number of times it repeats. 
	```Lodge
	(Int, Str) tuple1 := (10, "hello") 
	(Int,) tuple2 := (10,) 
	(Int: 5,) tuple3 := (1, 2, 3, 4, 5)
	(Int: 2, Str) tuple3 := (1, 2, "a", b")
	```


	
=== List
  A list is a variable-length sequence of homogenously-typed values.

	List literals consist of comma-separated expressions enclosed in a pair of square brackets `[]`.

	Because they are homogenously-typed the type expression consists of just a single value enclosed in square brackets.

	```
	[Int] list1 := [0, 1, 2, 3, 4]
	```

	Lists also support generator-like syntaax by replacing the angle brackets with square brackts. These are evaluated eagerly unlike generators.

=== Map #review[(Dictionary?)]
	A map represent a key-value mapping from a set of values of one type to a set of values of another type. Maps are implemented as a hash table.

	
	Map literals are comma-separated key-value pairs divided by colons `:` enclosed in curly brackets. `{key1 : value1, key2 : value2 }`
	Map type expressions consist of a single colon-separated pair of types enclosed in curly brackets. `{Type1 : Type2}`

	```
	{Str : Int} map1 := {"A" : 1, "B" : 20 }
	```

	#review[I haven't fully figured out if this syntax is ambiguous with other uses of cutly brackets in the language, but it may be possible if #link(<Basics.Control_Flow.Blocks.Naked_Blocks>)[naked blocks] are removed. If it is ambiguous, the following syntax will be used isntead:]

	Alternate syntax: `{> Str : Int} map1 := {> "A" : 1, "B" : 20 }`

=== Set
  A set is a variable-length unordered sequence of homogenously-typed unique values. In other words, a set is a set of vaues with the same type. Insertion, access, and membership tests are linear operations due to the hash-table-based implementation.  

	Set literals consist of comma-separated expressions enclosed in curly brackets. `{Value1, value2, value3}`
	The type expression for a set is a single type enclosed in curly brackets. `{Type}`

	```Lodge
	{Int} set = {2, 4, 6, 8}
	```

	#review[If this syntax ends up being ambiguous with the use of curly brackts for blocks, this alternate syntax will be used instead:]

	```Lodge
	{$ Int} set = {$ 2, 4, 6, 8}
	```

=== Generator
	A generator is a sequence of homogenously-typed values that can only be accessed sequentially. The length of a generator can be finite or unbounded.

	There is a special syntax for defining number (Int or Float) generators consisting of one, two or three colon-separated values. The three values represent the start, stop (exclusive), and may be omitted in various combinations. 
	```Lodge
	<:Stop>
	<Start:Stop>
	<Start:Stop:Step>
	<Start::Step>
	```

	The type expression for a generator is a set of angle brackets surrounding a type expression followed by a colon:
	```Lodge
	<Type:>
	```
	

// ==== Value Types vs Reference Types
// All values in Lodge are represented in memory by a #section-link("Lodge Thing", "", "thing"). 
// The thing contains a field for the value and a field for type information.

// For value types, the value field is the value itself, but for reference types the value is a reference to the object in memory. 

// For smaller value types like bools and bytes, there are wasted bytes in the high end of the value portion of the thing. 

\
#expand \
#review[Later, there should be a section detailing all of the fields and methods of each of these types. But that probably should be something more akin to docs.]
