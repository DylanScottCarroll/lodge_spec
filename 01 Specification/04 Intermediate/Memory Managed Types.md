#syntax_question

By default, constructors automatically allocate just the amount of memory needed for the fields they contain. However, there are some cases in which the programmer might want more control over the memory used for the sake of efficiency.

```
struct IntArray(Int length) {
	Data<length*4> data

	fun [get] None!(Int index) {
		return data[index:index+1]! ->Int 
	}
	
	fun [set] None!(Int index, Int val) {
		var bytes = Int->Byte
		loop for i := (index*4):(index*4+4):4 { data[i] = bytes }
	}
}
```

#expand