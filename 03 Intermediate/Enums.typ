#import "../shared.typ": *

Enums are tricky to fit into the type system, but are super useful...

#expand


Regular enum
```
enum EnumName {
  OPTION1,
  OPTION2,
  OPTION3,
}
```


Enums with values
```
enum EnumName {
  OPTION1(Type, Type),
  OPTION2(Type, Type),
  OPTION3(Type, Type),
}
```

Getting the values from an enum value (calling?)
```
EnumName variable := EnumName.OPTION1
val1, val1 := variable()
```