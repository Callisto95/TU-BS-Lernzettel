// #set text(font: "Inter", fill: white)
// #set page(fill: black)
#set text(font: "Inter", size: 1.25em, lang: "de")
#set grid(column-gutter: 1em, row-gutter: 1em)
#set page(margin: 4em)

#align(center, text([Software Engineering], weight: "bold", size: 16pt))

#outline()

// apparently the outline header is a heading and so this must be here
#show heading.where(level: 1): content => [#pagebreak();#content]

= Software

== Charakteristiken

+ keine Ersatzteile
+ kein Verschleiß
+ Alterung
+ schwer zu messen
+ immateriel
+ abstrakt (keine physischen Gesetze)
+ häufige Anpassungen
+ leichtere Anpassung als Hardware

== Kategorien

- Freeware/Kommerziel
- Open Source/Closed Source
- UI/API
- System Software/Application Software
- Standalone/Integrated
- Monolithic/Distributed
- Data Intesive/Computation Intesive
- Generic/Customized

== Code Smells

- Magic Numbers
- Magic Strings
- Duplicate Code
- Shotgun Surgery
    - eine Änderung erzwingt Änderung an anderen Stellen
- Long Method
- Long Parameter List

== Version Control Service (VCS)

#table(
    columns: (1fr, 1fr, 1fr),
    table.header([], [Centralized (CVCS)], [Dezentralized (DVCS)]),
    [Beispiel], [SVN], [Git],
    [Speicherort], [Server], [Lokal + Server mit Historie],
    [Arbeit ohne Netzwerkverbindung], [keine Commits], [lokale Commits],
    [Geschwindigkeit, Sicherheit], [langsam (Netzwerkverbindung benötigt)], [schneller (lokale Backups)],
)

= Testing

== White-Box

- Code bekannt

== Black-Box

- Code unbekannt

== Teststufen

=== Komponententest

Testen von kleinere Komponenten

- Isolierte Funktionen und Klassen

=== Integrationstest

Testen von Zusammenspiel mehrerer Komponenten

- z.B. DB und Service

=== Systemtest

Testen von System gegen Anforderungen

=== Abnahmetest

Prüfung mit Kunde (Stakeholder) ob System Use-Case erfüllt und abnahmefähig ist

= Graphen

#image("Arten-von-UML-Diagrammen.png")

== Kontrollflussgraph

=== Zweigüberdeckung

Ablauf aller Kanten

=== Anweisungsüberdeckung

Ablauf aller Knoten

= Lehman's Law of Software Evolution

+ Continuous Change
+ Increasing Complexity
+ Self Regulation
    - Productivity plateaus even when you add more developers
    - Technical debt eventually forces slowdowns
    - Long-running systems evolve in surprisingly consistent patterns
+ Conservation of organizational stability
    - Over the lifetime of a software system, the average effective rate of development remains roughly constant, regardless of how much work is waiting to be done.
    - Several forces balance each other out:
        - Communication overhead grows with team size
        - System complexity makes changes harder and slower
        - Cognitive limits of developers
        - Organizational processes (reviews, coordination, approvals)
+ Conservation of familiarity
+ Continuous growth
+ Declining quality
+ Feedback system

Beispiele:

Conservation of organizational stability:
- A team delivers \~10 meaningful changes per month.
- Product demands 20.
- The result isn't 20 changes - it's:
    - 10 rushed changes or
    - 10 changes with more bugs or
    - burnout and turnover
- The system “protects” its stability.

= Software Development Practices

== DevOps

- Dev + Ops
    - Automatisierung bauen, testen, betreiben

== CI/CD

- CI: automatisches Bauen und Testen
- CD: Deployment per Knopfdruch bis in Production

== Configuration Management

Reproduzierbare und standartisierte Infrastruktur und Einstellungen

= Softwareentwicklungsmodelle

== Wasserfallmodell

#image("SE-Wasserfallmodell.png")

Geeignet für:
- eingebettete Systeme
- große Softwaresysteme
- sicherheitskritische Systeme

