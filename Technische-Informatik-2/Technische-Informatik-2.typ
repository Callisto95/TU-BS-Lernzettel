#set text(font: "Inter", size: 1.25em, lang: "de")
#set grid(column-gutter: 1em, row-gutter: 1em)
#set page(margin: 4em)
#set quote(block: true) // actually show attribution in quotes
#show link: underline
#set line(length: 100%)
#show math.equation: set text(font: "Fira Math")

#align(center, text([Technische Informatik 2], weight: "bold", size: 16pt))

#outline()

// apparently the outline header is a heading and so this must be here
#show heading.where(level: 1): content => [#pagebreak();#content]

= Konvertierungen

== BCD - Addition

Wenn $a + b > 9$, dann $a + b + 6$ (bzw. $+ (0110)_2$)

== Dezimal zu Binär, Zwischenschritt Hex

$(1023.5390625)_10 -> ()_2$

```text
1023 : 16 = 63 R15 -> (F)_16
63   : 16 =  3 R15 -> (F)_16
3    : 16 =  0 R3  -> (3)_16
```
-> $(3"FF")_16$

```text
0.5390625 * 16 = 8.625 -> (8)_16
0.625     * 16 = 10    -> (A)_16
```
-> $(0.8"A")_16$

=> $(3"FF",8"A")_16 = (0000 space 0011 space 1111 space 1111, 1000 space 1010)_2$

= Kosten

- $L$: Anzahl der Literale
- $G$: Anzahl der Gattereingänge
- $G N$: Anzahl der Gattereingänge mit Negation

= Formen

== DNF (Disjunktive Normalform)

$(x_1 and x_2) or (x_1 and x_3)$

== DMF (Disjunktive Minimalform)

Optimierte Form einer DNF

== KNF (Konjunktive Normalform)

$(x_1 or x_2) and (x_1 and x_3)$

== Umwandlungen

=== KNF -> DMF

$
    f_1(x_3,x_2,x_1,x_0)= sum m(0.4,5.9,11.12.13) = overline(x_3) overline(x_2) overline(x_1) overline(x_0) +
$

Gesamte Funktion aufschreiben

$
    f_1
    = overline(x_3) overline(x_2) overline(x_1) overline(x_0)
    + overline(x_3) x_2 overline(x_1) overline(x_0)
    + overline(x_3) x_2 overline(x_1) x_0
    + x_3 overline(x_2) overline(x_1) x_0
    + x_3 overline(x_2) x_1 x_0
    + x_3 x_2 overline(x_1) overline(x_0)
    + x_3 x_2 overline(x_1) x_0
$

Minimierung:

1.
$
    "0+4": & overline(x_3) overline(x_2) overline(x_1) overline(x_0) + overline(x_3) x_2 overline(x_1) overline(x_0) && = overline(x_3) overline(x_1) overline(x_0) \
    "5+4": & overline(x_3) x_2 overline(x_1) overline(x_0) + overline(x_3) x_2 overline(x_1) x_0 && = overline(x_3) x_2 overline(x_1) \
    "9+11": & x_3 overline(x_2) overline(x_1) x_0 + x_3 overline(x_2) x_1 x_0 && = x_3 overline(x_2) x_0 \
    "12+13": & x_3 x_2 overline(x_1) overline(x_0) + x_3 x_2 overline(x_1) x_0 && = x_3 x_2 overline(x_1) \
$
$
    => f_1
    = overline(x_3) overline(x_2) overline(x_1) overline(x_0)
    + overline(x_3) x_2 overline(x_1)
    + x_3 overline(x_2) x_0
    + x_3 x_2 overline(x_1)
$

$"0+4"$ wird zugunsten $"5+4"$ nicht verwendet.

2.
$
    overline(x_3) x_2 overline(x_1) + x_3 x_2 overline(x_1) = x_2 overline(x_1)
$
$
    => f_1
    = overline(x_3) overline(x_2) overline(x_1) overline(x_0)
    + x_2 overline(x_1)
    + x_3 overline(x_2) x_0
$

= IEEE 754

`-0.054351806640625` -> IEEE 754 (FP32)

Negativ -> sign bit ist `1`

Weiter mit with `0.054351806640625`.

