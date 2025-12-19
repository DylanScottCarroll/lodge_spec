#import "../shared.typ": *

=== Constructors
New types in lodge are defined using special functions called constructors (struct for short). When a constructor executes, it returns a new object of the type it defines. The members of this new object are variables that existed in the scope of the constructor. In that way, a constructor could be considered a function for which 1) its 

The definition of a constructor also implicitly defines an interface with the same name.

Multiple constructors can produce values with the same public interface and they will be treated equivalently. In that way, types in lodge are defined entirely by form and function rather than a notion of identity. 

There are several special pieces of syntax that differentiate constructors from normal functions including getters, setters, and operator functions.

=== Constructor Syntax

==== Basic Syntax
The basic syntax of a constructor mirrors the syntax of a function definition as constructors are essentially functions. Constructors do not specify a return type as the return type is automatic.

```Lodge
struct ConstructorName(Type1 arg1, Type2 arg2, ...) {
	Int field = arg
	
	fun method(args...) ReturnType {
		!! Method Body 
	}
}
```

The objects produced by a constructor have an interface consisting of the variable names and types in the scope of the constructor. This example constructor produces the following interface for its values ?.
```Lodge
interface ConstructorName {
	Int field
	
	fun method(args...) ReturnType
}
```


The constructor itself has the type of a function that takes  the constructor arguments and returns the type described by the constructor.


==== Anonymous Constructors
#review[This syntax may be removed or replaced with an anonymous object syntax. The usefulness of anonymous constructors seems limited, but objects without named constructors may be useful and this odd double parenthesis syntax is clunky]

Constructors can also be created without names in order to allow the creation of an object without needing to write a dedicated named constructor for it.

The anonymous values will participate in the typing system as normal, and can even be placed in other variables using the `var` keyword.

```Lodge
var anonValue := struct (){
	!! Value body
}()
```

=== Public/Private Methods and Fields

Any variable whose name begins with an underscore will not be included in the public interface of objects produced by the constructor, which means that they cannot be accessed from outside the class and will not be considered for any type set operations. 

```Lodge
struct A {
	Int _a := 0 !! Private field
	Int a := 10 !! Public field
	
	fun F Int(Int arg) {
		!! External function
	}
	
	fun _F Int(Int) {
		!! Private functions
	}
	
}
```

=== Properties

A property is a type of struct member that resembles a field from outside the struct, but behaves like a function internally. A property is made out of a getter/setter pair (or just one for a read/write-only property).

Getters and setters can be defined by the `get` and `set` keywords, which are only allowed in struct bodies. What follows the keyword is a syntax that mirrors function definitions without argument lists. Inside the body of the setter, the name of the setter takes the value being provided to the setter.

```Lodge

struct A {
	Int _val
	get Int val {
		return _val
	}
	set Str val {
		_val = Val->Int
	}
}

A a := A()
a.propertyName := "20"
Int val := a.properyName
!! val == 20

```

The get and set type for a given property do not have to be the same. In fact, the get and set properties act essentially independently from one another despite the fact that they have thee same name.


=== This
Anywhere inside the body of a struct, the identifier `this` is in scope, referring to the value being created by the innermost enclosing struct.

It is considered (by me) bad practice not to use `this` when referring to a struct member from inside a method as it makes it unclear where the value is coming from.

```
struct A(){
  Int x = 0
  
  fun method(Int x){
    !! The argument to this method masks the member x in the scope of this method, so we can use this to disambiguate. 
    this.x = x
  }
}
```

==== This Escape

#expand

#text(fill:red)[Define the rules surrounding escape analysis for the this object.]

In theory, `this` cannot be assigned to a variable from an enclosing scope until all of the members of the struct have received values, as tha could cause threaded code to refer to a partially initialized struct, which would be a nightmare (technical term). This logic would be similar to #link(<Intermediate.Scoping_Rules.Function_Declarations.Escape_Analysis>, [function escape analysis]).

=== Operator Methods

In order to implement an operator for a given struct, an operator method can be implemented for the given struct with a special function syntax where the identifier has been replaced with an operator.  

```Lodge
struct A {
	fun + Int(auto other) {
		!! Logic for adding objects
	}
}

A var1 := A()
A var2 := A()
A var3 := var1 + var2
```

Functions with operator names are only legal within constructors.

There is also special syntax  for the index/slice operator `[]` to distinguish between getting and setting values.
```Lodge
struct A {
	fun [get] Int(Int index, Int? End=None, Int? Step=None){
		!! Value retrieving logic
	}
	
fun [set] (Int value, Int index, Int? End=None, Int? Step=None){
		!! Value assigning logic
	}
}
```

==== Type switching inside operator methods

It is best to use the broadest possible type for the operator method. These methods are a particularly good use case of the #section-link("05 Variables", "Auto Keyword", "auto keyword") as the type of the argument grows automatically as the ways that the variable is used grows.

==== Reverse operator methods

When an operator acts on two values, the compiler will look in the interface of the first value for an operator method that can accept the interface of the second value. If there is no such method, it will look in the second vlaue for the #section-link("04 Operators", "Reverse Operator", "reverse operator") method (the operator followed by the `~` symbol) that can accept the first interface.

For example, take the expression `a / b` for values from structs `A` and `B`.

If `A` implements `/` for the type of `B`, then that method will be called on `a` with `b` as an argument.

If `A` does *not* implement `/` for the type `B`, then the compiler will check for the `/~` method in `B` on the type of `A`.

The intention being that even if `A` was implemented with no knowledge of `B`, `B` can be implemented such that it is still compatible with `A`, by implementing the reciprocal of the operator.


=== Type Conversion Methods

