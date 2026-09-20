# Fragen.ps1
# Gibt ein Array von Frage-Objekten zurueck

$Fragen = @(
	# --- OSI ---
    @{ Typ = "offeneFrage"; Kategorie = "OSI"; Prompt = "Wie heißt die OSI-Schicht 1? (deutsch)"; RichtigeAntwort = "Bitübertragung" },
    @{ Typ = "offeneFrage"; Kategorie = "OSI"; Prompt = "Wie heißt die OSI-Schicht 2? (deutsch)"; RichtigeAntwort = "Sicherung" },
    @{ Typ = "offeneFrage"; Kategorie = "OSI"; Prompt = "Wie heißt die OSI-Schicht 3? (deutsch)"; RichtigeAntwort = "Vermittlung" },
    @{ Typ = "offeneFrage"; Kategorie = "OSI"; Prompt = "Wie heißt die OSI-Schicht 4? (deutsch)"; RichtigeAntwort = "Transport" },
    @{ Typ = "offeneFrage"; Kategorie = "OSI"; Prompt = "Wie heißt die OSI-Schicht 5? (deutsch)"; RichtigeAntwort = "Sitzung" },
    @{ Typ = "offeneFrage"; Kategorie = "OSI"; Prompt = "Wie heißt die OSI-Schicht 6? (deutsch)"; RichtigeAntwort = "Darstellung" },
    @{ Typ = "offeneFrage"; Kategorie = "OSI"; Prompt = "Wie heißt die OSI-Schicht 7? (deutsch)"; RichtigeAntwort = "Anwendung" },

    @{ Typ = "offeneFrage"; Kategorie = "OSI"; Prompt = "Wie heißt die OSI-Schicht 1? (englisch)"; RichtigeAntwort = "physical" },
    @{ Typ = "offeneFrage"; Kategorie = "OSI"; Prompt = "Wie heißt die OSI-Schicht 2? (englisch)"; RichtigeAntwort = "Data Link" },
    @{ Typ = "offeneFrage"; Kategorie = "OSI"; Prompt = "Wie heißt die OSI-Schicht 3? (englisch)"; RichtigeAntwort = "Network" },
    @{ Typ = "offeneFrage"; Kategorie = "OSI"; Prompt = "Wie heißt die OSI-Schicht 4? (englisch)"; RichtigeAntwort = "Transport" },
    @{ Typ = "offeneFrage"; Kategorie = "OSI"; Prompt = "Wie heißt die OSI-Schicht 5? (englisch)"; RichtigeAntwort = "Session" },
    @{ Typ = "offeneFrage"; Kategorie = "OSI"; Prompt = "Wie heißt die OSI-Schicht 6? (englisch)"; RichtigeAntwort = "Presentation" },
    @{ Typ = "offeneFrage"; Kategorie = "OSI"; Prompt = "Wie heißt die OSI-Schicht 7? (englisch)"; RichtigeAntwort = "Application" },
    @{ Typ = "offeneFrage"; Kategorie = "OSI"; Prompt = "Wieviel Schichten gibt es?";  RichtigeAntwort = "7" },
    @{ Typ = "offeneFrage"; Kategorie = "OSI"; Prompt = "Wie viele Bit hat ein Byte?"; RichtigeAntwort = "8" },
    @{ Typ = "offeneFrage"; Kategorie = "OSI"; Prompt = "Was bedeutet das Ptotokoll TCP ausgeschrieben?"; RichtigeAntwort = "Transmission Control Protokoll" }

	@{ Typ = "MultipleChoice"; Kategorie = "OSI"; Prompt = "Wie viel Layer hat das OSI Modell"; Antworten = @("1", "7", "8", "6"); RichtigeAntwort = 2 },
	@{ Typ = "MultipleChoice"; Kategorie = "OSI"; Prompt = "Welche OSI-Schicht ist für die physische Übertragung von Bits zuständig?"; Antworten = @("Bitübertragungsschicht", "Sicherungsschicht", "Vermittlungsschicht", "Transportschicht"); RichtigeAntwort = 1 },
	@{ Typ = "MultipleChoice"; Kategorie = "OSI"; Prompt = "Auf welcher OSI-Schicht arbeitet ein Router hauptsächlich?"; Antworten = @("Schicht 1", "Schicht 2", "Schicht 3", "Schicht 4"); RichtigeAntwort = 3 },
	@{ Typ = "MultipleChoice"; Kategorie = "OSI"; Prompt = "Auf welcher OSI-Schicht werden MAC-Adressen verwendet?"; Antworten = @("Bitübertragungsschicht", "Sicherungsschicht", "Vermittlungsschicht", "Transportschicht"); RichtigeAntwort = 2 },
	@{ Typ = "MultipleChoice"; Kategorie = "OSI"; Prompt = "Welche PDU gehört zur OSI-Schicht 3?"; Antworten = @("Bit", "Frame", "Paket", "Segment"); RichtigeAntwort = 3 },
	@{ Typ = "MultipleChoice"; Kategorie = "OSI"; Prompt = "Welche PDU gehört zur OSI-Schicht 2?"; Antworten = @("Bit", "Frame", "Paket", "Segment"); RichtigeAntwort = 2 },
	@{ Typ = "MultipleChoice"; Kategorie = "OSI"; Prompt = "Welche OSI-Schicht ist für TCP und UDP zuständig?"; Antworten = @("Sitzungsschicht", "Transportschicht", "Vermittlungsschicht", "Anwendungsschicht"); RichtigeAntwort = 2 },
	@{ Typ = "MultipleChoice"; Kategorie = "OSI"; Prompt = "Welche Information wird auf der Transportschicht unter anderem verwendet, um Anwendungen zu unterscheiden?"; Antworten = @("MAC-Adresse", "IP-Adresse", "Portnummer", "Subnetzmaske"); RichtigeAntwort = 3 },
	@{ Typ = "MultipleChoice"; Kategorie = "OSI"; Prompt = "Welche OSI-Schicht ist für die logische Adressierung mit IP-Adressen zuständig?"; Antworten = @("Sicherungsschicht", "Vermittlungsschicht", "Transportschicht", "Darstellungsschicht"); RichtigeAntwort = 2 },
	@{ Typ = "MultipleChoice"; Kategorie = "OSI"; Prompt = "Welche Schicht des OSI-Modells ist für die Darstellung und Formatierung von Daten zuständig?"; Antworten = @("Anwendungsschicht", "Sitzungsschicht", "Darstellungsschicht", "Transportschicht"); RichtigeAntwort = 3 },
	@{ Typ = "MultipleChoice"; Kategorie = "OSI"; Prompt = "Welche OSI-Schicht stellt Netzwerkdienste für Anwendungen bereit?"; Antworten = @("Anwendungsschicht", "Darstellungsschicht", "Transportschicht", "Sicherungsschicht"); RichtigeAntwort = 1 },


	# --- Netzwerk ---
	@{ Typ = "MultipleChoice"; Kategorie = "Netzwerk"; Prompt = "Was macht DNS?"; Antworten = @("Automatische Netzwerkkonfiguration", "Namen in IP uebersetzen", "uebertraegt Dateien", "Verschluesselt Netzwerkverbindungen"); RichtigeAntwort = 2 },
	@{ Typ = "MultipleChoice"; Kategorie = "Netzwerk"; Prompt = "Was macht DHCP?"; Antworten = @("Automatische Netzwerkkonfiguration", "Namen in IP uebersetzen", "uebertraegt Dateien", "Verschluesselt Netzwerkverbindungen"); RichtigeAntwort = 1 },
	@{ Typ = "MultipleChoice"; Kategorie = "Netzwerk"; Prompt = "Was macht DNS?"; Antworten = @("Automatische Netzwerkkonfiguration", "Namen in IP uebersetzen", "uebertraegt Dateien", "Verschluesselt Netzwerkverbindungen"); RichtigeAntwort = 2 },
    @{ Typ = "MultipleChoice"; Kategorie = "Netzwerk"; Prompt = "Bei welcher DNS-Aufloesung uebernimmt der angefragte Server die komplette Suche?"; Antworten = @("Iterativ", "Rekursiv", "Broadcast", "Reverse"); RichtigeAntwort = 2 },
    @{ Typ = "MultipleChoice"; Kategorie = "Netzwerk"; Prompt = "Auf welchem Port laeuft DNS standardmaessig?"; Antworten = @("Port 25", "Port 53", "Port 80", "Port 443"); RichtigeAntwort = 2 },
    @{ Typ = "offeneFrage"; Kategorie = "Netzwerk"; Prompt = "Auf welchem Port laeuft DNS standardmaessig?"; RichtigeAntwort = "53" },

    # --- DHCP ---
    @{ Typ = "offeneFrage"; Kategorie = "DHCP"; Prompt = "Wofuer steht das Akronym DORA beim DHCP-Prozess?"; RichtigeAntwort = "Discover, Offer, Request, Acknowledge" },
    @{ Typ = "MultipleChoice"; Kategorie = "DHCP"; Prompt = "Welche Nachricht sendet der Client als ersten Schritt beim DHCP-Prozess?"; Antworten = @("DHCP Offer", "DHCP Discover", "DHCP Request", "DHCP Acknowledge"); RichtigeAntwort = 2 },
    @{ Typ = "MultipleChoice"; Kategorie = "DHCP"; Prompt = "Welche Nachricht sendet der DHCP-Server als Antwort auf den Discover?"; Antworten = @("DHCP Ack", "DHCP Offer", "DHCP Request", "DHCP Release"); RichtigeAntwort = 2 },
    @{ Typ = "MultipleChoice"; Kategorie = "DHCP"; Prompt = "Ist DHCP Discover ein Broadcast oder ein Unicast?"; Antworten = @("Unicast", "Broadcast", "Multicast", "Anycast"); RichtigeAntwort = 2 },

	# --- PowerShell ---
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Was macht Read-Host?"; Antworten = @("Gibt Text auf der Konsole aus", "Liest eine Eingabe des Benutzers ein", "Beendet das Script", "Startet eine Schleife"); RichtigeAntwort = 2 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Was macht Write-Host?"; Antworten = @("Liest Benutzereingaben ein", "Gibt Text auf der Konsole aus", "Erstellt eine Variable", "Startet eine Funktion"); RichtigeAntwort = 2 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Welche Schleife wird verwendet, wenn eine Bedingung geprüft werden soll?"; Antworten = @("if", "while", "switch", "param"); RichtigeAntwort = 2 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Was macht eine if-Bedingung?"; Antworten = @("Wiederholt Code", "Definiert Parameter", "Führt Code abhängig von einer Bedingung aus", "Erstellt ein Array"); RichtigeAntwort = 3 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Was bedeutet -gt?"; Antworten = @("Kleiner als", "Größer als", "Gleich", "Ungleich"); RichtigeAntwort = 2 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Was bedeutet -lt?"; Antworten = @("Kleiner als", "Größer als", "Kleiner oder gleich", "Ungleich"); RichtigeAntwort = 1 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Was ist ein Array?"; Antworten = @("Eine einzelne Zahl", "Eine Sammlung mehrerer Werte", "Eine Funktion", "Ein PowerShell-Befehl"); RichtigeAntwort = 2 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Bei welchem Index beginnt ein Array in PowerShell normalerweise?"; Antworten = @("0", "1", "-1", "Je nach Array unterschiedlich"); RichtigeAntwort = 1 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Was macht $PSScriptRoot?"; Antworten = @("Enthält den Namen des Computers", "Enthält den Pfad des aktuellen Scripts", "Enthält den aktuellen Benutzer", "Enthält die PowerShell-Version"); RichtigeAntwort = 2 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Was ist der Zweck von param() in einer Funktion?"; Antworten = @("Es definiert Eingabeparameter", "Es beendet die Funktion", "Es erstellt eine Schleife", "Es gibt einen Wert aus"); RichtigeAntwort = 1 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Was macht return in einer Funktion?"; Antworten = @("Startet die Funktion", "Beendet die PowerShell", "Gibt einen Wert zurück bzw. beendet die Funktion", "Erstellt einen Parameter"); RichtigeAntwort = 3 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Welche Schreibweise erzeugt ein Array?"; Antworten = @("@(1, 2, 3)", "$(1, 2, 3)", "array(1, 2, 3)", "[1, 2, 3]"); RichtigeAntwort = 1 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Was macht eine for-Schleife typischerweise?"; Antworten = @("Sie definiert eine Funktion", "Sie verarbeitet eine festgelegte bzw. kontrollierte Anzahl von Durchläufen", "Sie liest Benutzereingaben", "Sie lädt ein Modul"); RichtigeAntwort = 2 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Was bedeutet $i++?"; Antworten = @("Die Variable wird um 1 erhöht", "Die Variable wird um 1 verringert", "Die Variable wird auf 0 gesetzt", "Die Variable wird gelöscht"); RichtigeAntwort = 1 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Was macht foreach?"; Antworten = @("Es durchläuft die Elemente einer Sammlung", "Es erstellt eine Funktion", "Es prüft die PowerShell-Version", "Es beendet eine Schleife"); RichtigeAntwort = 1 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Was macht .Trim() bei einem String?"; Antworten = @("Entfernt Leerzeichen am Anfang und Ende", "Wandelt den Text in Großbuchstaben um", "Löscht den String", "Teilt den String auf"); RichtigeAntwort = 1 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Was macht .ToLower()?"; Antworten = @("Wandelt einen Text in Kleinbuchstaben um", "Entfernt Leerzeichen", "Wandelt einen Text in Großbuchstaben um", "Zählt die Zeichen"); RichtigeAntwort = 1 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Was bedeutet -and?"; Antworten = @("Mindestens eine Bedingung muss wahr sein", "Alle verknüpften Bedingungen müssen wahr sein", "Eine Bedingung wird negiert", "Eine Schleife wird gestartet"); RichtigeAntwort = 2 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Was ist der Datentyp [uint]?"; Antworten = @("Eine Ganzzahl ohne negative Werte", "Eine Dezimalzahl", "Ein String", "Ein Boolean"); RichtigeAntwort = 1 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Was passiert bei [uint]$Anzahl = -1?"; Antworten = @("Die Variable enthält -1", "Die Eingabe wird automatisch zu 0", "Ein negativer Wert ist für diesen Datentyp nicht gültig", "Die Variable wird zu einem String"); RichtigeAntwort = 3 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Welche Schreibweise ermöglicht Variablen innerhalb eines Strings?"; Antworten = @("'Text $Variable'", "`"Text $Variable`"", "[Text $Variable]", "(Text $Variable)"); RichtigeAntwort = 2 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Was macht $Fragen.Count?"; Antworten = @("Gibt das erste Element zurück", "Gibt die Anzahl der Elemente zurück", "Löscht alle Fragen", "Sortiert die Fragen"); RichtigeAntwort = 2 },
	@{ Typ = "MultipleChoice"; Kategorie = "PowerShell"; Prompt = "Was macht Get-Random?"; Antworten = @("Erzeugt eine zufällige Auswahl bzw. einen Zufallswert", "Löscht zufällige Dateien", "Startet ein Script zufällig", "Erstellt automatisch Variablen"); RichtigeAntwort = 1 },
	@{ Typ = "offeneFrage"; Kategorie = "PowerShell"; Prompt = "Wie schreibt man eine Zeichenkette in PowerShell?"; RichtigeAntwort = "In Anführungszeichen" },
	@{ Typ = "offeneFrage"; Kategorie = "PowerShell"; Prompt = "Wie beginnt man in PowerShell eine Variable?"; RichtigeAntwort = "$" },
	@{ Typ = "offeneFrage"; Kategorie = "PowerShell"; Prompt = "Welcher Operator prüft in PowerShell auf Gleichheit?"; RichtigeAntwort = "-eq" },
	@{ Typ = "offeneFrage"; Kategorie = "PowerShell"; Prompt = "Wie greift man auf die Anzahl der Elemente eines Arrays zu?"; RichtigeAntwort = ".Count" },
	@{ Typ = "offeneFrage"; Kategorie = "PowerShell"; Prompt = "Welcher Befehl zeigt den Inhalt einer Variable an?"; RichtigeAntwort = "Write-Host" },
	@{ Typ = "offeneFrage"; Kategorie = "PowerShell"; Prompt = "Mit welchem Schlüsselwort werden Parameter einer Funktion definiert?"; RichtigeAntwort = "param" },
	@{ Typ = "offeneFrage"; Kategorie = "PowerShell"; Prompt = "Wie wird ein Kommentar in PowerShell eingeleitet?"; RichtigeAntwort = "#" },
	@{ Typ = "offeneFrage"; Kategorie = "PowerShell"; Prompt = "Mit welchem Operator wird in PowerShell eine Variable erhöht?"; RichtigeAntwort = "++" },
	@{ Typ = "offeneFrage"; Kategorie = "PowerShell"; Prompt = "Wie greift man auf das erste Element eines Arrays zu?"; RichtigeAntwort = "[0]" },
	@{ Typ = "offeneFrage"; Kategorie = "PowerShell"; Prompt = "Welcher Operator prüft auf Ungleichheit?"; RichtigeAntwort = "-ne" },
	@{ Typ = "offeneFrage"; Kategorie = "PowerShell"; Prompt = "Welcher Operator negiert eine Bedingung in PowerShell?"; RichtigeAntwort = "-not" },
	@{ Typ = "offeneFrage"; Kategorie = "PowerShell"; Prompt = "Wie kann man in PowerShell einen bestimmten Array-Index ansprechen?"; RichtigeAntwort = "[Index]" }

)
$Fragen
