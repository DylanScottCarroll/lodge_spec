#import "../shared.typ": * 

#expand
#review[Create a more unified description of the type expression syntax]

Type expressions are a kind of expression that exists when a type is being defined such as during variable declaration, before the `as` keyword, or on the right hand side of the special `->` operator. 

Unlike regular expressions, type expressions be assigned to a variable using the assignment operator `:=`. 

Type expressions differ from normal expressions in that
1. They can only exist in a few situations
2. The values of the expression must all be types
	- Non-type values will be coerced into types by resolving their interface
	- Explicitly defined type values mask non-type values
3. The operators must be the type set operators


To expand on point one, values inside of type expression will first 

=== Type Unions
Because the type of a variable is defined only by an interface, the value of the type expression in an assignment may be more than just a single variable. The most basic of these compound type expressions is the #link(<The_Type_System.Type_Unions>)[type union], which creates an interface capable of containing values of any participating type, while exposing only the public members accessible in all participating types.

```Lodge
(Str | Int) x

!! Allowed
x := 10
x := "Hello World"
```

=== As statements
Composite types created by type expressions can also be given names with the `as` keyword, making the `as` keyword essentially the equivalent of the assignment operator for type expresssions.

```Lodge
(Str | Int) as StrInt
StrInt x = 5
StrInt x = "10"
```

Unlike normal expressions, names created by type expressions enter scope before the expression that defines them, which allows for circular type definitions.


Circular type definitions can be used to create composite definitions such as the following type that defines a structure akin to a linked list.

```Lodge 
((int, listelement) | None) as listElement

listElement list = (0 (1, (2, (3, None))))
```
