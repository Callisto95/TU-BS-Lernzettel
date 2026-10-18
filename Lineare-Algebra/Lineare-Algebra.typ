#set text(font: "Inter", size: 1.25em, lang: "de")
// #show math.equation: set text(font: "Fira Math")
#show link: set text(fill: blue)
#set grid(column-gutter: 1em, row-gutter: 1em)
#set page(margin: 3em)
#set line(length: 100%)

#set math.mat(delim: "[")
#let Map = math.op("Map")
#let Span = math.op("Span")
#let Ker = math.op("Ker")
#let Img = math.op("Img")
#let Ran = Img
#let Pol = math.op("Pol")
#let Sol = math.op("Sol")
#let Eig = math.op("Eig")
#let Spec = math.op("Spec")
#let vecnorm = content_ => $bar.v.double #content_ bar.v.double$

#let mid = $mid(|)$

#let nxm = $n times m$
#let mxn = $m times n$
#let nxn = $n times n$
#let mxm = $m times m$

#align(center, text([Lineare Algebra], weight: "bold", size: 16pt))

#outline()

// apparently the outline header is a heading and so this must be here
#show heading.where(level: 1): content => [#pagebreak();#content]
