#set text(font: "Inter", size: 1.25em, lang: "de")
#show math.equation: set text(font: "Fira Math")
#set math.mat(delim: "[")
#show link: content => [#underline(text(fill: blue, content)) 🡵]

#set line(length: 100%)
#show image: img => align(center, img)

#let Hz = $"Hz"$
#let bps = $"bps"$
#let kbps = $"kbps"$
#let ms = $"ms"$
#let bit = $"bit"$
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
// Data link layer Service Access Point
#let DSAP = [Data link Service Access Point]

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

#table(
    columns: 3,
    align: center + horizon,
    table.header(table.cell([Layer], colspan: 2), [Datenentität]),
    [5], [Application], [...],
    [4], [Transport], [...],
    [3], [Network], [Paket (packet)],
    [2], [Data Link], [Frame],
    [1], [Physical], [Bitstream],
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

=== Herangehensweisen

==== Fehlererkennung

Es werden Redundanzen eingefügt, sodass der Empfänger ein Fehler feststellen kann.
Fehlerbehandlung muss dabei separat gehandhabt werden (z.B. durch erneutes Senden).

==== Fehlerbehandlung

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

===== Erkennung und Behandlung nach Hamming

Hamming-Distanz entscheidet über die Erkennungs- und Behandlungsmerkmale von einem Code.

===== 1-Bit Fehler

Beispiele:

#let parity(content) = text(content, fill: blue)

Wert ${0,1}$; Parity ${parity(0),parity(1)}$

#heading_[Eindimensional]
$
    mat(delim: #none, 0, 0, parity(0); 0, 1, parity(1))
$

#heading_[Zweidimensional]
$
    mat(
        delim: #none,
        0, 0, 1, 1, 0, parity(0);
        1, 1, 1, 1, 1, parity(1);
        1, 0, 0, 0, 0, parity(1);
        1, 1, 0, 0, 0, parity(0);
        0, 0, 0, 0, 1, parity(1);
        parity(1), parity(0), parity(0), parity(0), parity(0), parity(1);
    )
$

====== Erkennung

Wenn gilt
$
    d >= f + 1
$
dann generieren $f$ und weniger Fehler ein invalides Codewort.

Beispiel
$
    mat(
        delim: #none,
        0, 0, parity(0);
        0, 1, parity(1);
        1, 0, parity(1);
        1, 1, parity(0);
    )
$

Bei $1 1 parity(0): d = 2$.
Somit $max f = 1$, also Erkennung eines 1-Bit Fehlers.

====== Behandlung

Wenn gilt
$
    d >= 2 dot f + 1
$
dann erzeugen $f$ und weniger Fehler aus einem Wort $w$ ein invalides Wort, welches näher zu $w$ ist als zu jedem anderen Wort.

Beispiel
$d=5: f <= 2$:
$
    mat(
        delim: #none,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
        0, 0, 0, 0, 0, 1, 1, 1, 1, 1;
        1, 1, 1, 1, 1, 0, 0, 0, 0, 0;
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1;
    )
$
bei zwei 1-Bit Fehlern kann das Wort $0000000111$ entstehen.
Das nächste Wort ist $0000011111$ (mit $d(0000000111 xor 0000011111) = 2$).

Untere Schranke für die Anzahl der Parity-Bits:
$
    m + r + 1 <= 2^r
$
mit Data-Bits $m$ und Parity-Bits $r$.

z.B.: $m = 8 => r = 4$, $m = 1000 => r = 10$

#heading_[Behandlung von Burstfehlern von Länge $k$]

$k$ hintereinanderfolgende Codewörter als Matrix.
Übertragung erfolgt pro Spalte.

Nutzvoll, wenn nur Simplex-Kommunikation verfügbar ist.
Hat aber hohe Redundanz pro Block.

Generell weniger nützlich als nur Fehlererkennung alleine.

==== Cyclic Redundancy Check (CRC)

Grundidee: Bits werden als Polynome behandelt.
Bei $n$ Bit:
$
    k_(n-1) dot x^(n-1) + k_(n-2) dot x^(n-2) + ... + k_1 dot x^1 + k_0
$
mit $k_i in {0,1}$.

z.B. ist $110001 = x^5 + x^4 + 1$.

===== Algorithmus

$B$ zu versendender Block

$B(x)$ Blockpolynom

$G(x)$ Generatorpolynom vom Grad $r < deg B(x)$.
Höchstes und geringstes Bit sind $1$.

1. Addiere $r$ $0$-Bits am unteren Ende von $B$. Das Ergebnis ist $B^E = x^r dot B(x)$.
2. Berechne $B^E(x) slash G(x)$. Das Ergebnis ist $Q(x) + R(x)$.
    - Addition und Subtraktion sind durch $mod 2$ equivalent zu $xor$
3. Berechne $B^E - R(x) mod 2$. Das Ergebnis wird übertragen.

- Sender: Berechnung von $B(x) slash G(x) = Q(x) + R(x)$
- Versendung von $(B,R)$
- Empfänger: Berechne $(B(x)-R(x)) slash G(x) = Q(x) + R'(x)$

Wenn $R'(x) = 0$, nehme $B$ an.
Ansonsten lehne $B$ ab.

#line()

Standardisierte Polynome:
- CRC-12: $x^12 + x^11 + x^3 + x^2 + x + 1$
- CRC-16: $x^16 + x^15 + x^2 + 1$
- CRC-CCITT: $x^16 + x^12 + x^5 + 1$

Anerkennung von
- alle Simplex und Duplikatsfehler
- Alle Fehler mit einer ungeraden Anzahl von Bits
- Alle Burstfehle bis zu Länge 16
- 99.99% von allen Burstfehlern mit Länge 17 oder mehr
durch CRC-CCITT

Implementation ist einfach durch Shift-Register in Hardware.
So gut wie alle LAN's verwenden CRC.

#pagebreak()

== Flusskontrolle

Grundproblem: Sender kann schneller senden als Empfänger empfangen kann.
Flusskontrolle dient zur Verhinderung dieses Problems.

Normalerweise sind Flusskontrolle und Fehlerkontrolle verbunden.

=== Protokoll 1: Utopia

Annahmen:
- fehlerfreier Kommunikationskanal
- Empfänger hat unendliche Puffergröße
- Empfänger kann Frames unendlich schnell bearbeiten

Simples senden von Frames.

=== Probleme 2: Stop-and-Wait

Annahmen:
- fehlerfreier Kommunikationskanal
- Empfänger hat endliche Puffergröße
- Empfänger hat endliche Bearbeitungsgeschwindigkeit
    - schnell genug für ein Frame

Sender sendet ein Frame und Empfänger sendet ein ACK. Ein neues Frame wird erst nach einem ACK gesendet.

Benötigte Eigenschaften:
- Empfänger hat Platz für ein Frame
- Kommunikation in beide Richtungen

Die Kommunikation verriegelt, wenn ein Frame oder ACK verloren geht.

=== Protokoll 3a: Stop-and-Wait / ARQ

ARQ: "Automatic Repeat reQuest" \
auch PAR ("Positive-Acknowledgement with Retransmit") genannt

Annahmen:
- kein fehlerfreier Kommunikationskanal
- Empfänger hat endliche Puffergröße
- Empfänger hat endliche Bearbeitungsgeschwindigkeit

Sender started beim Senden einen Timeout für den Frame. Wenn kein ACK innerhalb des Timeouts erhalten wurde, wird der Frame erneut gesendet.

zu kurzer Timer: unnötige Neuübertragung \
zu langer Timer: unnötiges Warten bei Fehlern

=== Protokoll 3b: Stop-and-Wait / ARQ / SeqNo

Behandelt das Problem von Verlust von ACK's.

Jeder Frame erhält eine Sequenznummer, wodurch nur neue Frames vom Sender akzeptiert werden.

Die Sequenznummern sind im Bereich ${0,1}$ bei Stop-and-Wait und zwischen ${0,...,2^n - 1}$ im Generellen, wobei $n$ die Fenstergröße ist.

=== Protokoll 3c: Stop-and-Wait / NAK+ACK / SeqNo

Aktive Fehlerkontrolle durch das senden von NAK, wenn ein schlechter Frame erhalten wurde.
Dadurch wird der Timeout, welcher normalerweise indirekt beim verwerfen von schlechten Frames erzeugt wird, umgangen.

=== Sliding Window

Sender und Empfänger haben pro Verbindung Sender und Empfänger Fenster.
Das Senderfenster enthält Sequenznummern, welche gesendet, aber noch nicht anerkannt wurden.
Das Empfängerfenster enthält enthält Sequenznummern, welche angenommen werden können.

Die gesendeten Frames werden in Puffern vom Sender bzw. Empfänger gespeichert, bis entsprechende ACK's erhalten werden.
Es können maximal so viele Frames wie die Fenstergröße gesendet werden.
Der Empfänger sendet ein ACK, wenn der Frame korrekt übertragen und korrekt identifiziert wurde.

#table(
    columns: (auto, 1fr, 1fr),
    table.header([Grenze], [Sender], [Empfänger]),
    [obere], [älteste, noch nicht bestätige Sequenznummer], [nächste erwartete Sequenznummer],
    [untere], [nächste zu sendene Sequenznummer], [höchste akzeptierbare Sequenznummer],
)

