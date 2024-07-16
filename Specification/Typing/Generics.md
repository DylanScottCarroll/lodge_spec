
``` Lodge
class A<T>
	T field = .... ;

A<int> a = new A<int>()
int val = a.field
```

When the `<T>` is specified, all instances of the type T found in the class definition will be replaced with whatever the type is at the object creation. T could be any identifier, but a single uppercase letter is standard.

This is implemented by simply using the broadest possible type union to replace T. If nothing is specified, T is equivalent to the [[Object Interface]]. 

The type of T is known at compile time for a given object, so the return types of methods can be checked statically and type errors are avoided.

You can also specify restrictions on the generic types with interfaces or type unions.

``` Lodge
class A<Iterable T>
	...
;

class B<(int | str | list) T>
	...
;
```



Note: there is a small, yet important difference between creating non-generic class whose member types are a type union vs creating a generic class whose generic type is that same type union. With the generic, only one type of the union can be in object when the object is created. This difference is demonstrated by the following example.
``` Lodge
class A
	 (Int|Str) field ;

class B<(Int|Str) T>
	T field ;

A a = new A()
B<int> bInt= new B<Int>()
B<string> bStr = new B<Str>()



a.field = 10
a.field = "string"

b1.field = 10
b1.field = "string"    !!Compile error

b2.field = 10          !!Compile error
b2.field = "string" 

```

 In class A, both strings and integers can be placed into the field regardless, but with class B, only the generic type specified at the creation of the object can be placed in the field.