Konvertierung zu Binär:
```text
0.054351806640625 * 2 = 0.10870361328125   -> 0
0.10870361328125  * 2 = 0.2174072265625    -> 0
0.2174072265625   * 2 = 0.434814453125     -> 0
0.434814453125    * 2 = 0.86962890625      -> 0
0.86962890625     * 2 = 1.7392578125       -> 1
0.7392578125      * 2 = 1.478515625        -> 1
0.478515625       * 2 = 0.95703125         -> 0
0.95703125        * 2 = 1.9140625          -> 1
0.9140625         * 2 = 1.828125           -> 1
0.828125          * 2 = 1.65625            -> 1
0.65625           * 2 = 1.3125             -> 1
0.3125            * 2 = 0.625              -> 0
0.625             * 2 = 1.25               -> 1
0.25              * 2 = 0.5                -> 0
0.5               * 2 = 1                  -> 1
```

=> $0.054351806640625_10$ = $0.000011011110101_2$

Normalisiere:

$#raw("0.000011011110101") = #raw("1.1011110101") * #raw("2")^#raw("-5")$

Exponent: E = `-5 + 127 = 122 = 01111010` \
Mantisse: M = `1011110101` + `0` für Padding
- die führende `1` wird ignoriert, da sie implizit ist


```text
[S|E (8)   |M (23)                 ]
[1|01111010|10111101010000000000000]
```

= Subtraktion

$#raw("7367.01") _#raw("16") - #raw("4010.7C") _#raw("16")$

```text
  0111 0011 0110 0111.0000 0001
- 0100 0000 0001 0000.0111 1100
C             1     1 1111 1
= 0011 0011 0101 0110.1000 0101

Q 0011 0011 0101 0110.1000 0101
```

Ein Carry im Bruchteil wird zum Integerteil weitergeleitet.

= Karnaugh-Veitch Diagram

let $f_0 = (overline(x_2) or overline(x_1)) and (overline(x_0) or x_2) and (x_1 or x_0)$

DNF -> KV Diagram braucht eine Wahrheitstabelle.

#table(
    columns: 4,
    table.header($x_2$, $x_1$, $x_0$, $f_0$),
    $0$, $0$, $0$, $0$,
    $0$, $0$, $1$, $0$,
    $0$, $1$, $0$, $0$,
    $0$, $1$, $1$, $1$,
    $1$, $0$, $0$, $0$,
    $1$, $0$, $1$, $1$,
    $1$, $1$, $0$, $0$,
    $1$, $1$, $1$, $0$,
)

= Automaten

== Mealy

$A = (X, Y, Z, delta, lambda)$
- Eingaben $X$
- Ausgaben $Y$
- Zustände $Z$
- Transitionen $delta: Z times X -> Z$
- Ausgabefunktion $lambda: Z times X -> Y$

== Moore

Wie Mealy-Automaten, aber Ausgabefunktion ist nur vom Zustand abhängig $lambda: Z -> Y$

Jeder Zustand hat dabei eine Ausgabe während jeder Übergang nur eine Eingabe hat.

== Implementierung im PLA

Jede Ausgabe $y_i$ und jeder Zustand (für den nächsten Schritt) $z_i^(n+1)$ bekommt eine eigene Funktion.
Dabei ist jede $y_i$ und jeder $z_i^(n+1)$ von $x_j$ und $z_j^(n)$ abhängig.
Durch Minimierung werden nur notwendige Verbindungen eingetragen.

= Zeitverhalten

- $t_"pdD"$ clock-to-output vom sendenden FlipFlop
    - $t_"pdDmax"$ = maximale Ausbreitungsverzögerung vom D-FlipFlop
- $t_"pdS"$ Verzögerung der Schaltungen zwischen den FlipFlop's
    - $t_"pdSmax"$ = maximale Ausbreitungsverzögerung vom  gesamten Schaltnetz ($delta slash lambda$ Logik)
- $t_"hold"$ Verzögerung vom empfangenden FlipFlop

== Entscheidungszeit

Sei $t_s$ die Setup-Zeit und $t_h$ die Hold-Zeit.
Dann ist die Entscheidungszeit $E$
$
    E = t_s + t_h
$

== Skew

