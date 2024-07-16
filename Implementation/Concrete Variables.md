## Concrete Variables

In Lodge, concrete variables are variables/arguments/fields that do not participate in Lodge's typing system in the typical way including [[Automatic Interfacing|automatic interfacing]], and inclusion in [[Lodge Type Unions|type unions]].


The reason for the existence of concrete variables is a technical reason based on the existence of [[Value Types|value types]] in lodge. Value types can only exist in concrete variables because the generated code for value types must be different as they are all value types and their value doesn't exist in a [[Lodge Thing]], which is the basis for the typing system.


## Concrete variables for reference types
I'm not sure if it will be possible to make concrete variables for reference types.


There aren't a lot of scenarios under which you would want to create a concrete variable for a reference as it *should* always be the case that an object with a compatible interface has compatible behavior as well.

The other side of this is that it might be irritating to the programmer to not be allowed to do this: It's not generally the philosophy of lodge to disallow things that are bad practice, but rather to design the language such that best practices are intuitive.

