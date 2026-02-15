#set text(font: "Inter", size: 1.25em, lang: "de")
#set grid(column-gutter: 1em, row-gutter: 1em)
#set page(margin: 4em)
#set quote(block: true) // actually show attribution in quotes
#show link: underline
#set line(length: 100%)
#show math.equation: set text(font: "Fira Math")

#let E2 = $E_2$
#let E3 = $E_3$
#let Ar = $A_r$
#let Al = $A_l$
#let Av = $A_v$
#let maps = sym.arrow.bar

#align(center, text([Betriebssysteme], weight: "bold", size: 16pt))

#outline()

// apparently the outline header is a heading and so this must be here
#show heading.where(level: 1): content => [#pagebreak();#content]

= Virtuelle Maschinen

== semantische Lücke

#quote(
    [
        The difference between the complex operations performed by high-level language constructs and the simple ones provided by computer instruction sets.

        It was in an attempt to try to close this gap that computer architects designed increasingly complex instruction set computers.
    ],
    attribution: [https://hyperdictionary.com/computing/semantic-gap],
)

Schließen der semantischen Lücke durch #link(<Interpreter>, [Interpreter]) und #link(<Compiler>, [Compiler])

== Multiplexer und Virtualisierer

- Angebot einer erweiterten Maschinenschnittstelle (teilinterpretierte virtuelle Maschine #E3) für Programme / Anwender
- Durchgabe des Befehlssatzes der Hardware (#E2) und Erweiterung um weitere Syscalls
- Virtualisierung (Mehrbenutzerbetrieb) der Ressourcen der Hardware (Prozesse, Speicher, IO-Geräte,...)
- Isolierung der virtuellen Hardwareressourcen durch räumliche und zeitliche Schutzmechanismen voneinander (Mehrbenutzerbetrieb)
- Repräsentation der virtuellen Hardwareressourcen durch grundlegenden Konzepte (Abstraktionen) eines Betriebssystems
    - Prozess (Adressraum & Fäden): virtueller Computer
    - Datei: virtuelles Peripheriegerät

#image("Multiplexing.png")

=== Schutzmechanismen

- horizontale Isolation: Prozesse mit jeweils eigenem Adressraum und Fäden
- vertikale Isolation: Aufteilung in Benutzer- und Systemmodus
    - Benutzermodus:
        - spezieller CPU-Modus
        - Interpretation von #E2 Anweisungen vom Betriebssystem anstatt Durchgabe
        - Manipulation von Adressräumen -> räumliche Isolation, Speicher
        - Manipulation der Unterbrechungsbehandlung -> zeitliche Isolation, CPU
    - Systemmodus:
        - Verfügbarkeit aller #E2 Anweisungen

- Anwenderprozesse immer im Nutzermodus
- Systemdienste (teilweise) im Systemmodus

== Ebenen

Jede Ebene wird durch einen spezifischen Prozessor implementiert

Ebene n:
- virtuelle Maschine $M_n$ mit Maschinensprache $S_n$
- Programme in $S_n$ werden von einem auf einer tieferen Maschine laufenden Interpreter gedeutet oder in Programme tieferer Maschinen übersetzt

Ebene 0:
- Programme in $S_0$ werden direkt von der Hardware ausgeführt

Überetzung und Interpretation als Techniken zur Ausführung von Programmen (auch in Kombination)

== Interpreter <Interpreter>

#underline([Softwareprozessor])

Transformation eines Programms in Quellsprache in semantisch äquivalente Form einer Zielsprache

== Compiler <Compiler>

#underline([Hard-, Firm-, oder Softwareprozessor])

Direkte Ausführung von Programmen

Gegebenfalls Vorübersetzung durch einen Kompiler für günstige Repräsentation der Programme

== Maschinenmodell

- *Speicher & Objekte*: Wie kann man Daten ablegen und wieder aufrufen?
- *Befehle & Operationen*: Wie kann man Daten miteinander kombinieren?
-> Implementation durch einen "Prozessor" (#link(<Interpreter>, [Interpreter]) oder #link(<Compiler>, [Compiler]))

== privilegierte und unprivilegierte Befehle

Befehle der Maschinenprogrammebene #E3
- "normale" Befehle der Befehlssatzebene #E2
    - Ausführung vom Prozessor
    - unkritische Befehle, Ausführbar in jedem Kontext des Prozessors
- "unnormale" Befehle der Befehlssatzebene #E2
    - Ausführung vom Betriebssystem
    - privilegierte Befehle, nur im Systemmodus Ausführbar

=== privilegierte Befehle

Bereitstellung von Prozessen, Dateien, (Schutz)
- Betriebssystem ist Interpreter der #E3 Befehle
- Umsetzung benötigt privilegierte #E2 Befehle

Betriebssystem ist nur ausnahmsweise Aktiv
- Aktivierung von Außerhalb nötig
    - explizit: synchroner Systemaufruf (Syscall)
    - implizit: synchrone Programmunterbrechung (trap)
    - implizit: asynchrone Programmunterbrechung (interrupt)
-> immer Deaktivierung von alleine

= Aufgabenteilung

#align(center, [
    Anwendungen

    #sym.arrow.b System Calls

    Betriebssystem-Server\
    Betriebssystem-Kern

    #sym.arrow.t Interrupts

    Hardware
])

== Anwendungen

"Userland"

Bereitstellung von weitergehenden Diensten, Programmen, und Bibliotheken zur Verwendung und Steuerung des Betriebssystems durch Nutzer

- Bibliotheken
- Dienste
- Shells
- Utilities

== Betriebssystem-Server

Erweiterung der Abstraktionen und Bereitstellung von Strategien zur Verwaltung und Zuteilung der (virtuellen) Hardwareressourcen and Benutzer und Prozesse.

Läuft im System- und Nutzermodus

- Prozessverwaltung
- Dateisysteme (VFS)
- Speicherverwaltung
- Gerätesteuerung

== Betriebssystem-Kern

#underline([Hauptaufgabe]): Steuerung der grundlegenden Mechanismen für Multiplexing und Isolation der Hardwareressourcen.

Immer im Systemmodus.

- Prozessfäden
- Signale & IPC
- Synchronisation
- Adressräume Speicher
- Gerätezugriff

== weitere Dienste und Systemprogramme

- e.g. Shell, Benutzeroberfläche
- Hintergrundprozesse (UNIX: Daemon)
- Systemprogramme, Editoren (Systemsteuerung)
- gemeinsame Bibliotheken (shared library)

= Architekturen

Varianten: Monolithisch, Mikrokernel, ...

Unterschiede: Granulatirät der Schutzdomäne und Privilegienebenen #underline([innerhalb]) des Betriebssystems

Beeinflussung der Auslegungen im Betriebssystem, *nicht* die Funktionalität der Systemfunktion

#{
    set list(marker: ([->], [•]))
    [
        - Funktion transparent für Anwendungen und Anwender
        - Unterschiede in *nichtfunktionalen* Eigenschaften
            - Robustheit
            - Geschwindigkeit
            - Angriffssicherheit
            - Speicherbedarf
    ]
}

== Monolithisch

-> gesamtes Betriebssystem im Systemmodus

UNIX, Linux

Server im Systemmodus, Reduktion der Laufzeitkosten des Betriebssystems

= Multiplexing und Isolation durch Prozesse

#underline([Konzeptionelle Sicht]): nebenläufige Prozesse

#underline([Realzeit Sicht]): Betriebssystem multiplext CPU\
(physische Zeit auf realer CPU)

Repräsentation virtueller Hardwareressourcen durch grundlegende Konzepte des Betriebssystems:

#grid(
    columns: 3,
    [Prozess (Addressraum & Fäden)], [->], [virtueller Computer],
    [Datei], [->], [virtuelles Peripheriegerät],
)

== Dateien

=== EDV-Definition

- aus sachlich zusammenhängenden, (un-) strukturierten Daten
- idR persisten
- Verarbeitung durch Prozesse bei der Ausführung von Programmen

-> Unterscheidung nur von echten Dateien
- nicht ausführbare Datei: Verarbeitung durch ein Programm
- ausführbare Datei: Instruktionen zur Ausführung durch einen Prozess

=== Pseudodateien

- Gerätedatei: physikalisches oder virtuelles Gerät (Festplatte, Drucker)
- `procfs` Datei: Zustandsvariable des Betriebssystem-Kerns (Anzahl der Prozesse)
- Kommunikationskanal: Kommunikation zwischen Prozessen (IPC) (Pipe, Socket, stdout)

=== Dateisystem

Prinzip zur strukturellen Ablage von Informationen auf einem Datenträger.

- Abbildung von Dateien und Verzeichnissen auf das Format des Datenträgers.
- Bereitstellung von Metainformationen zur Einbindung in ein Betriebssystem

wesentliches internes Strukturelement: Block
- FS Aufgabe: Abbildung von Dateien auf Blöcke
- FS Aufgabe: Allokation und Freigabe von Blöcken
- Element einer Datenträgeroperation
- typisch 512B - 64KiB

Benötigt Verwaltungsinformationen
- Tabelle der Indexknoten
- Liste der freien Blöcke
- Liste der fehlerhaften Blöcke
- zentrale Metadaten (super block)

==== Kontext

- Kontext definiert flachen Namensraum
- Erstellung eines Namensraums hierarchischer Struktur durch Rekursion
- Arbeitsverzeichnis als impliziter Startkontext für den Pfad

==== virtuelles Dateisystem

VFS; Anwender und Anwendungen benutzen idR nur das VFS

Abstraktionsschicht des Betriebssystems für die Integration und Verwendung von Dateisystemen

- virtualisierte Schnittstelle für den Zugriff auf konkrete Dateisysteme
- Einbindung durch Montieren
- Einbindung in den Dateibaum
- Überwachung und Protokollierung des Zugriffs auf Dateien

==== Sichtweisen

===== Benutzersicht

persistenz von Daten
- Sicherung und Benennung von Ergebnissen eines Programmablaufs auf einen Hintergrundspeicher
- spätere Wiederverwendung der Ergebnisse in anderem Programm

====== Datein als benannte Objekte

Mehrwortbenennung:

- ein Wort:
    - Name ist relativ zu bestimmten Kontext
    - lokal eindeutig, global mehrdeutig
- mehrere Wörter:
    - Pfadname im Namensraum zum benannten Ding
    - global eindeutige Bezeichnung des Namenskontextes
- Trenntext als Separator
    - `/` in UNIX
    - Vorgabe von Alphabet und maximale Wortlänge durch Namensverwaltung
    - keine weitere Interpretation der Namen

Verknüpfungen sind benannt, nicht Objekte\
Verzeichnis als Katalog von Verknüpfungen

Verzeichnisse enthalten:
- Verweis auf sich selbst (`.`)
- Verweis auf übergeordnetes Verzeichnis (`..`)
- Verweise auf Dateien und Verzeichnisse

====== Links

======= Hard Links

- Verweis auf ein Dateiobjekt
- exklusiv auf Dateien

