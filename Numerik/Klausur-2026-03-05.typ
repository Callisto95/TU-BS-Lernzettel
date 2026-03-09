#set text(font: "Inter", size: 14pt, lang: "de")
// #show math.equation: set text(font: "Fira Math")
#set page(margin: 3em)
#set line(length: 100%)
#set math.mat(delim: "[")

#let condition(body) = $abs(abs(body))$

#let task = (number, heading, points) => [#text(weight: "bold", [Aufgabe #number:]) #heading #h(1fr) [#points Punkte]]
#let subtask = (letter, points, content_) => grid(
    columns: (auto, 1fr),
    column-gutter: 0.5em,
    [#letter)],
    {
        [\[#points Punkt]
        if points > 1 {
            [e]
        }
        [\] #content_]
    },
)

#align(center, text([Klausur Numerik], weight: "bold", size: 16pt))

#task(1, "Interpolation", 6)

Gegebene Stützpunkte: $(0,1),(1,4),(2,11),(3,22)$

#subtask("a", 5, [Bestimme das Interpolationspolynom nach einem beliebigen Verfahren ihrer Wahl.])

#subtask("b", 1, [Welches Interpolationspolynom ergibt sich, wenn man den Stützpunkt $(2,11)$ weglässt? Begründe!])

#task(2, "Splines", 7)

Betrachte das Problem der gemischten kubischen Spline-Interpolation, wo am linken Rand die Bedingung der natürlichen Spline-Interpolation sowie am rechten die Bedingung der vollständigen Spline-Interpolation erfüllt sein soll.\
Dazu werden folgende Daten bereitgestellt:

#align(center, grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    table(
        stroke: none,
        columns: 4,
        column-gutter: (2.2pt, auto),
        align: center,
        // https://typst.app/docs/guides/tables/#double-stroke
        // not a good way, but the official way
        table.vline(end: 3, position: end, x: 0),
        table.vline(end: 3, position: start, x: 1),
        table.header($j$, $0$, $1$, $2$),
        table.hline(),
        $x_j$, $-1$, $0$, $1$,
        $f_i$, $0$, $0$, $0$,
    ),
    $
        f'(x_2) = f'_2 = 4
    $,
))

$
    S_l (x) = & 1/7 lr(size: #150%, [-8x -12x^2 -4x^3])  && in [-1 &&& , 0] \
    S_r (x) = & 1/7 lr(size: #150%, [-8x -12x^2 +20x^3]) && in [0  &&& , 1] \
$

Überprüfen sie, ob die aus $S_l$ und $S_r$ zusammengesetzte Funktion die zu dieser Aufgabenstellung gehörige interpolierende Spline-Funktion ist.

#task(3, [Gleichungssystem, LR-Zerlegung], 6)

$
    A = mat(4, 2, 0; 2, 5, 2; 0, 2, 5)
$

#subtask(
    "a",
    3,
    [Bestimmen sie die LR-Zerlegung mit Hilfe der partiellen Pivotisierung aus der Vorlesung. Geben sie $L, R$ und $P$ an.],
)

#subtask("b", 2, [
    Zeige, dass $R = D L^T$ gilt. D ist die Diagonalmatrix mit den Einträgen aus $R$.\
    Welches Vorzeichen haben die Einträge? Was bedeutet das für $A = L D L^T$?
])

#subtask("c", 1, [Gebe die Cholesky-Zerlegung $A = G G^T$ mit Hilfe der Zerlegung $A = L D L^T$ an.])

#task(4, "Numerische Integration", 5)

Gegeben sei $f(x,y) = alpha x + beta y$ für fest gewählte $alpha, beta in RR$.\
Zeigen sie, dass $Q(f) := 1/2 dot f(1/3, 1/3)$ eine exakte Quadraturformel für das Integral
$
    integral^1_0(integral^(1-y)_0 f(x,y) dif x) dif y
$
ist.

#task(5, "Kondition und Stabilität", 4)

Betrachte $f(x,y) = x - y$, wobei $x != y$.

#subtask(
    "a",
    2,
    [Bestimmen sie die Kondition bezüglich der $condition(bullet)_infinity$-Norm mit Hilfe der oberen Schranke aus der Vorlesung und werten sie die obere Schranke explizit für $x = 1$ und $x = 1.01$ aus.],
)

#subtask(
    "b",
    2,
    [Führen sie eine Rückwärtsanalyse für den Fall, dass $x,y$ Maschinenzahlen sind, durch und schätzen sie den Eingangsfehler bezüglich der Maschinengenauigkeit $epsilon$ ab.],
)

#task(6, "Ausgleichsproblem, kleinster Fehlerquadrate", 9)

Wir wollen eine Ersatzfunktion der Form
$
    y = p(t) = alpha dot frac((t-3)(t-4), 2) + beta t
$
konstruieren, wobei es unsere Aufgabe ist, die Parameter $alpha, beta$ bestmöglich mit Hilfe der folgenden Messdaten zu bestimmen

#align(center, grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    table(
        stroke: none,
        columns: 4,
        column-gutter: (2.2pt, auto),
        align: center,
        // https://typst.app/docs/guides/tables/#double-stroke
        // not a good way, but the official way
        table.vline(end: 3, position: end, x: 0),
        table.vline(end: 3, position: start, x: 1),
        table.header($t$, $3$, $4$, $5$),
        table.hline(),
        $y$, $5$, $-5$, $1$,
    ),
))

#subtask(
    "a",
    1,
    [Formulieren sie das Problem $x = mat(alpha; beta)$ zu bestimmen mit Hilfe der Methoden der kleinen Fehlerquote als $condition(A x - b)_2 =^! min$ und geben sie an, was $A$ und $b$ in unserem Fall sind.],
)

#subtask("b", 3, [
    Verifizieren sie, dass
    $
        Q = 1/5 mat(0, 3, 4; 0, 4, -3; 5, 0, 0) space space space R = mat(1, 5; 0, 5; 0, 0)
    $
    Faktoren aus der QR-Zerlegung von $A$ sind, indem sie die zugehörigen Bedingungen an $Q$, $R$, sowie $Q dot R$ verifizieren.
])

#subtask(
    "c",
    4,
    [Lösen sie das kleinste Fehlerquadratproblem mit einem von ihnen bevorzugten Verfahren und geben sie die Ersatzfunktion $p(t)$ an.],
)

#subtask("d", 1, [Bestimmen sie den Residualvektor $r = A x - b$ für ihre berechnete Lösung.])

#task(7, [Differentialgleichungen], 4)

Gegen sei die Differentialgleichung $y' = 4y - t$ mit Startwert $y(0) = 3$.

#subtask("a", 3, [
    Zeigen sie, dass die Konsistenzordnung des folgenden Verfahrens zur Lösung der Differentialgleichung mindestens 1 ist. Folgt aus der Konsistenz auch die Konvergenz?
    $
        u(t + h) := u(t) + h f(t + h, u(t))
    $
])

#subtask(
    "b",
    1,
    [Wenden sie einen Schritt mit konstanter Schrittweite $h > 0$ an, um die Iterierte $u_1$ zu berechnen.],
)
