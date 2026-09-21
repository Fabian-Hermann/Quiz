# ==============================================================
# quiz_functions.ps1
# Sammlung aller Funktionen fuer das PowerShell-Quiz in main.ps1
# ==============================================================


function Ladebalken {
    # NAME: Ladebalken
    # ZIEL: Für UX sollen das Quiz nicht direkt starten sonden ein wenig warten
    # EINGABE: -
    # ABLAUF:
    #   1. Die Länge soll angegeben werden aus wie viel Symbolen der Ladebalken besteht 
    #   2. Länge wird inerhalb des Blocks weitergegeben
    #   3. Für jedes Element wird dies wiederholt bis die Anzahl der symbole erreicht wird
    #   4. Symbol fuer den vollen und leeren Balken festlegen 
    #   5. Schleife soll sich "erneuern" und updaten mit "`r" und "-NoNewLine"
    # WIEDERHOLUNGEN:
    #   - Solange bis alle Symbole von leer zu voll gewächselt haben
    # AUSGABE: [###.....]
    # VERANTWORTUNG NICHT HIER:
    #   - Nicht für den Ablauf davor oder Danach verantwortlich

    param(
        [int]$Laenge = 15
    )

    for ($i = 1; $i -le $Laenge; $i++) {

        $Balken = "#" * $i
        $Punkte = "." * ($Laenge - $i)

        Write-Host "`r[$Balken$Punkte]" -NoNewline

        Start-Sleep -Milliseconds 100
    }

    Write-Host
}
#===============================================================

function FragenAnzahl {
    # ZIEL: Vom Nutzer abfragen, wie viele Fragen gestellt werden sollen,
    #       und sicherstellen, dass die Anzahl gueltig ist (min. 1, max. vorhandene Fragenzahl)
    # EINGABE: $Fragen - Array aller verfuegbaren Fragen
    # ABLAUF:
    #   1. Anzahl der verfuegbaren Fragen anzeigen
    #   2. Nutzereingabe abfragen
    #   3. Eingabe validieren, bei ungueltiger Eingabe erneut abfragen
    #   4. Bestaetigung anzeigen
    #   5. Gueltige Anzahl zurueckgeben
    # ENTSCHEIDUNGEN:
    #   - Ist Anzahl -eq 0? -> Fehlermeldung "mindestens 1"
    #   - Ist Anzahl -gt Fragen.Count? -> Fehlermeldung "Maximum ueberschritten"
    # WIEDERHOLUNGEN:
    #   - Solange die Eingabe ungueltig ist (0 oder groesser als Fragen.Count), erneut abfragen
    # AUSGABE: [uint16] gueltige Anzahl gewuenschter Fragen
    # VERANTWORTUNG NICHT HIER:
    #   - Kein Stellen der Fragen selbst
    #   - Keine Auswahl, WELCHE Fragen genommen werden (nur wie viele)
    #   - Kein Laden der Fragen-Datenstruktur


    param(
        $Fragen
    )
    Write-Host "Anzahl Fragen im Array: $($AusgewaehlteFragenKategorie.Count)"  
    [uint16]$Anzahl = Read-Host "Wie viel Fragen moechtest du?"

    while ($Anzahl -gt $AusgewaehlteFragenKategorie.Count -or $Anzahl -eq 0) {
		
		if ($Anzahl -eq 0){
			Write-Host "Die Anzahl muss mindestens 1 sein." -ForegroundColor Yellow
		}
		elseif ($Anzahl -gt $AusgewaehlteFragenKategorie.Count) {
			Write-Host "Das momentane Maximum ist: $($AusgewaehlteFragenKategorie.Count)" -ForegroundColor Yellow
		}

        [uint16]$Anzahl = Read-Host "Wie viel Fragen moechtest du?"
    }

    Write-Host "Du hast ausgewaelhlt: $($Anzahl)" 
    return $Anzahl
}
#===============================================================

function FragenKategorie {
    param(
        $Fragen
    )
	$Kategorie = $Fragen.Kategorie
	$EinzigartigeKategorie = $Kategorie | Select-Object -Unique
	Write-Host "[1] Alle Kategorieren"
	
	for ($i = 0; $i -lt $EinzigartigeKategorie.Count; $i++){
		
		Write-Host "[$($i+2)] $($EinzigartigeKategorie[$i])"
	}
	
	while($AusgewaehlteKategorie -gt $($EinzigartigeKategorie.Count)+1 -or $AusgewaehlteKategorie -eq $null){
			
		$AusgewaehlteKategorie = Read-Host "Waehle eine Kategorie aus"
		
			if ($AusgewaehlteKategorie -gt $($EinzigartigeKategorie.Count)+1){
				Write-Host "Es kommen bald weitere Kategorien hinzu"
				$AusgewaehlteKategorie = Read-Host "Waehle eine Kategorie ein"
			}
			elseif ($AusgewaehlteKategorie -eq 0){
				Write-Host "Null gibt's nicht du Nulpe!" -ForegroundColor Red
				$AusgewaehlteKategorie = Read-Host "Waehle eine Kategorie"
			}

	}
	if ($AusgewaehlteKategorie -eq "1"){
		$AusgewaehlteFragenKategorie = $Fragen
	}
	else {
		$AusgewaehlteKategorieName = $EinzigartigeKategorie[$AusgewaehlteKategorie - 2]
		Write-Host "Du hast folgendes gewaehlt: $($AusgewaehlteKategorieName)"
		$AusgewaehlteFragenKategorie = $Fragen | Where-Object {
			$_.Kategorie -eq $($AusgewaehlteKategorieName)
		}
	}
	return $AusgewaehlteFragenKategorie
}

