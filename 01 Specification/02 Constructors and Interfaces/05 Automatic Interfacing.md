Automatic Interfacing is the process by which a class that doesn't explicitly promise an interface can still be used with that interface if it happens to implement. If, at compile time, a class's public interface is a superset of an interface or the public interface of another class, interface, type union, or type intersection, that class will implicitly promise that class/interface.

The result of automatic interfacing is that, objects can be placed into any container whose interface is a subset of that objects interface without needing to be explicitly declared. This is conveniently similar to duck typing while maintaining static type safety.

See [[04 Interface Compatibility]]