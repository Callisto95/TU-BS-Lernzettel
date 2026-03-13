#set text(font: "Inter", size: 1.25em, lang: "de")
#show math.equation: set text(font: "Fira Math")
#set grid(column-gutter: 1em, row-gutter: 1em, align: horizon)
#set page(margin: 3em)
#set line(length: 100%)

#let null = `NULL`
#let aggregation(grouping, function) = $attach(frak(F), bl: grouping, br: function)$
#let mid = $mid(|)$

#align(center, text([Relationale Datenbanksysteme 1], weight: "bold", size: 16pt))

#outline()

// apparently the outline header is a heading and so this must be here
#show heading.where(level: 1): content => [#pagebreak();#content]

/*
#pagebreak()

- Datenbank + Datenbankmanagementsysteme
    - Begriffe
    - Aufgaben
- Unterschied: logisches, physikalisches Interface
    - Vorteile, Nachteile
- 3 Nutzerkategorien bei der Nutzung von DB's
- Universe of Discourse
- Redundanz
    - kontrollierte, unkontrollierte Redundanz
- Datenbankprinzip der Isolation und deklarative Anfragesprachen
- RBAC: Role Based Access Control
    - Database users
- Charakteristiken von Datenbanken
    - Transaktionen
        - \+ Beispiele wo sie benötigt werden
- Ziele der Datenmodellierung
- Deutung von #null
- 3 Schichten Architektur
    - Bedeutung
- Phasen von DB-Design (?)
- Entitätstypen
- Data Models
- Klassifikation von ER-Attributen
- ER-Modelle
    - Relationen
    - Attributstypen
- Integrationstypen
    - Integrationsschritte
        + pre-integration Analysis
        + comparison of schemas
        + conformation of schemas
        + merging and restructuring of schemas
- entity clustering (?)
- open world assumption
- Bereichsatome (range atoms)
    - TRC, DRC - Anfragen ohne Bereichsatome
- sichere / unsichere Anfragen
- relationale Vollständigkeit
- Constraints
    - PK constraint
    - not null constraint
    - FK constraint
- Abfragen
    - korrelierte / unkorrelierte
    - Aggregationsfunktionen (VL:6 57)
- Unterschied Menge Set - Multimenge Bag
- Fetch First
- Normalformen
    - BCNF (Boyce Cott Normalform) (EX:10.3)
- Views
    - updatable views
- A.C.I.D.
    - Atomicity
    - Consistency
    - Isolation
    - Durability
- Normalisierung
    - funktionale Abhängigkeiten
- relationale Vollständigkeit

#linebreak()

- ER-common mistakes (VL:5 2)
*/

= grundlegende Definitionen

== Datenbank

- Sammlung zusammengehöriger Daten
- Repräsentiert Ausschnitt realer Welt (Universe of Discourse)
- logisch kohärent
- für Nutzer und Anwendungen bereitgestellt.

=== Nutzerkategorien

+ Direkt involviert
    - (DB-Ebene)
    - Administratoren (Wartung/Sicherheit)
    - Designer (Strukturfestlegung).
+ Entwicklung & Analyse
    - Anwendungsentwickler (Softwarebau)
    - Datenanalysten (Trendsuche).
+ Endbenutzer
    - Naive Nutzer (vordefinierte Aufgaben)
    - anspruchsvolle Nutzer (komplexe Tools)
    - Gelegenheitsnutzer.

=== Isolation

- Datenbank nutzt Datenabstraktion
- Applikationen arbeiten nur auf konzeptioneller Ebene
    - Details über Speicherort und Zugriffsmethoden bleiben verborgen
- Bei Transaktionen: Operationen beeinflussen sich gegenseitig nicht, auch bei gleichzeitigem Zugriff

#pagebreak()

== Charakteristiken

- Kontrollierte Redundanz
    - Daten idealerweise nur einmal gespeichert
    - Redundanz nur gezielt für Performance
- Strukturierung
    - Nutzung von Modellen wie ER
- Effizienz
    - Physisches Tuning, Indexe und optimierte Anfragepläne
- Abstraktion/Isolation
    - Trennung zwischen Anwendung und Datenhaltung
