#set text(font: "Inter", size: 1.25em, lang: "de")
// #show math.equation: set text(font: "Fira Math")
#set grid(column-gutter: 1em, row-gutter: 1em)
#set page(margin: 3em)
#set line(length: 100%)

#set math.mat(delim: "[")
#let map = math.op("Map")
#let span = math.op("Span")
#let ker = math.op("Ker")
#let img = math.op("Img")
#let mid = $mid(|)$
#let vspace = $cal(V)$
#let vspaceW = $cal(W)$
#let vspaceU = $cal(U)$
#let kvspace = [$K$-Vektorraum]
#let defspace = h(2em)
#let nxm = $n times m$
#let mxn = $m times n$
#let nxn = $n times n$

#align(center, text([Lineare Algebra], weight: "bold", size: 16pt))

#outline()

// apparently the outline header is a heading and so this must be here
#show heading.where(level: 1): content => [#pagebreak();#content]

= Grundlagen

== Abbildungen

sei $f: D -> Z$

- Injektivität
$
    forall x,y in D: f(x) = f(z) => x = y
$

- Surjektivität
$
    img f = Z\
    forall z in Z: exists x in D: z = f(x)
$

- Bijektivität: sowohl injektiv als auch surjektiv
$
    forall z in Z: exists_1 x in D: z = f(x)
$

= Vektorraum

elementare Operationen:

$
    arrow(x), arrow(y) in RR^2: vec(x_1, x_2) + vec(y_1, y_2) := vec(x_1 + y_1, x_2 + y_2)\
    alpha in RR: alpha dot vec(x_1, x_2) := vec(alpha x_1, alpha x_2)
$

#line()

sei Körper $K$

Elemente von K: Skalare, Element von #vspace: Vektoren

== Eigenschaften

#kvspace ist eine Menge #vspace mit Operationen
$
    vspace times vspace -> vspace, #defspace (x,y) & mapsto x + y \
     K times vspace -> vspace, #defspace (alpha,x) & mapsto alpha dot x
$

durch Addition von Vektoren bildet #vspace eine kommutative Gruppe. Es gilt:

#grid(
    columns: 2,
    [Kommutativität], $ forall x,y in vspace: x + y = y + x $,
    [Assoziativität], $ forall x,y,z in vspace: (x+y) + z = x + (y+z) $,
    [neutrales Element], $ exists 0 in vspace: forall x in vspace: x + 0 = x $,
    [inverses Element], $ forall x in vspace: exists -x in vspace: x + (-x) = 0 $,
)

dazu: $forall x,y in vspace, alpha, beta in K$:
$
         alpha dot (x + y) & = alpha dot x + alpha dot y \
      (alpha + beta) dot x & = alpha dot x + beta dot x \
    (alpha dot beta) dot x & = alpha dot (beta dot x) \
                   1 dot x & = x
$

und

$
    forall x in vspace: 0_K dot x = 0_vspace
$

== Linearkombination

sei #kvspace #vspace, Vektoren $x_1,...,x_n in vspace$, Skalare $alpha_1,...,alpha_n in K$:

$
    sum^n_(k=1) alpha_k x_k in vspace
$
ist eine Linearkombination der Vektoren $x_1,...,x_n in vspace$

== Vektorraum von Abbildungen

/*
Menge aller reellen Funktionen $f: RR -> RR$ ist ein (reeler) Vektorraum, da
$
        (f+g)(x) & := f(x) + g(x) \
    (alpha f)(x) & := alpha dot f(x)
$
*/

sei #kvspace #vspace, Menge $M$

