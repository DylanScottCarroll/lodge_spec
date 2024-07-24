Errable and Nonable types simply refer to any type union that contains `Err` or `None` respectively. These use cases are so common that they have their own special syntax for declaration.

## Errable
Types with the `!` token are unioned with `Err`

``` Lodge
(Err | Str)

!! Is the same as

!Str

```

## Nonable
Types with the `?` token are unioned with `None`

``` Lodge
(None | Str)

!! Is the same as

?Str
```