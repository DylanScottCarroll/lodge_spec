#import "../shared.typ": * 

Lodge is a lexically-scoped language; blocks create new scopes, a variable defined in a block will go out of scope at the end of the scope, and each block's scope will contain the variables from the enclosing scope. Variables aren't in scope until after their declaration.


=== Scope Lifetimes

There are cases where a particular instance of a scope can continue to exist after program execution leaves that block. Namely, functions defined inside of a scope that have references to values in that scope can cause a scope to persist if that function is accessed elsewhere as. Likewise, 


=== Function Hoisting
#expand

We really want to be able to call functions before they're defined in the global scope as this would get really annoying to have to worry about in structs.

If functions exist in the whole scope they're defined in, what value do other variables in the same scope get inside the function scope?

I think I may make a special exception for the highest-level scope in a file where functions are in-scope the entire time. I would then just have to enforce the rule that the highest-level scope could only have statically determinable declarations, which would be quite unfortunate. I could also execute lodge code in the highest scope at compile time, but that is also quite odd.



```
struct ImmutableStruct(...){
  Int _x = 10;
  get x { return _x }
  set x { _x = x }
}

```