- Mehrfache Sichten
    - Verschiedene Perspektiven auf dieselben Daten für unterschiedliche Aufgaben
- Multi-User & Transaktionen
    - Gleichzeitiger Zugriff und atomare Operationen
- Persistenz & Recovery
    - Schutz vor Datenverlust durch Systemfehler oder Katastrophen

== Datenbankmanagementsysteme

- Sammlung von Programmen zur Pflege und Verwaltung der Datenbank

=== Katalog (Data Dictionary)

- Enthält Metadaten; definiert Struktur der Daten in DB

=== Schemas

- Konkrete Instanzen von Datenmodellen (konzeptionell, logisch oder physisch)

=== Datenbankinstanz

- Aktueller Zustand der DB
- Menge von Tupeln zu bestimmtem Zeitpunkt

=== Aufgaben

- Daten- und Strukturdefinition
    - physische Konstruktion
    - Manipulation von Daten
- Teilen/Schützen von Daten
    - Sicherstellung von Persistenz/Wiederherstellung
- Gleichzeitigen Zugriff ermöglichen
    - Daten immer in konsistentem Zustand halten

=== Vorteile zu Dateisystemen

- Dateisysteme
    - \+ schneller & einfacher Zugriff
    - \- unkontrollierte Redundanz
    - \- manuelle Konsistenzpflege
    - \- schlechte Standards
- Datenbanken
    - \+ Kontrollierte Redundanz
    - \- Datenkonsistenz
    - \- Backup/Recovery
    - \- hohe Komplexität
    - \- teurerer Datenzugriff

== Universe of Discourse

auch: Miniworld

- spezifischer Aspekt der realen Welt, der in DB abgebildet wird

== deklarative Anfragesprache

- Sprachen geben an, was zurückgegeben werden soll, nicht wie die Verarbeitung erfolgt
- Beispiele
    - Relationale Kalküle (TRC, DRC) basierend auf Prädikatenlogik

== RBAC

Role Based Access Control

- Verfeinertes Sicherheitskonzept gegenüber manuellem Grant/Revoke
- Privilegien werden Rollen zugewiesen statt jedem einzelnen Nutzer manuell

=== Database Users

- Direkt involviert
    - Administratoren (Wartung, Sicherheit, Tuning)
    - Datenbank-Designer (Datenidentifikation, Strukturfestlegung)
- Entwicklung & Analyse
    - Anwendungsentwickler (Softwarebau für Endnutzer)
    - Datenanalysten (Trendsuche für Business)
- Endbenutzer
    - Naive Nutzer (vordefinierte Aufgaben, z. B. Bankangestellte)
    - Sophisticated Nutzer (komplexe, eigene Problemlösungen)
    - Casual Nutzer (gelegentliche Nutzung mit Anfragesprachen)
- Hinter den Kulissen
    - DBMS-Designer
    - Tool-Entwickler
    - Operator für Hardware

== Transaktionen

- Menge von Operationen, die als eine logische Einheit ausgeführt werden
- ACID-Prinzip
    - Atomarität (ganz oder gar nicht)
    - Konsistenz (Zustandsübergang)
    - Isolation (keine gegenseitige Störung)
    - Dauerhaftigkeit (Überleben von Fehlern nach Commit)
- Beispiele
    - Geldüberweisungen in Banken (Abbuchung und Gutschrift müssen zusammen geschehen)

= Datenmodellierung

- Datenkonsolidierung
    - Speicherung an zentralem Ort
    - Abbildung von Beziehungen.
- Datenunabhängigkeit
    - Entkopplung von Programmiersprachen und physischer Speicherung
- Datenschutz
    - Schutz vor Verlust und Missbrauch
- Normalisierung
    - Keine mehrfache Repräsentation von Infos
    - Vermeidung von Modifikations-Anomalien

= 3-Schichten-Architektur (ANSI-SPARC)

- Presentation Layer
    - Externe Sichten für Endnutzer
- Logical Layer
    - Enthält logisches Schema (Datenmodelle)
    - oft auch als konzeptionelle Ebene bezeichnet
- Physical Layer
    - Verwaltet tatsächliche Speicherung (Speicherplatz, Zugriffspfade)

== Bedeutung (Unabhängigkeit)