-> #underline([Dateibaum ist ein azyklischer Graph])

- Anzahl der Links auf ein Dateiobjekt wird vermerkt
-> Freigabe, nur wenn keine Links vorhanden sind

======= Soft Links

- Verweis auf einem Pfad
- spezielle Datei
- Verweis auf Verzeichnisse und andere Dateisysteme
- kein Einfluss auf Linkanzahl

===== Anwendungssicht

Schnittstelle zum Zugriff auf Daten
- standartisierte Schnittstelle zur einfacheren Softwareentwicklung
- Trennung von Programmtext und Daten(zugriffen)

===== Systemsicht

Virtualisierung des Zugriffs auf Daten
- Multiplexing & Isolation von Geräten, Ressourcen, und Daten
- Vereinfachte Einbettung weitere Geräte und Ressourcen

====== Datenstrukturen

======= Indexknotentabelle

i-node table

zentrale Datenstruktur: statisches Array von Indexknoten
- Indexknoten: Deskriptor des Objektes
- Indexknotennummer: eindeutige Referenz des Objektes

======= Verzeichnis

Abbildungstabelle
- Übersetzung symbolisch repräsentierter Namen in Indexknotennummern
- spezielle Datei der Namensverwaltung des Betriebssystems

======= Datei

abgeschlossene Einheit zusammenhängender Daten
- beliebige Repräsentation, Struktur, und Bedeutung

====== Implementierung

Namensbindung:
- Abbildung der symbolischen in numerische Adresse
    - Assoziation eines Pfadnamen mit einem Indexknoten
    - beim Erzeugungszeitpunkt

Namensauflösung
- Umsetzung der symbolischen in numerischen Adressabbildung
    - Lokalisierung eines Indexknoten anhand eines Pfadnamen
    - beim Benutzungszeitpunkt

======= Verzeichnisse

Definierung von Paaren: Name -> Indexknotennummer
- von Namensverwaltung als Dateien abgelegt
- Referenzierung mit Indexknotennummer
    - `/` besitzt Indexknotennummer 2
- Dateiattribute im Indexknoten abgelegt, nicht im Verzeichnis
- Verzeichniseintrag kann für schnelleren Zugriff Kopien bereithalten

-> tatsächlicher Namensraum ist flach (durchnummerierte Dateien)

======= Dateiattribute

Aggregation von Attribute eines Objektes in Indexknoten
- Typ der Datei (reguläre Datei, Verzeichnis, soft link, Gerät, Pipe, Socket)
- Anzahl der Verzeichnisverweise
- Größe der Datei
- Eigentümer der Datei (user ID)
- Gruppenzugehörigkeit (group ID)
- Rechte (Eigentümer, Gruppe, Welt)
- Zeitstempel (letzter Zugriff, Änderung, Attributänderung)

Weitere Attribute sind Implementierungsspezifisch
- zusätzliche Metadaten
- Insbesondere jedoch doe Objektdatenverweise (z.B. Festplattenblöcke) // ???

Indexknotennummer ist eindeutig innerhalb des Dateisystems

===== Offene Dateien

Lesen & Schreiben erfordert #underline([Dateideskriptor])
- nichtresidentes Betriebsmittel
- Repräsentation einer prozesslokalen Befähigung für Zugriff auf eine geöffnete Datei
- Anforderung: `open`, `creat`, `dup`
- Freigabe: `close`, Prozessbeendigung
- Implizit: 3 geöffnete FD's: 1: `stdin`, 2: `stdout`, 3: `stderr`

FD: interner Verweis auf Dateiobjekt
- nichtresidentes Betriebsmittel
- systemweite Repräsentation einer geöffneten Datei
- Erzeugung: implizit (erstes öffnen der Datei)
- Freigabe: implizit (Freigabe des letzten FD's)

-> Deskriptortabelle pro Prozess (file descriptor table | fd-table)\
-> Systemweite Dateiobjekttabelle (open file table | of-table)

===== Speicherung von Dateien

Verwaltung von Datenträgerspeicher in Form von Blöcken

Abbildung einer Datei auf Folge von Blöcken
- Entstehung von Verschnitt: keine Vollständige Nutzung jedes Blocks
- Speicherung und Verwaltung der Blockfolge notwendig

====== Kontinuierliche Speicherung

z.B. CDFS

einfachste Speicherverwaltung
- Blockfolge: Blöcke mit aufsteigenden Blocknummern
- Verwaltung: Tupel aus Startblock und Anzahl der Folgeblöcke

Hoher Durchsatz, aufwendige Freispeicherverwaltung
- schnelles kontinuierliches Lesen
- keine leichte Vergrößerung von Dateien

-> Einsatz auf RO Datenträgern (DVD), serielle Datenträger (Magnetbänder)

====== Verkettete Speicherung

- Blockfolge: einfach verkettete Liste
- Verwaltung: Block entält Zeiger auf den nachfolgenden Block

Größenänderung einfach, aber Mischung von Nutz- und Verwaltungsdaten
- Nutzdatengröße ist keine Zweierpotenz
    - ungünstiges Paging
- hohe Zugriffzeit: lineare Suche
- hohe Fehleranfälligkeit
    - Zerstörung gesamter Kette durch einen defekter Block

======= FAT

File Allocation Table

Variante der verketteten Speicherung
- Blockfolge: einfach verkettete Liste
- Verwaltung: Speicherung der Blockfolge in separaten Blöcken

- vollständige Nutzung des Datenblocks
- Reduktion Fehleranfälligkeit durch mehrfache Speicherung der FAT

====== Indizierte Speicherung

ext2, ext3, ext4

- Blockfolge: Ablage in speziellen Indexblöcken
- Verwaltung: Verweis auf Daten- und Indexblöcke im Indexknoten
    - kleine Dateien: direkte Verweise
    - große Dateien: indirekte Verweise
        - Pointer auf Tabelle mit Verweisen
        - maximal dreifach indirekt

- indirekter Zugriff auf Datenblöcke\
    -> X zusätzliche Blockzugriffe
- Beschränkung der Anzahl der Indexeinträge\
    -> Beschränkte Dateigröße

====== Freispeicherverwaltung

Variante: Bitmaps
- Markierung der Blöcke nach Belegung
- Metadatei des Dateisystems
- NTFS: `$Bitmap`

Variante: Verkettete Listen
- Repräsentation der Freien Blöcke durch verkettete Listen
- Optimierung: Indizierung freier Blöcke

====== Dateisystemorganisation

#image("UNIX-System-V.png")

#image("Linux-extX.png")

== Prozesse

Mit Erzeugung, Bereitstellung, und Begleitung von Prozessen bringt das Betriebssystem Programme zur Ausführung

Gleichzeitige Programmabläufe durch Prozesse
- multiprogramming: mehrere Programme
- multitasking: mehrere Aufgaben mehrerer Programme
- multithreading: mehrere Fäden eines oder mehrerer Programme

#underline([Ablauf]): Teil eines einzelnen oder mehrerer Programme
- Einlastung einen Prozesses vom Betriebssystem zum Ablaufstart
    - Einlasten: Wechsel von aktiven Prozessen
- Einplanung von Prozessen durch das Betriebssystem
- üblich: Zeitteilverfahren

=== Simultanverarbeitung von Prozessen

Programmablauf möglich, wenn
+ er dem Betriebssystem explizit gemacht worden ist
+ alle von ihm benötigten Betriebsmittel (real/virtuell) verfügbar sind

=== Zustände

#grid(
    columns: 2,
    [blockiert], [Warten auf Verfügbarkeit der Betriebsmittel],
    [bereit], [bei Verfügbarkeit der Betriebsmittel],
    [laufend], [zusätzliche Zuteilung des Betriebsmittel CPU],
)

weitere Zustände

#grid(
    columns: 2,
    [erzeugt], [vom Betriebssystem bekannt, kein Zulass auf Verarbeitung],
    [beendet], [keine Ausführung eines Programms, aber immer noch vom Betriebssystem bekannt],
    [anghalten], [temporärer Ausschluss von der Verarbeitung durch Überlastung oder Benutzerwunsch],
)

===== Reihenfolgebestimmung

pro Rechenkern:
- ein laufender Prozess
- mehrere blockierte und laufende Prozesse

=== Sichtweisen

==== Benutzersicht

Prozess #sym.equiv Ablauf\
"Gerichteter Ablauf des Geschehens"

- Geschäfts-, Datenverarbeitungs-, Softwareentwicklungsprozess
- formale Beschreibung (= Standartisiert)

==== Anwendungssicht

Prozess #sym.equiv Programmablauf\
Interaktive Ausführung durch einen Prozessor

- (inter)aktive Elemente des Rechensystems
- Ausführung durch Betriebssystem

Unterscheidung zwischen Programm und Prozess:
- statisches Programm (passiv)
- dynamischer Prozess (aktiv)

Ausführung von Zustandsübergängen nur durch laufenden Prozess (technisch gesehen)
- explizit: eigenständiger Übergang in einen anderen Zustand
- implizit: anderer Prozess übernimmt Transition aus blockiert und bereit

Übernahme von Zustandsübergängen durch Scheduler\
-> Definition der Phasen der Prozessverarbeitung
- scheduling: beim Übergang in bereit und blockiert
- implizit: beim Übergang in laufend

==== Systemsicht

Prozess #sym.equiv Ausführungskontext\
Systemobjekt, welches Prozessausführung beschreibt
- Umgebung für die Inkarnation einen Programmablaufs
    - Prozessor / VM für Programmablauf
- Einheit zur Zuteilung von Betriebsmitteln

=== Prozesse unter UNIX

primäres Strukturierungsmittel für Aktivitäten
- hierarchische Anordnung in Eltern-Kind-Beziehung

Entstehung eines Kindprozesses durch Klonung
- fork: identischer Programmablauf
- exec: Ersetzung des Programmablaufs

Trennung von exec und fork ist eine UNIX Besonderheit
- andere Betriebssysteme: forkexec ähnliche Primitive
    - Windows: `CreateProcess`: Erzeugung und Ausführung eines Kindprozesses
- Vorteil: Anpassung von Umgebung des Kindprozesses möglich
    - Anpassung der Rechte
    - Umleitung von stdin, stdout
    - -> flexible Schnittstelle fork und exec (3 Parameter), anstatt große Funktion (CreateProcess: 25 Parameter)
- Nachteil: Klonen ist für viele Abstraktionen schwer
    - FD werden beibehalten
    - Aktion bei unteilbaren Betriebsmitteln?
    - Zustand für konsumierbaren Betriebsmitteln?
    - Aktion bei mehrfädigen Programmen?
    - -> fork nur bei einfachen Programmen wohldefiniert
        - viele Sonder- und Spezialfälle in der Dokumentation

==== Mehrdeutigkeit

Prozess #sym.equiv Programmablauf
- Programm in Ausführung durch einen Prozessor

Prozess #sym.equiv Anweisungsfolge
- Folge von Anweisungen für einen Prozessor

