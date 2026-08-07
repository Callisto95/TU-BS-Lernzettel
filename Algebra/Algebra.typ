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

In Klausur
- Permutationsgruppe $S_n$
- Zyklenschreibweise
- chinesischer Restsatz
- Gruppenhomomorphismus
    - ker, img, injektivität, surjektivität
- Polynomringe
- euklidischer Algorithmus
// - Fermatische Faktorisierung

= Notizen

- Monoid: assoziativ, neutrales Element
- Untermonoid: abgeschlossen, neutrales Element auch enthalten
- Gruppe: inverses Element

$(x y)^(-1) = y^(-1) x^(-1)$

Ideal: $(I,+) <= (R,+): forall r in R, i in I: r dot i in I$

Homomorphismus: $phi: G -> H, phi(e_G) = e_H$, $phi(a b) = phi(a) phi(b)$ ($phi(a^(-1)) = phi(a)^(-1)$)

Ring: $exists bb(1)$ bezüglich der Multiplikation, Multiplikation ist kommutativ

$ker phi$ eines Gruppenhomomorphismus ist ein Normalteiler

In einem Gruppenhomomorphismus $phi: H -> G$
- $phi(bb(0)_H) = bb(0)_G$
- $phi(bb(1)_H) = bb(1)_G$

Gruppe $G$
- $forall g in G: g^0 = e$

Ring $(R,+,dot)$
- $forall r in R: bb(0) dot r = bb(0)$

$ord()$:
- (endliche) Gruppe $G$: $ord(G)$ ist die Anzahl der Elemente in $G$ = die Mächtigkeit von $G$
- $a in G$: $ord(a)$ ist die Mächtigkeit von $cyclic(a)$
    - bei endlicher Gruppe $G$: $ord(a) = m: a^m = e$
- $a in G, cyclic(a) <= G$: $ord(cyclic(a)) divides ord(G)$
    - $a^ord(G) = e_G$

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

== Sieb des Eratosthenes

== chinesischer Restsatz

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
