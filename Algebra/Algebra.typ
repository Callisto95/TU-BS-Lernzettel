#set text(font: "Inter", size: 1.25em, lang: "de")
#set line(length: 100%)
#set grid(column-gutter: 0.75em, row-gutter: 0.75em)
#set math.mat(delim: "[")
#set raw(tab-size: 4)
#let mid = $mid(|)$

#let ord = math.op("ord")
#let cyclic(content) = $chevron.l content chevron.r$

#outline()

#show heading.where(level: 1): content => [#pagebreak() #content]

= Notizen

- Monoid: assoziativ, neutrales Element
- Untermonoid: abgeschlossen, neutrales Element auch enthalten
- Gruppe: inverses Element
- Ring $(R,+,dot)$:
    - $(R,+)$ ist eine abelsche Gruppe mit $e = bb(0)$
    - $(R,dot)$ ist ein abelsches Monoid mit $e = bb(1)$
    - Distributivgesetz gilt $a dot (b + c) = a dot b + a dot c$
    - Integritätsbereich: Ring, der Nullteilerfrei ist
        - $a dot b = 0 => a = 0 or b = 0$
- Körper $(R,+,dot)$:
    - $(K,+)$ ist eine abelsche Gruppe
    - $(K,dot)$ ist ein Monoid
    - $K^times = K without {0}$
    - Nullteilerfrei: $a,b in K:a != 0 and b != 0 => a dot b != 0$
    - Regeln
        - $0 dot a = 0$
        - $a dot -1 = -1$
        - $(-a)^2 = a$
        - binomische Formeln gelten

$(x y)^(-1) = y^(-1) x^(-1)$

Ideal: $(I,+) <= (R,+) and forall r in R, i in I: r dot i in I$

Einheit $r in R$: $exists r^(-1) in R: r dot r^(-1) = 1$

Normalteiler $H lt.closed.eq G$:
- $forall a in G: a H = H a$
- $a H a^(-1) subset.eq H$

Homomorphismus $phi: G -> H$:
- $phi(e_G) = e_H$
- $phi(a circle.small b) = phi(a) circle.small phi(b)$
- ($phi(a^(-1)) = phi(a)^(-1)$)
- $ker phi = {a : phi(a) = bb(0)_H} <= G$ eines Gruppenhomomorphismus ist ein Normalteiler

In einem Ringhomomorphismus $phi: H -> G$
- $phi(bb(0)_H) = bb(0)_G$
- $phi(bb(1)_H) = bb(1)_G$

Gruppe $G$
- $forall g in G: g^0 = e$

zyklische Untergruppe
- $cyclic(a) = {a^n : n in ZZ}$
- $a^(-m) = (a^(-1))^m$

$ord()$:
- (endliche) Gruppe $G$: $ord(G)$ ist die Anzahl der Elemente in $G$ = die Mächtigkeit von $G$
- $a in G$: $ord(a)$ ist die Mächtigkeit von $cyclic(a)$
    - bei endlicher Gruppe $G$: $ord(a) = m: a^m = e$
- $a in G, cyclic(a) <= G$: $ord(cyclic(a)) divides ord(G)$
    - $a^ord(G) = e_G$

Index (sei $H <= G$) $(H:G)$: Menge der Linksnebenklassen von $H$ in $G$
- $(G:H) := \#(G slash H)$

zyklische Untergruppe
- $ord(a) = ord(cyclic(a))$
- $ord(a) = m != infinity: cyclic(a) = {a^0,a^1,...,a^(m-1)}$
- $cyclic(a)$ ist isomorph zu $(ZZ, +)$ oder $(ZZ slash m ZZ, +)$

Restklassengruppen
- Gruppe $(G,dot)$, Normalteiler $N lt.closed.eq G$
- Elemente der Restklassengruppe ($G slash N$) sind Nebenklassen von $N$ in $G$
    - $forall g in G: g N = {g dot n : n in N}$