- Physisch
    - Speicherdesign änderbar, ohne logische/konzeptuelle Schemas zu stören (z.B. andere Festplatte nutzen)
- Logisch
    - Logisches Design änderbar, ohne Datensemantik zu stören (z.B. Alter speichern vs. aus Geburtsdatum berechnen)

= Interfaces

== physisches

- Dateiverwaltungssysteme
- direkt an physischer Organisation der Dateien orientiert

== logisches

- Datenbanken
- Abstraktion von Speicherung
- Zugriff über Daten-Semantik (deklarative Abfragen)

= Redundanz

Mehrfache Speicherung identischer Informationen

== kontrolliert

- Daten meist nur einmal gespeichert
- Redundanz nur gezielt für mehr Geschwindigkeit (z. B. Materialized Views)

== unkontrolliert

- Typisch in Dateisystemen
- Gefahr von Inkonsistenzen bei Daten-Updates

= Datenbank Design

== Phasen

+ Requirements Analysis
    - Interviews mit Stakeholdern
    - Definition von Daten- und Funktionsbedarf
+ Conceptual Design
    - Datenbedarf in konzeptuelles Modell (z. B. ER) bringen
    - unabhängig von Software/Hardware.
+ Logical Design
    - Abbildung des konzeptuellen Modells auf DBMS-Technik (z. B. relationales Modell)
+ Physical Design
    - Erstellung interner Strukturen für effiziente Speicherung (Tabellenbereiche, Indizes)

= Entitäten

== Typen

- Mengen von Entitäten mit gleichen Eigenschaften/Attributen
- Beschrieben durch Name und Attribute
    - stellen das Schema (Intension) einer Menge dar

== Klassifikation

- Einfach vs. Zusammengesetzt
    - Einzelner Wert vs. mehrere Komponenten (z. B. Adresse aus Straße, PLZ, Ort)
- Einwertig vs. Mehrwertig
    - Ein Wert vs. Liste von Werten
    - grafisch: doppelrandiges Oval
- Gespeichert vs. Abgeleitet
    - Direkt abgelegt vs. aus anderen Daten berechnet
    - grafisch: gestricheltes Oval
- Schlüsselattribute
    - Wertkombination ist eindeutig
    - grafisch durch Unterstreichung markiert

== Data Models

- Abstraktes Modell zur Beschreibung von Datenrepräsentation, Zugriff und Logik
- Theorie
    - Formale Beschreibung (unabhängig von Software/Hardware)
- Instanz/Schema
    - Konkrete Anwendung der Theorie für eine Applikation
- Kategorien
    - Konzeptuell (nutzernah)
    - Logisch (tabellennah)
    - Physisch (speichernah)

== ER-Modelle

- Traditioneller Ansatz für konzeptuelle Modellierung (Peter Chen, 1976)
- Top-Down-Ansatz
    - Fokus auf Entitäten, Attribute, Beziehungen und Constraints
- Diagramme (ERD) zeigen Entitätstypen, keine Einzelobjekte

#pagebreak()

== Relationen

- Generische Modelle
    - Klassifikations-Relation (is_a) oder Teil-Ganzes-Relation (is_part_of).
- Relationales Modell
    - Logisches Modell
    - Daten wie strukturierte Karteikarten organisiert

= Integration

== View-Integration

- Fasst verschiedene Nutzersichten zusammen
- Ziel: Auflösung konzeptueller Inkompatibilitäten
- Nutzt Techniken wie Entity Clustering
- (Hinweis: Detaillierte Definitionen der Schritte wie "pre-integration Analysis" oder "Merging" sind im Text der vorliegenden Folienausschnitte nicht explizit ausgeführt)

== Entity-Clustering

- Kombiniert Entitäten und Beziehungen zu Konstrukten höherer Ebene
- Ziel: Überblick bei sehr großen Schemata behalten (z. B. komplettes Firmenmodell)
- Abstraktion erlaubt Darstellung des Modells auf einer Seite; Details per "Zoom"
- Operationen (heuristisch): Dominanz-, Abstraktions-, Constraint- oder Beziehungs-Gruppierung

= relational Algebra

== Open World Assumption

