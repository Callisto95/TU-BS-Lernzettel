#set text(font: "Inter", size: 1.25em, lang: "de")
#set grid(column-gutter: 1em, row-gutter: 1em)
#set page(margin: 3em)
#set line(length: 100%)
#set math.mat(delim: "[")

#let cond(body) = $abs(abs(body))$

#align(center, text([Numerik], weight: "bold", size: 16pt))

Da das Skript sowie die Vorlesungen von eher schlechterer Qualität sind, ist vieles hiervon KI-generiert.

#outline()

// apparently the outline header is a heading and so this must be here
#show heading.where(level: 1): content => [#pagebreak();#content]

= Diskretisierungsfehler

Ein Diskretisierungsfehler ist in der Numerik der Fehler, der entsteht, wenn ein eigentlich kontinuierliches Problem in ein diskretes Problem umgewandelt wird, damit es numerisch berechnet werden kann.

= Konvergenz

Konsistenz + Stabilität = Konvergenz

Das numerische Verfahren bildet die zugrunde liegende Gleichung im Grenzfall kleiner Schrittweiten korrekt ab.

Nähern sich die numerischen Lösungen tatsächlich der exakten Lösung an?

\= Der globale Fehler geht gegen 0, wenn $h -> 0$

$
    abs(y(t_n) - y_n) -> 0
$

"Das Verfahren liefert tatsächlich richtige Ergebnisse."

Fehlerberechnung:

$
    e_n = abs(x_n - x^*)
$

== algebraische Konvergenz

auch: polynomielle Konvergenz

$
    e_n lt.eq C n^(-p); p gt 0
$

- langsame Konvergenz
- gerade Linie im log-log Diagramm

Beispiel:
- $frac(1, n^2)$ "verdoppelt sich n, reduziert sich der Fehler um Faktor 4"

== geometrische Konvergenz

auch: exponentielle Konvergenz

$
    e_n lt.eq C q^n; 0 lt q lt 1
$

- schneller als algebraisch
- gerade Linie im semilog Diagramm

Beispiel
- $(0.5)^n$ "Jeder Schritt halbiert den Fehler"

== supergeometrische Konvergenz

$
    lim_(n -> infinity) frac(e_(n+1), e_n) = 0
$

- sehr schnelle Konvergenz
- Fehler fällt schneller als $q^n$ für jedes feste $q lt 1$

= Stabilität

Bleiben Fehler (z. B. Rundungsfehler) unter Kontrolle oder wachsen sie stark an?

Instabile Verfahren verstärken Rundungsfehler exponentiell.

= Konsistenz

Ein Verfahren ist konsistent, wenn der lokale Diskretisierungsfehler verschwindet: $tau(h) -> 0$ für $h -> 0$

"Der lokale Diskretisierungsfehler verschwindet für kleine Schrittweiten."

== Ordnung

Konsistenzen besitzen eine Ordnung der Konsistenz.

Euler-Verfahren: Ordnung 1

== Anfangswertproblem

Differentialgleichungsproblem:

$
    y' = f(t,y), y(t_0) = y_0
$

Lösung mit Euler-Verfahren ist konsistent, da der lokale Fehler proportional zu $h^2$ ist.

Wenn $h -> 0$, dann geht auch der Fehler $-> 0$

auch "Das Verfahren approximiert die Differentialgleichung korrekt im Grenzfall kleiner Schrittweiten."

= Kondition

Konditionszahl eines Problems = Empfindlichkeit dessen Lösung auf kleine Änderungen der Eingabe

gute Kondition $hat(=)$ kleine Konditionszahl\
schlecht Kondition $hat(=)$ große Konditionszahl

Kondition: Eigenschaft des mathematischen Problems\
Stabilität: Eigenschaft des numerischen Verfahrens

== Konditionszahl

$
    kappa(A) = cond(A) dot cond(A^(-1))
$

bei linearer Abhängigkeit von zwei Zeilen in einer Matrix:
- $kappa(A)$ ist sehr groß
- Problem ist numerisch Instabil

typische Größen:
#grid(
    columns: 2,
    row-gutter: 0.5em,
    [- $kappa(A) approx 1$], [sehr gute Konditionierung],
    [- $kappa(A) approx 10^2 - 10^3$], [unproblematisch],
    [- $kappa(A) gt.eq 10^8$], [numerisch kritisch],
)


Fehlerabschätzung:\
relativer Lösungsfehler #sym.lt.eq Konditionszahl #sym.dot relativer Eingabefehler