Prozess #sym.equiv Ausführungskontext
- vom Betriebssystem verwalteter Ausführungskontext (CPU, Speicher, Umgebung)
- seit Multics: eigener Adressraum
- zusammengefasst in Prozesskontrollblock
-> Prozesse als Objekte des Betriebssystems

=> "Prozess" ist mehrdeutig (im Kontext Betriebssystem)
- oft für Prozessobjekt, Programmablauf, oder beides
- oft 1:1 Beziehung zwischen Objekt und Ablauf
    - Beziehung nicht garantiert

=== Repräsentation im Betriebssystem

Bündlung aller zur partiellen Virtualisierung relevanten Attribute im Prozesskontrollblock
- process control block, PCB
- zentrale Informations- und Kontrollstruktur im Betriebssystem
- typische Attribute
    - Adressraum, Speicherbelegung, Laufzeitkontext, geöffnete Dateien,...
    - Verarbeitungszustand, Blockierungsgrund, Dringlichkeit, Termin
    - Name, Domäne, Zugehörigkeit, Befähigung, Zugriffsrechte, Identifikation

ein Prozesszeiger pro Prozessor
- Verwaltung vom Betriebssystem
- Identifikation des laufenden Prozessobjektes
    - zeigt auf gegenwärtigen Prozess
    - ähnlich: Befehlszeiger der CPU zeigt auf laufenden Befehl
- Weiterschaltung bei Prozesswechsel (dispatch)

äußere Referenzierung durch Prozessidentifikation (PID)
- oft: Index in systemweite Prozesstabelle
- UNIX: Wiederverwendung der PID's
    - nur eindeutig, so lange Prozessobjekt existiert

== Betriebsmittel

logische Abhängigkeit von Prozessen und konsumierbaren Betriebsmittel

bei Simultanverarbeitung: Wettstreit um wiederverwendbare Betriebsmittel

=== Klassifikation

#image("Betriebsmittelklassifikation.png")

Erforderliche Synchronisation bei
- gemeinsamer Nutzung wiederverwendbarer Betriebsmittel
- logische Abhängigkeit von konsumierbaren Betriebsmittel

==== wiederverwendbare Betriebsmittel

- typisch: Hardware (CPU, Speicher)
- teilweise Aufteilbar für gleichzeitige Benutzung durch mehrere Prozesse
- exklusive Zuordnung auf einen einzelnen Prozess bei unteilbaren Betriebsmittel

==== konsumierbare Betriebsmittel

- typisch: IO Operationen
    - jede Art von Interaktion mit der Umwelt
- Ergebnis von IO Operationen ist konsumierbares Betriebsmittel

=== Gewichtsklassen

UNIX Prozesse als schwergewichtige Ausführungskontexte
- eigener Adressraum, FD Tabelle, Befähigung, Signale,...
- Segmente für Text (code), Daten (data), 2 Stapel (user & kernel stack)
-> Multiplexing und Virtualisierung des vollständigen Computers
- aufwendige Erzeugung
- aufwendige Ein- & Auslasten von Prozessen
- ungünstig für parallele Abläufe innerhalb eines Programms

==== Prozess (Process)

Prozessobjekt

- schwergewichtig
- Verwaltung des Ausführungskontextes durch Betriebssystem
- "virtueller Computer", virtueller Adressraum / Geräte / CPU's
- Verwendet von mehreren Fäden des Programms

==== Faden (Thread)

- leichtgewichtiger Prozess
- vom Betriebssystem verwalteter CPU-Kontext für einen Programmstrang
- Manifest im Anwendungs- wie im Kernadressraum
- Virtualisierung der CPU auf Ebene $L_3$, "virtueller Prozessor"
- Ausführung in einem konkreten Prozessadressraum

==== Faser (Fiber)

- von der Anwendung verwalteter CPU-Kontext für einen Programmstrang
- Manifest nur im Anwendungsadressraum
- Virtualisierung der virtuellen CPU oberhalb der Maschinenebene #E3
- Unbekannt beim Betriebssystem
- Ausführung in einem konkreten Faden

=== Aufgaben

#underline([Buchung]) über die im Betriebssystem vorhandenen Betriebsmittel
- Art, Klasse
- Zugriffsrechte, Prozesszuordnung, Nutzungsstand und -dauer

#underline([Steuerung]) der Verarbeitung von Betriebsmittelanforderungen
- Entgegennahme, Überprüfung (z.B. der Zugriffsrechte)
- Einplanung und Nutzung durch Prozesse
- Zuteilung (Entlastung) von Betriebsmittel
- Freigabe von Prozessen benutzter Betriebsmittel

#underline([Betriebsmittelentzug])
- Zurücknahme der Betriebsmittel, welche von einem schlechten Prozess belegt werden
- bei Virtualisierung: Entzug des realen Betriebsmittels

=== Ziele

Durchsetzen der gewählten Betriebsstrategie in Abhängigkeit von Betriebsart und Planungszielen:
- konfliktfreie Abarbeitung der anstehenden Aufträge
- korrekte Bearbeitung der Aufträge in endlicher Zeit
- gleichmäßige und maximale Auslastung der Betriebsmittel
- hoher Durchsatz, geringe Durchlaufzeit, hohe Ausfallsicherheit
- ...

Betriebsmittelzugang frei von Verhungern / Verklemmung
- Verhungern
    - zeitweilige Benachteiligung einzelner Prozesse
    - Betriebssystem macht weiterhin Fortschritt, kein Stillstand
- Verklemmung
    - irreversible gegenseitige Blockierung von Prozessen
    - Stillstand des Prozessorsystems

gemeinsames Merkmal: Wettstreit um Betriebsmittel
steuerndes Element: Form der Zuteilung der Betriebsmittel

=== Zuteilung

#grid(
    columns: (1fr, 1fr),
    align(center, [statisch]), align(center, [dynamisch]),
    [
        - vor der Laufzeit / Laufzeitabschnitt
        - Anforderung aller (im Abschnitt) benötigten Betriebsmittel
        - Zuteilung der Betriebsmittel erfolgt ggfs. lange vor ihrer eigentlichen Benutzung
        - Freigabe aller Betriebsmittel mit Laufzeitende / Laufzeitabschnittende
    ],
    [
        - zur Laufzeit, in beliebigen Laufzeitabschnitten
        - Anforderung des jeweils benötigten Betriebsmittel bei Bedarf
        - Zuteilung des jeweiligen Betriebsmittel erfolgt im Moment seiner Benutzung
        - Freigabe eines belegten Betriebsmittels, sobald kein Bedarf mehr besteht
    ],

    [
        Risiko: suboptimale Auslastung der Betriebsmittel
    ],
    [
        Risiko: Verklemmung von abhängigen Prozessen
    ],
)

== Signale

virtuelle Ausnahme des Prozessors

=== Sichtweisen

==== Benutzersicht

seltene Ereignisse

==== Anwendungssicht

Signal vom Betriebssystem
- Rückruf des Betriebssystems an ein Programm in Ausführung
- Auslösung durch
    - synchrones Ereignis: unmittelbarer Zusammenhang mit der Programmausführung
    - asynchrones Ereignis: kein Zusammenhang mit der Programmausführung

==== Systemsicht

Aktivierung des Betriebssystems
- Aufruf des durch das Betriebssystem realisierten Interpreters
- synchron durch laufende Prozess (implizit und explizit)
- asynchron durch ein Signal der nebenläufigen Hardware

==== synchrones Signal

Auslösung durch Aktivität des eigenen Prozesses
- durchgereichter #E2 trap bei Ausführung einer Instruktion durch die CPU
    - `SIGFPE`: Divison durch 0
    - `SIGSEGV`: segmention fault
    - `SIGILL`: illegal instruction
- zusätzliche #E3 trap bei Ausführung eines syscalls durch das Betriebssystem
    - `SIGPIPE`: pipe error
    - `SIGSYS`: illegal syscall

==== asynchrones Signal

Auslösung durch externes Ereignis oder anderer Prozessor
- durchgereichtes asynchrones Ereignis des $L_2$ Prozessors (CPU, Hardware Ereignis)
    - `SIGINT`: CTRL+C gedrückt
    - `SIGALRM`: timer expired
- zusätzliche asynchrone Ereignisse eines #E3 Prozessors (anderer Prozess, Betriebssystem)
    - `SIGCHLD`: child stopped / terminated
    - `SIGTERM`: terminate
    - `SIGHUP`: hangup
    - `SIGUSR1`, `SIGUSR2`: user signal 1 / 2
- Unterdrück- und Verzögerbar wie IRQ's
    - Synchronisation erforderlich
    - nicht-unterdrück/-verzögerbare Signale existieren (`SIGKILL`, `SIGSTOP`)

===== technische Sicht

Signalbehandlung erfolgt immer beim Verlassen des Kerns\
-> wenn #E3 Prozessor (Prozess) Arbeit wiederaufnimmt

Genauer Ablauf abhängig vom Zustand des Prozesses
#grid(
    columns: 2,
    [laufend],
    [
        - synchrone und asynchrone Signale
        - unmittelbarer Start des Behandlers
    ],

    [bereit],
    [
        - nur asynchrone Signale
        - Vormerkung im Prozesskontrollblock
        - unmittelbare Behandlung, wenn der Prozess eingelasted wird
    ],

    [blockiert],
    [
        - Ausführung eines Systemaufrufs durch Prozess
        - Unterbrechungen des IO Systemaufruf (wenn möglich)
        - Prozess wird bereit gestellt
        - Entscheidung über Fortsetzung des Systemaufrufs (`SA_RESTART`) oder Abbruch mit Rückgabewert `EINTR` bei der Installation des Signalbehandlers
    ],
)

==== Nebenläufigigkeit durch Signale

Erzeugung von Nebenläufigkeit durch asynchrone Signale innerhalb eines Prozesses
- Problem ähnlich wir IRQ auf #E2
    - Erstellung eines inkonsistenten Zustands möglich
=> keine Verwendung von sehr vielen Funktion der C-Bibliothek innerhalb Signalbehandlern
- Heap: `malloc`, `free`
- IO: `printf`, `puts`, `scanf`, `perror`
- nur `signal-safety (7)` sind erlaubt

== Ausnahmen und Unterbrechungen

Analog: Signale für Maschinenprogrammebene #E3

Unterscheidung von drei Fällen von Ausnahmen

#grid(
    columns: (1fr, 1fr, 1fr),
    align(center, [trap/exception]), align(center, [syscall/instruction trap]), align(center, [hardware interrupt]),
    [
        - Seitenfehler
        - Schutzfehler
        - Divison durch 0
    ],
    [
        - Systemaufruf
        - Haltepunktbefehl
    ],
    [
        - Zeitgeber abgelaufen
        - Taste gedrückt
        - IO Operation abgeschlossen
    ],

    [-> Befehl kann nicht ausgeführt werden],
    [-> Befehl führt zu gewollten Moduswechsel],
    [-> Gerät erfordert Aufmerksamkeit],
)