- Konzept im reinen TRC
- Variablen können alle theoretisch möglichen Tupel annehmen, nicht nur die in der Datenbank
- Führt dazu, dass Aussagen über Daten außerhalb der aktuellen DB-Instanz als wahr evaluiert werden können

== Bereichsatome (range atoms)

- TRC
    - Bindet Relation $R$ an Tupelvariable $t$ ($R(t)$)
    - Wahr, wenn Tupel tatsächlich Element der Relation $R$ ist
- DRC
    - Relationsatom $R(x_1,...,x_n)$ prüft, ob Wertekombination in Relation existiert
- Dienen als Filter
    - Nur existierende Daten der DB werden betrachtet

=== Anfragen ohne Bereichsatome

- Erzeugen "Open World" Szenario
- Variablen beziehen sich auf unendliche Menge möglicher Tupel
- Ergebnis oft unendlich groß und damit "unsicher" (unsafe)

== Sichere / Unsichere Anfragen

- Unsicher
    - Anfrage liefert unendliche Anzahl von Tupeln (z. B. „alle Tupel, die NICHT in Relation Student sind“)
    - Nicht sinnvoll auswertbar
- Sicher
    - Liefert endliche Ergebnismenge
- Lösung:
    - Closed World Assumption (nur vorhandene Tupel als Variablen-Ersatz)

== Relationale Vollständigkeit

- Sprache ist vollständig, wenn sie gleiche Relationen wie sicheres TRC erzeugen kann
- Basis-Relationalalgebra (5 Grundoperationen) ist relational vollständig
    - Vollständigkeit umfasst keine Aggregationen, Statistiken oder Sortierungen

== Aggregationsfunktionen

- Teil der fortgeschrittenen Relationalalgebra
- Ermöglicht Statistiken
    - übersteigt Ausdruckskraft der relationalen Vollständigkeit
- Können in SQL genutzt werden

== Menge (Set) und Multimenge (Bag)

- Set (Menge)
    - Mathematisches Primitiv
    - Sammlung von Objekten
    - jedes Element einzigartig.
- Bag (Multimenge)
    - SQL-Standard bei Abfrageergebnissen
    - Duplikate standardmäßig erlaubt

== Fetch First

- Teil des SQL:2008 Standards
- begrenzt Zeilenanzahl im Ergebnisset
- nützlich für schnellen Überblick (z.B. `FETCH FIRST 10 ROWS ONLY`)

#pagebreak()

== SQL

- keine `HAVING` ohne `GROUP BY`

=== Datentypen

- `SMALLINT`
- `INTEGER`
- `NUMERIC(precision?,scale?)`
- `FLOAT`
- `CHAR(length?)`
- `varchar(length?)`
- `DATE`
- `TIME`
- `TIMESTAMP`

= relational Algebra in Abfragen

- set operations
    - operands must be union-compatible (consist of the same attributes)
    - union $R union S$
    - intersection $R inter S$
    - difference $R without S$
- kartesisches Produkt $S times R$
    - Kombination jedes Tupels aus $R$ mit jedem Tupel aus $S$
- Projection: $pi_"attr"$ retains only specified attributes
- Selection: $sigma_"condition"$ selects all tuples from a relation that satisfy the given boolean condition
- Rename: $rho_("new-table-name" ("column-1-name", ... ,"column-N-name"))$
    - also possible: $rho_("column-1-name",...,"column-N-name")$
- Joins:
    #grid(
        columns: 2,
        [- Theta Join], [$join_theta$ (boolean condition $theta$)],
        [- Semi-Left Join], $R times.l S = pi_("alle Attribute in R") (R join S)$,
        [- Left-Outer-Join], [$R join.l S$ alle Tupel von R werden beibehalten],
    )
- Division: $R div S$
    - $S$ only contains attributes that are also present in $R$
    - result attributes: those in $R$, but not in $S$
    - result tuples: those in $R$ such that every tuple in S is a join partner
    - formal:
        - let $A_R = {"Attributes of" R}, A_S = {"Attributes of" S}, A_S subset.eq A_R$
        - $A = A_R without A_S$
        - $R div S eq.triple pi_A R without pi_A (((pi_A R) times S) without R)$
        - $(R times S) div S = R$