$
    frac(cond(Delta x), cond(x)) lt.eq kappa(A) frac(cond(Delta b), cond(b))
$

#pagebreak()

== Normen

Zeilensummennorm:

$
    A in RR^(n times m): cond(A)_infinity = max_(i=1,...,n) sum^m_(j=1) abs(a_(i j))
$

Spaltensummennorm:

$
    A in RR^(n times m): cond(A)_1 = max_(i=1,...,m) sum^n_(j=1) abs(a_(j i))
$

Spektralnorm:

größtmöglichster Streckungsfaktor, der durch die Anwendung der Matrix auf einen Vektor der Länge Eins entsteht

$
    A in RR^(n times m): cond(A)_2 & = max_(x!=0) frac(cond(A x)_2, cond(x)_2) \
                                   & = max_(cond(x)_2 = 1) cond(A x)_2
$

allgemein:

$
    cond(A)_2 = sqrt(lambda_max (A^T A))
$

dabei

$
    cond(A)_2 = sigma_max (A)
$

= Maschinenzahlen

$
    x = plus.minus m dot b^e
$

- Basis b
- Mantisse m
    - m Stellen
- Exponent e
    - maximaler Exponentwert e


Beispiel $10^(-4)$ in $MM(10, 3, 1)$:
- b = 10, t = 3 Stellen, $e in {-1,0,1}$
- $x plus.minus(d_0.d_1 d_2) dot 10^e$
    - $d_0 != 0$

= Auslöschung

Verlust signifikanter Stellen bei der Subtraktion zweier fast gleich großer Zahlen.

Beispiel

$
    a = 1,2345; b = 1,2344; a - b = 0,0001
$

Verfälschung bei vorheriger Rundung (= Auslöschung)
- Rundung kann auch Darstellung in Maschinenzahlen sein

Beispiel:

```matlab
y = 1/x - 1/(x + 1)
```

-> Subtraktion fast gleich großer Zahlen

Umformulierung:

```matlab
y = 1 / (x * (1 + x))
```

= nichtlineare Gleichungen

== Selbstabbildung

$F: M->M$ ist eine Selbstabbildung
- Definitions- und Zielmenge sind identisch

#line()

$
    F: RR^n -> RR^n; F(x) = 0
$

Umformulierung in Fixpunktgleichung:

$
    x = Phi(x); Phi: M -> M "mit" M subset.eq RR^n
$

== kontrahierende Abbildungen

Eine kontrahierende Abbildung (auch Kontraktion) ist eine spezielle Art von Selbstabbildung, bei der Abstände zwischen Punkten verkleinert werden.

#line()

Anders ausgedrückt: Die Abbildung $Phi$ ist genau dann eine Kontraktion, wenn sie
- die Menge $MM$ in sich abbildet und
- eine Lipschitz-Bedingung mit einer Lipschitz-Konstanten $lambda lt 1$ erfüllt.

Sei $Phi: M -> M$

$Phi$ heißt Kontrahierend, wenn

$
    exists lambda: lambda in [0,1): forall x,y in M: d(Phi(x), Phi(y)) lt.eq lambda d(x, y)
$

#line()

Beispiel

$
    g(x) = frac((x+2), (x+1)); I = [1,2]
$

$
    [g(1), g(2)] = [frac(3, 2), frac(4, 3)] subset [1,2]
$

=> $g$ ist eine kontrahierende Abbildung

== Fixpunkte

Fixpunktverfahren:

$
    g(x) = frac((x+2), (x+1)); I = [1,2]
$

Fixpunktsuche:

$
          x & = frac((x+2), (x+1)) \
     x(x+1) & = x + 2 \
    x^2 + x & = x + 2 \
        x^2 & = 2 \
          x & = plus.minus sqrt(2)
$

$
    arrow sqrt(2) in I; -sqrt(2) in.not I
$

=> g besitzt genau einen Fixpunkt: $sqrt(2)$
- Fixpunkt ist eindeutig: $x^star = sqrt(2)$
- $x_(k+1) = g(x_k)$ konvergiert eindeutig für jeden Startwert in $I$ gegen $x^star$

= lineares Ausgleichsproblem

Fehlerminimierung

$
    r = A x - b
$

in der euklidischen Norm

$
    min_x cond(A x - b)_2^2
$

=> Man sucht das x, für das die Summe der quadrierten Abweichungen minimal ist

== Lösung über Normalengleichung

$
    A^T A x = A^T b