$vspace^M = map(M, vspace)$ (Menge der Abbildungen von M nach #vspace) durch Operationen
$
      +: && vspace^M times vspace^M -> vspace^M, defspace & (f+g): x mapsto f(x) + g(x) \
    dot: &&        K times vspace^M -> vspace^M, defspace & (alpha dot f): x mapsto alpha dot f(x)
$

ist $(vspace^M, + , dot)$ ein #kvspace

== lineare Abbildung

sei #kvspace $vspace, vspaceW$ (über dem gleichen Körper)

$
    F: vspace -> vspaceW, defspace v mapsto F(v)
$
$F$ ist eine lineare Abbildung, wenn
- $F$ ist ein Gruppen-Homomorphismus von $(vspace,+)$ nach $(vspaceW,+)$
$
    forall u,v in vspace: F(u + v) = F(u) + F(v)
$
- Homogenität
$
    forall v in vspace: forall alpha in K: F(alpha dot v) = alpha dot F(v)
$

Menge aller linearen Abbildungen von #vspace nach $vspaceW$:
$
    cal(L)(vspace, vspaceW) := {F: vspace -> vspaceW mid F "ist linear"}
$

=== Verkettung

seien $X,Y,L$ Vektorräume über demselben Körper $K$, $F: X -> Y, G: Y -> Z$ linear

dann ist
$
    (G circle.small F): X -> Z. defspace x mapsto (G circle.small F)(x) := G(F(x))
$
ebenfalls eine lineare Abbildung

=== lineare Abbildungen und Linearkombinationen

Eine Abbildung $F: vspace -> vspaceW$ zwischen $K$-Vektorräumen ist genau dann linear, wenn
$
    forall u,v in vspace: forall alpha, beta in K: F(alpha u + beta v) = alpha F(u) + beta F(v)
$

Außerdem gilt:
$
    forall F in cal(L)(vspace, vspaceW): forall n in NN: forall v_1,..., v_n in vspace: forall alpha_1,...,alpha_n in K: F(sum^n_(j=1) alpha_j v_j) = sum^n_(j=1) alpha_j F(v_j)
$

=== inverse lineare Abbildungen

Bijektivität:
$
    f: D -> Z: forall z in Z: exists_1 x in D: f(x) = z
$

Dann existiert die inverse Abbildung $f^(-1)$ zu f mit
$
    forall x in D: f^(-1)(f(x)) = x and forall z in Z f(f^(-1)(z)) = z
$

$f$ muss nicht linear sein

Falls $f$ linear ist, ist $f^(-1)$ ebenfalls linear

seien #vspace und #vspaceW lineare Abbildungen über $K$, $F in cal(L)(vspace, vspaceW)$ bijektiv\
$F^(-1) : vspaceW -> vspace$ ist linear

=== Bild

seien #vspace, #vspaceW Vektorräume über demselben Körper K, $F: vspace -> vspaceW$ linear

$
    img F := {F(x) mid x in vspace} subset.eq vspaceW
$

Das Bild gibt an, welche Vektoren von der Abbildung erreicht werden

=== Kern

seien #vspace, #vspaceW Vektorräume über demselben Körper K, $F: vspace -> vspaceW$ linear

$
    ker F :={x in vspace mid F(x) = 0} subset.eq vspace
$

der Kern darüber Auskunft, welche Vektoren zu einem einzigen Bild "zusammengefaltet" werden. Der Kern enthält dabei stets mindestens den Nullvektor.

=== Zusammenhang mit Nullvektoren

sei $F: vspace -> vspaceW$ linear

Es gilt
$
    F(0_vspace) = 0_vspaceW
$

und damit
$
    0_vspace in ker F
$

== Unterraum

sei #kvspace #vspace

Eine Teilmenge $vspaceU subset.eq vspace$ heißt Unterraum von #vspace ($vspaceU lt.eq vspace$), wenn gilt
+ $vspaceU != emptyset$
+ Menge #vspaceU enthält alle Linearkombination ihrer Vektoren
$
    forall x,y in vspaceU: forall alpha, beta in K: alpha x + beta y in vspaceU
$

triviale Unterräume
- ${0} lt.eq vspace$
- $vspace lt.eq vspace$

=== symmetrische Matrizen

sei Körper $K$

Im Vektorraum $K^nxn$ gibt es den Unterraum der symmetrischen Matrizen
$
    K^nxn_"sym" := {A in K^nxn mid A^T = A}
$

zudem existiert der Unterraum der schiefsymmetrischen Matrizen
$
    K^nxn_"skew" := {A in K^nxn mid A^T = -A}
$

=== Unterraum aus linearen Abbildungen

seien #vspace, #vspaceW zwei $K$-Vektorräume

Dann gilt
$
    cal(L)(vspace, vspaceW) lt.eq vspaceW^vspace
$

=== Schnitt von Unterräumen

sei #kvspace #vspace, Menge $J$, $(U_j)_(j in J)$ eine Familie von Unterräumen

Der Schnitt aller $U_j$ ist ein Unterraum von #vspace

$
    inter.big_(j in J) U_j := {v in vspace mid forall j in J: v in U_j} lt.eq vspace
$

Die Vereinigung zweier Unterräume $U_1 union U_2$ muss kein Unterraum von #vspace sein.

=== (linearer) Spann

auch: lineare Hülle; Erzeugnis von $M$

sei #kvspace #vspace, $M subset.eq vspace: M != emptyset$

$span M$ ist die Menge aller Linearkombination von Vektoren aus $M$
$
    span M := {x in V mid forall n in NN: forall u_1,...,u_n in M: forall alpha_1,...,alpha_n in K: x = sum^n_j=1 alpha_j u_j}
$

dabei $span emptyset = {0}$

=> kleinster Unterraum von #vspace, der $M$ enthält

=== Zusammenhang mit linearen Abbildungen

seien #vspace, #vspaceW zwei $K$-Vektorräume, $F in cal(L)(vspace, vspaceW)$

1. für $cal(X) lt.eq vspace$ ist sein Bild unter $F$ ein Unterraum
$
    F(cal(X)) = {F(x) mid x in cal(X)} lt.eq vspaceW
$
#h(1.25em) insbesondere gilt dies für das Bild von $F$
$
    img F = F(vspace) lt.eq vspaceW
$

2. für $scr(L) lt.eq vspaceW$ ist sein Urbild unter F ein Unterraum
$
    F^arrow.l scr(L) = {x in vspace mid F(x) in scr(L)} lt vspace
$
#h(1.25em) insbesondere gilt
$
    ker F = F^arrow.l ({0}) lt.eq vspace
$

3. die lineare Abbildung $F$ ist genau dann injektiv, wenn $ker F = {0}$ gilt

== Innenprodukträume

(Vektorraum mit Skalaren)

=== Orthogonalität

= Tupel

sei Menge $M$, natürliche Zahl $n in NN$ heißt eine Abbildung
$
    x:{1,...,n} -> M, #defspace k mapsto x_k
$
ein $n$-Tupel mit Einträgen aus $M$

Abkürzung: $x = (x_k)^n_(k=1)$

für Zahlentupel (mit Einträgen aus Körper $K$): $arrow(x) = (x_k)^n_(k=1)$. Darstellung als Zeile oder Spalte möglich.

Dabei $M^n := M^({1,...,n}) = map({1,...,n}, M)$ Menge aller $n$-Tupel

Einträge aus $M$ sind geordnete Liste vorgegebener Anzahl $n$ von Einträgen

== Rechnen

$M$ muss z.B. Körper sein

sei Körper $K$, $n in NN$

Dann ist $K^n$ durch
$
    arrow(x) + arrow(y) := (x_k + y_k)^n_(k=1), #defspace alpha dot arrow(x) := (alpha dot x_k)^n_(k=1)
$
für $arrow(x), arrow(y) in K^n, alpha in K$ erklärten Verknüpfungen ein Vektorraum

= Matrizen

sei Körper $K$, $n,m in NN$:
$
    K^nxm := K^({1,...,n} times {1,...,m}) = map({1,...,n} times {1,...,m}, K)
$
Menge der ($nxm$)-Matrizen mit Einträgen aus $M$

Matrix $A$ ist somit eine Abbildung
$
    A:{1,...,n} times {1,...,m} -> M, defspace (k,j) mapsto a_(k j)
$

Notation:
$
    A = (a_(k j))^(n,m)_(k=1,j=1) = mat(
        a_(1 1), ..., a_(a m);
        dots.v, dots.down, dots.v; a_(n 1), ..., a_(n m)
    )
$

=> $a_(y x)$ und $A^(y times x)$ ($A^("Zeilen" times "Spalten")$), *nicht* $a_(x y)$ und $A^(x times y)$

== Rechnen

sei Körper $K$, Matrizen $K^nxm$
$
                      forall A,B in K^nxm: & A + B        && := (a_(k j) + b_(k j))^(n,m)_(k=1, j=1) \
    forall lambda in K: forall A in K^nxm: & lambda dot A && := (lambda a_(k j))^(n,m)_(k=1,j=1)
$

=> $K^nxm$ ist ein #kvspace

=== Transposition

sei $A = (a_(j k))^(n,m)_(j=1,k=1) in K^nxm$
$
    A^T = (b_(k j))^(n,m)_(j=1,n=1) in K^mxn; b_(k j) = a_(j k)
$

=> Zeilen zu Spalten, Spalten zu Zeilen

=== Matrix-Tupel Multiplikation

sei Körper $K$

für Matrix $A = (a_(k l))^(m,n)_(k=1,l=1) in K^mxn$ und Tupel $arrow(x) = (x_l)^n_(l=1) in K^n$:
$
    A dot arrow(x) = mat(
        sum^m_(l=1) a_(1 l) x_l;
        dots.v;
        sum^m_(l=1) a_(n l) x_l
    ) = mat(sum^n_(l=1) a_(k l) x_l)^m_(k=1)
$

$A$ erzeugt dadurch eine Abbildung
$
    F_A: K^n -> K^m, defspace F_A(arrow(x)) := A dot arrow(x)
$

$F_A$ ist linear, also
$
    forall alpha, beta in K: forall arrow(x), arrow(y) in K^n: F_A(alpha arrow(x) + beta arrow(y)) = alpha F_A(arrow(x)) + beta F_A(arrow(y))
$

=== Matrix-Matrix Multiplikation

für $A in K^mxn, B in K^(mu times m)$ sei
$
    B dot A := mat(sum^m_(l=1) b_(j l) a_(l k))^(mu,n)_(j=1,k=1) in K^(mu times n)
$

Ausgeschrieben:
#image("Matrix-Matrix-Multiplikation.png")

Assoziativität gilt:
$
    forall A in K^(mu times m): forall B in K^mxn: forall C in K^(n times v): (A dot B) dot C = A dot (B dot C)
$

== Elementarmatrix

= lineare Gleichungssysteme

= Basen

== geordnete Basen von Koordinaten

== Existenz von Basen

== Dimension und Berechnung

== Quotientenraum und Dimensionsformeln

== Orthonormalbasen

== Orthogonalprojektion

== Darstellung von Linearprojektionen

= lineare Abbildungen

== geordnete Basen und Koordinaten

== lineare Abbildung in Koordinaten

= komplexe Zahlen

= Skalarprodukt und Normen

== Darstellung durch Matrizen

= Determinanten

== im dreidimensionalen, euklidischen Raum

== Konstruktion

== Berechnung

= Spektraltheorie

== Eigenvektor

== Eigenwerte

== Diagonalisierbarkeit

(Zerlegung in Eigenwerte)

== Hermitesche Endomorphismen

== normale Endomorphismen

== Anwendung

=== Drehung

=== Drehspiegelung

=== Funktionen von Endomorphismen