Sei $n_"skew"$ die Anzahl der Skew-Elemente zwischen Start und Ziel.

$
    n_"skew" dot t_("skew",max) <= t_("pdD",min) + Sigma space t_("pdS",min) - t_"hold"
$

Minima von allen Werten.
"Wie schnell können Daten das Ziel erreichen?"

Wenn der Takt das Ziel schneller erreicht als die Quelle existiert gilt:
$
    t_("skew",max) <= t_("cycle",min)
$
da das Ziel schon den Wert gespeichert hat, bevor die Quelle überhaupt senden konnte.

== Frequenz

Sei $n_"source"$ und $n_"destination"$ die Anzahl der Skew-Elemente von der Einspeisung zum jeweiligen Element.

$
    t_("cycle",min) >= n_"source" dot t_("skew",max) + t_("pdD",max) + Sigma space t_("pdS",max) + t_("destination_setup") - n_"destination" dot t_("skew",min) \
    f_max = 1/t_("cycle",min)
$

#pagebreak()

== Beispiel

#image("circuit.png")

#table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: center,
    stroke: 0.5pt,
    table.header([], [7432\ (OR)], [7486\ (XOR)], [7408\ (AND)], [7474\ (D-FF)], [74114\ (JK-FF)]),

    $t_"pdLH"$, [2.9 - 4.3 ns], [4.2 - 6.4 ns], [3.3 - 4.5 ns], [5.3 - 6.1 ns], [7.8 - 9.0 ns],
    $t_"pdHL"$, [3.5 - 4.6 ns], [4.1 - 5.6 ns], [3.2 - 4.3 ns], [5.8 - 7.1 ns], [7.2 - 9.2 ns],
    $t_"setup"$, [ ], [ ], [ ], [2.9 ns], [2.6 ns],
    $t_"hold"$, [ ], [ ], [ ], [2.3 ns], [2.0 ns],
)

#pagebreak()

=== Skew

==== T1, FF1 -> FF3

#let ns = "ns"

kürzeste Route: FF1 -> AND -> OR -> FF3 \
Skew-route: T1 -> skew -> T2 -> skew -> FF3 => 2 skew's

$
    2 dot t_("skew",max) <= & t_("pdD",min)(7474) && + t_("pdS",min)(7408) && + t_("pdS",min)(7432) && - t_("hold")(7474) \
    2 dot t_("skew",max) <= & 5.3 ns              && + 3.2 ns              && + 2.9 ns              && - 2.3 ns \
    2 dot t_("skew",max) <= & 9.1 ns \
          t_("skew",max) <= & 4.55 ns \
$

==== T1, FF2 -> FF3

kürzeste Route: FF2 -> OR -> FF3 \
Skew-route: T1 -> skew -> T2 -> skew -> FF3, aber T1 -> skew -> T2 is vor FF2 und FF3 wodurch es nicht berücksichtigt werden muss. \
Somit: Skew-route: T1 -> T2 -> skew -> FF3 => 1 skew

$
    t_("skew",max) <= & t_("pdD",min)(7474) && + t_("pdS",min)(7432) && - t_("hold")(7474) \
    t_("skew",max) <= & 5.3 ns              && + 2.9 ns              && - 2.3 ns \
    t_("skew",max) <= & 5.9 ns \
$

==== T3, FF3 -> FF2

$
    t_("skew",max) <= t_("cycle",min)
$
da das Ziel (FF3) schneller erreicht wird als die Quelle (FF2).

=== Frequenz

==== T2, FF1 -> FF3

$
    t_("cyc",min) >= &&  1.1 ns && + 7.1 ns && + 4.5 ns && + 4.6 ns && + 2.9 ns && - 0.5 ns \
    t_("cyc",min) >= && 19.7 ns
$
$
    f_max < 1/(19.7 ns) = 0.0507614213198 "GHz" approx 50.08 "MHz"
$

==== T3, FF3 -> FF3

$
    t_("cyc",min) >= & 7.1 ns  && + 6.4 ns && + 4.5 ns && + 7.1 ns && + 4.6 ns && + 2.9 ns \
    t_("cyc",min) >= & 32.6 ns
$
$
    f_max < 1/(32.6 ns) = 0.0306748466258 "GHz" approx 30.67 "MHz"
$