$

wenn $A^T A$ invertierbar ist:

$
    x = (A^T A)^(-1) A^T b
$

== Beispiel

Betrachte das Ausgleichsproblem $cond(A x - b)_2 = min$ mit $A=mat(0, 2; -1, 1; 0, 2; 3, 5), b=mat(0; 1; 2; 1)$

1. Besitzt $cond(A x - b)_2 = min_(x in RR^3)$ für obiges A und beliebiges $b in RR^4$ eine Lösung?

Eine Lösung existiert für jedes $b in RR^m$, wenn A eindlich viele Spalten besitzt

genau: es existiert genau dann eine Lösung, wenn $A^T A x = A^T b$ lösbar ist.\
Das gilt, wenn $A^T A$ invertierbar ist\
-> Spalten von A sind unabhängig\
-> $"rang"(A) = n$

Spalten von A: $a_1 = mat(0; -1; 0; 3), a_2 = mat(2; 1; 2; 5)$\
Ist $a_2 = lambda a_1$?\
Teilproblem: $a_(21) = lambda a_(11) => 2 = lambda 0$

Unmöglich, daher sind die Spalten unabhängig

-> $"rang"(A) = 2 = n$

Also:
- $A^T A$ ist invertierbar
- Normalengleichung besitzt für jedes $b in RR^4$ eine eindeutige Lösung
- Ausgleichsproblem besitzt immer eine eindeutige Minimallösung

2. Bestimme $x in RR^2$ mit $cond(A x - b)_2 = min_(x in RR^2)$ mit einem beliebigen Verfahren. Gebe die Lösung x, sowie $min_(x in RR^2) cond(A x - b)_2$ konkret an.

Verwendung der Normalengleichung: $A^T A x = A^T b$

Berechnung von $A^T A$:
$
    A^T A = dots = mat(10, 14; 14, 32)
$

Berechnung von $A^T b$:
$
    A^T b = dots = mat(2; 10)
$

Lösung von $A^T A x = A^T b$:
$
    mat(10, 14; 14, 32) mat(x_1; x_2) = mat(2; 10)
$

Schrittweise Lösung:
$
    10x_1 + 14x_2 = 2; 14x_1 + 32x_2 = 10
$

Lösung des lineares Gleichungssystems:
$
    x = mat(-frac(19, 31); frac(18, 31))
$

#line()

Berechnung von $min cond(A x - b)_2$

Zuerst $A x$: normale Matrixmultiplikation
$
    A x = mat(frac(36, 31); frac(37, 31); frac(36, 31); frac(33, 31))
$

Berechnung des Residuums b:
$
    r = b - A x = mat(0; 1; 2; 1) - mat(frac(36, 31); frac(37, 31); frac(36, 31); frac(33, 31)) = mat(frac(-36, 31); frac(-6, 31); frac(26, 31); frac(-2, 31))
$

$
    cond(r)_2^2 & = (-36/31)^2 + (-6/31)^2 + (26/31)^2 + (-2/31)^2 \
                & = (1296+36+676+4)/32^2 \
                & = 2012/31^2
$

$
    min cond(A x - b)_2 & = sqrt(2012/31^2) \
                        & = sqrt(2012)/31 \
                        & approx 1.overline(4)
$

= Interpolation

und Interpolationspolynom

Gegeben sind $f(0) = 1, f(1) = 4, f(2) = 11, f(3) = 22$


Das zugehörige Schema der dividierten Differenzen lautet

#table(
    columns: 2,
    table.header($t$, $f_t$),
    [0], $[t_0]f = 1$,
    [1], $[t_1]f = 4; [t_0, t_1]f = 3$,
    [2], $[t_2]f = 11; [t_1, t_2]f = 7; [t_0,t_1,t_2]f = 2$,
    [3], $[t_3]f = 22; [t_2,t_3]f = 11; [t_1,t_2,t_3]f = 2; [t_0,t_1,t_2,t_3]f = 0$,
)

1. Gebe das zu den obigen Daten gehörige Interpolationspolynom an.

$
    P_3(x) = & f[t_0] + \
             & f[t_0,t_1](x - t_0) + \
             & f[t_0,t_1,t_2](x - t_0)(x - t_1) + \
             & f[t_0,t_1,t_2,t_3](x - t_0)(x - t_1)(x - t_2) \
           = & 1 + \
             & 3(x - 0) + \
             & 2(x - 0)(x - 1) + \
             & 0(x - 0)(x - 1)(x - 2) \
           = & 1 + 3x + 2x(x - 1) \
           = & 2x^2 + x + 1