Manipulation: Grenzen werden erhöht, wenn
#table(
    columns: (auto, 1fr, 1fr),
    table.header([Grenze], [Sender], [Empfänger]),
    [obere], [Empfang eines ACK's], [Empfang eines Frames],
    [untere], [Senden eines Frames], [senden eines ACK's],
)

Wenn die Fenstergröße $n = 1$ ist, dann ist jede Sequenz immer korrekt.
Bei einer Fenstergröße von $n > 1$ können Sequenzen Fehlerhaft sein, aber die maximale Verschiebung der Sequenznummern ist durch die Fenstergröße beschränkt.

Die Effizienz ist abhängig von
- Art und Menge der Fehler im #L1
- Datenmenge pro Frame
- Übertragungsrate
- End-to-End Verzögerung
- Fenstergröße

Bei kleiner Fenstergröße ist die End-to-End Verzögerung am #L2 Service Interface allgemein geringer.
Dazu wird auch weniger Arbeitsspeicher benötigt.

==== Piggybacking

Bei einer Full-Duplex Verbindung (beide Stationen senden volle Frames) können ACK's mit den Frames mitgesendet werden.
Die ACK's geben dabei die nächste erwartete Sequenznummer an.
Ein Frame hat dadurch den Inhalt `Frame(SeqNo,ACK-SeqNo,...Data)`.
Der erste Frame der gesamten Verbindung erhält Sequenznummer 0 und `ACK-SeqNo` 0.

==== Go-Back-N

Normalerweise werden alle Frames nach einem fehlerhaften Frame verworfen.
Somit müssen alle Frames nach dem fehlerhaften Frame erneut übertragen werden.

Es ist simpel, da keine Frames außerhalb der Sequenz gespeichert werden müssen, hat aber einen schlechten Durchlass.

Bei $n$ Sequenznummern muss die Fenstergröße $k <= 1/2 n$ sein, da ansonsten erneute Übertragungen nicht eindeutig zugeordnet werden können.

==== Selective Repeat

Empfänger speichert alle korrekten Frames, selbst wenn diese nach einem fehlerhaften Frame erhalten wurden.
Der Sender wird über den fehlerhaften Frame informiert und überträgt nur diesen Frame neu.

== Kanalauslastung

#let Tip = $"T"_"ip"$
#let Tit = $"T"_"it"$
#let Tic = $"T"_"ic"$
#let Tap = $"T"_"ap"$
#let Tat = $"T"_"at"$
#let Tac = $"T"_"ac"$
#let Tp = $"T"_"p"$

== Stop-and-Wait

Stop-and-Wait Verfahren hat eine schlechte Kanalauslastung, da nach jedem Frame gewartet werden muss.

Beispiel: Satellitenkanal

Übertragungsrate: $50 kbps$, round-trip-delay: $2 dot 250 ms = 500 ms$, Framegröße $1000 bit$, ACK ist kurz und im Vergleich zu Frames vernachlässigbar.

Senden eines Frames brauch $1000 bit slash 50 000 bps = 20 ms$.
Durch Stop-and-Wait ist der Sender für $500 ms$ von $520 ms$ blockiert.
Effektive Nutzung von $20 ms$ mit Kanalauslastung von $520 ms$.

Die Kanalauslastung ist damit zu $1 - (500 ms slash 520 ms) approx 4%$ ausgelastet.

#line()

#grid(
    columns: 2,
    row-gutter: 0.75em,
    Tip, [Ausbreitungsverzögerung eines Frames (Sender -> Empfänger)],
    Tit, [Übertragungszeit eines Frames (Sender -> Empfänger)],
    Tic, [Bearbeitungszeit eines Frames (Empfänger)],
    Tap, [Ausbreitungsverzögerung eines ACK's (Empfänger -> Sender)],
    Tac, [Bearbeitungszeit eines ACK's (Empfänger)],
)

Normalerweise gilt $Tip = Tap = Tp$

Genaue Formel
$
    U = Tit/(sum "T"_"information + acknowledgement") = Tit/(Tip + Tit + Tic + Tap + Tat + Tac)
$

Ungefähre Formel
$
    U = Tit/(Tit + 2 Tip) = 1/(1 + 2 Tip/Tit)
$
mit den Annahmen
- $Tip = Tap = Tp$
- $Tic, Tac << Tip, Tap$
- $Tit >> Tat$

== Sliding Window

Mit Fenstergröße $k$:
$
    U = cases((k Tit)/(Tit + 2 Tp) = k/(1 + 2 Tp/Tit) & "wenn" k < 1 + 2 Tp/Tit, 1 & "sonst")
$

== LAN

Ein LAN ist ein Netzwerk für die bit serielle Übertragung von Informationen zwischen Komponenten, die unabhängig und miteinander verbunden sind.
Das Netzwerk ist zudem legal von dem Nutzer kontrolliert und die Reichweite is (normalerweise) auf die Grundstücksgrenzen beschränkt.

Eigenschaften:
- relativ hohe Geschwindigkeit
- leichte und (relativ) billige Verbindungen
- keine Regulierungen bezüglich Telekommunikations
- limitierte Distanz (wenige Kilometer)
- Übertragung von verschiedenen Arten von Daten
    - Text
    - generelle Daten
    - Bilder
    - Audio
    - Video
- Verbindung von verschiedenen Geräten
    - Computer
    - Terminals
    - Drucker
    - Speichereinheiten
- mehrere Sender und Empfänger teilen einen Kommunikationskanal bzw. Kommunikationsmedium
    - Medium Access Control (MAC) wird benötigt

MAC wird benötigt, da ansonsten mehrere Geräte gleichzeitig kommunizieren.
Statische Kanalvergabe, durch Multiplexing wie FDM oder TDM, ist einfach, funktioniert aber nicht gut mit sprunghaften Übertragungen.

=== Dynamic Channel Allocation

Annahmen
1. Stationsmodell
    - $N$ unabhängige Stationen (z.B. Computer), welche Frames für die Übertragung erstellen
    - Stationen blockieren Verbindung, bis der Frame erfolgreich versendet wurde
2. Einkanalannahme
    - Es existiert nur ein Kanal für die gesamte Kommunikation
3. Kollisionsannahme
    - Wenn 2 Frames gleichzeitig gesendet werden, überlagern sich diese. Somit ist das Signal verzerrt. (= Kollision)
    - Stationen können eine Kollision erkennen
4.
    a. kontinuierliche Zeit
    - Übertragung eines Frames kann zu jeder Zeit beginnen
    b. Zeitfenster
    - Zeit ist in diskrete Intervalle (Slots) unterteilt
    - Übertragung eines Frames beginnt am Anfang eines Slots
    - Ein Slot kann 0 (Leerlauf), 1 (erfolgreiche Übertragung), 2+ (Kollision) Frames enthalten
5.
    a. Kanalwahrnehmung
    - Stationen wissen, ob ein Kanal in Benutzung ist, bevor sie versuchen ihn zu verwenden
    - Wenn ein Kanal in Verwendung ist, versucht keine Station zu senden bis dieser frei ist
    b. keine Kanalwahrnehmung
    - Stationen können den Kanal nicht untersuchen

=== Polling

Kontrollstation gibt an, wann und wer senden darf.
Ein Ausfall der Kontrollstation sorgt für den Ausfall des gesamten Netzwerkes.
Dazu wird Kapazität für das Nachfragen verbraucht.

=== Token Ring

IEEE 802.5

Stationen formen einen virtuellen oder physischen Ring.
Ein Token (die Erlaubnis zum Senden) wird herumgereicht.
Der Token wird dabei beim Senden vom Ring entfernt und nach dem Senden erstellt die Station einen neuen Token.
Es ist ein deterministisches und faires Verfahren.

==== Frameformat

Token:
#table(
    columns: 2,
    align: (center + horizon, center + horizon, left),
    table.header([Bytes], [Funktion]),
    [1], [Starting Delimiter],
    [1], [Access Control],
    [1], [Ending Delimiter],
)

Frame:
#table(
    columns: 3,
    align: (center + horizon, center + horizon, left),
    table.header([Bytes], [Funktion], [Beschreibung]),
    [1],
    [Starting Delimiter],
    [
        `SD AC` mit $T$ = "1" als "Start of Frame" Sequenz
    ],

    [1],
    [Access Control],
    [
        ermöglicht Prioritäten und Reservierungen

        enthält Token-Bit $T$
        - $T$ = "0": Token
        - $T$ = "1": Daten
        "entferne Token vom Ring" entspricht $T :=$ "1"
    ],

    [1], [Frame Control], [],
    [2 / 6], [Zieladresse], [],
    [2 / 6], [Quelladresse], [],
    [unlimitiert], [Daten], [],
    [4], [Checksumme], [],
    [1], [Ending Delimiter], [],
    [1], [Frame Status], [],
)

