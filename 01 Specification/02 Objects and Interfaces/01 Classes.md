## Class Definition Syntax

### Basic Syntax
``` Lodge
class ClassName  {
	promises Interface1, Class1
	uses ParentClass1, !ParentClass2
	
	Int field
	
	fun Method() ReturnType {
		!! Method Body 
	}
}
```

### Anonymous Classes
Classes can also be created without names in order to allow the creation of an object without needing to write a dedicated named class for it.

The anonymous class will participate in the typing system as normal, and can even be placed in other variables using the `var` keyword.

``` Lodge
var anonObj := class {
	!! Class body
}()
```

Even though the class does not have a defined name, it will still have an internal name and interface like any other class.

## Promising
When a class promises an interface, all public fields and methods are required to be explicitly defined in the promising class.

If a promise results in a name collision with previous promises, this will be accompanied by an error unless the function signatures are identical / the field types are identical.

However, because of [[02 Interfaces#Automatic Interfacing|automatic interfacing]], promising only makes a difference from the perspective the programmer and doesn't result in code that compiles any differently. The advantage to promising is that it becomes impossible to fail to implement ant of the promised methods or fields. 

Even if a class/interface is not promised, it will be able to participate in polymorphisms via automatic interfacing as long as it matches the criteria to do so. Promising simply ensures that the programmer is required to satisfy those criteria as well as providing more self-documenting code.

``` Lodge
class ClassName  {
	promises Interface1, Class1
	
	!! Class Body
}
```

## Using

When a class uses another class, all methods and fields (external and internal) from the superclass are implicitly copied into the subclass. Methods created in a class via using satisfy promise requirements.

Lodge allows for using multiple classes. In the case of namespace collisions, the value from the class listed second will be used. However, if a usage overwrites the implementation of the class or any previous uses, this will cause a compiler warning. This warning can be suppressed by placing a `!` before the class name that caused the collision as seen in the example above.

``` Lodge
class ClassName  {
	promises Interface1, Class1
	uses ParentClass1, !ParentClass2

	!! Class Body
}
```

## Public/Private Methods and Fields

``` Lodge
class A {
	int _a := 0 !! Private/Internal field
	int a := 10 !! Public/External field
	
	fun F(int arg) int {
		!! External function
	}
	
	fun _F(int) int {
		!! Internal functions
	}
	
}
```

The difference between external and internal class members is that internal members will not be considered as part of the class's interface for the purposes of promising, automatic interfacing, and type union definition.

Internal members can be accessed from inside the class, but also from within concrete [[05 Type Switching|type switches]] that switch on the specific concrete class.

## Properties

Defining properties is done using the get and set keywords

``` Lodge

class A {
	get propertyName Type {
		!! Code for getting the value
	}
	set propertyName Type {
		!! Code for setting the value
	}
}
```

The get and set type for a given property do not have to be the same. In fact, the get and set properties act pretty much independently from eachother despite the fact that they have thee same name.

Behind the scenes, properties are compiled as functions. Properties cannot be internal, but they can still be accessed from within the class.

From the outside, properties act just like fields.

``` Lodge
A a := new A()
print(a.propertyName)
a.properyName := 10
a.propertyName += 10
```

## Generics

``` Lodge
class A<T> {
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
With the generic, the single allowed type is specified at object creation, whereas the type union allows all the types in the union forever. This difference is demonstrated by the following example.
``` Lodge
class A {
	(Int|Str) field 
}

class B<(Int|Str) T> {
	T field
}

A a := new A()
B<int> bInt:= new B<Int>()
B<string> bStr := new B<Str>()

a.field := 10
a.field := "string"

b1.field := 10
b1.field := "string"    !!Compile error

b2.field := 10          !!Compile error
b2.field := "string" 

```

 In class A, both strings and integers can be placed into the field regardless, but with class B, only the generic type specified at the creation of the object can be placed in the field.


## Nested Classes

Classes can be defined within other classes. This class can be accessed within the outer class and from the program at large through the outer class.

This is a purely static concept. Class instances (objects) can't and don't contain classes

``` Lodge
class A {
	fun F() B {
		b := new B()
		return b
	}
		
	class B {
		int v := 10
	}
}

A a := new A() 
A.B b := a.F()
```


## Operator Methods

``` Lodge
class A {
	fun + (auto other) int {
		!! Logic for adding objects
	}
}

A var1 := new A()
A var2 := new A()
A var3 := var1 + var2
```

The syntax of the format `fun + () ...` is only legal within classes.

### Type switching inside operator methods

Because of the way that [[08 Interface Intersection|interface intersection]] works in lodge, it is best to use the broadest possible type for the operator method. These methods are a particularly good use case of the [[05 Variables#Auto Keyword|auto keyword]] as the type of the argument grows automatically as the ways that the variable is used grows.

### Reverse operator methods

When an operator is acting on two objects, the compiler will first look if the first object implements the operator on the type of the second object. If not, it will look to see if the second object implements the *reverse method* of that operator.

For example, take the expression `a / b` for objects of classes `A` and `B`.

If `A` implements `/` for the type of `B`, then that method will be called on `a` with `b` as an argument.

If `A` does *not* implement `/` for the type `B`, then the compiler will check for the `~/` method in `B` on the type of `A`.

The intention being that even if `A` was implemented with no knowledge of `B`, `B` can be implemented such that it is still compatible with `A`, by implementing the reciprocal of the operator.


## Method Overloading
* Lodge does not have method overloading in the typical sense currently
	* Recent improvements in how method signatures are defined has made me rethink this

* Type unions make it less clear what a functions signature actually is as a functions argument types could refer to any number of combination of concrete argument types.
	* It might be possible to  allow overloading but restrict it to strictly non-intersecting interfaces, which would allow method overloading in some cases
	* Though, this might get frustrating as this intersection behavior would likely be complex and unintuitive
	* Though, this also makes candidacy for [[08 Interface Intersection|interface intersection]] much more complicated and may not be worth it.

* Instead, the way Lodge is currently designed is to use optional parameters and type switching to achieve similar behavior.
	* This is similar to Python's behavior and people don't seem to mind that much

* Look at [[07 Functions]] to see about optional parameters and type switching to mimic the behavior of method overloading