## Concrete Variables

In Lodge, concrete variables are variables/arguments/fields that do not participate in Lodge's typing system in the typical way including [[05 Automatic Interfacing|automatic interfacing]], and inclusion in [[03 Type Unions|type unions]].

## Concrete variables for reference types
I'm not sure if it will be possible to make concrete variables for reference types.

There aren't a lot of scenarios under which you would want to create a concrete variable for a reference as it *should* always be the case that an object with a compatible interface has compatible behavior as well.

The other side of this is that it might be irritating to the programmer to not be allowed to do this: It's not generally the philosophy of lodge to disallow things that are bad practice, but rather to design the language such that best practices are intuitive.

