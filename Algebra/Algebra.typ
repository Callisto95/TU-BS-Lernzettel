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

= Notizen

Monoid: assoziativ, neutrales Element

Untermonoid: abgeschlossen, neutrales Element auch enthalten

Gruppe: inverses Element

$(x y)^(-1) = y^(-1) x^(-1)$

Ideal: $(I,+) <= (R,+): forall r in R, i in I: r dot i in I$

Homomorphismus: $phi: G -> H, phi(e_G) = e_H$, $phi(a b) = phi(a) phi(b)$ ($phi(a^(-1)) = phi(a)^(-1)$)

Ring: $exists bb(1)$ bezüglich der Multiplikation, Multiplikation ist kommutativ

$ker phi$ eines Gruppenhomomorphismus ist ein Normalteiler

In einem Gruppenhomomorphismus $phi: H -> G$
- $phi(bb(0)_H) = bb(0)_G$
- $phi(bb(1)_H) = bb(1)_G$

Ring $(R,+,dot)$
- $forall r in R: bb(0) dot r = bb(0)$

= Beispielklausur

== Aufgabe 1: chinesischer Restsatz

$
    x equiv && -1 & mod 5 \
    x equiv &&  2 & mod 7 \
    x equiv &&  3 & mod 8
$
$
    => a_0 = -1, m_0 = 5, a_1 = 2, m_1 = 7, a_2 = 3, m_2 = 8
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

== Aufgabe 3: Beweis

Sei $G$ eine Gruppe und $X,Y <= G$ Untergruppen von $G$.

z.Z.: $X Y = {x y : x in X, y in Y} subset.eq G$ ist eine Untergruppe von $G$, genau dann wenn $X Y = Y X$.

#sym.triangle.r.small $X Y <= G => X Y = Y X$:

$
       & x y in X Y \
    => & (x y)^(-1) = y^(-1) x^(-1) in X Y \
       & sans("wähle") x = x^(-1) in X Y, y = y^(-1) in X Y \
       & x^(-1) y^(-1) in X Y \
    => & (x^(-1) y^(-1))^(-1) = (y^(-1))^(-1) (x^(-1))^(-1) = y x in X Y \
    => & Y X = X Y
$

#sym.triangle.r.small $X Y = Y X => X Y <= G$:

z.Z.:
- $X Y$ ist abgeschlossen
- $forall a in X Y: a^(-1) in X Y$
- $e in X Y$

#sym.triangle.r.small.filled $e in X Y$

$
    e in X, e in Y \
    => e e = e in X Y = Y X \
$

#sym.triangle.r.small.filled $forall a in X Y: a^(-1) in X Y$

$
    x in X, y in Y => x y in X Y \
    x^(-1) in X, y^(-1) in Y => x^(-1) y^(-1) in X Y \
    a = x y in X Y => a^(-1) = (x y)^(-1) = y^(-1) x^(-1) in Y X = X Y
$

#pagebreak()

#sym.triangle.r.small.filled Abgeschlossenheit

$
    a = x y in X Y, b = v w in X Y \
    a b = (x y) (v w) = x (y v) w \
    [X(Y X)Y]=[X(X Y)Y]
$

da $X Y = Y X: y v in Y X => exists c = y'v' in X Y, y' in X, v' in Y$:

$
    x (y' v') w = (x y')(v' w)
$
da $x in X, y' in X: x y' in X$ und $y in Y, v' in Y$:
$
    exists p = x y' in X, exists q = y v' in Y
$

$
    p q in X Y
$

=> Somit ist $X Y <= G$.

= Hausaufgabenblatt 11

== 11.1

=== 11.1.1

Ideal:
$
    (I,+) <= (R,+) \
    forall r in R, i in I: r dot i in I
$

Aus Aufgabe 6.1.2: $ker phi lt.closed.eq R$ und damit auch $(ker phi,+) <= (R,+)$ und #linebreak() $forall r in R: r dot ker phi = ker phi dot r$.

z.Z.: $forall r in R, forall i in ker phi: r dot i in ker phi$

sei $r in R, i in ker phi$:
$
    phi(r dot i) = phi(r) dot.o phi(i) = phi(r) dot.o bb(0)_R' = bb(0)_R'
$
Somit ist $phi(r dot i) = bb(0)_R' in ker phi$

=> $ker phi$ ist ein Ideal in $R$
