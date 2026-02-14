#set text(font: "Inter", size: 1.25em)
#set grid(column-gutter: 1em, row-gutter: 1em)
#set page(margin: 4em)
#set quote(block: true) // actually show attribution in quotes
#show link: underline
#set line(length: 100%)

#align(center, text([Software Engineering], weight: "bold", size: 16pt))

#outline()

// apparently the outline header is a heading and so this must be here
#show heading.where(level: 1): content => [#pagebreak();#content]

= Virtuelle Maschinen

== Semantische Lücke

#quote(
    [
        The difference between the complex operations performed by high-level language constructs and the simple ones provided by computer instruction sets.

        It was in an attempt to try to close this gap that computer architects designed increasingly complex instruction set computers.
    ],
    attribution: [https://hyperdictionary.com/computing/semantic-gap],
)

Schließen der semantischen Lücke durch #link(<Interpreter>, [Interpreter]) und #link(<Compiler>, [Compiler])

== Multiplexer und Virtualisierer

- Angebot einer erweiterten Maschinenschnittstelle (teilinterpretierte virtuelle Maschine $E_3$) für Programme / Anwender
- Durchgabe des Befehlssatzes der Hardware ($E_2$) und Erweiterung um weitere Syscalls
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
        - Interpretation von $E_2$ Anweisungen vom Betriebssystem anstatt Durchgabe
        - Manipulation von Adressräumen -> räumliche Isolation, Speicher
        - Manipulation der Unterbrechungsbehandlung -> zeitliche Isolation, CPU
    - Systemmodus:
        - Verfügbarkeit aller $E_2$ Anweisungen

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

= Aufgabenteilung

#align(center, [
    Anwendungen

    #sym.arrow.b System Calls

    Betribssystem-Server\
    Betribssystem-Kern

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

== Betribssystem-Server

Erweiterung der Abstraktionen und Bereitstellung von Strategien zur Verwaltung und Zuteilung der (virtuellen) Hardwareressourcen and Benutzer und Prozesse.

Läuft im System- und Nutzermodus

- Prozessverwaltung
- Dateisysteme (VFS)
- Speicherverwaltung
- Gerätesteuerung

== Betribssystem-Kern

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

#underline([Konzeptionelle Sicht]): Nebenläufige Prozesse

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
- `procfs` Datei: Zustandsvariable des Betribssystem-Kerns (Anzahl der Prozesse)
- Kommunikationskanal: Kommunikation zwischen Prozessen (IPC) (Pipe, Socket, stdout)

=== Dateisystem

Prinzip zur strukturellen Ablage von Informationen auf einem Datenträger.

- Abbildung von Dateien und Verzeichnissen auf das Format des Datenträgers.
- Bereitstellung von Metainformationen zur Einbindung in ein Betribssystem

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
- Erstellung eines Namensraums hierarchiescher Struktur durch Rekursion
- Arbeitsverzeichnis als impliziter Startkontext für den Pfad

==== virtuelles Dateisystem

VFS; Anwender und Anwendungen benutzen idR nur das VFS

Abstraktionsschicht des Betribssystems für die Integration und Verwendung von Dateisystemen

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
- spezielle Datei der Namensverwaltung des Betribssystems

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

Mit Erzeugung, Bereitstellung, und Begleitung von Prozessen bringt das Betribssystem Programme zur Ausführung

Gleichzeitige Programmabläufe durch Prozesse
- multiprogramming: mehrere Programme
- multitasking: mehrere Aufgaben mehrerer Programme
- multithreading: mehrere Fäden eines oder mehrerer Programme

#underline([Ablauf]): Teil eines einzelnen oder mehrerer Programme
- Einlastung einen Prozesses vom Betribssystem zum Ablaufstart
    - Einlasten: Wechsel von aktiven Prozessen
- Einplanung von Prozessen durch das Betriebssystem
- üblich: Zeitteilverfahren