=== ALOHA

==== Pure

Zwei Kanäle:
1. zentraler Host zu allen Stationen.
2. alle Stationen zum Host

Übertragung ohne jegliche Koordination.
Sender hört den Rückkanal auf ACK's vom Host ab.
Bei Kollision werden die Daten nach einer zufälligen Zeit erneut Übertragen.
Potentiell kann es viele Kollisionen geben.

==== Slotted

Zeitunterteilung in Slots.
Übertragung von Frames kann nur zu Beginn eines Slots geschehen.
Benötigt zentrale Synchronisierung, reduziert aber das Kollisionsfenster um die Hälfte.

==== Durchlass

Annahme: eine vielzahl von Stationen

Sei
- $t$ Sendezeit eines Frames
- $S$ Menge der neuen Anfragen einen Frame pro Sendezeit $t$ zu senden
- $G$ alle zu sendenden Anfragen

#grid(
    columns: (auto, 1fr),
    align: horizon,
    [
        maximale Kanalauslastung:
        - pure ALOHA: $1/(2e) approx 0.184$
        - slotted ALOHA: $1/e approx 0.368$
    ],
    image("ALOHA-comparisons.svg", height: 150pt),
)

=== Carrier Sense Multiple Access (CSMA)

CSMA überprüft vor dem Senden, ob eine Übertragung möglich ist.

