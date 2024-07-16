#lodge_spec 


I am considering two kinds of exception handling in Lodge:
1. Something more like python where an exception will roll up the stack until it encounters a catch
2. Exceptions are a special type that can fit into any variable, but will result in an exception when any operation is performed on them

#lodge_hole