Vorteile:
- Einfach zu verstehen und zu Überwachen
- Gut für gemeinsame Entwicklung von Software und kostspieliger Hardware
- Gleiches Modell für Hard- und Software nutzbar

Nachteile:
- Probleme in einer Phase haben Auswirkungen auf folgenden Phasen
- Phasen können nicht parallel bearbeitet werden
- Änderungen in vorherigen Phasen schwer möglich

== V-Modell

#image("SE-V-Modell.png")

== Scrum

Darunter: Kanban, Extreme-Programming

= Risk- und People Management

== Risk Management

Systematisches Erkennung, Bewertung, und Steuerung von Risiken im Projekt

== People Management

Führung, Motivation, Koordination, Kommunikation, und Weiterentwicklung der Projektmitglieder

- Respekt
- Inklusion
- Ehrlichkeit

= Anforderungen

== Lastenheft

Beschreibung von Anforderungen an das System aus Sicht der Stakeholder

== Pflichtenheft

Beschreibung aus technischer Sicht, wie und womit der Auftragnehmer die Anforderungen umsetzt

== Funktionale Anforderungen

"Was tut das System"

Beispiele:
- Warenkorb
- Bestellung auslösen, Bestellbestätigung
- RBAC
- Registrierung, Einloggen von Nutzern

== Nicht-Funktionale Anforderungen

Beispiele:
- Leistung
- Verfügbarkeit
- Sicherheit
- Skalierbarkeit
- Zuverlässigkeit
- Nutzbarkeit
- Wartbarkeit
- Portability
- Compliance

#image("Non-Functional-Requirements.png")

=== Organisatorische

Rahmenbedingungen der Organisation

- Zeitrahmen
    - Entwicklung innerhalb von 9 Monaten
- Entwicklung nach Scrum
- nur Verwendung einer spezifischen API

=== Externe

Äußere Vorgaben, Gesetze, Normen

- Einhaltung der DSGVO
- verhlüsselte Übertragung der Daten
- Kompatibilität mit offiziellen Schnittstellen

=== Produktanforderungen

Qualität oder Eigenschaft eines Systems

- Reaktion innerhalb von X Sekunden
- Erkennungsrate von mindestenz XX%
- maximaler Akkuverbrauch

#pagebreak()

== Anforderungsmanagement

#grid(
    columns: (1fr, 1em, 1fr, 1em, 1fr, 1em, 1fr),
    align(center, [*Ermittlung*]),
    [->],
    align(center, [*Analyse*]),
    [->],
    align(center, [*Spezifikation*]),
    [->],
    align(center, [*Validierung*]),

    [
        Sammeln von Anforderungen
        - Workshops
        - Interviews
    ],
    [],
    [
        Verstehen, Strukurierung, Analysieren von Anforderungen
        Finden von Unklarheiten
    ],
    [],
    [
        Dokumentationen von Anforderungen
    ],
    [],
    [
        Prüfung von Anforderungen auf Vollständigkeit und Testbarkeit mit Stakeholdern
    ],
)

= Maintenance

- Adaptive
- Perfective
- Preventive
- Corrective

= Design

== Software Design

- Lösungsentwurf im Codenahen Bereich
- Klassen, Module, Datenstruktur, API's,...

== Architecture Design

- Entwurf der Systemstruktur
- Komponenten, Services, Datenfluss, Tech-Stack, Leistung, Sicherheit,...

== Conway's Law

Die Struktur einer Software spiegelt die Kommunikations- und Teamstruktur wieder

Beispiel:
- Teams: Frontend - Backend - DB
- Softwarestruktur: Frontend - Backend - DB

== Muster

#image("gang-of-four-patterns.png")

== Architekturmuster

- Client-Server
- Peer-To-Peer (2-Peer?)
- Layered Architecture

== Entwurfsmuster

- Erzeugungsmuster
    - Objekterzeugung
- Strukturmuster
    - Klassenstruktur
- Verhaltensmuster
    - Interaktion und Verantwortlichkeit von Objekten

= Quality Assurance

#image("Quality-Assurance.png")
