*Goals*\
The Lodge Programming Language, as it is described in this text, _does not exist_. Ultimately, the goal of this document is to outline the syntax, and semantics of Lodge thoroughly enough to guide the implementation of an eventual compiler. The creation of this document itself is part of the language design process, acting as a assemblage of my current thoughts of what Lodge will be. Because of that, this document is fundamentally a work-in-progress and will be until the compiler is done. It has various mistakes, inconsistencies, and notes to the author.

Additionally, the deficiencies of the author reveal themselves in numerous places. Oftentimes, descriptions of Lodge's semantics and type system are lacking theoretical grounding and misuse vocabulary and notation; purists be warned.

*Style*\
This document is written in a style as similar as possible to a guide for an existing programming language and acts, for the most part, as if an implementation of Lodge exists. It presents information in an order aiming to be useful to someone who would be learning the language and demonstrates syntax largely through example.

This document starts out by describing the basics of syntax before moving on to what is arguably more interesting: descriptions of Lodge's type system in a more theoretical way. If you don't care about syntax and want to learn about the type system, skip to part 2.

*Plans*\
During what will likely end up being by very slow and sporadic compiler implementation, this document will be continuously updated to match the most up-to-date state of the language with the hope that, at such time as there is anything approaching a functional implementation, this document will act as a complete guide and specification for that language.  