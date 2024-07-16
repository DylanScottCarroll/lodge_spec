The type conversion operator `:` is the way to convert an object of one type into another.

It is particularly useful for conversion into strings for representational purposes:
``` Lodge
Str myStrRepr = myObj:str
```


Or for conversions between numerical types
``` Lodge
Int myInt = myFloat:int
```


For this operator, it is very useful, or potentially essential to have some kind of representation of [[Types as Objects]]. 

Since this behavior must be implemented by the class overloading the `:` operator, there must be some value that is passed into it