Kanalstatus
1. in Verwendung
    - Station wartet bis Kanal frei ist
    - Entweder
        - kontinuierliche Überprüfung, ob Kanal verfügbar ist
        - gewisse Zeit warten, dann erneute Überprüfung
2. Leerlauf
    - Übertragung eines Frames
    - Kollision kann auftreten
3. Kollision
    - Station wartet eine zufällige Zeit, überprüft dann den Kanal erneut

==== 1-Persistent

Prinzip:
- Frame soll gesendet werden
- Überprüfung des Kanals
    - in Verwendung
        - kontinuierliche Überprüfung, ob Kanal frei ist
    - Leerlauf
        - Sende Frame (mit Wahrscheinlichkeit 1)
    - Kollision
        - warte zufällige Zeit, überprüfe dann erneut

Die Verzögerung der eigenen Station wird minimiert.
Jedoch entstehen viele Kollisionen bei hoher Auslastung.

==== Nicht-Persistent

Prinzip:
- Frame soll gesendet werden
- Überprüfung des Kanals
    - in Verwendung
        - erneute Überprüfung erst nach einer zufälligen Zeit
    - Leerlauf
        - sende Frame
    - Kollision
        - warte zufällige Zeit, überprüfe dann erneut

Es wird angenommen, dass andere Stationen auch senden wollen.
Dadurch ist es besser die Überprüfungsintervalle zufällig zu bestimmen.
Es ist generell effizienter, jedoch ist die Verzögerung für einzelne Stationen erhöht.

==== P-Persistent

Aufteilung der Zeit in Zeitslots.

Prinzip:
- Frame soll gesendet werden
- Überprüfung des Kanals
    - in Verwendung
        - kontinuierliche Überprüfung, ob der Kanal frei ist
    - Leerlauf
        - sende Frame mit Wahrscheinlichkeit $p$
        - warte mit Wahrscheinlichkeit $1 - p$ für den nächsten Slot
        - überprüfe nächsten Slot
    - Kollision
        - warte zufällige Zeit, überprüfe dann erneut

Kompromiss zwischen Verzögerung und Durchlass, definiert durch den Parameter $p$.

==== CD

"Carrier Sense Multiple Access with Collision Detection" = CSMA-1 mit persistenter Kollisionserkennung

