This note is where I put 

## Interesting Ideas
* Libraries for interacting with code from other languages.
* Compile-time integrated configs
	* Would let you define constants and literals in a separate file.
	* You could import them just like a header file and it would just act like a namespace without any functions
	* Maybe it could be like yaml, json, toml, or maybe all/more

* Automatic interface declarations.
	* Declaring auto types

* Syntax that emphasizes specifying action on data  like in functional programming
	* Lodge's main emphasis so far is the ease with which data is described in such a way that allows a high degree of interoperability.
	* It might also be a good idea to try to conceive of a syntax that takes a similar approach but for operations on the data as well.
		
		
	* To some extent, functions take care of this. You can specify a function as a way to encapsulate behavior
		* That way, you can encapsulate data and functionality, then bringing them together with an expressive syntax gives you the program behavior.
		
		
	* But also OOP is somewhat opposed to this because it intends to join functionality and data into one.
		* The advantage being that the program is much more encapsulated when data cares about mutations to itself.
		
		
	* Lodge's Automatic Interfacing allows for a unique situation
		* You can specify behavior without having to worry about data
		
	  * Python's duck typing does this, but it sacrifices safety and the code is not very self documenting.
		  * Type hints