$

2. Welches Interpolationspolynom ergibt sich, wenn der Stützpunkt $f(3) = 22$ gestrichen wird.

Der letzte Stützpunkt ist sowieso 0, daher ist $f(3) = 22$ irrelevant.

$f$ bleibt gleich.

#pagebreak()

== Lagrange Polynome

spezielle Basis-Polynome, mit denen das Interpolationspolynom zu gegebenen Stützstellen konstruieren kann.

Ausgangssituation:

- gegeben: $n + 1$ Stützstellen $x_0,...,x_1$ mit Funktionswerten $f(x_0),...,f(x_n)$
- gesucht: Polynom $P(x): deg P lt.eq n and forall i: P(x_i) = f(x_i)$

Basis-Polynom der Stützstelle $x_i$:
$
    L_i (x) = product_(j=0\ j!=i)^n frac(x - x_j, x_i - x_j)
$

damit:
$
    L_i (x_j) = cases(1 space & i = j, 0 & i != j)
$

-> erfüllt "Kronecker-Delta-Eigenschaft"

Interpolationspolynom aus den Lagrange Polynomen:
$
    P(x) = sum^n_(i = 0) f(x_i) L_i (x)
$

#line()

Beispiel:

Stützstellen $x_0 = 0, x_1 = 1$

$
    L_0 (x) = & frac(x - 1, 0 - 1) && = 1 - x \
    L_1 (x) = & frac(x - 0, 1 - 0) && = x
$

Interpolationspolynom:
$
    P(x) = f(0)(1 - x) + f(1)x
$

#pagebreak()

== Hermite-Interpolationsbasis

Verallgemeinerung der Lagrange-Basis

Ableitungen und Funktionswerte

#table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr),
    table.header([], [Wert bei 0], [Wert bei 1], [Ableitung bei 0], [Ableitung bei 1]),
    $L_0$, [1], [0], [0], [0],
    $L_1$, [0], [1], [0], [0],
    $L_2$, [0], [0], [1], [0],
    $L_3$, [0], [0], [0], [1],
)

allgemeine Hermite Darstellung:
$
    H(x) = f_0 L_0 (x) + f_1 L_1 (x) + f'_0 L_2 (x) + f'_1 L_3 (x)
$
bei Daten
$
    (x_0, f_0), (x_0, f'_0), (x_1, f_1), (x_1, f'_1)
$

#pagebreak()

== Splines

Bestimme die stückweise Darstellung des quadratischen Splines $S(x)$, welcher die Daten $f(0) = 0, f(1) = 1, f(2) = 2$ interpoliert und die Bedingung $s'(0) = 2$ erfüllt.

Gesucht: quadratische Spline mit zwei Teilintervallen $[0,1], [1,2]$

Ansatz:
$
    S(x) = cases(S_1(x) = a_1 x^2 + b_1 x + c_1\,& 0 lt.eq x lt.eq 1, S_1(x) = a_2 x^2 + b_2 x + c_2\,& 1 lt.eq x lt.eq 2)
$

Interpolation:
$
    S(0) = 0, S(1) = 1, S(2) = 2
$

Damit:
$
    S_0(0) & = c_1 = 0 \
    S_1(1) & = a_1 + b_1 + c_2 = 1 \
    S_2(1) & = a_2 + b_2 + c_2 = 1 \
    S_2(2) & = 4a_2 = 2b_2 + c_2 = 2
$

Stetigkeit der ersten Ableitung in $x = 1$: $S'_1(1) = S'_2(1)$
$
    S'_1(x) & = 2a_1x + b_1 \
    S'_2(x) & = 2a_2 x + b_2
$

bei $x = 1$:
$
    2a_1 + b_1 = 2a_2 + b_2
$

Randbedingung:
$
    S'(0) = 2, S'_1(0) = b_1 = 2
$

Gleichungssystem lösen:

bekannt: $c_1 = 0, b_1 = 2$

aus $S_1(1) = 1$:
$
    a_1 + 2 = 1 => a_1 = -1
$

aus Ableitungsbedingung:
$
    2(-1)+2 = 2a_2 + b_2 => b_2 = -2a_2
$

Interpolation auf dem zweiten Intervall:
$
      a_2 + b_2 + c_2 & = 1 \
    4a_2 + 2b_2 + c_2 & = 2
$

Setze $b_2 = -2a_2$:

