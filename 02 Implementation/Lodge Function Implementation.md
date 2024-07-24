#lodge_implementation 

## Function definition Locations

Regardless of where a function is defined, its code will be in the code segment of the compiled program.

* The main body of a code file
	* The function will be assessable from anywhere in the file or from any file that imports that one. 
* Inside the body of a class/struct
	* It will be treated as a class/struct method and will be bond to 
* Inside the body of another function.
	* A new function object will be created at the line where the function is defined and bound to the name it is defined as within the scope it is defined under. 



## Function Closures

When a function is defined inside of an existing scope, the values from that enclosing scope will be captured into the function. This will probably be implemented as some sort of function object that holds a pointer to the code section of that function as well as all of the values for the scope that it captures. So, although function code would exist statically in the code section of the compiled program, there can still exist multiple function objects that reference that code. That way, the function object can hold the captured scope, so multiple different instances of the function can be created with different values for the variables at different times.

It is known at compile time which variables inside of a function definition are captured, so the function object types can be defined at compile time to include fields for those objects. And when the function is called, those values are placed into the stack along with the other local variables to the function.


## Generator Functions
Whenever a function in lodge is defined with a yield statement, it is a generator function.


Upon the first yield statement being encountered, the function state is copied into a newly created [[Function Closures|function closure]], and the function returns that closure. That function closure also 


When the generator is entered for the second time, the values of local variables are copied out of the closure and back onto the stack, then, the function will jump back to the location that it was most recently yielded out of.


I still need to make a decision about what generator scheme I'm going to use:``z [[07 Functions#Generator Functions|generator functions]]



There might also be a behind-the-scenes optimization possible where each generator function contains two code versions: the generator creator and the generator function. This way, the creator function would not need the labels or jump table. The generator function would not need to have the logic for creating a new closure and populating. It could also  store its state directly in the closure through some pointer mechanism rather than having to copy it between the closure and the call stack each call. 