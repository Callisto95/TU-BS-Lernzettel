#set text(font: "Inter", size: 1.25em, lang: "de")
#show math.equation: set text(font: "Fira Math")

#set line(length: 100%)
#show image: img => align(center, img)

#let Hz = $"Hz"$
#let bps = $"bps"$
#let SN = $S slash N$
#let dB = $"dB"$
#let low = $"low"$
#let high = $"high"$
#let corresponds = $hat(=)$

// Layers
#let L1 = [Physical Layer]
#let L2 = [Data Link Layer]
#let L3 = [Network Layer]
#let L4 = [Transport Layer]
#let L5 = [Application Layer]

// shortcuts
#let DLE = [Data Link Escape]

#let heading_(content) = [#h(1em) #sym.triangle.r.filled.small #content #linebreak()]
#let subheading_(content) = [#h(1em) #sym.triangle.r.small #content #linebreak()]

#outline()

#show heading.where(level: 1): content => [#pagebreak() #content]

= 5 Schichten Modell

#table(
    columns: 3,
    align: center + horizon,
    table.header(table.cell([Layer], colspan: 2), [Funktion]),
    [5], [Application], [Anwendungsservices],
    [4], [Transport], [Verbindung von Quellanwendung zur Zielanwendung (bzw. Quellprozess zu Zielprozess)],
    [3], [Network], [Endsystem zu Endsystem],
    [2], [Data Link], [Datentransfer zwischen benachbarten Stationen],
    [1], [Physical], [Integritätserhaltung von gesendeten Bits],
)

= Physical Layer (L1)

ISO Definition:

#L1 bietet
- mechanische
- elektronische
- funktionale
- prozedurale
Features zur Initialisierung, Instandhaltung, und Terminierung physischer Verbindungen zwischen
- Data Terminal Equipment (DTE)
- Data Circuit Terminating Equipment (DCE, "postal Socket")
- Data Switching Centers
an.

Es versendet digitale bits über analoge Leitungen.
Mit physischen Verbindungen versichert der #L1 ein transparenten Bitstream zwischen Data Link Layer Entitäten.

Eine physische Verbindung kann den Bitstream als
- Duplex
- Semi-Duplex
versenden.

== Bitrate und Baudrate

=== Baudrate

Anzahl der versendeten Symbole pro Zeiteinheit.

"Signalgeschwindigkeit" - Nummer der Signaländerungen pro Sekunde

=== Bitrate

Anzahl der versendeten Bits pro Sekunde.

Die Bitrate kann höher sein, als die Baudrate.

== Bandbreite

Unterschiedlich als normale Definition von der typischen Nutzung in der Informatik.

$
    "Bandbreite" B := f_max - f_min
$
- $f_max$: maximale Frequenz
- $f_min$: minimale Frequenz

=== Nyquist Theorem

Übertragungsgeschwindigkeit für einen Geräuschfreien Kanal

maximale Übertragungsgeschwindigkeit:
$
    max B := 2 B dot log_2 V
$
- $B$: Bandbreite des Signals (low pass Filter) (dabei $1 Hz eq.triple 1 bps$)
- $V$: Anzahl der diskreten Level

Beispiel: 3000 Hz Kanal: $B = 3000 Hz, V=2$:
$
    2 dot 3000 dot log_2(2) = 2 dot 3000 dot 1 = 6000 bps
$

=== Shannon Theorem

Übertragungsgeschwindigkeit für einen Kanal mit Geräusch

maximale Übertragungsgeschwindigkeit:
$
    max B := B dot log_2(1 + SN)
$
- $B$: Bandbreite des Signals (low pass Filter)
- $SN$: Verhältnis von Signal zu Geräusch

Obere Schranke. System erreichen diesen Wert kaum.

Beispiel: 3000 Hz Kanal: $B = 3000 Hz, SN = 1000 = 30 dB$:
$
    3000 dot log_2(1 + 1000) = 3000 dot 9,967 approx 30 000 bps
$

#pagebreak()

== Übertragungsarten

=== serielle Übertragung

sequenzielle Signalübertragung über einen Kanal

=== parallele Übertragung

gleichzeitige Signalübertragung über mehrere Kanäle

=== Übertragungsmodi

==== Simplex

Datentransfer in nur eine Richtung.

==== Semi-Duplex / Half-Duplex
Datentransfer in beide Richtungen, aber nicht gleichzeitig.

==== Full-Duplex
Datentransfer in beide Richtungen.

=== Synchronität

==== synchron

Von Takt vordefinierte Zeit, wenn ein Bitaustausch stattfindet.
Taktfrequenz wird vom Signal oder separaten Kanal erhalten.
Bit oder Frame synchron möglich.

==== asynchron
Taktfrequenz is für die Dauer des Signals fest.
Terminierung gekennzeichnet durch Stoppsignal oder Anzahl der Bits pro Signal.
Sender und Empfänger generieren Taktimpuls unabhängig voneinander.

Beispiel: RS-232-C

== Medium

=== ungeschütztes verdrehtes Paar

