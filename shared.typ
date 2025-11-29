#let expand=[\[This section needs to be expanded\]]

#let section-link(title, subtitle, display) = underline(text(blue, display))
// [ #underline(text(blue, display)) (#title #if(subtitle!=""){ "> "; subtitle} ) ]

#let review(v) = text(fill:red, v)