- $(a N) star (b N) = (a dot b) N$
- $e = e N = N$
- $(a N)^(-1) = a^(-1) N$

Polynomring $R[x]$
-

Beispiel: $ZZ slash m ZZ = ZZ_m$:
- $(G,dot)$ spezifiziert durch $(ZZ,+)$, also $a N = {a + n : n in N}$
- Elemente der Restklassen:
    - $a = 0: a N = {0,m,-m,2m,-2m,...}$
    - $a = 1: a N = {1,1+m,1+-m,1+2m,1+-2m,...}$
    - $a = 2: a N = {2,2+m,2+-m,2+2m,2+-2m,...}$
    - ...
    - $a = m: a N = {m,2m,0,3m,-m,...} = 0 N$
    - $a = m+1: a N = {1+m,1+2m,1,1+3m,1+-m,...} = 1 N$
- somit werden Restklassen (${overline(0), overline(1),...,overline(m-1)}$) erzeugt
- Nullteiler:
    - $m in PP => ZZ slash m ZZ$ Nullteilerfrei
    - $m in.not PP$: $ZZ slash 6ZZ: overline(2) dot overline(3) = overline(6) = overline(0)$
- $ZZ_m$ ist eine Restklassengruppe und ein Restklassenring
    - $(ZZ_m, tilde(+))$ ist die Gruppe
        - $e_tilde(+) = overline(0)$
    - $(ZZ_m, tilde(+), tilde(dot))$ ist der Ring
        - $e_tilde(dot) = overline(1)$

modulare Arithmetik
- $a mod m + b mod m = a + b mod m$
    - $overline(a) tilde(+) overline(b) = overline(a + b)$
- $a mod m dot b mod m equiv a dot b mod m$
    - $overline(a) tilde(dot) overline(b) = overline(a dot b)$

= Algorithmen

#let tab = h(1em)
#let rreturn = text(weight: "bold", "return")
#let do = text(weight: "bold", "do")
#let wwhile = text(weight: "bold", "while")
#let end = text(weight: "bold", "end")
#let iif = text(weight: "bold", "if")
#let then = text(weight: "bold", "then")
#let eelse = text(weight: "bold", "else")

#let code(input, output, ..blocks) = {
    grid(
        columns: 2,
        text(weight: "bold", "Input: "), input,
        text(weight: "bold", "Output: "), output,
    )
    grid(
        columns: 2,
        align: (right, left),
        ..for index in range(0, blocks.len()) {
            (
                [#text([#(index + 1)], font: "Fira Code"):],
                blocks.at(index),
            )
        }
    )
}

== Faktorisierungsmethode von Fermat

#code(
    [ungerade, natürliche Zahl $n$],
    [Zwei Faktoren $a$ und $b$ von $n$],
    $x <- ceil(sqrt(n))$,
    $r <- x^2 - n$,
    $wwhile sqrt(r) in.not NN do$,
    $tab r <- (x + 1)^2 - n = x^2 + 2x + 1 - n = r + 2x + 1$,
    $tab x <- x + 1$,
    $end wwhile$,
    $y <- sqrt(r)$,
    $a <- x + y$,
    $b <- x - y$,
    $rreturn a,b$,
)

Eine Zahl $n$ wird in zwei Teiler $a$ und $b$ zerlegt.
Dabei muss $n$ eine ungerade, natürliche Zahl sein, da für diese gilt:
$
    forall n in NN: n "ist ungerade" => n = x^2 - y^2
$

== Fermatischer Primzahltest

#code(
    $N in NN$,
    ["$N$ ist nicht prim" oder "$N$ ist möglicherweise prim"],
    $a <- "random" (1 < a < N)$,
    $iif gcd(a, N) != 1 then$,
    $tab rreturn N "ist nicht prim"$,
    $eelse$,
    $tab iif a^(N - 1) equiv.not 1 mod N then$,
    $tab tab rreturn N "ist nicht prim"$,
    $tab eelse$,
    $tab tab rreturn N "ist möglicherweise prim"$,
    $tab end iif$,
    $end iif$,
)

