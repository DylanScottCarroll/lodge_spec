```
fun quadratic(Float a, Float b, Flaot c) Float {
	Float disc := b**2 - 4*a*c
	return if disc >= 0 {
		(-b + (disc)**0.5  ) / (2 * a) 
	} else {
		-b / (2*a)
	}
}
```