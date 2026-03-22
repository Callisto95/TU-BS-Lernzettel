#set text(font: "Inter", size: 1.25em, lang: "de")
// #show math.equation: set text(font: "Fira Math")
#set grid(column-gutter: 1em, row-gutter: 1em)
#set page(margin: 3em)
#set line(length: 100%)

#set math.mat(delim: "[")
#let Map = math.op("Map")
#let Span = math.op("Span")
#let Ker = math.op("Ker")
#let Img = math.op("Img")
// Ran: "Bildraum" einer Matrix
// = Img
#let Ran = Img
#let Pol = math.op("Pol")
#let Sol = math.op("Sol")
#let Eig = math.op("Eig")
#let Spec = math.op("Spec")
#let vecnorm = content_ => $bar.v.double #content_ bar.v.double$

#let mid = $mid(|)$
#let vspace = $cal(V)$
#let vspaceW = $cal(W)$
#let vspaceU = $cal(U)$
#let kvspace = [$K$-Vektorraum]
#let defspace = h(2em)

#let nxm = $n times m$
#let mxn = $m times n$
#let nxn = $n times n$

// TODO: dimensionenformel, unterräume überprüfen, orthogonalität, normalvektor

#align(center, text([Lineare Algebra], weight: "bold", size: 16pt))

#outline()

// apparently the outline header is a heading and so this must be here
#show heading.where(level: 1): content => [#pagebreak();#content]

= Grundlagen

== Polynom dritten Grades

1. Nullstelle raten ($x_1 = s$)
2. Polynomdivision mit $P : (x - s)$

== PQ

$
                0 & = x^2 + p x + q \
    x_(1 slash 2) & = - p/2 plus.minus sqrt((p/2)^2 - q)
$

== binomische Formeln

$
            (a+b)^2 & = a^2 + 2 a b + b^2 \
            (a-b)^2 & = a^2 - 2 a b + b^2 \
    (a+b) dot (a-b) & = a^2 - b^2
$

== Abbildungen

sei $f: D -> Z$

- Injektivität
$
    forall x,y in D: f(x) = f(z) => x = y
$

- Surjektivität
$
    Img f = Z\
    forall z in Z: exists x in D: z = f(x)
$

- Bijektivität: sowohl injektiv als auch surjektiv
$
    forall z in Z: exists_1 x in D: z = f(x)
$

== Gauß-Algorithmus

=== reduzierte Zeilenstufenform

- Pivots sind 1
- alle Einträge über den Pivots sind 0

== Matrix invertieren

- Einheitsmatrix rechts von $A$
- Einheitsmatrix auf der linken Seite erzeugen

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

