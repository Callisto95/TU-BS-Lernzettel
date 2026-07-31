#set text(font: "Inter", size: 1.25em, lang: "de")
#set line(length: 100%)
#set grid(column-gutter: 0.75em, row-gutter: 0.75em)
#set math.mat(delim: "[")

#let mid = $mid(|)$

#outline()

#show heading.where(level: 1): content => [#pagebreak() #content]

In Klausur
- Permutationsgruppe $S_n$
- Zyklenschreibweise
- chinesischer Restsatz
- Gruppenhomomorphismus
    - ker, img, injektivität, surjektivität
- Polynomringe
- euklidischer Algorithmus

= Beispielklausur

== Aufgabe 1: chinesischer Restsatz

$
    x equiv && -1 & mod 5 \
    x equiv &&  2 & mod 7 \
    x equiv &&  3 & mod 8
$

$
    M = 5 dot 7 dot 8 = 280 \
    M_0 = 7 dot 8 = 56, M_1 = 5 dot 8 = 40, M_2 = 5 dot 7 = 35
$

$
    s_i = s_(i-2) - q_(i-1) dot s_(i-1) \
    t_i = t_(i-2) - q_(i-1) dot t_(i-1) \
$

#pagebreak()

für $M_0 = 56$ und $m_0 = 5$:
#table(
    columns: 5,
    align: right,
    table.header($i$, $r_i$, $q_i$, $s_i$, $t_i$),
    $0$, $56$, $-$, $1$, $0$,
    $1$, $5$, $11$, $0$, $1$,
    $2$, $1$, $5$, $1$, $-11$,
    $3$, $0$, $-$, $-$, $-$,
)

Somit
$
    1 dot 56 - 11 dot 5 = 1
$

für $M_1 = 40$ und $m_1 = 7$:
#table(
    columns: 5,
    align: right,
    table.header($i$, $r_i$, $q_i$, $s_i$, $t_i$),
    $0$, $40$, $-$, $1$, $0$,
    $1$, $7$, $5$, $0$, $1$,
    $2$, $5$, $1$, $1$, $-5$,
    $3$, $2$, $2$, $-1$, $6$,
    $4$, $1$, $2$, $3$, $-17$,
    $5$, $0$, $-$, $-$, $-$,
)

Somit
$
    3 dot 40 - 17 dot 7 = 1
$

für $M_2 = 35$ und $m_2 = 8$:
#table(
    columns: 5,
    align: right,
    table.header($i$, $r_i$, $q_i$, $s_i$, $t_i$),
    $0$, $35$, $-$, $1$, $0$,
    $1$, $8$, $4$, $0$, $1$,
    $2$, $3$, $2$, $1$, $-4$,
    $3$, $2$, $1$, $-2$, $9$,
    $4$, $1$, $2$, $3$, $-13$,
    $5$, $0$, $-$, $-$, $-$,
)

Somit
$
    3 dot 35 - 13 dot 8 = 1
$

$
    e_0 = 1 dot 56 = 56, e_1 = 3 dot 40 = 120, e_2 = 3 dot 35 = 105
$

#pagebreak()

$
    a_0 dot e_0 + a_1 dot e_1 + a_2 dot e_2 \
    -1 dot 56 + 2 dot 120 + 3 dot 105 = 499 \
    499 mod M = 499 mod 280 = 219
$