Station brechen Übertragung ab, sofort eine Kollision festgestellt wird.
Spart Zeit und Bandbreite.
Häufige Verwendung (z.B. in IEEE 802.3 Ethernet).
Algorithmus im Signal muss Kollisionserkennung ermöglichen.
Während der Übertragung des Frames vergleicht die Station das gesendete und erhaltene Signal.
Streitperiode ist unterschiedlich.

Schlimmster Fall: kleine Frames und lange Distanz zwischen Stationen.
Eine Station kann nur nach der vollen RTT sicher sein, dass keine Kollision aufgetreten ist.

Im Generellen gibt es nur exakt einen Weg zwischen zwei Stationen im Ethernet.

Sei $1 <= n <= 16$ die Anzahl der fehlgeschlagenen Sendeversuche, $k = min{n,10}$, $Delta t$ die Sendezeit von 512 Bits mit $0 <= r < 2^k$.

Es gilt:
$
    "backoff" = r dot Delta t
$
\= Binary Exponential Backoff Algorithmus
#table(
    columns: 2,
    table.header([Versuch], [Wartezeit in Frames]),
    $1$, $0,1$,
    $2$, $0,1,2,3$,
    $3$, $0,1,2,3,4,5,6,7$,
    $n$, $0,...,2^(k-1)$,
    $16$, [Fehler zu #L3],
)

Effekte:
- bei höherer Last entstehen längere Wartezeiten
- geringere Kanalauslastung bei mehr Station
- höhere Kanalauslastung bei längeren Frames

===== Switches

Kollisionsdomäne:
Kollisionen sind intern möglich, aber nicht mit anderen Domänen.

Bei Hubs und Repeater wird die Kollisionsdomäne beibehalten.
Alle verbundenen Stationen sind also auf der selben Domäne.
Um Kollisionen zu vermeiden, werden Switches anstatt Hubs verwendet.

Ein Switch erhält ein Frame von einer Station.
Zuerst wird versucht das Ziel innerhalb des "Boards" zu finden.
Falls das nicht möglich ist, wird eine anderer Standort versucht.
Dabei wird das Frame (wenn möglich) nicht an alle Stationen weitergeleitet.


==== CA

Nach einem übertragenen Frame wird durch zufälliges Warten bestimmt, welche Station senden darf.
IFS "Inter Frame Space" um den Kanal zu belegen.
Die Länge des IFS bestimmt die Priorität der Übertragung (kurze IFS wird früher gesendet).
Wenn das Medium länger Frei ist als das gesamte IFS, dann ist der Kanal frei.

==== MACA

"Multiple Access with Collision Avoidance"

Verwendung von kleinen Paketen zur Koordination und damit zur Kollisionsvermeidung.
Sender sendet Anfrage zum Senden zu einem Empfänger durch RTS (Request To Send) Paket.
Empfänger bestätigt die Anfrage, wenn dieser bereit ist zu empfangen durch ein CTS (Clear To Send) Paket.
Die Pakete enthalten Quelladresse, Zieladresse, und Paketgröße.

Dies ist wichtig, wenn Station verdeckt sind.
Verdeckte Station sind z.B. bei kabellosen Netzwerk außerhalb der Reichweite einer Station, wodurch Kollisionserkennung nicht möglich ist.
Bei sichtbare Stationen ist die Erkennung von Übertragen und damit Kollisionserkennung möglich.

Beispiel: \
Reichweite der Stationen:
- A erreicht B
- B erreicht A und C
- C erreicht B

1. verdeckte Terminals: A und C wollen an B senden.
    - A sendet RTS zuerst.
    - B sendet CTS and A und C.
    - C wartet da der CTS nicht zu C gehört
2. sichtbare Terminals: B will an A senden, C an ein anderes Gerät
    - B sendet RTS an A und C
    - A sendet CTS zurück
    - C erhält das CTS nicht und kann senden

#pagebreak()

===== Frameformat

#table(
    columns: 3,
    rows: (auto, auto, 1fr, 1fr, auto),
    align: (center + horizon, center + horizon, left),
    table.header([Bytes], [Funktion], [Beschreibung]),
    [8],
    [Präambel + FSD],
    [
        - 7 Bytes `10101010` zur Synchronisierung der Clock
        - Start Frame Delimiter `10101011`
    ],

    [6],
    [Zieladresse],
    table.cell(rowspan: 2, [
        - als MAC Adresse
        - lokale Adressgebung durch lokale Autorität
        - globale Adressgebung durch IEEE
            - #L3 muss Adresse suchen

        48 Bits eingeteilt in
        - Bit 0:
            - "0": individuelle Adresse
            - "1": Gruppenadresse
        - Bit 1:
            - "0": global verwaltete Adresse
            - "1": lokal verwaltete Adresse
        - restlichen 46 Bit als Adresse
        \
        - Unicast = individuelle Adresse
        - multicast = Gruppenadresse
        - Broadcast = alle Adressbits sind "1"

    ]),
    [6], [Quelladresse],
    [2],
    [Art oder Länge],
    [
        Alt: Anzahl der Bytes im Datenfeld \
        Neu: Art, zeigt Protokoll des oberen Layers (IP, IPX).
        Es werden nur werte über `0x0600` (der maximalen Datengröße) verwendet.

        z.B.
        - `0x0800`: IPv4
        - `0x0806`: ARP (Address Resolution Protocol)
    ],
    [0 - 1500], [Daten], [Daten des Frames],
    [0 - 46], [Padding], [mindestens 64 Byte pro Frame],
    [4],
    [FCS],
    [
        Frame Check Sum. 32 Bit CRC ohne Präambel und SFD berechnet.
    ],
)

