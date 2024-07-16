#lodge_spec

This is the plan of how the lodge language will treat operators
 * Have a set of operators that serve specific functions that user classes can overload
	*  +, -, /, \*, etc.
	* \# hash
	* : access (token on the right is passed as a string literal)
	* [] indexing
* Reserve some unused operator tokens that user classes can implement
	* ~, @, $


## Mathematical Operators

| op  | action           |
| --- | ---------------- |
| +   | addition         |
| -   | subtraction (and unary negation)    |
| /   | division         |
| //  | integer division |
| *   | multiplication   |
| %   | modulus          |
| **  | power            |
| /^  | root             |

## Logical Operators

The operators here that are words are reserved keywords

| op   | action                   |
| ---- | ------------------------ |
| and  | "                        |
| or   | "                        |
| not  | unary negation operator  |
| xor  | exclusive or             |
| =    | value equivalence        |
| is   | identity equivalence     |
| !=   | not value equivalent     |
| isnt | not identity equivalent  | 
| >    | greater than             |
| <    | less than                |
| >=   | greater than or equal to |
| <=    | less than or equal to    |

The value equivalence operator `=` should not be confused with the assignment operator `:=`

## Bitwise Operators

| op  | action      |
| --- | ----------- |
| &   | bitwise and |
| \|  | bitwise or  |
| ^   | bitwise xor |
| ~    | bitwise not (compliment)            |

## Assignment Operators
| op  | action     |
| --- | ---------- |
| :=  | assignment |
| ++  | increment  |
| --  | decrement  |

There is also forms such as `+=`, `-=`, `*=`, `/=`, and `**=` that are shorthand for performing an operation and then assigning the result to the first operand (assuming that operand is an existing identifier). Any operator except assignment operators and unary operators followed by a = will be treated as being a part of this shorthand.

## Other Operators 

| op  | action               |
| --- | -------------------- |
| :   | [[Type Conversion Operator\|type conversion]]         |
| #   | hash                 |
| ()  | call as a function   |
| []  | indexing and slicing |
| @   | other                |


## Operator Overloading
[[Lodge Classes#Operator Methods|Operator Methods]]