The type conversion operator must always be implemented using a function generic as the return type must mach the constructor argument given. In fact, the implementation of the type conversion operator must be a function with a generic return type which takes a function that returns that same type.

```
fun -> <T> ( (*)=>T constructor)
```


Then, the body of the type conversion operator would rely on type switching on struct types to determine what value to return.

#review[The type checking logic here needs to be scrutinized.]

=== Promising
When a constructor promises an interface, all public fields and methods are required to be explicitly defined in the promising constructor. Because of #section-link("02 Interfaces", "Automatic Interfacing", "automatic interfacing"), satisfied promises only makes a difference from the perspective the programmer and doesn't result in code that compiles any differently. The advantage to promising is that it becomes impossible to fail to implement any of the promised methods or fields. 

If a constructor promises multiple interfaces containing fields with matching names, the type of that field must be the interface union (type intersection) of the value from all interfaces.

Even if a class/interface is not promised, it will be able to participate in polymorphism via #section-link("05 Automatic Interfacing", "", "automatic interfacing") as long as it matches the criteria to do so. Promising simply ensures that the programmer is required to satisfy those criteria as well as providing more self-documenting code.

```Lodge
struct ConstructorName() {
	promises Interface1, Constructor2
	
	!! Constructor Body
} 
```

=== Wrapping

Note: this replaces the concept of one type "using" another, so any straggling references to using ought to refer to this instead.

The concept of one struct wrapping another in Lodge is very similar to subclassing in other languages, but explicitly uses composition instead of inheritance. Specifically, the wrapping struct holds onto an instance of the wrapped struct as a field. 


A wrap statement looks very similar to a variable declaration. However, in addition to creating a field, the wrap statement also creates a method in the wrapping struct for each of the public methods in the wrapped struct. These methods that simply call into the corresponding method in the wrapped instance. Likewise, a getter/setter is created for every public field and property. In that way, A struct that wraps another also inherently satisfies that struct's interface (and is required to).

Take for example the following struct.
```
struct A() {
    Num val := 10
    Str _privateField := "string"
    
    fun doThing Int(Str arg) {
      !! Perform some action
    } 
}
```

We can write a struct `B` that wraps an instance of `A` with syntax demonstrated by the following example:
```
struct B() {
  wraps _a := A()
  Float z = 1.5
}
```

This is roughly equivalent to the following code where `_a`  is declared as a member with the type `A` and all of the public methods, getters, and setters are conveyed.
```
struct B() {
	  promises A
		
    A _a = A()
    get Int val { _a.val }
    set Int val { _a.val := val}
    fun doThing Int(Str arg) {
      _a.doThing(arg)
    }

    Float z = 1.4
}
```

The difference between wrapping a class and manually defining the members as in the last example is that members created by wrapping are specially marked to allow being overwritten without causing an compiler error so long as the struct still satisfies the required interface.


==== Multiple Wrapping
It is possible for one struct to wrap multiple others. In the case that public properties or methods would result in a name collision, members from later wrap declarations take priority as they are defined later #review[(or, potentially, the programmer would be forced to explicitly define that member)]. However, the struct as a whole must still satisfy the interfaces of both wrapped structs. If wrapping multiple structs would violate this, the code will not compile.

==== Aware Wrappers
#expand

An aware wrap is when `this` is passed into the constructor of the value being wrapped. In that way, the "super" struct has access to the fields of the wrapping struct. This passing of `this` is subject to escape analysis, so the wrap statement may need to happen later.

=== Generics
Like functions, struct declarations can also take additional type parameters before the argument list inside angle brackets. In the body of the struct, these parameters can be used as  types.

```Lodge
struct A<T>(){
	T field := .... 
}

A<Num> a := new A<Num>()
int val := a.field
```

When the `<T>` is specified, all instances of the type name `T` found in the class definition will be replaced with whatever the type is at the object creation. `T` could be any identifier, but a single uppercase letter is standard.

There is only one implementation for each generic, which simply uses the narrowest type union that encapsulates all possible values of T. The difference occurs with the type checker; the type of T is known at compile time for a given object, so the return types of methods can be checked statically and type errors are avoided.

You can also specify restrictions on the generic types with interfaces or type unions.

```Lodge
struct A<Iterable T> {
	...
}

struct B<(Int|Str) T> {
	...
}
```


==== Generics vs Unions
There is a small, yet important difference between creating non-generic class whose member types are a type union vs creating a generic class whose generic type is that same type union. 
The difference arises from the binding  time of the type. 
With the generic, the single allowed type is specified at value creation, whereas the type union allows all the types in the union forever. This difference is demonstrated by the following example.
```Lodge
struct A {
	(Int|Str) field 
}

struct B<(Int|Str) T> {
	T field
}

A a := A()
B<int> bInt:= B<Int>()
B<string> bStr := B<Str>()

a.field := 10
a.field := "string"

b1.field := 10
b1.field := "string"    !!Compile error

b2.field := 10          !!Compile error
b2.field := "string" 

```

 For constructor A, both strings and integers can be placed into the field regardless, but with class B, only the generic type specified at the creation of the object can be placed in the field.

=== Early Returns within Constructors
The `return` keyword has special restrictions within constructors. The implicit return of a constructor returns the value that the current invocation of the struct is defining. This value cannot be returned early (i.e. with a bare `return`) as it may be the case that not all members have been defined.

The return keyword is allowed if it takes an argument compatible with thee struct. In this case, the value being constructed is discarded and the specified value is returned by the invocation of the constructor.


This makes the singleton pattern very simple:
```Lodge

A? instance = None

struct A {
	if instance isnt None {
		return instance
	}

	!! Struct body
	
	instance = this
} 

```