- UTP: "unshielded twisted pair"
- Verstärker durch Signalverlust auf größere Distanzen notwendig
- billig, breite Verwendung

=== Koaxialkabel

Schichten:
0. innerer Leiter
1. Isolation
2. äußerer Leiter
3. Schutzhülle
- bessere Übertragungsqualität

=== Glasfaser

- Licht durch totale interne Reflexion gefangen

==== Multi-Mode

- großer Durchmesser (mindestens 50 #sym.mu\m)
- mehrere Strahlen auf verschiedenen Winkeln ("modes")
- kürzere Distanzen (bis zu 1000m)
- billiger

==== Single-Mode

- kleiner Durchmesser (8-9 #sym.mu\m)
- geringe Anzahl von Wellenlängen
- Lichtausbreitung in gerader Linie
- bessere Eigenschaften, aber teurer

=== Kabellos

Signalübertragung mit Antennen

== Codierung

=== binäre Codierung (non-return-to-zero)

- "1" #corresponds Spannung hoch, "0" #corresponds Spannung niedrig
- einfach und billig
- gute Nutzung der Bandbreite
- keine automatische Frequenz

=== Manchester Codierung

Aufteilung des Bitintervalls in zwei partielle Intervalle $l_1, l_2$.
- "1" $corresponds l_1 high, l_2 low$
- "0" $corresponds l_1 low, l_2 high$
- gute automatische Frequenz
- 0.5 Bit pro Baud
- Verwendung: IEEE 802.3 (CSMA/CD)

=== Differentielle Manchester Codierung

Aufteilung des Bitintervalls in zwei partielle Intervalle.
- "1" #corresponds keine Veränderung des Levels am Beginn des Intervalls
- "0" #corresponds Veränderung des Levels
- gute automatische Frequenz
- geringe Störanfälligkeit, da nur Signalpolarität wichtig ist, nicht die Werte
- 0.5 Bit pro Baud
- komplex

=== Return-To-Zero

Aufteilung des Bitintervalls in zwei partielle Intervalle $l_0, l_1$ und Aufteilung der Spannung in drei Teile $high, 0, low$.
- "1" $corresponds l_0 high$
- "0" $corresponds l_0 low$
- $l_1$ ist immer $0$

#image("return-to-zero.png")

== Multiplexing

=== Frequency Division Multiplexing

Einteilung der verfügbaren Frequenzen in diskrete Kanäle für individuelle Nutzer.
Jeder Nutzer bekommt ein Frequenzband durch einen Filter (= verschieben der erhaltenen Frequenz auf der gesamten Frequenz).
Frequenzpuffer als Schutz vor Interferenz.

Qualität der Filter und Schutzpuffer ist wichtig um Überlappungen der Kanäle und damit Interferenz zu vermeiden.

=== Time Division Multiplexing

Einteilung der Zeit in diskrete Kanäle.
Jeder Nutzer erhält einen Zeitslot währenddessen der Nutzer die gesamte Bandbreite verwenden kann.

$
    sum_(i=1)^n d_i (t) = d_0 (t)
$
Dabei sind $d_1,...,d_n$ Nutzer und $d_0$ ist die gesamte Übertragungszeit.

= Data Link Layer (L2)

Bietet (potentiell) zuverlässige und effiziente Datenübertragung zwischen benachbarten Stationen an.
Es kann sich dabei um mehr als nur zwei Stationen handeln.
"benachbart" heißt dabei, dass die Stationen mit einem physikalischen Kanal verbunden sind.
Baut auf dem #L1 auf und verbessert deren Service.

Funktionalitäten:
- Datenübertragung as Frames
- Fehlerkontrolle und Fehlerkorrektur
- Flusskontrolle der Frames
- Konfigurationsmanagement

Was wird vom #L1 erhalten?
- Übertragung einen Bitstreams
    - ohne Sequenzfehler
    - eventuell mit Datenverlust, Einschub, Bit-Flips
- bösartige Merkmale des #L1 erzeugt durch
    - Kommunikationskanal
    - endlicher Ausbreitungsgeschwindigkeit
    - limitierter Datenrate

== Verbindunsklassen

=== unbestätigt und verbindungslos

Übertragung von isolierten, unabhängigen Einheiten (Frames).
Datenverlust möglich, es wird aber keine Korrektur versucht.
Data Link Layer versendet nur korrekte Frames.
Kein Kontrollfluss oder Verbindungsaufbau und -abbau.
Verwendet bei #L1 Verbindungskanälen mit einer sehr geringen Fehlerrate (Korrekturen werden auf einem höheren Level vorgenommen) und Echtzeitdatenübertragung (wie Sprachkommunikation und LAN).

== bestätigt und verbindungslos

Dateneinheiten werden (implizit) bestätigt.
Timeout und erneute Übertragung, wenn keine Bestätigung erhalten wurde.
Duplikate und Sequenzfehler können durch wiederholte Übertragung entstehen.
Wird bei #L1 Kanälen mit einer hohen Fehlerrate, wie z.B. einem kabellosen Kanal, eingesetzt.

== verbindungsbasiert

Bereitstellung eines fehlerlosen Kanals mit keinem Verlust, keiner Wiederholung, keinem Sequenzfehler, und Flusskontrolle.

3 Phasen
+ Verbindungsaufbau
    - Initialisierung der Zähler und Variablen des Senders und Empfängers
+ Datenübertragung
+ Verbindungstrennung

#line()

Die Bestätigungen sind für Optimierungszwecke, aber nicht unverzichtbar, da dies auch auf höheren Ebenen getan werden kann.
Nachrichten der Anwendungsschicht können aus mehreren Data Link Layer Frames bestehen, wodurch bei einem Fehler in der Nachricht die gesamte Nachricht neu übertragen werden muss.
Dadurch entsteht ein Verlust an Zeit und Effizienz.

== Frames

=== asynchrone Übertragung

Jedes Symbol ist durch einen Start- und Stopp-Bit gebunden.
Einfach und billig, hat aber eine geringe Übertragungsrate.

=== synchrone Übertragung

Mehrere Symbole werden zu einem Frame zusammengefasst.
Frames werden durch SYN oder ein Flag definiert.
Komplexer, erlaubt aber höhere Übertragungsraten.
Fehlerkorrektur wird auf dem gesamten Frame angewendet.

Definition und Erkennung von Frames durch
0. Leerlaufzeit
    - #L1 hat eventuell kein Zeitverständnis
    - eventuell Effizienzverlust
1. Symbolorientiert
2. Mengenorientiert
3. Bitorientiert
4. Nutzung von invaliden Symbolen vom #L1
Dabei kann eine Kombination von verschiedenen Methoden verwendet werden.

==== symbolorientierte Übertragung

Kontrollfelder sind Frame Flag und sind abhängig von der Codierung des Frameinhalts.

Der Inhalt kann dabei Kontrollsymbole enthalten.
Zur Lösung wird "Character Stuffing" verwendet.
Jedes Kontrollsymbol wird von einem "#DLE" Symbol vorausgegangen.
Dies geschieht nicht im Inhalt des Frames.
Der Empfänger interpretiert nur Kontrollsymbole mit existierenden #DLE.
Falls ein #DLE im Inhalt vorkommt, wird ein weiterer #DLE eingefügt.
Der Empfänger ignoriert aufeinanderfolgende #DLE's.
Das Einfügen von #DLE erfordert dabei weitere Zeit und mehr Aufwand.

==== mengenorientierte Übertragung

Frame enthält "Length Count Field".
Während der Übertragung kann das Feld desynchronisiert werden.
Dadurch wird unklar wann ein Frame anfängt und das nächste beginnt.

==== bitorientierte Übertragung

Spezielles Bitmuster wird als Flag verwendet.
Dieses Muster ist unabhängig von der Codierung.
Anfangs- und Endflag können unterschiedlich sein, sind aber meistens identisch.

Der Inhalt kann dabei Flags enthalten.
Als Lösung wird "Bit Stuffing" verwendet.
Dabei wird ein Bit nach einer bestimmten Anzahl von Bits eingefügt.
Der Sender ignoriert dann den eingestopften Bit.

==== Nutzung von invaliden Symbolen aus dem #L1

Beispiel: Return-To-Zero Codierung.
$high high$ Symbol existiert nicht.
Effektiv, aber inkonsistent mit dem Layer-Modell.

== Fehlererkennung und -behebung

Ursachen für Fehler
- thermisches Rauschen
    - Bewegung der Elektronen erzeugt Hintergrundrauschen
- Impulsstörung
    - Probleme in den Leitungen
    - Blitzeinschläge
- Übersprechnung durch benachbarte Leitungen
- Echo
- Interferenz durch andere elektronische Geräte
- Signalverzerrungen

Dabei gibt es Bitfehler (Modifikation eines einzelnen Bits) und Burstfehler (Modifikation von einer Sequenz von Bits).
Ein Fehler ist meistens ein Burstfehler.

== Herangehensweisen

=== Fehlererkennung

Es werden Redundanzen eingefügt, sodass der Empfänger ein Fehler feststellen kann.
Fehlerbehandlung muss dabei separat gehandhabt werden (z.B. durch erneutes Senden).

=== Fehlerbehandlung

Es werden Redundanzen eingefügt, sodass der Empfänger Fehler erkennen und beheben kann.

==== Hamming-Distanz

Anzahl der Unterschiedlichen Bitpositionen.

Die Hamming-Distanz zwischen zwei Wörtern `w1` und `w2` ist die Anzahl der unterschiedlichen Bitpositionen.
$
        && "w1" & mono(10001001) \
    xor && "w2" & mono(10110001) \
        &&    = & mono(00111000) -> d = 3
$

Die Hamming-Distanz von einem Code ist die geringste Distanz zwischen zwei Wörtern im Code.
$
    "w1" mono(10001001) \
    "w2" mono(10110001) \
    "w3" mono(10110011)
$
$"w2" xor "w3" = 1$, und somit ist die Distanz dieses Codes $1$.
