#set text(font: "Inter", size: 1.25em, lang: "de")
#set grid(column-gutter: 1em, row-gutter: 1em)
#set page(margin: 4em)
#set quote(block: true) // actually show attribution in quotes
#show link: underline
#set line(length: 100%)
#show math.equation: set text(font: "Fira Math")
// #set heading(numbering: "1.") // takes up way too much space, keep disabled

#let mid = $mid(|)$

#align(center, text([Programmiersprachen und Übersetzer], weight: "bold", size: 16pt))

#outline()

// apparently the outline header is a heading and so this must be here
#show heading.where(level: 1): content => [#pagebreak();#content]

= Syntaktische Analyse

== Tokenstrom

```
fn fnord /* bar */ ( { 0x17...
|  |               | | |
|  |               | | literal(23)
|  |               | lbracket
|  |               lparen
|  identifier("fnord")
func
```

Gruppierung von Zeichen zu sprachspezifischen Blöcken.
Blöcke haben eine Klasse (`func`, `identifier`) und eventuell eine Nutzlast (`fnord`, `23`).
Es gibt keine Kommentare im Tokenstrom.
Es wird immer der längste Treffer verwendet (`fn` vs `fnord`).

Ziele:
- Komplexitätsreduktion
    - weniger Token als Zeichen
- Fokussierung auf Sprachelemente, nicht schreibweise
- Vereinfachung des Parsens
    - weniger Sonderfälle (Kommentare)

== Scanner

Auch: Lexer

Erzeugung des Tokenstroms.
Automaten von regulären Ausdrücken werden parallel über die Eingaben ausgeführt.
Bei mehreren Treffern wird der längste Treffer verwendet.

== Syntaxbaum

#let EPS = math.op("EPS")
#let FIRST = math.op("FIRST")
#let FOLLOW = math.op("FOLLOW")
#let PREDICT = math.op("PREDICT")

Anordnung von Token in Baumform.
Implizite Sprachregeln werden dadurch explizit dargestellt.

LL-Grammatik: *L*~inks lesend, *L*~inksableitend \
LR-Grammatik: *R*~echts lesend, *L*~inksableitend \
LL($k$), LR($k$): Mit $k$ Zeichen lookahead Parser

LL-Grammatiken können mit einem Recursive-Descent Parser bearbeitet werden.
Dabei LL(1) #sym.lt.double LR(1)

Bei einer LL(1) Grammatik zeigt das nächste Zeichen sicher die anzuwendende Regeln an.

=== PREDICT

$
    PREDICT(A -> alpha) equiv FIRST(alpha) union ("if" EPS(alpha) "then" FOLLOW(A) "else" emptyset)
$

Intuition: Ein Terminal c sagt eine Regel dann voraus, wenn:
1. Die Ableitung der rechten Seite mit dem Terminal $c$ startet ($FIRST$).
2. Die rechte Seite $alpha$ kann $epsilon$ werden, daher muss man auf die Terminal schauen, die der Regel folgen können ($FOLLOW$).

Für jede Regel enthält die PREDICT-Menge jene Token/Terminale, die im Look-Ahead dazu führen, dass die Regel angewendet wird.

Ist eine Grammatik in LL(1)? \
Alle PREDICT-Mengen mit der gleichen linken Seite müssen Schnittfrei sein. \
-> für jedes Nichtterminal ist die Auswahl der Regel eindeutig.

=== EPS

$
    EPS(alpha) equiv alpha attach(==>, tr: *) epsilon
$

Kann aus $alpha$ durch Ableitungen $epsilon$ entstehen?

=== FIRST

$
    FIRST(alpha) equiv { c mid c in T, alpha attach(==>, tr: *) c beta }
$

Die Menge an Terminalen, die bei den Ableitungen von $alpha$ links entstehen.

=== FOLLOW

$
    FOLLOW(A) equiv { c mid c in T, S attach(==>, tr: +) alpha A c beta }
$

