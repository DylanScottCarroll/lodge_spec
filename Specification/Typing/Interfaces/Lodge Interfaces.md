## Interfaces


An Interfaces is simply a set of fields, properties, and methods. All classes have an interface, which is made up of the public members (methods and fields) of that class. Interfaces exist separate from the implementation behind those members.

An interface in Lodge is much more than it is in other programming languages and it is used throughout Lodge even when not explicitly defined by the programmer.

A lodge program consists of many concrete types and many interfaces. Interfaces may be created manually, implicitly by defining a class, or implicitly when creating a type union.

When a variable or container is declared, it automatically has some interface. Any concrete type that has a [[Lodge Compatible Interfaces|compatible interface]] can be placed in that container. See [[Lodge Type Checking]] for more detail.


[[Lodge Classes]] can promise interfaces to require that all functionality outlined by the interface is implemented.
However, only interfaces with a name can be promised by a class.

## Interface Creation

There are several ways that interfaces are created in Lodge
1. Explicitly with an interface definition
	* Using the [[Lodge Interfaces#Interface Definition|interface definition syntax]] 
2. Implicitly by creating a class
	* Every class definition will also create an interface of the same name out of that class's public members.
3. Using a [[Lodge Type Unions|type union]] to combine existing interfaces through [[Lodge Interface Intersection|interface intersection]]
4. Using a [[Lodge Type Intersection]] to combine existing interfaces through [[Lodge Interface Union|interface unions]]


Behind the scenes, the members that can make up an interface are getters, setters, and methods. This is distinct from how a programmer defines an interface or class, but the separation between getters and setters fields is important for interface intersection, type unions, and properties.

When a class or interface definition specifies a public field, both a getter and setter will be created of that type in the interface. When either a getter or a setter is specified, only that getter or setter is created in the interface. Getters and setters of a given name can have the same or different types. That means that, in an interface definition, getters and setters of the same time will have the same result as a field definition. Fields and properties are identical for both external access and interface satisfaction (assuming the getter and setters have the same type). 

## Interface Definition

The syntax for defining an interface is much like the [[Lodge Classes#Class Definition Syntax|class definition syntax]], but without any values,  method/property implementations, or private members.

Here is an example:

``` Lodge
interface InterfaceName
	int fieldName

	fun FunctionName(int arg1, str arg2) int

	get propertyName int
	set propertyName int
;

```



## Interface Intersection
[[Lodge Interface Intersection]] 

## Automatic Interfacing
[[Automatic Interfacing]]