#set text(font: "Inter", size: 1.25em, lang: "de")
#set grid(column-gutter: 1em, row-gutter: 1em)
#set page(margin: 3em)

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

Zeilensummennorm:

$
    A in RR^(n times m): cond(A)_infinity = max_(i=1,...,n) sum^m_(j=1) abs(a_(i j))
$

Spaltensummennorm:

$
    A in RR^(n times m): cond(A)_1 = max_(i=1,...,m) sum^n_(j=1) abs(a_(j i))
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

== kontrahierende Abbildungen

== Fixpunkte

= lineares Ausgleichsproblem

= Interpolation

== Interpolationspolynom

== Splines

= lineares Gleichungssystem

== LR-Zerlegung

= Integration

== Quadraturformel

= Euler-Verfahren

$
    y_(n+1) = y_n + h f(t_n, y_n)
$