Allgemein: Behandlung von Ausnahmen ist für Anwendungen zwingend und prozessorabhängig
- Aufwerfen (raising) einer Ausnahme durch realen (CPU) oder abstrakten (Betriebssystem) Prozessor
    - CPU: Ausnahmen der Hardware (interrupt, trap, syscall)
    - Betriebssystem: Ausnahmen der Software (UNIX/POSIX: Signale)
- Behandlung erfolgt immer durch abstrakten Prozessor
    - CPU-Ausnahmen: #E2 (durch Betriebssystem)
    - Betriebssystem-Ausnahmen: #E3 (durch Prozess)

Behandlung durch Ausnahmebehandler

#grid(
    columns: 2,
    [syscall], [Ausführung der gewünschten Systemfunktion auf #E2, Rückkehr],
    [trap], [Fehler beheben auf #E2, Wiederholen des Befehls oder abort],
    [interrupt], [Verarbeitung des externen Ereignisses auf #E2, Rückkehr],
    [Signal], [Behandlung auf #E3, Rückkehr, Wiederholen, oder abort],
)

#linebreak()

Aktivierung des Ausnahmebehandlers durch unbedingte Verzweigung

CPU-Ausnahme
- Sprung über Vektor der interrupt-vector-table (IVT)
    - entält Adressen von Unterprogrammen (selten: direkt Befehle)
    - systemweit im RAM oder ROM
        - spezielles CPU Register entält Basisadresse
    - Modifikation der IVT ist eine privilegierte #E2 Anweisung

Betriebssystem Signal
- POSIX: Registrierung mit `sigaction` für den Prozess
- Ausführung nach dem Auftreten des Signals beim Einlasten des Prozesses

=== syscall

- explizite Aktivierung durch die Anwendung
- synchron zum Kontrollfluss
    - effektiv: Prozeduraufruf mit Moduswechsel

=== trap

- implizite Aktivierung durch die CPU
- synchron zum Kontrollfluss, wenn #E2 Befehl nicht ausführbar ist
- Beispiele
    - Divison durch 0
    - Seitenfehler (page fault)
    - Schutzverletzung
    - privilegierter Befehl im Benutzermodus
    - unbekannter Befehl
- nicht unterdrückbar oder verzögerbar\
    -> Behandlung ist notwendig

=== interrupt

- implizite Aktivierung durch CPU
    - asynchrones Ereignis
- asynchron zom Kontrollfluss
- Beispiele
    - Zeitscheibe abgelaufen
    - Netzwerkpaket eingetroffen
    - Taste gedrückt
    - Inter-Process-Interrupt (IPI) durch Programm auf einem anderen Kern
- unterdrückbar und verzögerbar durch privilegierte #E2 Operationen

=== Synchronisation

asynchrone Unterbrechungen jederzeit (nach jeder #E2 Operation) möglich\
-> Problematisch: gemeinsam verwendeter Zustand\
=> kritische Gebiete Schützen
- Verzögerung von Unterbrechungen

== Scheduling

Ein Scheduling Algorithmus characterisiert sich durch die Reihenfolge von Prozessen in der Warteschlange und die Bedingungen, unter denen die Prozesse der Warteschlange zugeführt werden.

Definition des Ablaufplan (schedule) für die Prozessoreinteilung durch Bereitliste\
-> Ordnung nach Ankunft, Termin, Dringlichkeit (= #underline([schedule Strategie]))
- zur Laufzeit vorgeschrieben
- Elemente: Prozesskontrollblock

Dabei: Einhaltung komplexer Randbedingungen (Fairness, Durchsatz, Reaktionszeit, Ressourcennutzung = Planungsziele)
- idR: nicht alle Planungsziele können erreicht werden
- Gewichtung je nach Betriebsart
- Zielkonflikte bleiben bestehen

=== Ziele

#grid(
    columns: 3,
    [Benutzerorientiert], [->], [kurze Antwortzeiten],
    [Systemorientiert], [->], [hohe CPU-Auslastung],
)

Kein Planungsalgorithmus kann alle Anforderungen erfüllen

=== Sichtweisen

==== Benutzersicht

Wahrgenommenes Systemverhalten
- Antwortzeit einer Systemanforderung
- Durchlaufzeit eines Prozesses
- Fairness der Ressourcenverteilung

==== Anwendungssicht

Transparenz und Verlässlichkeit
- Termintreue neo der Prozessaktivierung (verlässliche Einplanung)
- Vorhersagbarkeit der Ressourcenzuteilung (Fortschrittsgarantie)
- Berücksichtigung der Dringlichkeit (Priorisierung von Aktivitäten)

===== Betriebsarten

====== Stapelbetrieb (batch scheduling)

interaktionslose, unabhängige Programme
- nicht verdrängend
- verdrängend mit langen Zeitscheiben
    - Minimierung des Umplanaufwands

Ziel: Durchsatz

====== Dialogbetrieb (interactive scheduling)

interaktionreiche, abhängige Programme
- ereignisgesteuerte, verdrängende Verfahren
- kurze Zeitscheiben

Ziel: Antwortzeit

====== Echtzeitbetrieb (real-time scheduling)

zeitkritische, abhängige Programme

- ereignisgesteuerte, zeitgesteuerte deterministische Verfahren
- Einhaltung physischer Zeitschranken

Ziel: Rechtzeitigkeit

==== Systemsicht

Auslastung der Systemressourcen
- Durchsatz des Rechensystems (Prozesse pro Zeiteinheit)
- Hardwareauslastung (Minimierung der Kosten des Rechenbetriebs)
- Ermöglichung von Lastenausgleich (gleichmäßige Nutzung der Hardware)

#line()

#grid(
    columns: 2,
    [Aufgabe (job)], [ausführbarer Arbeitsauftrag],
    [Prozess / Faden], [ausführende Einheit],
)

generell: Betrachtung von Aufgaben durch Planungsalgorithmen

idR: CPU Zuteilung an Prozessen und Fäden
- Betrachtungsweise entspricht Stapelbetrieb
- Instantiierung zugelassener Aufgaben als ein Prozess
    - Abarbeitung des Auftrags durch Prozess
    - Terminierung mit Ergebnis

Betrachtungsweise: Dialogbetrieb
- Starten von interaktiven Prozessen durch zugelassene Nutzer
- Kennzeichnung: Wechsel von IO und Berechnung
-> Aufgabe: CPU-Stoß (CPU burst)

===== Planungsebenen

====== High-Level Scheduling

"User"

Bereich: Sekunden - Minuten
- System Zwangskontrolle für Aufgaben
- Initiierung zugelassener Aufgaben zu interaktiven Prozessen (oder Gruppen von interaktiven Prozessen)

====== Intermediate-Level Scheduling

"Process"

Bereich: Millisekunden - Sekunden
- CPU Zwangskontrolle für Prozesse
- Steuerung von Aktivierung und Deaktivierung (Ein- & Auslagerung von Prozessen)
- Konkurrenz um Betriebsmittel nur von aktiven Prozessen

====== Low-Level Scheduling

"Thread"

Bereich: Mirkosekunden - Sekunden
- CPU Zuteilungskontrolle für Fäden
- Steuerung der Einlastung konkreter Prozesse und Fäden über die Zustände `BEREIT` #sym.arrow.l.r `LAUFEND` #sym.arrow.l.r `BLOCKIERT`

=== Verfahren

Planungsverfahren zu verschiedenen Zeitpunkten
- online scheduling: dynamischer, während der Ausführung
- offline scheduling: statisch, vor der Ausführung

Planungsverfahren unter der Annahme der Vorhersagbarkeit
- deterministic scheduling: bekannter, vorberechneter Prozesse
- probabilistic scheduling: unbekannte Prozesse

Kooperationsverhalten
- cooperative scheduling
    - voneinander abhängige Prozesse
    - freiwillige Abgabe des Prozessors
- preemptive scheduling
    - voneinander unabhängige Prozesse
    - Entziehung des Prozessors

UNIX: Einplanung von Prozesse (Fäden) durch online, probabilistisch, und verdrängender Einplanung

==== klassische Planungs- und Auswahlverfahren

#grid(
    columns: 2,
    [kooperativ],
    [
        - FCFS (first come, first serve)
    ],

    [verdrängend],
    [
        - RR (round robin)
        - VRR (virtual round robin)
    ],

    [probabilistisch],
    [
        - SPN (SJF) (shortes job finish)
        - SRTF (shortest remaining time first)
        - HRRN (highest reponse ration first)
    ],

    [mehrstufig],
    [
        - MLQ (multi level queues)
        - MLFQ (multi level feedback queues)
        - FSS (fair share scheduling)
    ],
)

==== Kooperativ (FCFS)

Einplanung nach Ankunftszeit
- nicht verdrängend
- gerecht
    - höhere Antwortzeit
    - niedriger IO Durchsatz
- suboptimal bei Mix von kurzen und langen CPU Stößen
    - Begünstigung von Prozessen mit langen CPU Stößen
    - Benachteiligung von Prozessen mit kurzen CPU Stößen
- Problem: Konvoieffekt
    - kurzer CPU-Stoß folgt einem langen

==== Verdrängend (RR)

Einplanung nach Ankunftszeit, Umplanung in regelmäßigen Zeitabständen
- verdrängend, periodische Unterbrechungen
- jeder Prozess erhält Zeitscheibe (time slice)
    - obere Schranke für CPU-Stoß
- Verringerung der Benachteiligung von FCFS
- Zeitscheibe bestimmt Effektivität
    - zu lang: Degenerierung zu FCFS
    - zu kurz: hoher Mehraufwand durch Kontextwechsel
    - Faustregel: etwas länger als die Dauer eines typischen CPU-Stoßes
- Problem: Konvoieffekt
    - kurzer Prozess folgt einem, welcher Zeitscheibe aufgebraucht hat

Konvoieffekt:
- Zuteilung weiterhin durch FCFS
    - Benachteiligung kurzer Prozesse besteht weiterhin
    - IO intensive Prozesse
        - selten vollständige Ausschöpfung der Zeitscheibe
        - freiwilliges Beenden des CPU-Stoßen
    - CPU intesive Prozesse
        - meist vollständige Ausschöpfung der Zeitscheibe
        - unfreiwilliges des CPU-Stoßes
- Bedienung aller Prozesse reihum

Ungünstige Verteilung der CPU-Zeit bei Nichtausschöpfung der Zeitscheibe durch einen Prozess
- schlechte Bedienung von IO intensiven Prozessen
- schlechtere Auslastung von IO-Geräten
- beträchtliche Varianz der Antwortzeit IO-intensiver Prozesse

==== Verdrängend VRR

RR mit Vorzugsliste und variablen Zeitscheiben
- keine Benachteiligung von interaktiven (IO-intensiven) Prozessen

bevorzugte Einplanung von Prozessen nach IO-Stoß
- Einplanung mittels einer der Bereitliste vorgeschalteten Vorzugsliste
    - FIFO
        - eventuell Benachteiligung hoch-interaktiver Prozesse
    - aufsteigend Sortiert nach Zeitscheibenrest eines Prozesses
- Umplanung bei Ablauf der aktuellen Zeitscheibe
    - priorisierter Einlass der Prozesse auf der Vorzugsliste
    - Zuteilung der CPU für die Restdauer der Zeitscheibe
    - Einreihung in Bereitliste nach Ablauf der Zeitscheibe
- erreicht durch strukturelle Maßnahmen, nicht durch analytische

kein voll-verdrängendes Verfahren
- Einlastung erst nach Ablauf der laufenden Zeitscheibe

===== RR & VRR

RR
- gleiche Behandlung CPU und IO-intensiver Prozesse
- eine gemeinsame Bereitliste zur Zuteilung der CPU
- IO-intensive Prozesse bekommen (relativ) weniger CPU-Zeit
- schlechte Auslastung von IO-Geräten

VRR
- Hinzufügen von Prozessen nach IO auf Vorzugsliste
- vorrangige Bedienung dieser Liste durch CPU
-> Aufbrauch vom Rest der Zeitscheibe von diesen Prozessen

==== Probabilistisch (SPN)

Einplanung nach durschnittlicher oder maximale erwarteten Bedienzeit
- Grundlage: à priori Wissen über Prozesslaufzeiten
    - Stapelbetrieb: Programmierer setzt Frist
    - Produktionsbetrieb: Erstellung einer Statistik durch Probeläufe
    - Dialogbetrieb: Abschätzung von CPU-Stoßlängen zur Laufzeit
- Abarbeitung nach aufsteigender Laufzeit
    - Abschätzung erfolgt vor (statisch) oder zur (dynamische) Laufzeit

Verkürzung von Antwortzeiten und Steigerung der Gesamtleistun des Systems
- Benachteiligung längerer Prozesse
- Verhungern (starvation) langer Prozesse möglich

kein Konvoieffekt
- praktikable Implementierung nur als näherungsweise Lösung möglich

===== Mittlung

heuristisches Verfahren
- bildet Mittelwert von CPU-Stoßlängen für jeden Procezz
- erwartete Länge des nächsten CPU-Stoßes eines Prozesses:
$
    S_(n+1) = frac(1, n) dot sum_(i=1)^n T_i
$
- Problem: gleiche Wichtigung aller CPU-Stöße
    - Lokalität durch jüngere CPU-Stöße
        - sollte: stärkere Berücksichtigung

===== Wichtung

Begrenzung des Einflusses älterer CPU-Stöße durch Dämpfungsfiler (decay filter)
$
    S_(n+1) = alpha dot T_n + (a - alpha) dot S_n
$
- zuletzt gemessener ($T_n$) und geschätzer ($S_n$) CPU-Stoßlänge
- konstanter Wichtungsfaktor $alpha: 0 < alpha < 1$

===== HRRN

hungerfreies SPN
- nicht verdrängend
- Einplanung nach der (erwarteten) kürzesten Bedienzeit
- Umplanung unter Berücksichtigung der Wartezeit
    - Einführung dynamische Prioritäten
    - regelmäßige, periodische Neuberechnung der Prioritäten anhand
    $
        "Prio" = frac("Wartezeit" + "Bedienzeit", "Bedienzeit")
    $
    - Neuberechnung betrifft alle Einträge in der Bereitliste
- Problem: Schätzung der Bedienzeit
- Anstieg der Wartezeit = "Alterung" (aging)
    - Vorbeugung vor Verhungern durch Entgegenwirkung der Alterung

==== Mehrstufig (MLQ)

Einplanung der Prozesse nach ihrem Typ
- Aufteilung der Bereitliste in separate Listen
    - z.B. für System-, Dialog-, und Stapelprozesse
- lokale Einplanungsstrategie pro Liste
    - z.B. SPN, RR, FCFS
- Definition einer globalen Einplanungsstrategie zwischen den Listen
    - statisch
        - Zuordnung einer Liste zu einer bestimmten Prioritätsebene
        - Hungergefahr für Prozesse in tieferen Listen
    - dynamisch
        - Wechseln der Listen durch Zeitmultiplexverfahren
        - z.B. 40% System-, 40% Dialog-, 20% Stapelprozesse
- Problem: Typfestlegung erfordert Vorabwissen (statische Entscheidung)

===== MLFQ

- Einplanung nach Ankunftszeit
- Umplanung in regelmäßigen Zeitabständen

- Hierarchie von Bereitlisten für Prioritätsebenen 1,...,n
    - Zeitscheibenlänge (Quantum q) wird immer länger
        - $q_1 < q_2 < ... < q_n$
    - Einstieg neuer Prozesse in Ebene 1
    - innerhalb der Ebene: FCFS
        - Verwendung von RR in Ebene n
    - Ebene 1
        - höchste Priorität
        - geringste Zeitscheibenlänge (Quantum q)

Bestrafung (penalization)
- Zeitscheibenlauf drückt laufenden Prozess weiter nach unten
-> lange Prozesse fallen nach unten

Alterung (aging, anti-aging)
- untere Prozesse finden seltener statt
    - Anhebung nach Bewährfrist

===== FSS

Grundidee: hierarchische Verteilung der Systemressourcen
- oberste Ebene: Verteilung nach festem Schlüssel
- weitere Ebenen: problemspezifischer Planer

Ausgleich von Interessensgruppen / Mischbetrieb von Betriebsarten
- Beispiele
    - Cloud
        - Teilung eines echten Rechners in mehrere VM's
        - VM-Anteil an CPU, Speicher,... entspricht Bezahlung
    - Mainframe
        - interaktive und Stapel- und Systemprozesse
        - Aufteilung: 50% interaktive Prozesse, 50% Stapel- & Systemprozesse

===== Gegenüberstellung

#table(
    align: center,
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr),
    table.header([], [FCFS], [(V)RR], [SPN], [HRRN], [SRTF]),
    [kooperativ], [X], [], [(X)], [(X)], [],
    [verdrängend], [], [X], [], [], [X],
    [probabilistisch], [], [], [X], [X], [X],
    [deterministische], table.cell(colspan: 5, [keines]),
)

