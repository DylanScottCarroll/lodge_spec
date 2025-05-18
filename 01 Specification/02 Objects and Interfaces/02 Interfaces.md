## Interfaces

An Interfaces is a set of fields, properties, and methods. All implementations  have an interface, which is made up of the public members (methods and fields) of that class. Interfaces exist separate from the implementation behind those members.

An interface in Lodge is much more than it is in other programming languages and it is used throughout Lodge even when not explicitly defined by the programmer.

A lodge program consists of many concrete types and many interfaces. Interfaces may be created manually, implicitly by defining a class, or implicitly when creating a type union.

When a variable or container is declared, it automatically has some interface. Any concrete type that has a [[04 Interface Compatibility|compatible interface]] can be placed in that container. See [[Type Checking]] for more detail.
## Interface Creation

There are several ways that interfaces are created in Lodge
1. Explicitly with an interface definition
	* Using the [[02 Interfaces#Interface Definition|interface definition syntax]] 
2. Implicitly by creating a class
	* Every class definition will also create an interface of the same name out of that class's public members.
3. Using a [[03 Type Unions|type union]] to combine existing interfaces through [[08 Interface Intersection|interface intersection]]
4. Using a [[06 Type Intersections|type intersection]] to combine existing interfaces through [[09 Interface Union|interface unions]]


Behind the scenes, the members that can make up an interface are getters, setters, and methods. This is distinct from how a programmer defines an interface or class, but the separation between getters and setters fields is important for interface intersection, type unions, and properties.

When a class or interface definition specifies a public field, both a getter and setter will be created of that type in the interface. When either a getter or a setter is specified, only that getter or setter is created in the interface. Getters and setters of a given name can have the same or different types. That means that, in an interface definition, getters and setters of the same type will have the same result as a field definition. Fields and properties are identical for both external access and interface satisfaction (assuming the getter and setters have the same type). 

## Interface Definition Syntax

The syntax for defining an interface is much like the [[01 Classes#Class Definition Syntax|class definition syntax]], but without any values,  method/property implementations, or private members.

Here is an example:

``` Lodge
interface InterfaceName {
	Int fieldName

	fun FunctionName(Int arg1, Str arg2) Int

	get propertyName Int
	set propertyName Int
}

```


## Generic Interface
```
interface A<T> {
	T fieldName 
}

```