#pagebreak()

== chinesischer Restsatz

Generell:

für $M_x$ und $m_x$:
#table(
    columns: 5,
    align: right,
    table.header($i$, $r_i$, $q_i$, $s_i$, $t_i$),
    $0$, $M_x$, $-$, $1$, $0$,
    $1$, $m_x$, $floor(M_0 slash m_1)$, $0$, $1$,
    $2$, $M_0 mod m_1$, $...$, $1$, $-m_x$,
    table.cell(colspan: 5, $...$, align: center),
    $i$,
    $M_(i-2) mod m_(i-1)$,
    $floor(M_(i-1) slash m_i)$,
    $s_(i-2) - q_(i-1) dot s_(i-1)$,
    $t_(i-2) - q_(i-1) dot t_(i-1)$,
    table.cell(colspan: 5, $...$, align: center),
    $j-1$, $1$, $a$, $b$, $c$,
    $j$, $0$, $-$, $-$, $-$,
)

$
    => b dot M_x + c dot m_x = 1
$

$
    s_i = s_(i-2) - q_(i-1) dot s_(i-1) \
    t_i = t_(i-2) - q_(i-1) dot t_(i-1) \
$

#line()

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

$
    a_0 dot e_0 + a_1 dot e_1 + a_2 dot e_2 \
    -1 dot 56 + 2 dot 120 + 3 dot 105 = 499 \
    499 mod M = 499 mod 280 = 219
$

= Theoreme

== kleiner Satz von Fermat

Sei $p in PP, a in ZZ$.
Dann gilt:
$
    a^p equiv a mod p
$

Gilt zusätzlich $gcd(a, p) = 1 <=> p divides.not a$ (und damit auch $a in ZZ^* = ZZ without 0$), dann gilt:
$
    a^(p-1) mod p = 1
$

=== Verallgemeinerung

Sei $G$ eine endliche Gruppe und $a in G$.
Es gilt:
$
    ord(a) divides ord(G) and a^(ord(G)) = e
$

=== Satz von Lagrange

Sei Gruppe $G$ endliche und $a in G$.
Es gilt:
$
    ord(a) divides ord(G)
$

== Satz von Lagrange

bei $H<=G$:

$ord(G) = ord(H) dot (G:H)$

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
       & sans("wähle") x = x^(-1) in X, y = y^(-1) in Y \
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

= Wolff 2025

== Aufgabe 5

=== 1

$overline(2) dot overline(5) = overline(10) = overline(0) = 0$

=> nicht Nullteilerfrei

=> kein Körper

=== 2

$overline(2) dot overline(6) = overline(12) = overline(2) in.not I$

=> es ist kein Ideal

=== 3

$R, {overline(0)}, {overline(0), overline(2), overline(4), overline(6), overline(8)}, {overline(0), overline(5)}$

=== 4

==== i

$(0,1) times.o (1,0) = ((0 dot 1),(1 dot 0)) = (0,0) = 0$

=> $S$ ist kein Körper

==== ii

$ker phi = {overline(0)}$

Untergruppe $(ker phi,+) <= (ZZ_10,+)$

Da $e_+ = 0$ und $ker phi = {0}$ ist $ker phi$ eine Gruppe bezüglich der Addition.

Idealeigenschaft $forall i in ZZ_10, j in ker phi: i dot j in ker phi$
$
    forall i in ZZ_10: i dot 0 = 0 \
    => i dot 0 = 0 in ker phi
$

= 2023

== 2

=== 3

$tau = (1 4 2)(5 3)$

$sigma^(-1) = (1 3 5 4 2)$

=== 4

$S_4$ mit $5 mapsto 5$

=== 5

==== i

+ $e$
+ $sigma_1$
+ $sigma_2$
+ $sigma_1 circle.small sigma_2$
+ $sigma_1 circle.small sigma_2 circle.small sigma_1$
+ $sigma_2 circle.small sigma_1 circle.small sigma_2$

==== ii