MLQ, MLFQ, FSS: Kombination der Verfahren möglich
- Prozesseinplanung unterliegt breit gefächerten Einordung
    - kooperativ/verdrängend
    - deterministische/probabilistisch
    - statisch/dynamisch

Festlegung von Prozessvorrang durch Verfahren
#grid(
    columns: 2,
    [nach], [],
    [Ankunftszeit], [FCFS, RR, VRR, (MLFQ)],
    [Bedienzeit], [SPN, (MLFQ)],
    [Bedienzeit/Wartezeit], [HRRN],
    [Restbedienzeit], [SRTF],
)

Problem der Abschätzung bei probabilistischen Verfahren

#image("Scheduling-Verfahren.png")

== Deadlocks

"Deadly Embrace"
//gekoppelte Prozesse warten gegenseitig auf die Aufhebung einer Wartebedingung, welche aber durch dir Prozesse selber aufgehoben werden müsste.

Ein Deadlock liegt vor, wenn eine Gruppe von Prozessen wechselseitig auf den Eintritt einer Bedienung wartet, die nur durch andere Prozesse der Gruppe hergestellt werden kann.
-> gekoppelte Prozesse im blocked Zustand

Situation nur von Außen lösbar
- keine Erkennung oder Behebung durch beteiligte Prozesse

Entstehung selbst wenn
- kein einziger Prozess benötigt mehr als die verfügbare Menge an Betriebsmittel
- unabhängig von der Verantwortlichkeit der Betriebsmittelzuteilung (Betriebssystem oder Anwendungsprogramm)
-> Stillstand durch Verschränkung der Prozessabläufe

=== Livelock

Ein Livelock ist wie ein Deadlock, jedoch sind die Prozesse nicht im blocked Zustand. Sie erzielen ebenfalls keinen Fortschritt im Sinne der Programmausführung.
-> gekoppelte Prozesse im ready Zustand

schwerere Erkennung als Deadlocks
- häufige Veränderung des Programmzählers

=== notwendige und hinreichende Bedingungen

vier Bedingungen notwendig
+ #underline([gegenseitiger Ausschluss]) bei der Benutzung der Betriebsmittel
    - exklusives Vergeben der Betriebsmittel
+ #underline([Nachforderbarkeit]) von Betriebsmitteln ist möglich
    - Nachforderung von weiteren Betriebsmitteln durch einen Prozess, welcher bereits Betriebsmittel belegt
+ #underline([Unentziehbarkeit]) der zugeteilten Betriebsmittel
    - Freigabe von Betriebsmitteln ausschließlich und explizit durch den Prozess, welcher sie belegt
+ #underline([zirkuläres Warten]) muss eingetreten sein
    - Es existiert eine geschlossene Kette von Belegungen und Anforderungen, an der mindestenz 2 Prozesse und 2 Betriebsmittel beteiligt sind

Dabei
- 1, 2, 3: notwendige Bedingung
- 4: notwendige und hinreichende Bedingung

Behandlung
- Invalidierung mindestenz einer der Bedingungen

=== Betriebssystemstrategien

+ #underline([Ignorieren])
    - pragmatischer Ansatz
    - Deadlocks sind selten und liegen in der Verantwortung der Anwendung
    - UNIX

+ #underline([Vorbeugung]) (deadlock prevention)
    - konstruktiver Ansatz
    - statisches Vergabeprotokoll zur Sicherstellung des Nichtauftretens von Deadlocks
    - direkte Methoden
        - Aufheben der notwendigen und hinreichenden Bedingung
        - 4: Definition einer linearen Ordnung über alle Betriebsmittel
            - Zuteilung nur in aufsteigender oder absteigender Reihenfolge
    - indirekte Methoden
        - heben eine notwendige Bedingung auf
        - 1: nichtblockierende Synchronisation
        - 2: unteilbare Anforderung der Betriebsmittel
        - 3: Virtualisierung der Betriebsmittel
            - Unentziehbarkeit
    - Vorbeigung auf Kosten der Betriebsmittelbelastung
    - Vorraussetzung von Vorabwissen
    - Nutzung in Echtzeitsystemen

+ #underline([Vermeidung]) (deadlock avoidance)
    - analytischer Ansatz
    - keine Stattgebung von Betriebsmittelanforderungen, welche einen Deadlock verursachen
    - Überwachung von Prozessen und deren Betriebsmittelanforderungen
        - Überprüfung jeder Anforderung auf einen möglichen unsicheren Zustand
        - Ablehnung der Anforderung, falls dieser möglich ist
        - Suspension des anfordernden Prozesses
        - Zuteilung nur im sicheren Zustand
    - Vorabwissen notwendig
        - Vorabwissen über mögliche Betriebsmittelanforderungen aller Prozesse
        - hohe Laufzeitkosten von Methode und Implementatierung
    - geringe Bedeutung
    - Bankieralgorithmus (Dijkstra, 1965)

