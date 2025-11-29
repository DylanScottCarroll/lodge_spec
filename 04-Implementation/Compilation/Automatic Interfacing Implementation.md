 See: [[05 Automatic Interfacing]]

Automatic interface is achieved by comparing each interface in a given lodge program to each concrete type to determine if that class is [[04 Interface Compatibility|compatible]] with that interface. If the interface is compatible, an entry for that interface is placed into the [[Lodge ttable|ttable]] for that class.


The [[Lodge Intermediate Format (.lift)]] is an important component of this process, because each lift file contains a complete set of all interfaces defined in that code segment. Interfaces can come from explicit interface definition, but also through type unions When lift files are combined, those lists are joined together. During each LIFT merge, all typing information is joined together.


When a lift file is finally compiled into machine code, the process of automatic interfacing is finalized and types can be erased for the most part.

