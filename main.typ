#set text(font: "Noto Sans")

#let ver = "0.0.1*"

#let to-string(it) = {
  if type(it) == str {
    it
  } else if type(it) != content {
    str(it)
  } else if it.has("text") {
    it.text
  } else if it.has("children") {
    it.children.map(to-string).join()
  } else if it.has("body") {
    to-string(it.body)
  } else if it == [ ] {
    " "
  }
}

#show raw.where(block:true): r => align(center, box(r, stroke: 0.5pt, inset: 1em))
  

#show heading.where(level:1): it => [
  #pagebreak()
  #set text(size: 32pt, weight: "light")
  #align(center+horizon)[#it]
  #set text(size: 12pt, weight: "regular")
  #linebreak()
]

#show heading.where(level:2): it => [
  #set text(size: 18pt, weight: "regular")
  #it
]

#show heading.where(level:3): it => [
  #set text(size: 14pt, weight: "regular" )
  #underline[#it]
]

#show heading.where(level:4): it => [
  #set text(size: 12pt, weight: "semibold")
  #it
]



#let heading_states = for i in range(1, 6) {
  (state("heading_name_" + str(i), ""), )
}

#show heading: it => [ 
  #it
  #heading_states.at(it.level).update(to-string(it.body))
  #for i in range(it.level+1, 5) {
    heading_states.at(i).update("")
  }
  #label(
    (for i in range(1, it.level) {
      heading_states.at(i).get() + "."
    } + to-string(it.body)).replace(" ", "_")
  )
]


#show link: it => {text(fill: blue, it)}


#align(center+horizon, text(size: 26pt)[
  The Lodge Programming Language \
  (Hypothetically)\
  #set text(0.6em)
  Version #ver
  #v(10em)
])

#align(center+bottom, text(size:  18pt)[
  Dylan Scott Carroll
])


#set page(header: context [
  #set text(fill:gray, size: 9pt)
  #{
    for i in range(1, 4) {
      if (heading_states.at(i).get() == "") {break}
      if (i!=1){" > "}else{""} + heading_states.at(i).get()
    }
  }
])

#set page(footer: context [
  #set text(fill:gray, size: 9pt)
  The Lodge Programming Language
  #h(1fr)
  Version #ver
  #h(1fr)
  #counter(page).display()
])


#outline(depth:2)

= Preface
#include "00 Preface.typ"

= Basics 

== Statements
#include "01 Basics/Statements.typ"

== Comments
#include "01 Basics/Comments.typ"

== Variables
#include "01 Basics/Variables.typ"

== Built-In Types
#include "01 Basics/Built-In Types.typ"

== Type Expressions
#include "01 Basics/Type Expressions.typ"

== Operators
#include "01 Basics/Operators.typ"

== Control Flow
#include "01 Basics/Control Flow.typ"

== Loops
#include "01 Basics/Loops.typ"


== Functions
#include "01 Basics/Functions.typ"

// = Reserved Keywords
// #include "01 Basics/Reserved Keywords.typ"

== Constructors
#include "01 Basics/Constructors.typ"

== Interfaces
#include "01 Basics/Interfaces.typ"

== Built-in Interfaces
#include "01 Basics/Built-In Interfaces.typ"



= The Type System

== The Lodge Type Checker
#include "02 Typing/Type Checking.typ"

== Interface Compatibility
#include "02 Typing/Interface Compatibility.typ"

== Function Interfaces
#include "02 Typing/Interface of a Function.typ"

== Type Set Operations
#include "02 Typing/Type Set Operations.typ"

== Type Unions
#include "02 Typing/Type Unions.typ"

== Type Intersections
#include "02 Typing/Type Intersections.typ"

== Interface Set Operations
#include "02 Typing/Interface Set Operations.typ"

== Interface Intersection
#include "02 Typing/Interface Intersection.typ"


== Interface Union
#include "02 Typing/Interface Union.typ"

== Errable and Nonable Types
#include "02 Typing/Errable and Nonable Types.typ"

== Type Switching
#include "02 Typing/Type Switching.typ"

// == Formalization
// #include "02 Typing/Formalization.typ"



= Intermediate

== Scoping Rules
#include "03 Intermediate/Scoping Rules.typ"

== Enums
#include "03 Intermediate/Enums.typ"


== With Statements
#include "03 Intermediate/With Statements.typ"

== Broadcasting
#include "03 Intermediate/Broadcasting.typ"

== Closures
#include "03 Intermediate/Closures.typ"

== Error Handling
#include "03 Intermediate/Error Handling.typ"

== Imports
#include "03 Intermediate/Imports.typ"

== Include Statements
#include "03 Intermediate/Include Statements.typ"

== Memory Managed Types
#include "03 Intermediate/Memory Managed Types.typ"