=== LLA

"Link Layer Addressing"

MAC Adresse als Sendeadresse, um ein Frame von einem Interface zu einem anderen zu senden.
Alternativ auch LAN, physische, oder Ethernet Adresse.

MAC Adresse ist portabel, da sie fest für jedes Interface ist. IP Adresse ist nicht portabel - sie hängt vom Subnet ab.

#page(
    grid(
        columns: 1,
        align: center + horizon,
        rows: 1fr,
        image("transmission-types.svg"),
        image("transmission-performance.svg"),
    ),
)

== Internetworking

#table(
    columns: 2,
    table.header([Layer], [Gerät]),
    [#L4, #L5], [Gateway],
    L3, [Router],
    L2, [Bridge],
    L1, [Repeater],
)

Layer 1: Repeater / Hub
- kopiert Bits zwischen Kabeln
- keine Modifikation der Informationen (ist nur ein Verstärker)
- eine Kollisionsdomäne

Layer 2: Bridge
- Vermittlung zwischen LAN's (MAC Level)
- geringe Veränderung der Frames
- jede Verbindung ist ihre eigene Kollisionsdomäne

Layer 2: Switch
- geringe Veränderung der Frames
- jede Verbindung ist ihre eigene Kollisionsdomäne
- Vermittlung zwischen Endsystemen

Layer 3: Router
- alternativ auch Level 3 Router
- Weiterleitung von Paketen zwischen verschiedenen Netzwerken
- Modifiziert Pakete
- Konvertierung zwischen verschiedenen Adressierungskonzepten

Layer 4 + 5: Gateway
- alternativ auch Protokollkonvertierer
- Konvertierung von Protokollen
    - meistens gibt es keine 1-zu-1 Abbildungsfunktion

#pagebreak()

=== Geräte

==== Repeater
- Verstärkung von Signalen um die Reichweite zu erhöhen

==== Bridge

- Verknüpfung mehrerer LAN's
- Skalierbarkeit von Netzwerken
- verbesserte Zuverlässigkeit und Sicherheit
- Unabhängigkeit von Protokollen

-> Ziel: Transparenz
- Netzwerkkomponenten sehen Bridge nicht
\
- Tabelle mit Systemeinträgen wird dynamisch erstellt
    - Frame mit Quelladresse wird als "in diesem LAN erreichbar" für einige Minuten gespeichert

Spanning Tree
- Vermeidung von Loops durch Bildung eines Baums
- jedes LAN bekommt eine repräsentative Bridge, woraus ein Baum gebildet werden kann
- Baum hat keine Loops, ignoriert aber Verbindung

Alternative: Source Routing Bridge
- Pfad definiert durch Sender
- LAN und Bridge benötigen eindeutige Adresse
- jede Bridge im Netzwerk routet diesen Frame
    - hohe Netzwerklast

==== Router

- Datentransfer von Endsystem zu Endsystem über mehrere Sprünge und heterogene Netzwerke
- kompensiert für Unterschiede der Endsysteme bei der Übertragung

==== Gateway

- Anpassung der Datenformate und Kontrollprotokolle

= Network Layer (L3)

Ziel ist die Datenübertragung von Endsystem zu Endsystem.
Dabei muss für Unterschiede in den Endsystemen und im #L2 während der Übertragung kompensiert werden.

Die Service sind
- für Endsysteme standardisiert
- unabhängig von der Netzwerktopologie
- unabhängig von der Anzahl, Art, und Topologie der Subnetzwerke

Funktionen
- Datenübertragung basierend auf #link("https://de.wikipedia.org/wiki/Datagramm", [Datagrammen]) oder virtuellen Schaltkreisen
- routing
- Internetworking
- Adressierung
- Fragmentation und Wiederzusammenbau

sekundäre Funktionen (meist nur für spezifische Arten)
- Staukontrolle
- Quality of Service
- Multiplexing von Netzwerkverbindungen
- Fehlererkennung und -behandlung
- Flusskontrolle
- Übertragungsreihenfolge beibehalten

Switching:
- Circuit Switching
    - Switching einer physischen Verbindung
- Message Switching
    - Nachricht wird von einem Hop gespeichert und weitergegeben
- Packet Switching
    - Store-And-Forward
    - Pakete sind von begrenzter Größe
- Virtual Circuit Switching
    - Pakete über einem vordefinierter Pfad

== Circuit Switching

Switching mittels dedizierten Pfad während der gesamten Übertragung.
Historisch auf Switching Boards.

Verbindung muss vor Übertragung erstellt werden.
Feste zugeteilte Bandbreite.
Keine Datenverarbeitung durch anderen Knoten.

== Message Switching

"Store-And-Forward"
+ erhalte Nachricht
+ überprüfe Nachricht und behandle Fehler, wenn vorhanden
+ speichere Nachricht
+ leite Nachricht weiter

Alle Daten werden als Nachricht behandelt.
Da alle Nachricht gespeichert werden, ist der Speicheraufwand von jedem Knoten hoch.
Dazu kann ein Knoten von einer Nachricht voll ausgelastet werden.

== Packet Switching

Pakete haben unterschiedliche Größe.
Die Route der Pakete wird dynamisch bestimmt.
Somit kann Bandbreite dynamisch vergeben werden, jedoch ist auch ein Stau möglich.
Pakete kommen weder sequenziell noch zuverlässig an, und die End-to-End Verzögerung kann variieren.

