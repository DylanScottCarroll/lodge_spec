#lodge_implementation

Of course, we will need to know more about [[01 Statements]] first.

## Preprocessor
This step is in charge of cleaning up certain things that are easy to recognize at this stage that would otherwise make the tokenizer 

Deals with:
* Removing Comments
* Compiler macros?
	* Don't know if Lodge will have this.


### Tokenizer Based on Regular Expressions

Types of Tokens
* numerical literals
	* 10
	* 1.5
	* .5
	* 0xFF
	* 0b1010
* string literals
	* How to deal with string literals in the tokenizer?
* operators
* keywords
* identifiers
	* Identifiers are any alphanumerical tokens with a given format excluding keywords and alphabetic operators like not, and, or or.
	* The exact format has not been settled on yet




### Parser Based on a Context-Free Grammar

Probably in LR form for more readable error messages.
