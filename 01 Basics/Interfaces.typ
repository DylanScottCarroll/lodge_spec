#import "../shared.typ": *

=== Interfaces

An Interfaces is a set of getters, setters, and methods. All values  have an interface, which is made up of the public members of that value where fields are represented by pairs of getters and setters. The interface for any particular value is defined in code by the constructor that created it. Interfaces exist separate from the implementation behind those members.

A lodge program consists of many concrete types and many interfaces. Interfaces may be created manually, implicitly by defining a constructor, or implicitly when creating a type union.

When a variable or container is declared, it automatically has some interface. Any concrete type that has a #section-link("04 Interface Compatibility", "", "compatible interface") can be placed in that container. See #section-link("Type Checking", "", "") for more detail.
=== Interface Creation

There are several ways that interfaces are created in Lodge
1. Explicitly with an interface definition
	- Using the #section-link("02 Interfaces", "Interface Definition", "interface definition syntax") 
2. Implicitly by creating a constructor
	- Every constructor definition will also create an interface of the same name out of that constructor's public members.
3. Using a #section-link("03 Type Unions", "", "type union") to combine existing interfaces into a #section-link("10 Interface Set", "", "interface set").
4. Using a #section-link("06 Type Intersections", "", "type intersection") to combine existing interfaces #section-link("10 Interface Set", "", "interface set").


Behind the scenes, the members that can make up an interface are getters, setters, and methods. This is distinct from how a programmer defines an interface or class, but the separation between getters and setters fields is important for interface intersection, type unions, and properties.

When a constructor or interface definition specifies a public field, both a getter and setter will be created of that type in the interface. When either a getter or a setter is specified, only that getter or setter is created in the interface. Getters and setters of a given name can have the same or different types. That means that, in an interface definition, getters and setters of the same type will have the same result as a field definition. Fields and properties are identical for both external access and interface satisfaction (assuming the getter and setters have the same type). 

=== Interface Name collision

It is possible to create an interface in a given scope even if another (non-interface) name already exists in that scope. This happens every time a struct is defined, as the struct definition creates the callable constructor itself as well as an interface of the same name. 

Interface values are only referenceable inside of a #section-link("Type Expressions", "", "type expression"), and other values are typically only referencable inside normal expressions.


=== Interface Definition Syntax

The syntax for defining an interface is similar to the  #section-link("01 Constructors", "Constructor Syntax", "constructor definition syntax"), but without any values,  method/property implementations, or private members.

Here is an example:

```Lodge
interface InterfaceName {
	Int fieldName

	fun functionName Int(Int arg1, Str arg2)

	get Int propertyName
	set Int propertyName
}
```

=== Generic Interfaces

Like generic structs, generic interfaces can also be created using the same syntax. 

```
interface A<T> {
	T fieldName 
}

```

