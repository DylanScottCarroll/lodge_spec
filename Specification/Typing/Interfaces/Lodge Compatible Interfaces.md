
The concept of a compatible interface refers to the ability for an interface to be substituted for another without issue. If we have two interfaces A and B, B is compatible with A, if there are no methods or fields in A that are missing from B. 

Interface compatibility describes candidacy for polymorphism in Lodge, and typically we would talk about a given Class as being compatible with an interface. 

For example, the Lodge integer class is not compatible with the interface of the string class because it fails to implement several of the methods that the string class like length and ToLowercase.



Therefore, In order for an interface to be compatible with another, that interface must be a superset of the other interface. This is similar to the requirements for a class satisfying having [[Lodge Classes#Promising|promised]] an interface. 