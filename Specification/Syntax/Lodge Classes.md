## Class Definition Syntax

``` Lodge

class ClassName promises Interface1, Class1 uses ParentClass1, !ParentClass2
	int field
	
	fun Method() returnType
		!! Method Body 
	;
; 
```

## Anonymous Objects
Similar to what JavaScript can do, but with the type safety/flexibility provided by lodge.

You'll be able to create an object anywhere in code, and, as long as it's interface is determinable at compile time, it will work with compatible interfaces just like any other class object. 


``` Lodge
var anonObj = class 
	!! Class body
;
```

Behind the scenes, the class will be assigned an internal name and interface. Additionally, anonymous classes will participate in [[Automatic Interfacing]] just like any other object. 

## Promising
When a class promises an interface or a class, all public fields and methods are required to be explicitly defined in the promising class.

If a promise results in a name collision with previous promises, this will be accompanied by an error unless the function signatures are identical / the field types are identical.

However, because of [[Lodge Interfaces#Automatic Interfacing|automatic interfacing]], promising only makes a difference from the perspective the programmer and doesn't result in code that compiles any differently. The advantage to promising is that it becomes impossible to fail to implement ant of the promised methods or fields. 

Even if a class/interface is not promised, it will be able to participate in polymorphisms via automatic interfacing as long as it matches the criteria to do so. Promising simply ensures that the programmer is required to satisfy those criteria as well as providing more self-documenting code.

## Using

When a class uses another class, all methods and fields (external and internal) from the superclass are implicitly copied into the subclass. Methods created in a class via using satisfy promise requirements.

Lodge allows for using multiple classes. In the case of namespace collisions, the value from the class listed second will be used. However, if a usage overwrites the implementation of the class or any previous uses, this will cause a compiler warning. This warning can be suppressed by placing a `!` before the class name that caused the collision as seen in the example above.


## Public/Private Methods and Fields

``` Lodge
class A
	int _a = 0 !! Private/Internal field
	int a = 10 !! Public/External field
	
	fun F(int arg) int
		!! External function
	;
	
	fun _F(int) int
		!! Internal functions
	; 
	
; 
```

The difference between external and internal class members is that internal members will not be considered as part of the class's interface for the purposes of promising, automatic interfacing, and type union definition.

Internal members can be accessed from inside the class, but also from within [[Lodge Type Switching|type switches]] that switch on the specific concrete class.

Though, accessing internal members is generally considered bad practice and to be avoided except in cases of debugging or testing.

## Method Overloading
* Lodge does not have method overloading in the typical sense currently
	* Recent improvements in how method signatures are defined has made me rethink this

* Type unions make it less clear what a functions signature actually is as a functions argument types could refer to any number of combination of concrete argument types.
	* It might be possible to  allow overloading but restrict it to strictly non-intersecting interfaces, which would allow method overloading in some cases
	* Though, this might get frustrating as this intersection behavior would likely be complex and unintuitive
	* Though, this also makes candidacy for [[Lodge Interface Intersection|interface intersection]] much more complicated and may not be worth it.

* Instead, the way Lodge is currently designed is to use optional parameters and type switching to achieve similar behavior.
	* This is similar to Python's behavior and people don't seem to mind that much

* Look at [[Lodge Functions]] to see about optional parameters and type switching to mimic the behavior of method overloading

## Operator Methods

``` Lodge
class A
	fun + (auto other) int
		!! Logic for adding objects
	;
;

A var1 = new A()
A var2 = new A()
A var3 = var1 + var2
```

The syntax of the format `fun + () ...` is only legal within classes.

### Type switching inside operator methods

Because of the way that [[Lodge Interface Intersection|interface intersection]] works in lodge, it is best to use the broadest possible type for the operator method. The 


These methods are a particularly good use case of the [[Lodge Typing Syntax#Auto Keyword|auto keyword]] as the type of the argument grows automatically as the 

### Reverse operator methods

When an operator is acting on two objects, the compiler will first look if the first object implements the operator on the type of the second object. If not, it will look to see if the second object implements the *reverse method* of that operator.

For example, take the expression `a / b` for objects of classes `A` and `B`.

If `A` implements `/` for the type of `B`, then that method will be called on `a` with `b` as an argument.

If `A` does *not* implement `/` for the type `B`, then the compiler will check for the `~/` method in `B` on the type of `A`.

The intention being that even if `A` was implemented with no knowledge of `B`, `B` can be implemented such that it is still compatible with `A`, by implementing the reciprocal of the operator.

## Properties

Defining properties is done using the get and set keywords

``` Lodge

class A
	get propertyName type
		!! Code for getting the value
	;
	set propertyName type
		!! Code for setting the value
	;
; 
```

The get and set type for a given property do not have to be the same. In fact, the get and set properties act pretty much independently from eachother despite the fact that they have thee same name.

Behind the scenes, properties are compiled as functions. Properties cannot be internal, but they can still be accessed from within the class.

From the outside, properties act just like fields.

``` Lodge
A a = new A()
print(a.propertyName)
a.properyName = 10
a.propertyName += 10
```

## Generics
[[Generics]]

[[Lodge Generics Implementation]]


## Nested Classes

Classes can be defined within other classes. This class can be accessed within the outer class and from the program at large through the outer class.

This is a purely static concept. Class instances (objects) can't and don't contain classes

``` Lodge
class A
	fun F() B
		b = new B()
		return b ; 
		
	class B
		int v = 10; 
	; 
; 

A a = new A() 
A.B b = a.F()
```

