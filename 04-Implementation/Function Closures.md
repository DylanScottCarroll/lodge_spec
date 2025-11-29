## Function Closures


When a function is defined inside of an existing scope, the values from that enclosing scope will be captured into the function. This will probably be implemented as some sort of function object that holds a pointer to the code section of that function as well as all of the values for the scope that it captures. So, although function code would exist statically in the code section of the compiled program, there can still exist multiple function objects that reference that code. That way, the function object can hold the captured scope, so multiple different instances of the function can be created with different values for the variables at different times.

I'm not sure if values captured by functions should be copied or if they should exist as references to the original scope. This keeping of a function's scope alive after the function has exited feels... bad. It feels to me like all of the cases where that's useful kind of circumvent the Lodgey way of doing things

It is known at compile time which variables inside of a function definition are captured, so the function object types can be defined at compile time to include fields for those objects. And when the function is called, those values are placed into the stack along with the other local variables to the function.

