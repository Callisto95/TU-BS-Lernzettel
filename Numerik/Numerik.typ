#set text(font: "Inter", size: 1.25em, lang: "de")
// #show math.equation: set text(font: "Fira Math")
#show link: set text(fill: blue)
#set grid(column-gutter: 1em, row-gutter: 1em)
#set page(margin: 3em)
#set line(length: 100%)

#align(center, text([Numerik], weight: "bold", size: 16pt))

#outline()

// apparently the outline header is a heading and so this must be here
#show heading.where(level: 1): content => [#pagebreak();#content]

= Fehler

Fehler:
$
    x - tilde(x)
$

Absoluter Fehler:
$
    abs(x - tilde(x))
$

Relativer Fehler:
$
    cases(frac(abs(x - tilde(x)), abs(x)) #h(2em) & \, x != 0, 0 & \, x = tilde(x) = 0, infinity & \, x = 0\, tilde(x) != 0)
$

$
    op("erf")(t) = 2/pi integral^1_0 e^(-x^2) d x
$

= Konvergenzraten