+ #underline([Erkennen & Erholen]) (deadlock detection)
    - optimiseriter Ansatz
    - Inkaufnahme von Deadlocks
    - kein Aufheben einer Bedingung
    - Suchen nach Zirkeln im Wartegraphen
    - Opfer muss Betriebsmittel abgeben
        - Prozesszerstörung
        - Betriebsmittelentzug
    - sporadische Suche nach blockierten Prozessen
        - Buchführung von Betriebssystem über Anforderungen und Belegungen
        - Such nach Zyklen in diesem Graphen
    - Erkennenung wird Verwendet (optionaler Systemdienst)

== Speicher

=== Hierarchie

+ Intern: Register, Cache
+ Vordergrundspricher: RAM, ROM, Flash
+ Hintergrundspeicher: Festplatte, Solid-State-Disk
+ Wechselspeicher: Magnetband, DVD, Blu-Ray, USB-Stick
+ Netzwerkspeicher: Netzwerklaufwerk/-dateisystem, Cloud-Speicher

- steigende Zugriffzeiten
- steigende Kapazität
- sinkender Preis pro Bit

=== Verwaltung

==== Adressabbildung

- logische Adressen auf physische Adressen
- Relokation von Code und Daten

==== Platzierungsstrategie

- In welcher Lücke soll Speicher reserviert werden?
- Kompaktifizierung verwenden?
- Minimierung des Fragmentierungsproblems

==== Ersetzungsstrategie

- Welcher Speicherbereich könnte Sinnvoll ausgelagert werden?

=== Speicherinteraktionen

==== aktives Warten

Prozessinteraktionen über gemeinsamen Speicher
- Konsistenzprobleme bei nichtatomaren Zugriff
    - "kritisches Gebiet"
- gemeinsamer Speicher
    - exklusives Betriebsmittel
-> Synchronisation erforderlich

Ideal: Verwendung atomarer Maschinenbefehle
- einzelner read/write Befehl ist auf Maschinenebene #E2 atomar
- spezielle read-modify-write Befehle sind ebenfalls atomar
- TAS, CAS, FAA: architekturabhängig
    - Unterstützung im Compiler durch Intrinsics
-> Lösung nicht verallgemeinerbar

Alternative: expliziter gegenseitiger Ausschluss (mutual exclusion, Mutex)
- Mutex mit spin lock, spin-on-read, ticket lock
- Protokoll mit `lock`, `unlock`, und Schlossvariable
    - aktives Warten in `lock`
- ineffizient bei virtuellem Prozessor
    - Verschwendung der Zeitscheibe
- kritische Implementierung
    - nichtfunktionale Effekte (Cache, Speicherbus)

===== gegenseitiger Ausschluss mit Mutex

#E3 Realisierung
- zeitweiser exklusiver Zugang zur geteilten Variable durch wechselseitigen Ausschluss
- Prozess ist während des Zugriffs im "kritischen Bereich"
- "Überwachung" des kritischen Bereichs durch Sperrobjekt (Mutex)
- Elementaroperationen
    - acquire/lock
        - Betritt des kritischen Gebietes
        - falls nötig, Warten bis Mutex frei ist
    - release/unlock
        - Freigabe und Verlassen des kritischen Gebietes

Es gilt $sum "acquire" ( "mutex" ) - sum "release" ( "mutex" ) lt.eq 1$\
-> maximal ein Prozess im Kritischen Bereich, weitere Prozesse warten

====== Realisierung durch Verdrängnissperre

Ansatz: Unterbindung von Verdrängungen
- z.B. Sperrung von Unterbrechungen im kritischen Gebiet

möglich, aber viele Nachteile
- Aufwendig
    - Erfordert privilegierte Operationen
- Fehleranfällig
    - Monopolisierung des Prozessors
    - Verlorene Ereignisse durch hohe Unterbrechungslatenz
- Grobgranular
    - Bestrafung unbeteiligter Prozesse
- Eingeschränkt
    - Funktioniert nicht bei echter Parallelität

====== Realisierung durch Spinlock

nicht sicher
- Eintritt mehrerer Threads in das kritische Gebiet möglich
    - Schreiben der Schlossvariable nach dem Eintritt eines anderen Threads

===== atomare Komplexbefehle (TAS, CAS, FAA)

====== Test-And-Set (TAS)

#E2 Elementaroperation: test-and-set

Schlossvariable prüfen und setzen = read-modify-write Operation

#underline([Pseudocode]) der TAS-Operation (Befehlssatzebene)
```C
int TAS(long* ref) {
    atomic {
        long aux = *ref;
        *ref = 1;
    }
    return aux;
}
```

Schreiben ist garantiert, Wertveränderung nur bedingt
- nur wenn Variable 0 enthält
- ansonsten wird der Wert 1 mit 1 überschrieben

Operationsergebnis: Variablenwert vor der Operation
- Ausschluss gleichzeitiger Buszugriffe vor der Operation durch Hardware
- Synchronisation auch mit anderen Busmastern (andere CPU, DMA,...)
-> TAS bewirkt einen atomaren Lese-/Schreibzyklus

======= Spinlock mit TAS

```C
typedef volatile long lock_t;

void acquire(lock_t* lock) {
    while( TAS(lock) ) {}
}

void release(lock_t* lock) {
    *lock = 0;
}
```

Funktionsfähig, aber sehr hohe Last auf den Cache bei Wettstreit im Multi-Core system
- angenommen n Prozessoren wollen in das kritische Gebiet
- Auslösen von massiven Datentransfer durch unbedingtes Schreiben von TAS. Entweder
    - write-through-cache: 1 Original schreiben, n-1 Kopien bei anderen Prozessoren aktualisieren
    - write-back-cache: n-1 Kopien invalidieren und 1 Original zum auslösenden Prozessor bewegen
- Außerden: hohe Last auf Speicherbus
- Ausbremsung von unabhängigen Prozessen und Prozessoren

-> schlechte Skalierung in nichtfunktionaler Sicht

====== Compare-And-Swap (CAS)

#E2 Elementaroperation: comapre-and-swap

#underline([Pseudocode]) der CAS-Operation
```C
int CAS(long* var, long val, long new) {
    atomic {
        if (*var == val) {
            *var = new;
            return 1;
        }
    }
    return 0;
}
```
Schreiben des neuen Wertes, wenn `*var` den erwarteten Wert hat

Weniger Verbreitet, aber auf vielen Platformen verfügbar

======= Spinlock mit CAS

```C
typedef volatile long lock_t;

void acquire(lock_t* lock) {
    while( !CAS(lock, 0, 1) ) {}
}

void release(lock_t* lock) {
    *lock = 0;
}
```
Schreiben nur bei Belegung des Mutex
- deutlich bessere Cachekohärenz
- weiterhin viele Zugriffe auf den Speicherbus

-> schlechte Skalierung in nichtfunktionaler Sicht

======= besseres Spinlock mit CAS

```C
typedef volatile long lock_t;

void acquire(lock_t* lock) {
    do {
        while( *lock ) {}
        while( !CAS(lock, 0, 1) ) {}
    }
}

void release(lock_t* lock) {
    *lock = 0;
}
```

Weniger Wettstreit auf dem Speicherbus durch spin-on-read
- innere while-Schleife arbeitet auf dem Cache (ohne ihn zu ändern)
- in dieser Zeit keine Datenzugriffe und keine Bus-Sperren

-> deutlich besser skalierbare Lösung

====== Fetch-And-Add (FAA)

#E2 Elementaroperation: fetch-and-add

TAS & CAS ermöglichen Verhungern
- hoher Wettstreit garantiert kein Durchkommen
- zufällige Reihenfolge

#underline([Pseudocode]) der FAA-Operation
```C
long FAA(long* var, long add) {
    atomic {
        long aux = *var;
        *var += add;
    }
    return aux;
}
```

- Operationsergebnis ist Variablenwert vor der Erhöhung
- weniger Verbreitet als TAS und CAS
    - manche Platformen: nur fetch-and-increment (Erhöhung um 1)
        - ebenfalls ausreichend

======= Mutex mit FAA

```C
typedef volatile struct {
    long next;
    long this;
} lock_t;

void acquire(lock_t* lock) {
    long self = FAA(&lock->next, 1);
    while( self > lock->this ) {}
}

void release(lock_t* lock) {
    lock->this++;
}
```
- "ticket lock"

- Kein Verhungern
- Vorraussetzung: Kein "Ausstieg" der Wartenden
    - Threads warten auf den Vorgänger, Austritt führt zu einem Deadlock

==== passives Warten

Wechsel in den blockiert-Zustand vor dem kritischen Gebiet
- freiwillige Abgabe des Prozessors
- Versetzung in den bereit-Zustand durch den Prozess, welcher das kritische Gebiet verlässt
    - erneuter Eintrittsversuch
-> Modifikation der Prozesszustände nötig\
->privilegierte Operation\
=> Implementation der Synchronisationsprimitiven im Betriebssystem-Kern

===== Semaphor

Vorschlag von Dijkstra (1964)

spezielle ganzzahlige Variable mit zwei Operationen
- P (prolaag) (down, wait, acquire, `sem_wait`)
    - Verringerung der Semaphor s um 1
    - Blockade des Prozesses, wenn s < 0
- V (verhoog) (up, signal, release, `sem_post`)
    - Erhöhung der Semaphor s um 1
    - ggfs. Bereitstellung eines blockierten Prozesses

ursprüngliche Definition: binäre Semaphor $s in {0,1}$\
spätere Verallgemeinerung: zählende Semaphor $s in ZZ$

====== Implementation: zählende Semaphor

```C
typedef volatile int semaphore_t;

void down(semaphore_t* sema) {
    atomic {
        *sema--;
        if (*sema < 0) {
            block(sema);
        }
    }
}

void up(semaphore_t* sema) {
    atomic {
        *sema++;
        if (*sema <= 0) {
            wakeup(sema);
        }
    }
}
```

Implementatierung der Unteilbarkeit (atomic) durch Betriebssystem-Kern.\
Varianten von atomic
- Unterbrechungssperren
    - `up` kann aus Unterbrechungsbehandlern aufgerufen werden
- nichtverdrängbares kritisches Gebiet
    - "non-premptible critical section", NPCS
    - kein Entzug des Prozessors von Faden im kritischen Gebiet
- Multiprozessorfall zusätzlich:
    - spin lock
- Einsatz von atomaren Befehlen

====== Erzeuger-Verbraucher mit Semaphor (Ringbuffer)

koordinierter Zugriff auf konsumierbare Betriebsmittel
- Erzeuger produziert Elemente
- Verbraucher konsumiert Elemente
- Entkopplung durch Ringpuffer

Erzeuger
- Ablegen von Elementen im Puffer
- Warten, wenn Puffer voll ist

Verbraucher
- Entnahme von Elementen aus dem Puffer
- Warten, wenn Puffer leer ist

semantisch ein Betriebsmittel, in der Realisierung zwei
- Erzeuger: produziert Elemente, verbraucht Pufferplätze
- Verbraucher: produziert Pufferplätze, verbraucht Elemente

=> Realisierung mit zwei zählenden Semaphorn

=== Speicherorganisation

==== Strategien

