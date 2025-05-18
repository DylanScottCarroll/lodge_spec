## Constructors
Lodge doesn't have a way of directly defining concrete types. Instead, the programmer defines a constructor that creates the type. Any (public) variables and functions defined inside the scope of the constructor will be fields and methods accessible through the value described by the constructor.

## Constructor Syntax

### Basic Syntax
``` Lodge
struct ConstructorName(Type1 arg1, Type2 arg2, ...) {
	Int field
	
	fun method() ReturnType {
		!! Method Body 
	}
}
```

### Anonymous Constructors
Constructors can also be created without names in order to allow the creation of an object without needing to write a dedicated named constructor for it.

The anonymous values will participate in the typing system as normal, and can even be placed in other variables using the `var` keyword.

``` Lodge
var anonValue := struct() {
	!! Value body
}()
```

Even though the constructor does not have a defined name, it will still have an internal name and interface like any other class.

## Constructor Types
A constructor has the type of a function that takes  the constructor objects and returns the type described by the constructor.

## Public/Private Methods and Fields

``` Lodge
struct A {
	Int _a := 0 !! Private field
	Int a := 10 !! Public field
	
	fun F Int(Int arg) {
		!! External function
	}
	
	fun _F Int(Int) {
		!! Internal functions
	}
	
}
```


The difference between external and internal class members is that internal members will not be considered as part of the class's interface for the purposes of promising, automatic interfacing, and type union definition.

Internal members can be accessed from inside the constructor  as they are in scope for all of the constructors methods


## Properties

Defining properties is done using the get and set keywords. Inside the body of a setter, the provided value can be referenced by the name of the setter.

``` Lodge

struct A {
	Int _val;
	get Int Val {
		return _val
	}
	set Type Val {
		_val = Val->Int
	}
}
```

The get and set type for a given property do not have to be the same. In fact, the get and set properties act pretty much independently from each other despite the fact that they have thee same name. Behind the scenes, properties are compiled as functions. 

From the outside, properties act just like fields.

``` Lodge
A a := A()
a.propertyName := "20"
Int val = a.properyName
!! val == 20
```


## Promising
When a constructor promises an interface, all public fields and methods are required to be explicitly defined in the promising constructor. Because of [[02 Interfaces#Automatic Interfacing|automatic interfacing]], satisfied promises only makes a difference from the perspective the programmer and doesn't result in code that compiles any differently. The advantage to promising is that it becomes impossible to fail to implement ant of the promised methods or fields. 

If a constructor promises multiple interfaces containing fields with matching names, the type of that field must be the interface union (type intersection) of the value from all interfaces.

Even if a class/interface is not promised, it will be able to participate in polymorphisms via automatic interfacing as long as it matches the criteria to do so. Promising simply ensures that the programmer is required to satisfy those criteria as well as providing more self-documenting code.

``` Lodge
struct ConstructorName() {
	promises Interface1, Constructor2
	
	!! Constructor Body
}
```

## Using

When a constructor uses another constructor, all fields and methods (external and internal) from the super-constructor are implicitly copied into the subclass. Methods created in a class via using satisfy promise requirements.

If two super constructors are promised, they are applied in-order. 
There's a way to resolve name conflicts, but there is some complexity here: #expand 

``` Lodge
struct ConstructorName  {
	promises Interface1, ParentConstructor2
	uses ParentConstructor1, ParentConstructor2

	!! Constructor Body
}
```


## Generics

``` Lodge
struct A<T>(){
	T field := .... 
}

A<int> a := new A<int>()
int val := a.field
```

When the `<T>` is specified, all instances of the type name `T` found in the class definition will be replaced with whatever the type is at the object creation. `T` could be any identifier, but a single uppercase letter is standard.

This is implemented by simply using the broadest possible type union to replace T. If nothing is specified, T is equivalent to the [[03 Built-In Interfaces]]. 

The type of T is known at compile time for a given object, so the return types of methods can be checked statically and type errors are avoided.

You can also specify restrictions on the generic types with interfaces or type unions.

``` Lodge
class A<Iterable T> {
	...
}

class B<(int | str | list) T> {
	...
}
```


## Generics vs Unions
There is a small, yet important difference between creating non-generic class whose member types are a type union vs creating a generic class whose generic type is that same type union. 
The difference arises from the binding  time of the type. 
With the generic, the single allowed type is specified at value creation, whereas the type union allows all the types in the union forever. This difference is demonstrated by the following example.
``` Lodge
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


## Operator Methods

``` Lodge
class A {
	fun + Int(auto other) {
		!! Logic for adding objects
	}
}

A var1 := A()
A var2 := A()
A var3 := var1 + var2
```

The syntax of the format `fun + Type() ...` is only legal within constructors.

### Type switching inside operator methods

Because of the way that [[08 Interface Intersection|interface intersection]] works in lodge, it is best to use the broadest possible type for the operator method. These methods are a particularly good use case of the [[05 Variables#Auto Keyword|auto keyword]] as the type of the argument grows automatically as the ways that the variable is used grows.

### Reverse operator methods

When an operator is acting on two objects, the compiler will first look if the first object implements the operator on the type of the second object. If not, it will look to see if the second object implements the *reverse method* of that operator.

For example, take the expression `a / b` for objects of classes `A` and `B`.

If `A` implements `/` for the type of `B`, then that method will be called on `a` with `b` as an argument.

If `A` does *not* implement `/` for the type `B`, then the compiler will check for the `~/` method in `B` on the type of `A`.

The intention being that even if `A` was implemented with no knowledge of `B`, `B` can be implemented such that it is still compatible with `A`, by implementing the reciprocal of the operator.


## Method Overloading
* Lodge does not have function overloading in the typical sense currently
* Type unions and automatic interfacing make it less clear which concrete types correspond to which function.

* It might be possible to  allow overloading but restrict it to strictly non-intersecting interfaces, which would allow method overloading in some cases.
		* What happens with None values, which have an empty interface?
		* This might get frustrating as this intersection behavior would likely be complex and unintuitive
		* This also makes candidacy for [[08 Interface Intersection|interface intersection]] much more complicated and may not be worth it.

* Instead, the way Lodge is currently designed is to use optional parameters and type switching to achieve similar behavior.
	* This is similar to Python's behavior and people don't seem to mind that much

* Look at [[08 Functions]] to see about optional parameters and type switching to mimic the behavior of method overloading