$ord(S_5) = ord(H) dot (S_5:H) <=> 120 = 6 dot (S_5:H) <=> 20 = (S_5:H)$

=== 3

==== 1

$
    g(2) = 0 => frac(x^3 - 2x^2 + 3x - 6, x-2) = x^2 + 3 \
    => g(x) = (x - 2)(x^2 + 3)
$

===== i

$K = RR$

$
    x^2 = -3
$
nicht in $RR$ möglich, also ist $g(x) = (x - 2)(x^2 + 3)$ die kleinste Faktorisierung.

===== ii

$K = CC$

$
    x^2 + 3 = 0 => x = plus.minus i sqrt(3) \
    => g = (x - 2)(x + i sqrt(3))(x - i sqrt(3))
$

===== iii

$K = ZZ_3$

$
    g = x^3 - 2x^2 + 3x - 6 <=> x^3 x^2 = x^2(x + 1)
$

==== 2

Nein :)

== 4

=== 1

z.Z. $phi_1(1) = phi_2(1) => phi_1 = phi_2$

$
    phi_1(2) = phi_1(1 + 1) = phi_1(1) + phi_1(1) = phi_2(1) + phi_2(1) = phi_2(2)
$

=== 2

==== i

Nein. $f(0) = 1$

==== ii

Nein. $25 = f(5) != f(4 + 1) = f(4) + f(1) = 16 + 1 = 17$

==== iii

Ja, da $f(0) = 0, f(1) = 1, f(2) = 8 equiv 2 mod 3$ und somit ist $f$ die Identitätsfunktion.

=== 3

==== i

$phi(0) = (0,0,0) = arrow(0) = 0$

$phi(a) + phi(b) = (a,2a,3a) + (b,2b,3b) = ((a + b),2(a + b),3(a + b)) = phi(a + b)$

Außerdem:

$(ZZ,+)$ sowie $(ZZ^3,plus.o)$ sind eine Gruppe.

Somit ist $phi$ ein Gruppenhomomorphismus.

==== ii

$H := {phi(z) : z in ZZ} = {(0,0,0),(1,2,3),(-1,-2,-3),(2,4,6),(-2,-4,-6),...}$

$H = {(1,2,3)^z : z in ZZ} = cyclic((1,2,3))$

$forall a,b in H: a plus.o b in H$:
$
    (m,2m,3m) plus.o (n,2n,3n) = ((m+n),2(m+n),3(m+n)) in H
$

$e in H$:
$
    0 in ZZ => (1,2,3) dot 0 = (0,0,0) = arrow(0) in H
$

inverse Elemente:
$
    forall a in ZZ: exists -a in ZZ\
    => forall a = (a,2a,3a) in H: exists -a = (-a,-2a,-3a) in H
$

#line()

Alternativ:

$cyclic((1,2,3)) subset.eq ZZ^3$, da
$
    forall a = (a,2a,3a) in H: exists a in ZZ => (a,2a,3a) in ZZ^3
$

==== iii

$K = {(0,0,0)} <= H$

== Aufgabe 6

=== 1

$
    k = deg(f), l = deg(g)\
    "sei" i_1 != 0, j_1 != 0 "und damit" i_1 dot j_1 != 0 "weil" R "Integritätsbereich" \
    f = i_1 x^k + ..., g = j_1 x^l + ... \
    f dot g = (i_1 dot j_1) x^(k + l) + ... \
    => deg(f dot g) = deg(f) + deg(l)
$

=== 2

$
    R = ZZ_4 \
    f = 2x, g = 2x \
    f dot g = 4 x^2 = 0 x^2 = 0
$

=== 3

$
    deg(1) = 0 \
    0 + 0 = deg(f) + deg(g) = deg(f dot g) \
    => f = x in R \
    => exists y in R: x dot y = 1, "wähle" g = y \
    => 1_R = x dot y, 1_(R[x]) = f dot g \
    "da" f = x, g = y => f in R, f in R[x], g in R, g in R[x]
$