=== Simultanverarbeitung von Prozessen

Programmablauf möglich, wenn
+ er dem Betribssystem explizit gemacht worden ist
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
    [erzeugt], [vom Betribssystem bekannt, kein Zulass auf Verarbeitung],
    [beendet], [keine Ausführung eines Programms, aber immer noch vom Betribssystem bekannt],
    [anghalten], [temporärer Ausschluss von der Verarbeitung durch Überlastung oder Benutzerwunsch],
)

===== Reihenfolgebestimmung

pro Rechenkern:
- ein laufender Prozess
- mehrere blockierte und laufende Prozesse

=== Scheduling

Ein Scheduling Algorithmus characterisiert sich durch die Reihenfolge von Prozessen in der Warteschlange und die Bedingungen, unter denen die Prozesse der Warteschlange zugeführt werden.

Definition des Ablaufplan (schedule) für die Prozessoreinteilung durch Bereitliste\
-> Ordnung nach Ankunft, Termin, Dringlichkeit (= #underline([schedule Strategie]))
- zur Laufzeit vorgeschrieben
- Elemente: Prozesskontrollblock

==== Ziele

#grid(
    columns: 3,
    [Benutzerorientiert], [->], [kurze Antwortzeiten],
    [Systemorientiert], [->], [hohe CPU-Auslastung],
)

Kein Planungsalgorithmus kann alle Anforderungen erfüllen

#image("Simultanverhalten.png")

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
- Ausführung durch Betribssystem

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
- hierarchiesche Anordnung in Eltern-Kind-Beziehung

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
- vom Betribssystem verwalteter Ausführungskontext (CPU, Speicher, Umgebung)
- seit Multics: eigener Adressraum
- zusammengefasst in Prozesskontrollblock
-> Prozesse als Objekte des Betribssystems

=> "Prozess" ist mehrdeutig (im Kontext Betribssystem)
- oft für Prozessobjekt, Programmablauf, oder beides
- oft 1:1 Beziehung zwischen Objekt und Ablauf
    - Beziehung nicht garantiert

=== Repräsentation im Betribssystem

Bündlung aller zur partiellen Virtualisierung relevanten Attribute im Prozesskontrollblock
- process control block, PCB
- zentrale Informations- und Kontrollstruktur im Betribssystem
- typische Attribute
    - Adressraum, Speicherbelegung, Laufzeitkontext, geöffnete Dateien,...
    - Verarbeitungszustand, Blockierungsgrund, Dringlichkeit, Termin
    - Name, Domäne, Zugehörigkeit, Befähigung, Zugriffsrechte, Identifikation

ein Prozesszeiger pro Prozessor
- Verwaltung vom Betribssystem 
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

=== wiederverwendbare Betriebsmittel

- typisch: Hardware (CPU, Speicher)
- teilweise Aufteilbar für gleichzeitige Benutzung durch mehrere Prozesse
- exklusive Zuordnung auf einen einzelnen Prozess bei unteilbaren Betriebsmittel

=== konsumierbare Betriebsmittel

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
- Verwaltung des Ausführungskontextes durch Betribssystem
- "virtueller Computer", virtueller Adressraum / Geräte / CPU's
- Verwendet von mehreren Fäden des Programms

==== Faden (Thread)

- leichtgewichtiger Prozess
- vom Betribssystem verwalteter CPU-Kontext für einen Programmstrang
- Manifest im Anwendungs- wie im Kernadressraum
- Virtualisierung der CPU auf Ebene $L_3$, "virtueller Prozessor"
- Ausführung in einem konkreten Prozessadressraum

==== Faser (Fiber)

- von der Anwendung verwalteter CPU-Kontext für einen Programmstrang
- Manifest nur im Anwendungsadressraum
- Virtualisierung der virtuellen CPU oberhalb der Maschinenebene $E_3$
- Unbekannt beim Betriebssystem
- Ausführung in einem konkreten Faden

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
