#expand: Create a more unified description of the type expression syntax

Type expressions are a kind of expression that exists when a type is being defined such as during variable declaration or on the right hand side of the special `->` operator. 

Type expressions differ from normal expressions in that
1. The values of the expression must all be types
	* Non-type values will be coerced into types by resolving their interface
	* Explicitly defined type values mask non-type values
2. The operators must be the type set operators
3. The expression must be 


To expand on point one, values inside of type expression will first 