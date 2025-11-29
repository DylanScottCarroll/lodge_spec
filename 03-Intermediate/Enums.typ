#import "../shared.typ": *

Enums provide a way to create a type which can only take a closed set of mutually incompatible values, which optionally take fields.


```
enum Enum {
  A; B; C
}

Enum value = Enum.A

if value is Enum.A {
  !! ...
} else if value is Enum.B{
  !! ...
} else {
  !!...
}

```

=== Syntax

Enum declarations consist of 1) `enum` keyword, 2) an identifier representing the Name of the enum and, and 3) body enclosed by curly brackets. The body of an enum consists of a list of identifiers and optional curly-bracket-enclosed bodies. 

```Lodge
enum Enum {
  Value1 { !- Value body -!}
  Value2 { !- Value body -!}
  ...
  ValueN { !- Value body -!}
}
```
The body the enum values are much like the bodies of structs; all of the variables declared in the scope of the body become fields of the value. However, enum value bodies do not take arguments, and they are executed at the time of the enum declaration.


=== Enum Objects, Interfaces, and Values

The declaration of an enum creates an variable in the namespace of the declaration, an enum object assigned to that variable, and an interface associated with the enum.

The enum object contains a getter for each value and acts as a way to access all of the enum values.

The enum interface is the type union of all of the enum values, so a variable declared with the enum interface may contain any value from the enum.

All of the enum values are type compatible with the enum interface, but are all mutually incompatible with each other. This compatibility behavior is acheived by inserting special fields into each enum value matching that value's name. 


```Lodge
enum Enum {
  A { Str foo = "hello" }
  B { Int bar = "world" }
}

Enum a = Enum.A
Enum b = Enum.B

Enum.A is a  !! True
a is Enum.A  !! True
a is b       !! False
```

Like other type unions, the fields of enum values can only be accessed through the use of a type switch. Switching the type of an enum will also provide other utilities in the form of warnings in case not all enum values are 

```Lodge
Enum val = Enum.A

swype val { !! Warning: not all enum values are included in the switch
  Enum.A : { val.foo }
}

swype val {
  Enum.A : { val.foo }
  * : { ... }
}
```