== Virtual Circuit Switching

Switching mittels dedizierten Pfad während der gesamten Übertragung.
Es wird keine physische Verbindung verwendet, sondern Zustandsinformationen in Knoten.

#pagebreak()

== Packet Switching - Circuit Switching

#table(
    columns: (1fr, 1fr),
    table.header([Packet Switching], [Circuit Switching]),
    [
        Verbindungsphase nicht unbedingt notwendig
    ],
    [
        Verbindungsaufbau kann einige Zeit benötigen
    ],

    [
        dynamische Zuweisung von Bandbreite
        - Staugefahr
        - optimierte Kanalauslastung
    ],
    [
        feste Bandbreite
        - keine Staugefahr
        - eventuell geringe Auslastung des Kanals
    ],

    [
        variierende Übertragungszeit
    ],
    [
        feste Übertragungszeit
    ],

    [
        Preiskalkulation basierend auf der übertragenden Datenmenge
    ],
    [
        Preiskalkulation basierend auf der Verbindungsdauer
    ],
)

== Services

=== Verbindungsbasiert

- Ziel: fehlerloser Übertragungskanal
- Fehlerfluss im #L3
- üblicherweise Duplex Kommunikation
- besser für Echtzeitkommunikation geeignet

3 Phasen Verbindungsaufbau:
+ verbinden
+ Datentransfer
+ trennen

Es erlaubt für die Verhandlung der Servicequalität (Durchlass, Fehlerwahrscheinlichkeit, Verzögerung).
(üblicherweise) zuverlässige Kommunikation in beide Richtungen: kein Verlust, keine Duplikate, und keine Modifikation.
Besitzt Flusskontrolle und hat relativ komplexe Protokolle.
Es erlaubt die Simplifizierung von höheren Layern und die Aufgaben der Endsysteme.

=== Verbindungslos

- unzuverlässige Kommunikation
- kaum Fehlerkontrolle, #L4 oder höher muss Fehler behandeln
- Simplex Kommunikation
- besser für einfache Kommunikation geeignet

Die Pakete werden als unabhängige, isolierte Einheiten (Datagramme) versendet.
(üblicherweise) unzuverlässige Kommunikation in beide Richtungen: Verlust, Duplikate, Modifikation, und Sequenzfehler sind möglich.
Vergleichsweise simple Protokolle.
Sehr flexibel mit geringer Komplexität.
Vermeidet die hohen Kosten von Verbindungsauf und abbau.
Es erleichtert die Optimierung der Netzwerklast.

== Routing

Ziel: Route für die Pakete durch das Network definieren.

Ein Routingalgorithmus definiert auf welcher ausgehende Verbindung ein eingehendes Paket übertragen wird.
Bei einem Datagramm wird diese Entscheidung für jedes Paket gemacht.
Bei virtuellen Schaltkreisen wird die Entscheidung einmalig für alle Pakete des selben Flusses gemacht.

=== Routingprozess

Dabei entscheidet Routing welche Route verwendet wird und Forwarding was passiert, wenn ein Paket ankommt.
Der Routingprozess nutzt die Informationen über die Topologie und Netzwerkauslastung um die Routingtabelle zu füllen.
Der Forwardprozess nutzt die Routingtabelle um zu entscheiden wohin ein Paket weitergeleitet wird.

Ein Routingprozess sollte
- korrekt
- simpel
- robust
    - Kompensation von Verbindungsfehlern
    - Handhabung von Topologie- und Verkehrsänderungen
- stabil
    - konsistente Ergebnisse
    - keine flüchtigen Änderungen zu neuen Bedingungen
- fair
- optimal

Fairness und Optimierung (der Kanalauslastung) sind oft gegensätzlich.
Die Auslastungsoptimierung einer Verbindung kann eine andere komplett ignorieren.
Oft wird die Anzahl der Hops reduziert.

==== nicht-adaptive Algorithmen

Der derzeitige Netzwerkstand wird nicht in Betracht gezogen.
Es werden durchschnittliche Werte verwendet.
Alle Routen sind vor der Inbetriebnahme des Netzwerkes statisch definiert.
Es gibt keine Änderungen während des Betriebs.
Sie sind gut, wenn sich die Topologie oder das Verkehrsvolumen nicht über Zeit verändert.

Wenn das Wissen über die Topologie verwendet wird, kann Spanning-Tree und Flussbasiertes Routing verwendet werden.
Ohne das Wissen wird Flooding verwendet.

===== Dijkstra's Algorithmus

Es wird die kürzeste Distanz zu jedem Knoten in einem gewichteten Graphen gesucht.

+ jeder Knoten hat die Distanz $(circle.filled.tiny, infinity)$
+ ausgehend vom Startknoten, setzte die Distanz der anliegenden Knoten zu $(A,<"Gewicht der Kante">)$
+ wiederhole 2. für jeden Knoten
    - falls ein Knoten mehrmals erreicht wird, wähle die Verbindung mit dem kleinsten Gewicht

===== Flooding

Eine Station überträgt ein empfangenen Paket an alle Leitungen, außer die eingehende.
Dabei würden unendlich viele Pakete entstehen.

Hop-Counter:\
Es kann ein Hop-Counter im Header des Paketes verwendet werden.
Jede Station verringert diesen Zähler um 1 und verwirft das Paket, wenn er 0 erreicht.
Pakete müssen aber mit einem ausreichen großen Hop-Counter initialisiert werden.
Im schlimmsten Fall wird der Durchmesser des Subnetzes verwendet.

