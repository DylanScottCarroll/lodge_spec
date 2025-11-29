#import "../shared.typ": *

#expand

With statements let the programmer automatically manage resources that need to be explicitly opened and closed using a block in which the resource

Any object that satisfies the  #section-link("03 Built-In Interfaces", "ContextManager", "ContextManager interface") can be placed in argument of a with statement.


```
with mutext_lock {

}
```

You can also place an assignment in the statement. 
```
with file_handle = open("filname".txt) {

}
```