#underline([Allokationsstrategie]) (allocation policy)
- Wann soll benötigter Speicher angefordert werden?
    - statisch: Wenn man weiß, dass man ihn braucht
    - dynamisch: Erst wenn dieser wirklich benötigt wird

#underline([Platzierungsstrategie]) (placement policy)
- Woher soll benötigter Speicher genommen werden?
    - Verschnitt maximal/minimal
    - Schnellstmöglich

#underline([Ladestrategie]) (fetch policy)
- Wann sind Speicherinhalte einzuladen?
    - auf Anforderung
    - im Voraus

#underline([Ersetzungsstrategie]) (replacement policy)
- Welche Speicherblöcke sind auszulagern, falls Speicher knapp wird?
    - ältesten
    - am längsten ungenutzten

===== Allokation

#underline([statische Allokation])
- beim Übersetzen und Linken
- globale / statische Variablen
- Code
- Allokation durch Platzierung in einer Sektion
    - `.text`: Programmcode
    - `.bss`: mit 0 initialisierten Variablen
    - `.data`: mit anderen Werten initialisierten Variablen
    - `.rodata`: unveränderliche Variablen

#underline([dynamische Allokation])
- Reservierung zur Laufzeit des Programms
- lokale auto-Variablen
- explizit angeforderter Speicher
    - Stack: enthält alle aktuell lebendigen auto-Variablen
    - Heap: mit `malloc` angeforderte Speicherbereiche

====== dynamische Allocation: Heap

Heap = vom Programm explizit verwalteter RAM-Speicher
- Lebensdauer unabhängig von Programmstruktur
- Anforderung und Freigabe mit `malloc` und `free`
    - andere Methoden möglich

====== dynamische Allocation: Stack

Verwaltung von lokalen Variablen, Funktionsparametern, Rücksprungadressen durch Übersetzer und Prozessor auf dem Stack
- architekturabhängiges Wachstum
    - "oben nach unten" = hohe adresse zur niedrigere
- Prozessorregister `[e]sp` zeigt auf nächsten freien Eintrag
- Verwaltung in Form von Stack-Frames

=== Freispeicherverwaltung

==== Methoden

generell: Bildung von kleinen Löchern -> externer Verschnitt

===== Stack

sehr effiziente Anforderung und Freigabe von Stapelspeicher
- Anforderung von n Bytes = Verringerung des Stapelzeigers um n
- Freigabe von n Bytes = Erhöhung des Stapelzeigers um n
- Anforderung und Freigabe in LIFO-Reihenfolge
    - kein Verschnitt, kein Loch

===== Bitlisten

Markierung von Speichereinheiten mit einem Bit als frei oder belegt
- Speicherblöcke sind Vielfaches der Einheitsgröße
- Bitindex -> Blockadresse

===== verkettete Liste

externe Verkettung der Speicherblöcke
- Repräsentation auch von freien Blöcken

bei Freigabe: Verschmelzung von Löchern
- Reduktion der Fragmentierung

==== Platzierung

#underline([First Fit])
- erstes passendes Loch
- schnell
- Konzentration auf kleine Lücken am Anfang der Löcherliste
- Degenerierung des Aufwandes
    - Anfang O(1)
    - O(n) möglich

#underline([Next Fit])
- nächstes passendes Loch
- wie First Fit, aber: Start bei zuletzt zugewiesenem Loch
- bessere Verteilung kleinerer Löcher

#underline([Best Fit])
- kleinstes passendes Loch
- minimiert Risiko, irgendwann kein genügend großes Loch mehr zu finden
- Aufwand: immer O(n)

#underline([Worst FIt])
- größtes passendes Loch
- minimiert Risiko in Zerstückelung in zu kleine Löcher
- Aufwand: immer O(n)

===== Halbierungsverfahren

Einteilung in dynamische Bereiche der Größe $2^n$
- Verminderung der Fragmentierung durch bessere Verschmelzbarkeit
- effiziente Algorithmen für Anforderung udn Freigabe: $O(log n)$

Aufrunden auf nächste Zweierpotenz -> interner Verschnitt

==== Fragmentierung und Verschmelzung

Ausprägung der Fragmentierung je nach Zuteilungsgranularität
- interne Fragmentierung
    - feste Granulatirät
    - angeforderte Größe kleiner als zugeteilter Block
    - lokaler Verschnitt durch Anforderer nutzbar (sollte es aber nicht)
    - unvermeidbare Verschwendung
- externe Fragmentierung
    - beliebige Granulatirät
    - angeforderte Größe ist zu groß für jedes Loch
    - globale Verschnitt ggfs nicht mehr zuteilbar
    - aufwendig vermeidbarer Verlust
    - Verringerung durch Verschmelzung
    - Auflösung durch Kompaktifizierung

==== Ebenen

#underline([innerhalb eines Prozesses])
- Verwaltung des Heaps
- dynamische Allokation von Speicher (`malloc`, `free`)

#underline([innerhalb des Prozessadressraums])
- Verwaltung von Adressbereichen (logischer Adressraum) für Segmente
- dynamisch Allokation mit `mmap`
- Laden dynamischer Bibliotheken

#underline([innerhalb des Betriebssystem])
- Verwaltung des physischen Speichers (realer Adressraum)
- Verwaltung des Hintergrundspeichers (swap storage)

#underline([innerhalb des Dateisystems])
- Verwaltung der freien und belegten Blöcke des Datenträgers
- Aufheben externer Fragmentierung durch Kompaktifizierung

zu beachten:
- Aufwand
- interner Verschnitt
- externer Verschnitt

grundlegende Probleme und Strategien sind übertragbar

=== Adressraumlehre ($E_3 arrow.squiggly E_2$)

Generierung einer Folge von Adressraumzugriffen durch einen laufenden Prozess
- anhand der im Programmtext codierten Daten und Zugriffmuster
- abhängig von der statischen Abbildung durch Compiler und Interpreter
- abhängig von den dynamischen Eingabedaten zur Laufzeit

immer Beschränkung des Wertevorrates möglicher Adressen
- obere Schranke
    - Adressbreite der Hardware
    - z.B. 32-Bit -> 4 GiB
- untere Schranke
    - initiale Speicherallokation des Maschinenprogramms
- zur Laufzeit
    - dynamisch wachsend oder schrumpfend

Defintion des Adressraums eines Prozesses durch den zugebilligten Wertevorrat
- logische / physische Einschluss des Prozesses
- durch Hardware oder Betriebssystem
    - oder auch: bereits konstruktiv auf der Maschinenprogrammebene
        - typsichere Sprachen, JVM

=> Implementatierung von horizontaler Isolation

==== Grundbegriffe

#underline([realer Adressraum]) #Ar
- #E2 (Befehlssatzebene)
- Durch Prozessor und Rechensystem definierter Wertvorrat von Adressen
- $abs(A_r) = 2^n$ mit (üblicherweise) $n in {16,32,48,64}$
- nicht jede reale Adresse $"ra" in A_r$ ist gültig
    - #Ar kann Lücken besitzen
-> Hauptspeicher HS adressierbar durch einen / mehrere Bereiche aus #Ar

#underline([logischer Adressraum]) #Al
- $E_(5,4,3)$ (Maschinenprogrammebene)
- Durch ein Programm P definierter Wertvorrat von validen Adressen, der der ausführenden virtuellen Maschine (Prozess p von P) zugebilligt wird
    - Übernahme der Abbildung $A_l -> A_r$ durch Prozessor der virtuellen Maschine
    - jede logische Adresse $"la" in A_l$ ist gültig
        - konzeptionell keine Lücken in #Al
-> Arbeitsspeicher AS des Prozesses p, auf HS abgebildet

#underline([virtueller Adressraum]) #Av
- #E3 (Maschinenprogrammebene)
- Durch das Betriebssystem definierter (erweiterteter) Wertvorrat an Adressen, der für einen logischen Adressraum zur Verfügung gestellt wird.
- $A_v = A_l$ aber $A_v arrow.bar A_r or "HGS"$ (Abbildung auf den Hintergrundspeicher HGS)
- partielle Interpretation von Speicherzugriffen auf das BHG durch das Betriebssystem
-> virtueller Arbeitsspeicher VAS, des Prozesses p, durch das Betriebssystem dynamisch auf HS oder HGS abgebildet

#underline([Adressraumbelegunsplan]) (memory map)
- Festlegung von #Ar
- welche Hardwareeinheiten sind über welche Adressbereiche zugreifbar
- Festlegung durch Hersteller des Rechensystems
- Adressbereiche zur allgemeinen Verwendung existieren
    - Hauptspeicher für Maschinenprogramme und ihre Daten
    - Zugriff kann Schutzfehler (protection fault trap) liefern

==== Grundprinzip virtueller Adressraum

Übersetzung der vom Prozess p generierten logischen Adressen
- transparent durch eine prozessspezifische Abbildung $p: A_l arrow.bar A_r$
- idR: Realisierung über die Hardware (z.B. memory management unit, MMU)
- Abbildung auf Adressen im realen Adressraum #Ar
- Abbildung erfolgt in Einheiten...
    - gleicher Größe (Seiten)
    - unterschiedlicher Größe (Segmente)

Grundlage des Speicherschutzes zwischen Prozessen (horizontale Isolation) unter der Vorraussetzung des Schutzes von p (vertikale Isolation)

===== Varianten