- Aggregation: $aggregation("grouping", "function")$

#pagebreak()

== TRC

"objektorientieres DRC"

$
    {"b.kundennr" mid "Fahrzeugbesitzer"(b) and \
        forall f (("Fahrzeug"(f) and "f.besitzer" = "b.kundennr")\
            -> (exists p ("Prüfung"(p) and "p.fahrzeug" = "f.fahrzeugnr") and \
                not exists r ("Reparatur"(r) and "r.fahrzeug" = "f.fahrzeugnr")))}
$

== DRC

filtern von beliebigen Werten im allgemeinen Universum

#let anr = "anr"

$
    {anr, f, d mid "Reparatur"(anr, f, d) and \
        exists anr', anr'' ("Reparatur"(anr', f, d) and \
            "Reparatur"(anr'', f, d) and \
            anr != anr' and anr != anr'' and anr' != anr'' and \
            not exists anr'''("Reparatur"(anr''', f, d) and anr''' > anr))}
$

#pagebreak()

== Trigger

```SQL
ON [EVENT]
IF [CONDITION]
DO [ACTION]
```

generally

```SQL
CREATE TRIGGER [name]
[BEFORE|AFTER] [[event]]
ON [table_name] [trigger_type]
BEGIN
    [[logic]]
END
```

- new value can be referenced as `NEW`
    - insert
    - rename via `REFERENCING NEW AS [name]`
- old value can be referenced as `OLD`
    - delete
- `OLD` and `NEW` must be explicitly referenced to access it
- `FOR EACH [ROW|STATEMENT]`

example

```SQL
CREATE TRIGGER kill_bugs
    AFTER UPDATE OF location ON bugs
    REFERENCING NEW AS bn
    FOR EACH ROW
    WHEN EXISTS(
        SELECT *
        FROM pesicides p
        WHERE p.name = "Glyphosat" AND p.location = bn.location
    )
    BEGIN
        DELETE FROM bugs b WHERE b.id = bn.id;
    END
```

```SQL
CREATE TRIGGER Mitarbeiter
    AFTER UPDATE ON Mitarbeiter
    REFERENCING NEW as new, OLD as old
    FOR EACH ROW
    WHEN new.gehalt > old.gehalt * 2
BEGIN
    UPDATE SET gehalt = old.gehalt * 2
    FROM Mitarbeiter
    WHERE id = new.mid
END
```

#pagebreak()

== Constraints

- Allgemein
    - Regeln, die für alle Instanzen eines Schemas gelten müssen
- PK Constraint (Primary Key)
    - Jede Relation hat Primärschlüssel
    - erzwingt Eindeutigkeit (Unique Key Constraint)
- FK Constraint (Foreign Key)
    - Erzeugt Links/Verknüpfungen zwischen verschiedenen Relationen
\
- `NOT NULL`
- `DEFAULT`
    - oft: `DEFAULT NULL`
- `UNIQUE`
- `PRIMARY KEY` (= `NOT NULL UNIQUE`)
    - composed PK:\
    ```SQL
    CREATE TABLE table (
        column-1 [TYPE],
        ...
        column-N [TYPE],
        PRIMARY KEY(column-1,...,column-N)
    )
    ```

#pagebreak()

- `REFERENCES [table_name(column_name?,...,column_name_n?)]`
    - ```SQL
        CREATE TABLE managed_by (
            employee INTEGER NOT NULL
                REFERENCES employee
            manager INTEGER NOT NULL
                REFERENCES employee
        )
        ```
    - reference can be created later
        - `FOREIGN KEY(column_name) REFERENCES other_table [ON DELETE?...]`
    - -> column created as normal, then constrained
    - referential integrity
        - `ON DELETE [NO ACTION|SET NULL|CASCADE]`
            - `NO ACTION`: reject deletion
            - `SET NULL`: set referencing FK's to #null
            - `CASCADE`: delete referencing rows as well
        - `ON UPDATE [NO ACTION|CASCADE]` (PK modified)
            - `NO ACTION`: reject update
            - `CASCADE`: change values of referencing FK's
        - default: `ON DELETE NO ACTION ON UPDATE NO ACTION`
    - ```SQL
        CREATE TABLE Angestellt (
            variete varchar FOREIGN KEY REFERENCES (Variete),
            akrobat varchar FOREIGN KEY REFERENCES (Akrobat),
            gehalt real NULL,
            PRIMARY KEY (variete, akrobat)
        )
        ```

example:
```SQL
CREATE TABLE person (
    name VARCHAR(200),
    age INTEGER CONSTRAINT adult
        CHECK (age >= 18)
)
```

= Normalformen

- Qualitätsstufen für Relationenschemata (1NF bis 6NF inkl. BCNF)
    - hängen von Constraints/Abhängigkeiten ab.
- Höhere Nummer = strengere Anforderungen, weniger Redundanz und weniger Anomalien

== Normalisierung

- Formalisierung von Regeln für gutes Design
- Zerlegung (Dekomposition) von Tabellen in kleinere Einheiten
- Ziele
    - Minimierung von Redundanz
    - Verhinderung von Modifikations-Anomalien

== funktionale Abhängigkeit (FD)

- Kern der Normalisierung
    - Y hängt von X ab, wenn gleiche X-Werte zwingend gleiche Y-Werte bedeuten
- Verletzungen von FDs sind Hauptursache für Redundanz und Update-Anomalien

== transitive Abhängigkeit

- wenn Y von X funktional abhängig ist und Z von Y, so ist Z von X funktional abhängig

== erste Normalform

- jedes Attribut in atomare Form

== zweite Normalform

- jedes Nichtschlüsselattribut ist von jedem Schlüsselkandidaten voll funktional abhängig

== dritte Normalform

- kein Nichtschlüsselattribut hängt transitiv von einem Kandidatenschlüssel ab

== Boyce Codd Normalform (BCNF)

- wenn jede Determinante vom Relationstyp ein Kandidatenschlüssel ist
- Strikter als 3NF; für jede nicht-triviale funktionale Abhängigkeit $X -> Y$ muss $X$ ein Superschlüssel sein
- "Jedes Attribut hängt vom Schlüssel ab, vom ganzen Schlüssel und von nichts als dem Schlüssel"

= Views

- Virtuelle Tabellen
    - bieten spezifische Perspektive auf DB für Nutzer oder Anwendungen
- Können Teilmengen oder abgeleitete Daten (Joins, Aggregationen) enthalten

== updatable Views

- Meist nur Read-Only, da Transformation von Updates oft unklar
- Updatebar in PostgreSQL 14 nur bei einfacher Struktur
    - nur eine Tabelle in FROM
    - keine Joins
    - kein GROUP BY
    - kein DISTINCT

= ACID

- Atomicity
    - Transaktion als eine logische Einheit
    - ganz oder gar nicht ausgeführt
- Consistency
    - Concurrency Control sichert konsistenten DB-Zustand
- Isolation
    - Transaktionen müssen voneinander isoliert ablaufen
- (Hinweis: Die explizite Definition von Durability fehlt in den vorliegenden Ausschnitten)

= CRUD

- Create
- Read
- Update
- Delete

= EER-Diagram

- Schlüssel #sym.eq.not Schlüsselattribut
\
- simple attribute
    - Attribut aus einzelnen Komponent
    - unabhängige Existenz
- composite attribute
    - Beispiel
        - SQL: `Car(brand, license_plate(district_id,letter_id, numeric_id), year)`
        - Erstellung: `(Mercedes,(BS,CL,797),1998)`
\
- single-valued attribute
    - z.B. Name, registration Nummer
- multi-valued attribute
    - doppelt umkreistes Attribut
    - Reihenfolge der Attribute irrelevant
    - mehrfacher Wert für Attribut
        - z.B. Telefonnummer
\
- stored attribute
    - Attribut direkt in der Datenbank gespeichert
- derived attribute
    - gestricheltes Oval
    - nicht in Datenbank gespeichert
    - aus anderen Attributen berechnet

== Vererbung

=== Union

- `u` in einem Kreis
- A und B nicht verwandt, aber trotzdem verbunden
- Beispiel
    - Dozent ist ein Angestellter von der Universität oder Unternehmensvertreter

=== Disjunktion

=== Overlap