Die Menge aller Terminale, die bei einer Ableitung vom Startsymbol $S$ direkt auf $A$
folgen können.
$alpha$ und $beta$ sind beliebige Teilwörter.

== Ableitungsbaum

Jede Anwendung einer Regel wird zu einem Knoten. Die
Blätter überdecken alle Token.

== Kontextproblem

Scanner kann ohne Kontext keine Sprachen bearbeiten.
Der Scanner muss eine Liste von von bereits definierten Typnamen speichern.
Das sorgt aber dafür, dass der Lexer kontextsensitiv ist.

#line()

Zeichenstrom -Lexer-> Tokenstrom -Parser-> AST

= Typen

== Strukturell

"Wie baue ich meine Datenstrukturen aus einfacheren Datentypen?"

Es gibt eingebaute und daraus kombinierte Typen.

Eingebaut: `char`, `int`,... \
Kombiniert: `char*`, `int[]`,...

== Denotationell

"Welche Regeln und Invarianten gelten für die Objekte hinter diesem Typ?"

Typen sind eine Menge von Objekten.

Beispiel: `ùint16_t = {0,...,65535}`

== Abstraktionell

"Mit welchen Operationen kann ich Objekte dieses Typs manipulieren?"

Ein Typ ist ein Interface konsistenter Operationen.

Beispiel: `int32` ist das Interface für ${+_(#raw("int32")), -_(#raw("int32")), dot_(#raw("int32")),...}$

== Äquivalenzen

=== Strukturell

```pascal
type student = record
    name: string;
    age: integer;
end;
type school = record
    name: string;
    age: integer;
end;
```

Mit struktureller Äquivalenz ist Unterscheidung beider Typen unmöglich.

=== Namensäquivalenz

Namen werden als Unterscheidung vermeidet.

== Polymorphismus

=== Varianzen

==== Kovarianz

Kompatibilität läuft entlang der Spezialisierung.

==== Kontravarianz

Kompatibilität läuft entgegen der Spezialisierung

==== Invarianz

Instanztypen sind inkompatibel zueinander

== Eigenschaften

- Typsicherheit
    - Kann ich das Typsystem (unbemerkt) umgehen?
- Dynamik
    - Zu welchem Zeitpunkt werden die Typen geprüft?
    - statisch
        - Festlegung des Typs bei jeder Definition und Deklaration
        - Variablen haben immer einen Wert des Typs
    - dynamisch
        - die Objekte in den Variablen haben einen Typen, die Variablen selber aber nicht
- Automatisierung
    - Wie viel Arbeit nimmt der Übersetzer uns ab?
- stärke der Typisierung
    - stark, wenn
        - es existieren unterschiedliche Typen
        - implizite Konvertierung zwischen ähnlichen Typen
        - explizit Konvertierung sind eventuell notwendig

= semantische Analyse

Syntaktische und semantische Analyse prüfen alle Sprachregeln.
Die syntaktische Analyse prüft die kontextfreien Regeln einer Sprache.
Alles, was nicht kontextfrei geprüft werden kann, überprüft die semantische Analyse.

Ziele
- Deklariertheit
    - jede Namensreferenz muss aufgelöst werden
- Typkonsistenz
    - korrekte Verwendung der Typen

Erzeugung neuer Attribute für den Übersetzer.

== Attributarten

=== synthetische Attribute

"von unten nach oben"

- von Kindern abhängig
- Beispiel: Typen in Ausdrücken
- Technik: Traversierung

=== geerbte Attribute

"von links nach rechts"

- von Vorgängern und Nachbarn abhängig
- Beispiel: Namensauflösung
- Technik: Symboltabelle

=== zyklische Attribute

"all over the place"

- Fixpunktberechnung
- Beispiel: Typinferenz in Haskell
- Technik: Unifikation

=== Attributberechnung

- Baumtraversierung
    - Visitor
- Symboltabelle
- Unifikation
    - Angleichung von parametrischen Typausdrücken durch Ersetzung