Speicherung:\
Jede Station speichert erhaltene Pakete und verwirft bereits erhaltene.
Die Quellrouter fügen dabei eine Sequenznummer in Paketen ein.
Diese Sequenznummer muss von jedem Router pro Quellrouter gespeichert werden.

===== Selective Flooding

Anstatt alle Verbindungen zu fluten, wird das Paket nur an Verbindungen in Richtung des Ziels weitergeleitet.
Dieser Ansatz funktioniert nicht bei allen Topologien.

==== adaptive Algorithmen

Der derzeitige Netzwerkstand wird verwendet.
Durch Messungen oder Schätzungen der Topologie und Verkehrsvolumen werden Entscheidungen getroffen.

===== Adaptive Centralized Routing

Das RCC (Routing Control Center) erhält periodisch von Zwischensystemen Informationen über den Status zum RCC.
Dies enthält unter anderem verfügbare Nachbarn, Länge der Warteschlange, und die Netzwerkauslastung.
Das RCC berechnet die optimale Route für jedes Paar an Zwischensystemen.
Da das RCC alle Informationen besitzt, kann es perfekte Entscheidungen treffen und die Zwischensysteme müssen keine Berechnungen ausführen.
Jedoch sind Neuberechnungen oft notwendig und bei Ausfall des RCC fällt das Routing komplett aus.
Dazu gibt es mehr Verkehr um dem RCC.

===== Distance Vector Routing

Algorithmen bekannt als Bellman-Ford Algorithmus und Ford-Fulkerson Algorithmen.

Verwendet im Internet als RIP (Routing Information Protocol).

Die Zwischensysteme pflegen eine Tabelle (= ein Vektor), in welcher die beste Distanz zu Zielen enthält und welche Verbindung verwendet werden soll.
Die Zwischensysteme aktualisieren die Tabelle indem sie Informationen mit ihren Nachbarn austauschen.
Bei Internet-RIP wird dieser Austausch alle 30 Sekunden mit einer maximalen Hop-Anzahl von 15 Hops ausgeführt.

// more details on protocols: Network layer part 2, page 79

===== Link State Routing

+ bestimme Adresse von benachbarten Stationen
    - sende `HELLO` Nachricht an Stationen über #L2 Kanal
    - Stationen antworten mit eigener, im Netzwerk einzigartige Adresse
+ miss Distanz zu benachbarten Stationen
    - Distanz = Delay
    - Durchschnitt von mehreren Nachrichten, teilweise auch mit Payload
+ organisiere Informationen in einem Paket
    - Adresse, Sequenznummer, Alter, Distanzen
+ verteile Informationen an alle anderen Stationen
    - Flooding als LSP (Link State Packet)
    - zu alte Pakete werden vom Netzwerk entfernt
+ berechne Route basierend auf den Informationen

== Addressing

Drei Arten von Kennzeichen:
#grid(
    columns: 2,
    column-gutter: 0.75em,
    row-gutter: 0.75em,
    [Name], [Was wird gesucht?],
    [Adresse], [Wo ist es?],
    [Route], [Wie man dorthin gelangt],
)

=== Sink-Tree

Ein Sink-Tree ist das Set von optimalen Routen von allen Quellen zu einem bestimmten Ziel erzeugen einen Baum, welcher am Ziel entsteht.
Dieser Baum wird Sink-Tree genannt.

= Protokolle

== HDLC

#text(fill: red, [Als Beispiel vorgestellt!])

Bitorientiert und Full-Duplex.
Verwendet Bitstuffing (nach 5 "1" kommt immer eine "0").

Frameformat:
- Address
    - Adressierungsstationen
    - bei Point-to-Point #L1 kann die Adresse zur Unterscheidung von Befehl und Antwort dienen
- Control
    - Sequenznummern
    - ACK's
    - Datenübertragungsinformationen
    - Kontrollmanagement
    - Verbindungsmanagement
- Data
    - Nutzerdaten
- Checksumme
    - Frame Check Sequence (FCS) - Variation von CRC

Informationsframe:
- "0"
- Sequenznummer
- Poll/Final
- Next
    - nächste erwartete Framenummer

Aufsichtsframe:
- "10"
- Art
    - "00" Receive Ready: effektiv ACK, Next ist das erwartete Frame
    - "01" Reject: effektiv NAK, Next ist der erste Frame, der neu übertragen werden soll (mit Go-Back-N Methode)
    - "10" Receive Not Ready: effektiv ACK + STOP, Empfänger hat ein temporäres Problem, keine weiteren Daten senden
    - "11" Selective Reject: Neuübertragung eines Frames, Next ist der zu übertragene Frame (Selective Repeat Methode)
- Poll/Final
- Next

unnummeriertes Frame:
- "11"
- Art
    - DISC (disconnect): berichtet über Nichtverfügbarkeit
    - SNRM (set normal response mode): Verfügbar im Primär-Sekundär Modus, setze `SeqNo` auf 0
    - SABM (set asynchronous balanced mode): Verfügbar im Peer-to-Peer Modus, setze `SeqNo` auf 0
    - FRMR (frame reject): Protokollverstoß, Frame wurde ignoriert
    - UA (unnumbered acknowledgement): ACK für unnummerierte Frames, Sicherheit bei Frameverlust
- Poll/Final
- Modifier

// === LLC
//
// "Logical Link Control"
