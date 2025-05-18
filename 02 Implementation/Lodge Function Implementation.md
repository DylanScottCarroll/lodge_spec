#lodge_implementation 

## Function definition Locations

Regardless of where a function is defined, its code will be in the code segment of the compiled program.


## Function Closures
[[Function Closures]]

## Generator Functions
Whenever a function in lodge is defined with a yield statement, it is a generator function.


Upon the first yield statement being encountered, the function state is copied into a newly created [[Function Closures|function closure]], and the function returns that closure.


When the generator is entered for the second time, the values of local variables are copied out of the closure and back onto the stack, then, the function will jump back to the location that it was most recently yielded out of.


I still need to make a decision about what generator scheme I'm going to use:``z [[07 Functions#Generator Functions|generator functions]]



There might also be a behind-the-scenes optimization possible where each generator function contains two code versions: the generator creator and the generator function. This way, the creator function would not need the labels or jump table. The generator function would not need to have the logic for creating a new closure and populating. It could also  store its state directly in the closure through some pointer mechanism rather than having to copy it between the closure and the call stack each call. 