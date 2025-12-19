#let publish = false

#let expand= if ( not publish ) {
  [\[This section needs to be expanded\]]
  } else { [] }

#let section-link(title, subtitle, display) = underline(text(blue, display))
// [ #underline(text(blue, display)) (#title #if(subtitle!=""){ "> "; subtitle} ) ]

#let review(v) = text(fill:red, v)
