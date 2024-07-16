#lodge_implementation 

## Compiler Frontend
[[Lodge Parsing]]
	Preprocessor
	Tokenizer
	LR Parser

The compiler frontend takes as input a lodge source code file, and outputs that `.lift` file representing that lodge file. 


## Intermediate Format
[[Lodge Intermediate Format (.lift)]]
The intermediate representation represents individual lodge files rather than entire programs.

The purpose of the intermediate format is to hold all of the information that the compiler backend needs to produce a complete lodge program such as relevant parse trees, classes, interfaces, type unions, and information necessary for performing name binding, automatic interfacing and multi-file static type analysis. 

In the final compiler, this format will most likely not be saved to disk during the process. However, libraries will probably be stored and/or distributed in this format to reduce compilation overhead.


## Interpreter Backend
During the development process, an interpreter for lodge will likely be implemented. The purpose of this

The design of the language, however, is careful in ensuring that the language *can* be required with minimal runtime processing and a minimal runtime package needing to be included in compiled files.

Some of the code for this Interpreter could potentially be reused for the final compiler as well.

## Compiler Backend

An LLVM compiler backend is the goal of this project.
Because of the fact that LLVM includes well-developed optimization steps that I don't want to spend the time poorly recreating, the .lift format will most likely not include anything but the most basic optimizations.