kleiner logischer #maps größerer realer Adressraum
- 16/32-Bit Systeme
- Varianten
    - 8086: $abs(A_l) = 2^(16) lt abs(A_r) = 2^(20)$ (64 KiB #maps 24 MiB)
    - IA-32: $abs(A_l) = 2^(32) lt abs(A_r) = 2^(36)$ (4 GiB #maps 64 GiB)

größerer logischer #maps kleiner realer Adressraum
- 32/64=Bit Systeme

lineare logische #maps unzusammenhängende reale Adressbreite

linear logische #maps zweigeteilte realre Adressbreite
- Zweiteilung in Hauptspeicher und Hintergrundspeicher

Aktivierung des Betriebssystems bei Speicherzugriff auf den HGS
- Signalisiert durch trap von MMU
- partielle Interpretation von Betriebssystem (-> Speichervirtualisierung)
    - Einlagerung des entsprechenden Bereiches aus dem HGS in den HS
    - ggfs Auslagerung von Bereich aus HS in HGS

===== Implementatierung

Implementierung von $p: A_l arrow.bar A_r$ erfolgt in der MMU
- Teil der CPU
- falls aktiv: Transformation jeder Adresse auf dem Speicherbus

typische Varianten: Segmentbasiert, Seitenbasiert
#underline([Segmentbasiert])
- Strukturierung in Einheiten verschiedener Größe
- Umrechnung logischer Adressen über die MMU auf zusammenhängende Bereiche aus #Ar mit Basisregister
    - $"ra" = "la" + "seg"_"base"$ für $"la" lt "seg"_"limit"$
    - ansonsten trap
- Ermöglichung einfacher Implementation von Relokation

#underline([Seitenbasiert])
- Strukturierung in Einheiten gleicher Größe
- Abbildung logischer Adressen über die MMU auf nichtzusammenhängende Bereiche der Größe $2^k$ mit Tabelle
    - Aufteilung von la an Bit k in Seitennummer $"la"_"pn"$ und Versatz $"la"_o$
    - $"ra" = "page"["la"_"pn"] + "la"_o$ für $"page"("la"_"pn") eq.not bot$
    - ansonsten trap
- Ermöglichung einfacher Implementation von virtuellem Speicher

==== Relokation

Erforderlich, wenn die Sektionen eines Programms nicht an der beim Linken angenommenen Stelle im Adressraum geladen werden können

#underline([Variante A]) patchen
- Anpassung des Codes beim Ladevorgang
- Anpassung jedes Verweises (Zeiger) auf ein Symbol
- Export von Tabelle der Symbolreferenzen durch Compiler und Linker
    - Anpassung jeder Symbolreferenz entsprechend der Ladeadresse

#underline([Variante B]) position-indipendent code (PIC)
- Positionsunabhängiger Code
- Zugriff auf Code und Daten erfolgen immer über Adressregister-indirekt
    - Codezugriffe: (wenn möglich) über PC (PC-relative Sprünge)
    - Datenzugriffe: Basisregister + Offset
    - Legen des Basisregister in Sektion beim Laden auf Ladeadresse
- Unterstützung durch Compiler und Linker bei der Codegeneration erforderlich

#underline([Variante C]) logischer Adressraum
- hardwaregestützte durch Segmentierung

==== Laden eines Programms

Laden eines Maschinenprogramms (#E3) in den realen Adressraum (#E2)
- Einprogrammbetrieb
- exklusiver Ablauf
- Strukturierung des Programms nach Adressraumbelegunsplan
- überlappungsfreie Abbildung von Symbolen und Sektionen durch Compiler und Linker auf #Ar

bei genügendem Platz im Adressraum #Ar
- einfache Platzierung

bei ungenügend zusammenhängendem Speicher im Adressraum #Ar
- deutlich mehr Arbeit
- Speicherverwaltung und Platzierung:
    - Freispeicherverwaltung
    - Platzierungsstrategie
    - Verhinderung von Fragmentierung
- Relokation der Symboladressen beim Laden erforderlich

== Interprozesskommunikation (IPC)

Verständigung unter Prozessen eines Rechnersystems mit Hilfe von Daten

Kommunikation durch
- gemeinsamer Speicher (shared memory)
    - nebenläufiges Schreiben & Lesen von gemeinsamen Speicher
    - explizite Synchronisation
- Nachrichtenaustausch (massage passing)
    - Senden & Empfangen von Nachrichten von Prozessen
    - implizite Synchronisation über den Nachrichtenaustauschmechanismus
    - Möglichkeit der Ortstransparenz
        - Kommunikation über Rechnergrenzen

Primitiven
#grid(
    columns: 2,
    [
        - `send(E,n)`
        - `receive(S,n)`
    ],
    [
        $S arrow.long^n E$ Sender S schickt Nachricht n an Empfänger E\
        $E arrow.l.long^n S$ Empfänger E empfängt Nachricht n von Sender S
    ],
)
-> Bereitstellung durch Kommunikationssystem (Betriebssystem)

semantische Unterschiede möglich
- Synchronisation der Beteiligten
- Adressierung von Sender S und Empfänger E
    - k:m Kommunikation
- Pufferung und Nachrichtenformat
    - maximale Größe von n

=== nachrichtenbasierte Kommunikation

Kommunikation auf höherer Abstraktionsebene
- kein gemeinsamer Speicher
    - Ortstransparenz, strikte Isolation
- explizite Kommunikation
    - Trennung der Belange, Verständlichkeit
- lose Kopplung der Paare
    - Modularisierung, Asynchronität

Kommunikation mit höherem Aufwand
- unzureichende aprachliche Abbilung
    - Programmieraufwand
- Kopieren der Nachrichten
    - Speicher- und Laufzeitkosten
- Beschränkung der Nachrichtengröße
    - Aufteilung großer Nutzlasten

Optimierung viele der Kosten im lokalen Fall durch Betriebssystem
- Nutzlast in Registern (short IPC)
- Übertragung einer ganzen Speicherseite in einen anderen Adressraum (zero copy)

-> Ortstransparenz und Asynchronität bleiben Illusion
- Begrenzung durch Pufferkapazität und Fehlerkorrektur des Kommunikationssystems
- möglicherweise Blockierung und Fehlschläge von asynchronen Aufrufen

==== technische Sicht

keine direkte Kommunikation\
-> immer über Kommunikationssystem KS
#grid(
    columns: 2,
    [
        - `send(E,n)`
        - `receive(S,n)`
    ],
    [
        $S arrow.long^(E,n) "KS"$ Übergabe von Nachricht and KS\
        $E arrow.l.long^(S,n) "KS"$ Erhalt von Nachricht von KS
    ],
)

durch Indirektion möglich
- Ortstransparenz
- Asynchronität
-> funktionale Transparenz
-> zusätzliche nichtfunktionale Kosten

==== Semantiken

4 verschiedenen Nachrichtensemantiken. Kombination aus Dimensionen

===== Dimension 1

Kommunikationsmuster (Interaktionen)

#underline([Meldung])
- Einwegnachricht
    - Sender braucht kein Ergebnis
+ $S arrow.long^n E$ Nachricht

#underline([Auftrag])
- Zweiwegnachricht
    - Sender auf Ergebis angewiesen
#grid(
    columns: 2,
    [
        + $S arrow.long^a E$
        + E
        + $E arrow.long^e S$
    ],
    [
        Auftrag (in Nachricht a)\
        Ausführung des Auftrags\
        Ergebnis (in Antwortnachricht e)
    ],
)

===== Dimension 2

zeitliche Kopplung (Synchronität)

#underline([Asynchron])
- zeitliche Entkopplung der Verarbeitung in S und E

#underline([Synchron])
- zeitliche Kopplung der Verarbeitung in S und E

====== asynchrone Meldung

no-wait send: asynchrone Meldung "fire-and-forget"

vollkommone Entkopplung von Sender und Empfänger

- Ablieferung der Nachricht von Sender S an Kommunikationssystem
- Sender S blockiert bis Erreichen der Nachricht vom Kommunikationssystem
- Weiterarbeiten von Sender S
-> Speicherung von Nachrichten im Kommunikationssystem notwendig

Zulieferung an wartenden Empfänger E\
Fall kein E wartet
- Verwurf der Nachricht vom Kommunikationssystem
- Zustellung der Nachricht an Warteschlange vom Kommunikationssystem

====== synchrone Meldung

synchronization send: synchrone Meldung mit Quittung

- Ablieferung der Nachricht von Sender S and Kommunikationssystem
- S blockiert bis Erreichen der Nachricht bei Empfänger E
- Zustellen einer Quittung vom Kommunikationssystem
- Entweder bei
    - Zustellung in Warteschlange
    - Zustellung bei Entgegennahme
-> Verhinderung von zu schnellem Senden von Nachrichten

====== synchroner Auftrag

remote-invocation send: synchroner Auftrag mit Resultat
- Bearbeitung beim Empfänger ist Teil der Transaktion
- Sender S blockiert bis Eintreffen des Resultats
- `reply(S,n)` $E arrow.long^n S$ zusätzliche Funktion zum Versenden der Antwort
- starke Beschränkung der Parallelität zwischen S und E
    - Prinzip des Fernaufrufes (remote procedure call, RPC)

====== asynchroner Auftrag

asynchronous remote-invocation send: Auftrag und Resultat in zwei unabhängigen Nachrichten; Verknüpfung über Auftragskennung

- Sender S blockiert bis Erreichen der Nachricht vom Kommunikationssystem
- ggfs blockiert Sender S später, wenn das Ergebnis benötigt wird
- Sender S kann mehrere Aufträge besitzen
- gezieltes Auswählen von Aufträgen von Empfänger E (Planung)
-> asynchroner Fernaufruf mit zeitlicher Entkopplung

==== Zusammenfindung

#underline([direkte Adressierung])
- Empfänger als Server-prozess
- Process-ID (Signale)
- Kommunikationsendpunkt eines Prozesses (Port, Socket)

#underline([indirekte Adressierung])
- Entkopplung von Empfang und Server-prozess
- Kanäle (Pipes)
- Briefkästen (Mailboxes)
- Nachrichtenpuffer (Message Queues)
- Linux: Adressierung durch (benannte) Dateiobjekte

#underline([zustätzliche Dimension])
- Gruppenadressierung (1:n)
- Einzelaufruf (Unicast)
- Gruppenaufruf (Multicast)
- Rundruf (Broadcast)

=== UNIX: Signale, Pipes, Sockets

==== asynchrone Signale als IPC

asynchrones Signal: no-wait send einer direkt adressierten leeren Nachricht
- implizit durch Kindprozess (`SIGCHLD`)
- explizit durch anderen Prozess

==== Pipes

FIFO-Kanal zwischen zwei Kommunikationspartnern
- unidirektional: Sender -> Empfänger
- gepuffert (feste Puffergröße)
- zuverlässig
- stromortientiert (stream-based)
    - Kommunikation auf Bytegranularität

Operationen: Schreiben und Lesen
- Beibehaltung der Ordnung der Daten (Bytestrom)
- Sender blockiert bei voller Pipe, Empfänger bei leerer

-> Semantik entspricht synchronization send

==== Sockets

allgemeiner Kommunikationsendpunkt im Rechnernetz
- Bidirektional
- gepuffert

Abstraktion von Details des Kommunikationssystems
- Bestimmung von möglichen Typen und Protokollen durch Domäne (Protokollfamilie)

===== Domänen

#underline([UNIX])
- lokaler Rechner
- Verhalten wie bidirektionale Pipe
- Anlage einer Spezialdatei im Dateisystem möglich
    - analog zu Named Pipe
- Übertragung von Dateideskriptoren an anderen Prozess möglich

#underline([Internet])
- rechnerübergreifend mit IP

#underline([Appletalk, DECNet, NetBIOS])
- geringfügige Bedeutung

Festlegung von Protokollen durch Domäne
- z.B. Internet Domäne: TCP/IP, UDP/IP

Definition der Adressierung durch Domäne
- z.B. Internet Domäne: IP-Adresse und Portnummer

Definition der Semantik der Datenübertragung durch Typ\
typische Typen
- stromortientiert, verbindungsorientiert und gesichert
- nachrichtenorientiert und gesichert
- nachrichtenorientiert und ungesichert

Definition der Umsetzung der Nachrichtenübertragung durch Protokoll\
z.B. Internet Domäne
- TCP/IP
    - stromortientiert, verbindungsorientiert und gesichert
- UDP/IP
    - nachrichtenorientiert, verbindungslos, ungesichert

Praxis: oft Redundante Angabe von Protokoll und Typ
- Definition eines möglichen Typen durch Protokoll
    - ebenfalls umgekehrt
