This section is an attempt at constructing a formalization of the type system  that can be used to prove correctness and decidability of the type checker. 

We make two simplifying assumptiojs about the problem:

*1. Method-Only members* \
In order to reduce the number of cases that need to be considered, we reduce all type members to methods. Fields can be described as a getter and a setter, while getters and setters can both be describeds as methods. A getter can be described by a method that takes no arguments and returns a single value, and a setter can be described by a method that takes a single value 

*2. Member Sets* \
We assume that a type can be fully described by a set containing all of its member methods. Additionally, we make no distinction between concrete, and interface types as compatibility checking operations do not depend on a concrete implementation to exist.

*Members*\
A member consists of a name, a return type, and a sequence of argument types. A member then is, formally, a 

$M = (N, R, A)$
1. $N$ is a string representing the name of the member
2. $R$ is a member set
3. $A$ is an ordered sequence of member sets $(a_1, a_2, a_3, ..., a_n)$

*Member Set* \
A type, then, is a set of members with distinct names.  \
$T = {M_1, M_2, M_3, ...}$ s.t. $M_i != M_j$ for all $i, j in bb(N)$ where $i!=j$\
When we refer to a type we refer to a particular set of members.


*Compatibility Relations*\
#let compt = $attach(supset.eq, bl: t)$
#let compm = $attach(supset.eq, bl: m)$

To describe the relationships between types and their memebers, we define two relations, member compatibility, #compm, and type compatibility #compt. Both of these relations are defined in terms of the other.

_Member Compatibility_ \
For $x, y$, which are members $x #compm y <=>  x.N = y.N and x.R #compt y.R and |x.A| = |y.A| and y.A_i #compt x.A_i forall i in [1, |x.A| ]$\
In other words, a member $x$ is compatible with another member $y$ if and only if they have the same, the return type of $x$ is compatible with the return type of $y$, they have the same number of arguments, and each argument type of $y$ is compatible with the corresponding argument type of $x$. 

_Type Compatibility (Member Set Compatibility)_ \
For $A, B$, which are types, $A #compt B <=> forall a in A exists b in B$ s.t. $a #compm b$ \
In other words, a type $A$ is compatible with another type $B$ if and only if all of the members in $A$ have a member in $B$ that they are compatible with. 