erste Gleichung:
$
    a_2 - 2a_2 + c_2 & = 1 \
                 c_2 & = 1 + a_2
$

zweite Gleichung:
$
    4a_2 + 2(-2a_2) + c_2 & = 2 \
                  c_2 = 2
$

Ergebnis:
$
    S(x) = cases(-x^2 + 2x\,& 0 lt.eq x lt.eq 1, x^2 -2x + 2\,& 1 lt.eq x lt.eq 2)
$

= lineares Gleichungssystem

== LR-Zerlegung

Zerlegung beliebiger Matrix A in links (L) und rechts (R) Teil

- normales Gaußverfahren
- 0 werden mit Vielfachen der Zeilenauslöschungen gefüllt ($Z_2: +2 dot Z_1, Z_3: -frac(1, 2) dot Z_1 arrow 2 "in Zeile" Z_2, frac(1, 2) "in Zeile" Z_3$)

Beispiel (parametrisierte Matrix):

#image("LR-Zerlegung.png")

=== Vorwärts- und Rückwärtseinsetzen

Zu einer Matrix $A in RR^4$ sei die Zerlegung

$
    A = mat(1, 4, 9, 16; 0, 4, 9, 16; 0, 0, 9, 16; 0, 0, 0, 16) mat(1, 0, 0, 0; 1, 1, 0, 0; 1, 1, 1, 0; 1, 1, 1, 1) = R L
$

gegeben. Löse das Gleichungssystem $A x = b$ mit
$
    b = mat(1; 0; 0; 0)
$

ohne Matrix A explizit zu berechnen.

Lösung:

Rückwärtseinsetzen:
$
    R y = b\
    mat(1, 4, 9, 16; 0, 4, 9, 16; 0, 0, 9, 16; 0, 0, 0, 16) mat(y_1; y_2; y_3; y_4) = mat(1; 0; 0; 0)\
    => y_4, y_3, y_2 = 0; y_1 = 1\
    => y = mat(1; 0; 0; 0)
$


Vorwärtsseinsetzen:
$
    L x = y\
    mat(1, 0, 0, 0; 1, 1, 0, 0; 1, 1, 1, 0; 1, 1, 1, 1) mat(x_1; x_2; x_3; x_4) = mat(1; 0; 0; 0)\
    => "Zeile 1": x_1 = 1, "Zeile 2": x_1 + x_2 = 0 => x_2 = -1, "Zeile 3,4": x_3, x_4 = 0\
    x = mat(1; -1; 0; 0)
$

= Integration

== Quadraturformel

Bestimme für die Quadraturformel $I(f) = f(-x_0) + f(x_0)$ die Stelle $x_0$ derart, dass $I(p) = integral^1_(-1) p(x) dif x$ exakt ist für alle Polynome $p(x) in Pi_2$ vom Grad 2.

Lösung:

für $p(x) = 1$:
$
    I(1) = 1 + 1 = 2\
    integral^1_(-1) 1 dif x = 2
$

für $p(x) = x$:
$
    I(x) = (-x_0) + x_0 = 0\
    integral^1_(-1) x dif x = 0
$

für $p(x) = x^2$:
$
    I(x^2) = x_0^2 + x_0^2 = 2x_0^2\
    integral^1_(-1) x^2 dif x = [frac(x^3, 3)]^1_(-1) = frac(1, 3) - (-frac(1, 3)) = frac(2, 3)
$

für Exaktheit:
$
    2x_0^2 & = frac(2, 3) \
           & => x_0^2 = frac(1, 3) \
           & => x_0 = frac(1, sqrt(3))
$

Somit:
$
    x_0 = frac(1, sqrt(3))
$

= Euler-Verfahren

$
    y_(n+1) = y_n + h f(t_n, y_n)
$

= Determinante

Laplacescher Entwicklungssatz:

$
    mat(
        +, -, +, dots;
        -, +, -, dots;
        +, -, +, dots;
        dots, dots, dots, dots;
    )
$

bei $R^(n times n)$ Matrizen:

$
    n = 2:& det(mat(a_11, a_12; a_21, a_22)) = a_11 a_22 - a_21 a_12\
    n = 3:& det(mat(a_11 a_12 a_13; a_21 a_22 a_23; a_31 a_32 a_33)) = a_11 mat(a_22, a_23; a_32, a_33) - a_21 mat(a_12, a_13; a_32, a_33) + a_31 mat(a_12, a_13; a_22, a_23)
$