#===============================================================

function Titelbild {
    # ZIEL: Titelbildschirm zur Begrüßung 
    # EINGABE: -
    # ABLAUF: -
    # AUSGABE: ASCI Art
    # VERANTWORTUNG NICHT HIER: Weder Starten noch sonstige Funktionen

	Write-Host @"
   ____        _    
  / __ \__  __(_)___
 / / / / / / / /_  /
/ /_/ / /_/ / / / /_
\___\_\__,_/_/ /___/

"@ -ForegroundColor Yellow
}
#===============================================================

function AbfrageAntwort {
    # ZIEL: Eine einzelne Frage stellen, Antwort vom User abfragen und mit der
    #       gespeicherten richtigen Antwort vergleichen
    # EINGABE: $Frage - EIN Fragen-Objekt (nicht das ganze Array!)
    # ABLAUF:
    #   1. Frage-Text anzeigen
    #   2. Je nach Typ (MultipleChoice / offeneFrage) Eingabe abfragen
    #   3. Eingabe mit RichtigeAntwort vergleichen
    #   4. Rueckmeldung ausgeben
    # AUSGABE: [bool] $true bei richtiger, $false bei falscher Antwort
    # VERANTWORTUNG NICHT HIER:
    #   - Kein Iterieren ueber mehrere Fragen (macht main.ps1 bereits per foreach)

    param(
        $Frage
    )

    Write-Host $Frage.Prompt -ForegroundColor Cyan

    if ($Frage.Typ -eq "MultipleChoice") {

        for ($i = 0; $i -lt $Frage.Antworten.Count; $i += 2) {
            $links = "[$($i+1)] $($Frage.Antworten[$i])"

            if ($i + 1 -lt $Frage.Antworten.Count) {
                $rechts = "[$($i+2)] $($Frage.Antworten[$i+1])"
                Write-Host ("{0,-60}{1}" -f $links, $rechts)
            } else {
                Write-Host $links
            }
        }

        [int]$Auswahl = Read-Host "Deine Wahl (Nummer)"

        if ($Auswahl -eq $Frage.RichtigeAntwort) {
            Write-Host "Richtig" -ForegroundColor Green
            return $true
        } else {
            $richtigerText = $Frage.Antworten[$Frage.RichtigeAntwort - 1]
            Write-Host "Falsch. Die richtige Antwort wäre: [$($Frage.RichtigeAntwort)] $richtigerText" -ForegroundColor Red
            #return $Frage
			return $false
        }

    }  elseif ($Frage.Typ -eq "offeneFrage") {

        $Antwort = Read-Host "Antwort"

        if ((LevenshteinDistance $Antwort.Trim() $Frage.RichtigeAntwort.Trim()) -le 1) {
            Write-Host "Richtig" -ForegroundColor Green
            return $true
        } else {
            Write-Host "Falsch. Die richtige Antwort wäre: $($Frage.RichtigeAntwort)" -ForegroundColor Red
            #return $Frage
            return $false
        }
    }
}
#===============================================================

function LevenshteinDistance {
    # ZIEL: Berechnet die Levenshtein-Distanz zwischen zwei Zeichenketten
    # EINGABE: Zwei Zeichenketten (Antwort und RichtigeAntwort)
    # ABLAUF:
    #   1. Länge der beiden Zeichenketten bestimmen
    #   2. Eine Matrix erstellen, um die Distanzen zu speichern
    #   3. Die Matrix initialisieren
    #   4. Die Matrix mit den Distanzen füllen
    #   5. Die Levenshtein-Distanz zurückgeben
    # AUSGABE: [int] Levenshtein-Distanz
    # VERANTWORTUNG NICHT HIER:
    #   - Keine Validierung der Eingaben (sollte bereits vorher geschehen)

    param (
        [string]$Antwort,
        [string]$RichtigeAntwort
    )

    $n = $Antwort.Length
    $m = $RichtigeAntwort.Length

    if ($n -eq 0) { return $m }
    if ($m -eq 0) { return $n }

    $d = New-Object 'int[,]' ($n + 1), ($m + 1)

    for ($i = 0; $i -le $n; $i++) { $d[$i, 0] = $i }
    for ($j = 0; $j -le $m; $j++) { $d[0, $j] = $j }

    for ($i = 1; $i -le $n; $i++) {
        for ($j = 1; $j -le $m; $j++) {
            if ($Antwort[$i - 1] -eq $RichtigeAntwort[$j - 1]) {
                $cost = 0
            } else {
                $cost = 1
            }
			# berechnung der minimalen Distanz
			$loeschen = $d[($i -1), $j] +1
            $einfuegen = $d[$i, ($j - 1)] +1
            $ersetzen = $d[($i - 1), ($j - 1)] + $cost
            $d[$i, $j] = [Math]::Min([Math]::Min($loeschen, $einfuegen), $ersetzen)
        }
    }

    return $d[$n, $m]
}