$vspace^M = Map(M, vspace)$ (Menge der Abbildungen von M nach #vspace) durch Operationen
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

// [Zettel]
$F$ ist eine lineare Abbildung, wenn
- $F$ ist ein Gruppen-Homomorphismus von $(vspace,+)$ nach $(vspaceW,+)$
$
    forall u,v in vspace: F(u + v) = F(u) + F(v)
$
- Homogenität
$
    forall v in vspace: forall alpha in K: F(alpha dot v) = alpha dot F(v)
$
Schnelle Überprüfung der Linearität:
$
    F(arrow(0)) = arrow(0)
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

==== Überprüfung der Linearität

// [Zettel]

0. Vereinfachung des Polynoms (optional)
    - Ausklammern
    - binomische Formeln
    - ...
0. Überprüfung des Nullvektors
    - schnelle Überprüfung, ob Linearität überhaupt existiert
    - kein Nachweis
    - Nullvektor einsetzen
    - $
            phi(0) = cases(0: "Linearität möglich", 1: "Linearität unmöglich")
        $
1. Überprüfung der Additivität
    0. Definition: $phi(x + y) = phi(x) + phi(y)$
    1. Wähle 2 Matrizen $M_1: alpha_1, beta_1, delta_1,...; M_2: alpha_2, beta_2, delta_2,...$
    2. Berechnung von $phi(M_1 + M_2)$
    3. Berechnung von $phi(M_1) + phi(M_2)$
    4. Vergleich: Sind 2. und 3. Identisch?
2. Überprüfung der Homogenität (Multiplikation / Skalar)
    0. Definition: $phi(lambda dot x) = lambda phi(x)$
    1. Wähle Matrix $M: alpha, beta, gamma,...; lambda in K$
    2. Berechnung von $phi(lambda dot M)$
    3. Berechnung von $lambda dot phi(M)$
    4. Vergleich: sind 2. und 3. Identisch?

#pagebreak()

=== Darstellungsmatrix

// [Zettel]

==== Matrix-Matrix

Die Darstellungsmatrix $[F]^B_C$ beschreibt eine lineare Abbildung zwischen zwei Vektorräumen in Form einer Matrix.

Dabei ist $B$ die Basis der Urmenge und $C$ die Basis der der Zielmenge.

#line()

Beispiel:\
sei
$
    F: B -> C, defspace F: (x,y) mapsto (2x, x+y)\
    "Basen" B: {vec(1, 0), vec(0, 1)}, "Basen" C: {vec(1, 1), vec(1, 0)}
$
dann
$
    F(b_1) = vec(2, 1), F(b_2) = vec(0, 1) -> mat(2, 0; 1, 1) = M_I
$
$M_I$ durch Basen von $C$ darstellen:
$
    vec(2, 1) = alpha_1 vec(1, 1) + beta_1 vec(1, 0); vec(0, 1) = alpha_2 vec(1, 1) + beta_2 vec(1, 0)\
    => alpha_1 = 1, beta_1 = 1, alpha_2 = 1, beta_2 = -1
$
Zusammenfassung in Matrix:
$
    mat(1, 1; 1, -1) = [F]^C_B
$

#line()

bei $M^B_B$: reduzierte Zeilenstufenform

#pagebreak()

===== ohne gegebene Basen

// [Zettel]

sei
$
    phi: RR^(2 times 2) -> RR^(2 times 2), defspace A mapsto A dot mat(1, 2; 3, 4)
$

Basis: *Standardbasis* von $RR^(2 times 2)$
$
    E_(1 1) = mat(1, 0; 0, 0), E_(1 2) = mat(0, 1; 0, 0), E_(2 1) = mat(0, 0; 1, 0), E_(2 2) = mat(0, 0; 0, 1)
$

einsetzen:
$
    phi(E_(1 1)) = & mat(1, 2; 0, 0) \
    phi(E_(1 2)) = & mat(3, 4; 0, 0) \
    phi(E_(2 1)) = & mat(0, 0; 1, 2) \
    phi(E_(2 2)) = & mat(0, 0; 3, 4)
$

Daraus entsteht die Darstellungsmatrix:
$
    mat(1, 3, 0, 0; 2, 4, 0, 0; 0, 0, 1, 3; 0, 0, 2, 4)
$

#pagebreak()

==== Vektor

// [Zettel]

Bestimmen sie die Darstellungsmatrix von $phi$ bezüglich der Einheitsbasis

dabei:\
$phi$ ist die Orthogonalprojektion auf den Unterraum aufgespannt durch $arrow(u) = vec(1, -3)$

=> eindimensionaler Unterraum

Also: $P = frac(u u^T, u^T u)$

hier also:
$
    u^T u = & 1 + 9 = 10 \
    u u^T = & mat(1, -3; -3, 9) \
        P = & frac(1, 10) mat(1, -3; -3, 9)
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

#pagebreak()

=== Bild

seien #vspace, #vspaceW Vektorräume über demselben Körper K, $F: vspace -> vspaceW$ linear

$
    Img F := {F(x) mid x in vspace} subset.eq vspaceW
$

Das Bild gibt an, welche Vektoren von der Abbildung erreicht werden

=== Kern

seien #vspace, #vspaceW Vektorräume über demselben Körper $K$, $F: vspace -> vspaceW$ linear

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

$Span M$ ist die Menge aller Linearkombination von Vektoren aus $M$
$
    Span M := {x in V mid forall n in NN: forall u_1,...,u_n in M: forall alpha_1,...,alpha_n in K: x = sum^n_j=1 alpha_j u_j}
$

dabei $Span emptyset = {0}$

=> kleinster Unterraum von #vspace, der $M$ enthält

=== Zusammenhang mit linearen Abbildungen

seien #vspace, #vspaceW zwei $K$-Vektorräume, $F in cal(L)(vspace, vspaceW)$

1. für $cal(X) lt.eq vspace$ ist sein Bild unter $F$ ein Unterraum
$
    F(cal(X)) = {F(x) mid x in cal(X)} lt.eq vspaceW
$
#h(1.25em) insbesondere gilt dies für das Bild von $F$
$
    Img F = F(vspace) lt.eq vspaceW
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

= Polynome

== Rechnen

z.B.
$
    F: RR^(2 times 2) -> Pol^2_RR, defspace mat(alpha, beta; gamma, delta) mapsto "X"^2 + alpha + 2 delta "X" + beta ("X"^2 + 1) - ("X" - gamma)^2 + gamma^2 "X"^2
$

Das $"X"$ steht für die Variable des Polynoms (bei $f(x)$ das $x$, bei $h(z)$ das $z$)

// = Tupel

// sei Menge $M$, natürliche Zahl $n in NN$ heißt eine Abbildung
// $
//     x:{1,...,n} -> M, #defspace k mapsto x_k
// $
// ein $n$-Tupel mit Einträgen aus $M$

// Abkürzung: $x = (x_k)^n_(k=1)$

// für Zahlentupel (mit Einträgen aus Körper $K$): $arrow(x) = (x_k)^n_(k=1)$. Darstellung als Zeile oder Spalte möglich.

// Dabei $M^n := M^({1,...,n}) = Map({1,...,n}, M)$ Menge aller $n$-Tupel

// Einträge aus $M$ sind geordnete Liste vorgegebener Anzahl $n$ von Einträgen

// == Rechnen

// $M$ muss z.B. Körper sein

// sei Körper $K$, $n in NN$

// Dann ist $K^n$ durch
// $
//     arrow(x) + arrow(y) := (x_k + y_k)^n_(k=1), #defspace alpha dot arrow(x) := (alpha dot x_k)^n_(k=1)
// $
// für $arrow(x), arrow(y) in K^n, alpha in K$ erklärten Verknüpfungen ein Vektorraum

= Matrizen

// sei Körper $K$, $n,m in NN$:
// $
//     K^nxm := K^({1,...,n} times {1,...,m}) = Map({1,...,n} times {1,...,m}, K)
// $
// Menge der ($nxm$)-Matrizen mit Einträgen aus $M$

// Matrix $A$ ist somit eine Abbildung
// $
//     A:{1,...,n} times {1,...,m} -> M, defspace (k,j) mapsto a_(k j)
// $

Notation:
$
    A = (a_(k j))^(n,m)_(k=1,j=1) = mat(
        a_(1 1), ..., a_(a m);
        dots.v, dots.down, dots.v; a_(n 1), ..., a_(n m)
    )
$

=> $a_(y x)$ und $A^(y times x)$ ($A^("Zeilen" times "Spalten")$), *nicht* $a_(x y)$ und $A^(x times y)$

// == Rechnen

// sei Körper $K$, Matrizen $K^nxm$
// $
//                       forall A,B in K^nxm: & A + B        && := (a_(k j) + b_(k j))^(n,m)_(k=1, j=1) \
//     forall lambda in K: forall A in K^nxm: & lambda dot A && := (lambda a_(k j))^(n,m)_(k=1,j=1)
// $

// => $K^nxm$ ist ein #kvspace

// === Transposition

// sei $A = (a_(j k))^(n,m)_(j=1,k=1) in K^nxm$
// $
//     A^T = (b_(k j))^(n,m)_(j=1,n=1) in K^mxn; b_(k j) = a_(j k)
// $

// => Zeilen zu Spalten, Spalten zu Zeilen

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

== Basis

- gegeben ist Matrix $A$
- Matrix in reduzierter Zeilenstufenform
- Vektoren mit `1` sind unabhängig -> Index für Vektoren aus $A$

#line()

$
    A = & mat(2, 1, 3, 2; 4, 2, 1, 1; 8, 4, 17, 11) \
        & ... \
        & mat(1, 1/2, 0, 1/10; , -1, , 0; 0, 0, 1, 3/5; , 0, , -1)
$

Spalte 1 und 3 sind unabhängig -> Basis des Bildes ist
$
    {vec(2, 4, 8),vec(3, 1, 17)}
$

=== Basis des Kerns

// [Zettel]

- reduzierte Zeilenstufenform
- leere Zeilen mit -1 auffüllen
- Spalten mit -1 in der Diagonale sind Vektoren der Basis

=== Basis des Bildes

// [Zettel]

1. reduzierte Zeilenstufenform
    - Spalten mit 1 sind unabhängig und Indizes aus der unveränderten Matrix

ODER

2. Spalten zu Zeilen
    - in Zeilenstufenform
    - unabhängige Zeilen sind Basis

\2. auch bei "Bestimmen sie eine Basis des Bilds der Abbildung $mu_A: RR^5 -> RR^4, x mapsto A x$"

== Kern

- gegeben ist Matrix $A$
- Matrix in reduzierter Zeilenstufenform
- Vektoren nicht mit `1` sind nicht unabhängig -> Basis des Kerns von $A$

#line()

$
    A = & mat(2, 1, 3, 2; 4, 2, 1, 1; 8, 4, 17, 11) \
        & ... \
        & mat(1, 1/2, 0, 1/10; , -1, , 0; 0, 0, 1, 3/5; , 0, , -1)
$

Spalte 2 und 4 sind nicht unabhängig -> Basis des Kerns ist
$
    {vec(1, -2, 0, 0),vec(1, 0, 6, -10)}
$

== Elementarmatrix

= lineare Gleichungssysteme

// [Zettel]

$
    x in RR^3; A in RR^(3 times 4);"Basis von " Ker A: {vec(alpha_1, alpha_2, alpha_3, alpha_4),vec(beta_1, beta_2, beta_3, beta_4)}\
    Sol(A, arrow(x)) = {vec(x_1, x_2, x_3, 0) + s dot vec(alpha_1, alpha_2, alpha_3, alpha_4) + t dot vec(beta_1, beta_2, beta_3, beta_4) mid s,t in RR}
$

= Diagonalisierung

Matrix $A$

$
    S^(-1) A S & = D = mat(lambda_1, , 0; , dots.down, ; 0, , lambda_n) \
             A & = S D S^(-1) \
           A S & = S D
$

mit Einheitsvektoren $e_i$:

$
    A S e_i = S D e_i = S dot lambda_i e_i = lambda_i dot S e_i
$

dabei

$
    S e_i = arrow(x)_i
$

also

$
    A arrow(x)_i = lambda_i arrow(x)_i, arrow(x)_i != 0
$

#line()

$
    A = mat(-3, 4; 4, 3)
$

== Eigenwerte

(weiterhin im Beispiel Diagonalisierung)

$
    0 = det mat(-3 - lambda, 4; 4, 3 - lambda) = (-3 - lambda)(3 - lambda) - 16 = lambda^2 - 9 - 16 = lambda^2 - 25\
    -> lambda^2 = 25 <=> lambda = sqrt(25) <=> lambda = plus.minus 5
$

== Eigenvektor

(weiterhin im Beispiel Diagonalisierung)

zu $lambda = 5$:
$
           mat(-3 - (5), 4; 4, 3 - (5)) & = mat(-8, 4; 4, -2) \
    mat(-8, 4; 4, -2) dot vec(x_1, x_2) & = vec(0, 0)
$

da zwei nicht unabhängige Zeilen: ein Wert zu Parameter ($x = t$ oder $y = t$)\
hier: $y = t$
$
    -2 x + t = 0 <=> x = frac(1, 2) t\
    => arrow(x)_1 = vec(frac(1, 2) t, t) = t vec(frac(1, 2), 1), t in RR without {0} = t vec(1, 2), t in RR without {0}
$

erneute Rechnung für $lambda_2 = -5$

Aber hier: symmetrische Matrix. Also:
$
    arrow(x)_2 = vec(-2, 1)
$

-> $x,y$ tauschen, dann ein Vorzeichen verändern

$
    D = mat(5, 0; -5, 0), S = mat(1, -2; 2, 1), S^(-1) = frac(1, 5) mat(1, 2; -2, 1)\
    => A = frac(1, 5) mat(1, -2; 2, 1) mat(5, 0; 0, -5) mat(1, 2; -2, 1)
$

Da $D^m$ aus $lambda_1$ *dann* $lambda_2$ besteht, müssen die Zeilen von $S$ $arrow(x)_1$ *dann* $arrow(x)_2$ sein.

$
    A^m = S D^m S^(-1)
$

Diagonalmatrix hoch m:
$
    D^m = mat(d_11^m, ..., 0; 0, dots.down, 0; 0, ..., d_(n n)^m)
$

== charakteristisches Polynom

+ Vorzeichenwechsel bei allen Werten
+ in Hauptdiagonale $X - a_(i i)$, dann Determinante ausrechnen

#sym.arrow.squiggly Eigenwerte

== Determinante

=== Laplacescher Entwicklungssatz:

$
    mat(
        +, -, +, dots;
        -, +, -, dots;
        +, -, +, dots;
        dots, dots, dots, dots;
    )
$

bei $R^nxn$ Matrizen:

$
    n = 2:& det(mat(a_11, a_12; a_21, a_22)) = a_11 a_22 - a_21 a_12\
    n = 3:& det(mat(a_11 a_12 a_13; a_21 a_22 a_23; a_31 a_32 a_33)) = a_11 mat(a_22, a_23; a_32, a_33) - a_21 mat(a_12, a_13; a_32, a_33) + a_31 mat(a_12, a_13; a_22, a_23)
$

=== Regel von Sarrus

Diagonale zusammenrechnen, basierend auf Hauptdiagonale (addieren) und Nebendiagonale (subtrahieren)

$
    mat(a_11, a_12, a_13, a_11, a_12; a_21, a_22, a_23, a_21, a_22; a_31, a_32, a_33, a_31, a_32)
    #line(start: (-145pt, 0pt), end: (-65pt, 50pt), stroke: 1pt + green)
    #line(start: (-125pt, 0pt), end: (-45pt, 50pt), stroke: 1pt + green)
    #line(start: (-105pt, 0pt), end: (-25pt, 50pt), stroke: 1pt + green)
    #line(start: (-158pt, 50pt), end: (-82pt, 0pt), stroke: 1pt + red)
    #line(start: (-137pt, 50pt), end: (-61pt, 0pt), stroke: 1pt + red)
    #line(start: (-116pt, 50pt), end: (-40pt, 0pt), stroke: 1pt + red)
$

== Berechnung des Kerns

== lineare Unabhängigkeit / Basen

== Eigenräume

=== Matrix

$
    A = mat(1, 3, -3; 6, 4, -6; 3, 3, -5) in CC^(3 times 3), lambda = -2\
    A - (-2)bb(1) = mat(3, 3, -3; 6, 6, -6; 3, 3, -3) arrow.long_"Gauß" mat(1, 1, -1; , -1, ; , , -1)\
    => Eig(A, -2) = Span{vec(1, -1, 0), vec(-1, 0, -1)}
$

=== Vektor

#let vecU = $arrow(u)$
#let vecW = $arrow(w)$

sei Unterraum $U$ aufgespannt durch $arrow(u) = vec(1, -3)$ und $phi$ die Orthogonalprojektion auf $U$

Dann:
- $phi(vecU) = vecU$
- $vecW = vec(3, 1): phi(vecW) = arrow(0)$

Also $1,0 in Spec(phi)$ mit *Eigenvektoren* $vecU$ bzw. $vecW$

Da $dim EE_2 = 2$ bleibt nur $Eig(phi, 1) = Span{vecU}$ und $Eig(phi, 0) = Span{vecW}$

#pagebreak()

== Orthogonalprojektion

// [Zettel]

#let vecX = $arrow(x)$
#let vecB = $arrow(b)$
#let vecQ = $arrow(q)$

=== Grundlagen

$
    vecB^T vecB = abs(vecB)^2
$

==== Normierung eines Vektors

Vektor durch seine Länge teilen
$
    vecnorm(vecX) = frac(1, abs(vecX)) vecX
$

=== Vektor-Vektor

Generell:
$
    vecX_vecQ = & lambda dot vecQ \
    vecX_vecQ = & frac(vecX^T vecQ, abs(vecQ)^2) dot vecQ
$

=== Vektor-Matrix

$
    A = mat(1, 3, -3; 6, 4, -6; 3, 3, -5);vecX = vec(1, 2, -1); Eig(A, -2)
$

Bestimme Orthogonalprojektion von $vecX$ auf den Eigenraum $Eig(A, -2)$ zum Eigenwert $lambda = -2$ von A

Lösung:

- Hauptdiagonale in $A$ durch $- lambda$ ergänzen (durch $lambda = -2$: alle Einträge $+ 2$)
- $A$ durch Gauß-Algorithmus in reduzierte Zeilenstufenform
- Nullzeilen in der Hauptdiagonalen durch "-1" ersetzen und als Basis Nutzen.

$
    A arrow.squiggly mat(1, 1, -1; 0, 0, 0; 0, 0, 0) arrow.squiggly mat(1, 1, -1; , -1, ; , , -1) => Span {vec(1, -1, 0), vec(-1, 0, -1)}
$

==== Gram-Schmidt-Algorithmus

(weiter mit $A$ und $vec$ aus Vektor-Matrix)

Der Gram-Schmidt-Algorithmus dient dazu, aus einem beliebigen System von Vektoren ein Orthogonalsystem zu konstruieren.

Allgemein:

Für Ausgangsvektoren $v_1,...,v_n$ und orthogonale Vektoren $q_1,...,q_n$
$
    q_n = v_n - sum^(n-1)_(i=1) frac(v^T_n q_i, vecnorm(q_i)^2) q_i
$

dabei
$
    RR: vecnorm(vecX) = & sqrt(x_1^2 + ... + x_n^2)           && = abs(vecX) \
    CC: vecnorm(vecX) = & sqrt(abs(x_1)^2 + ... + abs(x_n)^2) &&
$

Teilweise auch $u_n$ anstatt $q_n$

=> $q_1 = v_1$\
=> $q_2 = v_2 - frac(v_2^T q_1, abs(q_1)^2) dot q_1$

=> $q_3 = v_3 - (frac(v_3^T q_1, abs(q_1)^2) dot q_1 + frac(v_3^T q_2, abs(q_2)^2) dot q_2)$\
=> $q_4 = ...$

- Brüche idealerweise Ausklammern

*Orthonogalprojektion ausrechnen*
$
    vecX_o = sum^n_(i=1) vecX_(vecQ_i) = sum^n_(i=1) frac(vecX^T vecQ_i, abs(vecQ_i)^2) dot arrow(q)_i
$

=== Orthogonalbasis

Die aus dem Gram-Schmidt-Algorithmus entstehenden Vektoren $q_1,...,q_n$:
$
    "OB" = Span{q_1,...,q_n}
$

=== Orthonormalbasis

Orthogonalbasis, wobei jeder Vektor die Länge 1 hat

#pagebreak()

== Vektor an Geraden

#let vecN = $arrow(n)$
#let vecR = $arrow(r)$
#let vecS = $arrow(s)$
#let vecV = $arrow(v)$
#let vecZ = $arrow(z)$
#let vecP = $arrow(p)$

=== Umformung der Geraden

Gerade gegeben durch
$
    G = {vecX in EE_2; 3x_1 - 2 = 5(x_2 + 1)}
$
Umformung zu
$
    G = {vecX in EE_2; 3x_1 - 5x_2 = 7} = {vecX in EE_2; chevron.l vecX, vecN chevron.r = 7}
$

- Normalenvektor $vecN = vec(3, -5)$

- Richtungsvektor $vecR = vec(5, 3)$

- Stützvektor $vecS = vec(4, 1)$

$
    => G = vecS + Span {vecR} = {vecS + alpha vecR; alpha in RR}
$

=== Vektor an Gerade anlegen

! Keine Spiegelung an der Geraden !

// [Zettel]

gesucht: Orthogonalprojektion von #vecV an $G$

Vektor an gerade anlegen:
$
    vecX := vecV - vecS
$

Orthogonalprojektion durchführen (auf den Unterraum $U = Span{vecR}$)
$
    P_U (vecX) = frac(vecX^T vecR, abs(vecR)^2) vecR = vecZ
$

Vektor wieder richtig zurück schieben:
$
    P_G (vecX) = vecP = vecS + P_U (vecX)
$

= Spiegelung

== Vektor an Geraden

! Keine Orthogonalprojektion an der Geraden !

=== Umformung der Geraden

Gerade gegeben durch
$
    G = {vecX in EE_2; 3x_1 - 2 = 5(x_2 + 1)}
$
Umformung zu
$
    G = {vecX in EE_2; 3x_1 - 5x_2 = 7} = {vecX in EE_2; chevron.l vecX, vecN chevron.r = 7}
$

- Normalenvektor $vecN = vec(3, -5)$

- Richtungsvektor $vecR = vec(5, 3)$

- Stützvektor $vecS = vec(4, 1)$

$
    => G = vecS + Span {vecR} = {vecS + alpha vecR; alpha in RR}
$

=== Vektor an Gerade anlegen

// [Zettel]
gesucht: Spiegelung von #vecV an $G$

Vektor an gerade anlegen:
$
    vecX := vecV - vecS
$

kürzester Weg von Punkt bei $vecV$ zur Geraden ausrechnen
$
    P_U (vecX) = frac(vecX^T vecN, abs(vecN)^2) vecN = vecZ
$

Vektor spiegeln:
$
    P_G (vecX) = vecP = vecV - 2 dot vecZ
$

= idk aber wichtig

Gegeben sei die lineare Abbildung $F$ und die Menge $M$
$
    F: RR^2 -> RR^2, defspace F(vecX) := A dot vecX, A = mat(1, -2; 2, 3)\
    M := {vecX in RR^2 mid 1 lt.eq x_1 lt.eq 2 and -1 lt.eq x_2 lt.eq 1}
$

1. Bestimmen sie das Bild $F(M)$ der Menge $M$ unter der Abbildung $F$

$M$ als $M = {vec(1, 1) + alpha vec(1, 0) + beta vec(0, -2) mid alpha, beta in [0,1]}$ schreiben

$vec(1, 1), vec(1, 0), vec(0, -2)$ in $F$ einsetzen, dann wieder Gleichung bilden

=> $F(M) = {vec(-1, 5) + alpha vec(1, 2) + beta vec(4, -6) mid alpha, beta in [0,1]}$

2. Berechnen sie die Determinante von $F$

$= det A$
