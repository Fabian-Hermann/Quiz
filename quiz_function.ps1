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

        Start-Sleep -Milliseconds 30
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
	# Write-Host $Kategorie
	$EinzigartigeKategorie = $Fragen.Kategorie | Select-Object -Unique
	Write-Host $EinzigartigeKategorie
	Write-Host "[1] Alle Kategorien"
    # Tests um CSV Implimentierung zu prüfen
	# Write-Host $($EinzigartigeKategorie) -ForegroundColor Red
	for ($i = 0; $i -lt $EinzigartigeKategorie.Count; $i++){
		
		Write-Host "[$($i+2)] $($EinzigartigeKategorie[$i])"
	}
	
	while($AusgewaehlteKategorie -gt $($EinzigartigeKategorie.Count)+1 -or $null -eq $AusgewaehlteKategorie){
			
		$AusgewaehlteKategorie = Read-Host "Waehle eine Kategorie aus"
		
			if ($AusgewaehlteKategorie -gt $($EinzigartigeKategorie.Count)+1){
				Write-Host "Es kommen bald weitere Kategorien hinzu"
				$AusgewaehlteKategorie = Read-Host "Waehle eine Kategorie ein"
			}
			elseif ($AusgewaehlteKategorie -eq 0){
				Write-Host "Null gibt's nicht du Nulpe!" -ForegroundColor Red
				$AusgewaehlteKategorie = Read-Host "Waehle eine VORHANDENE Kategorie!" -ForegroundColor Red
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
function ModusSelektion {
    Write-Host "Welchen Modus moechtest du?`n" -ForegroundColor Cyan
    Write-Host "[1] Einfache Abfrage" 
    Write-Host "[2] Lernmodus (mit Erklärung der Antworten)" 
    Write-Host "[3] Prüfungsmodus`n" 

    do {
        $ModusEingabe = Read-Host -Prompt "Geben Sie eine Zahl ein (1 - 3)"
    } until ($ModusEingabe -in '1','2','3')

    switch ($ModusEingabe) {
        '1' { $ToleranzArray = @{Toleranzwert = 0.4; isErklärung = $false} }
        '2' { $ToleranzArray = @{Toleranzwert = 0.5; isErklärung = $true} }
        '3' { $ToleranzArray = @{Toleranzwert = 0.1; isErklärung = $false} }
    }
	
    # Write-Host "Toleranz nach ModusSelektion: $Toleranz" -ForegroundColor Yellow
    return $ToleranzArray
}

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
		$Toleranz,
        $Frage
    )
	# Tests zur Übergabe des Parameters $Toleranz
	# $Toleranz = ModusSelektion
    # Write-Host "Toleranz in AbfrageAntwort: $($Toleranz)" -ForegroundColor Red

    <# Debug-Ausgaben
    Write-Host "==  DEBUG  ==" -ForegroundColor Yellow
    Write-Host "ID: [$($Frage.ID)]" -ForegroundColor Red
    Write-Host "Typ: [$($Frage.Typ)]" -ForegroundColor Red
    Write-Host "Frage: [$($Frage.Frage)]" -ForegroundColor Red
    Write-Host "Antworten: [$($Frage.Antworten)]" -ForegroundColor Red
    Write-Host "Typ von Antworten: [$($Frage.Antworten.GetType())]" -ForegroundColor Red
    Write-Host "RichtigeAntwort: [$($Frage.RichtigeAntwort)]" -ForegroundColor Red
    Write-Host "-------------------------`n"
#>
    Write-Host $($Frage.Frage) -ForegroundColor Cyan



    # MultipleChoice
    if ($Frage.Typ -eq "MultipleChoice") {
	# Test CSV Fragen
    # Write-Host $Frage.Typ.getType() -ForegroundColor Yellow
	# Write-Host "Ausgabe: $($Frage.getType())" -ForegroundColor Red
		
    # Tests um das Array aus der CSV Datei zu prüfen
    # Write-Host "Ausgabe $Frage.Frage: $($Frage.Frage)" -ForegroundColor Red

    # Write-Host "Die Richtige Antwort wäre: [$($Frage.Antworten[1])]"
    
        # Ausgabe der Antworten in zwei Spalten
        for ($i = 0; $i -lt $Frage.Antworten.Count; $i += 2) {
            $links = "[$($i+1)] $($Frage.Antworten[$i])"

            if ($i + 1 -lt $Frage.Antworten.Count) {
                #$rechts = "[$($i+2)] $($Frage.Antworten[$i+1])"

                $rechts = "[$($i+2)] $($Frage.Antworten[$i+1])"
                Write-Host ("{0,-50}{1}" -f $links, $rechts)
            } else {
                Write-Host $links
            }
        }
		
		# Antwort sterilisieren 
		$AntwortMultipleChoiceFrage = Read-Host "`nDeine Wahl [Nummer]"
		if ($AntwortMultipleChoiceFrage -match '^\d+$') {
			
		}
		else {
			Write-Host "Ungültige Eingabe!"
			$AntwortMultipleChoiceFrage = Read-Host "Antwort"
		}
        
		# Vergleich Antwort zur richtigen Antwort
        if ($AntwortMultipleChoiceFrage -eq $Frage.RichtigeAntwort) {
            Write-Host "Richtig" -ForegroundColor Green
            return $true
        } else {
            
            $BerechneterIndex = $Frage.RichtigeAntwort - 1
            # Write-Host "Berechneter Index: [$BerechneterIndex]"
            $ArrrayRichtigeAntworten = @($Frage.Antworten)
            Write-Host "Falsch. Die Richtige Antwort ist: $($ArrrayRichtigeAntworten[$BerechneterIndex])" -ForegroundColor Red
            # Write-Host "$ArrayRichtigeAntworten[$($Frage.RichtigeAntwort) - 1]" -ForegroundColor Red
            
            # Write-Host "Typ von Antworten: [$($Frage.Antworten.GetType().name)]" -ForegroundColor Red
            # Write-Host "Die richtige Antwort ist: $($ArrayRichtigeAntworten[$Frage.RichtigeAntwort - 1])" -ForegroundColor Yellow
            # Write-Host "Falsch. Die richtige Antwort wäre: $($ArrayRichtigeAntworten[$Frage.RichtigeAntwort - 1]) $AusgabeRichtigeAntwort" -ForegroundColor Red

            <# Debug-Ausgaben
            Write-Host "Falsch. Die richtige Antwort wäre: [$($Frage.Antworten[$Frage.RichtigeAntwort - 1])] $richtigerText" -ForegroundColor Red
			Write-Host "Die richtige Antwort ist: $($Frage.Antworten[$Frage.RichtigeAntwort - 1])" -ForegroundColor Yellow #2
            Write-Host "Die richtige Antwort ist: $Frage.Antworten[$Frage.RichtigeAntwort - 1]" -ForegroundColor Yellow # ganzes Fragen Array ausgeben
            Write-Host "Die richtige Antwort ist: $($Frage.Antworten[$($Frage.RichtigeAntwort.Count - 1)])" -ForegroundColor Red
            #>
            
            Write-Host "`nDie Erklärung: $($Frage.Erklärung)"
            return $false
        }

    } 
    
	
	# ==============================================================
    # Offene Frage
    elseif ($Frage.Typ -eq "offeneFrage") {
	
        # Write-Host "Frage.RichtigeAntwort: [$($Frage.RichtigeAntwort)]"
        # Write-Host "Frage Typ: [$($Frage.Typ)]" 

    
	<# Test CSV Fragen
	Write-Host "Ausgabe Fragen.getType(): $($Frage.getType())" -ForegroundColor Blue
	Write-Host "Ausgabe $Frage.Frage: $($Frage.Frage)" -ForegroundColor Red
	Write-Host "Ausgabe $Frage.Fragen: $($Frage.Fragen)`n" -ForegroundColor Yellow
	Write-Host "Ausgabe $Frage.Kategorie: $($Frage.Kategorie)" -ForegroundColor Blue
	Write-Host "Ausgabe $Fragen.Antworten: $($Fragen.Antworten)" -ForegroundColor Red
	Write-Host "Ausgabe $Fragen.RichtigeAntwort: $($Fragen.RichtigeAntwort)" -ForegroundColor Yellow
    #>
	        $AntwortOffeneFrage = Read-Host "Gebe deine Antwort ein"	
		if ($Frage.RichtigeAntwort.Length -le 4){
            $TolerierteAbweichung = 0
			
            # Tests um die Übergabe von $Toleranz
			# Write-Host $Frage.RichtigeAntwort.Length
			# Write-Host $TolerierteAbweichung -ForegroundColor Yellow
            
		}else{
			$TolerierteAbweichung = [Math]::Round($Frage.RichtigeAntwort.Length * $($Toleranz),0)
			# Tests um die Übergabe von $Toleranz
			# Write-Host $Toleranz -ForegroundColor Red
			# Write-Host $TolerierteAbweichung -ForegroundColor Yellow
			# Write-Host $Frage.RichtigeAntwort.Length -ForegroundColor Green
		}
		


        # Vergleich der Antwort mit der richtigen Antwort unter Verwendung der Levenshtein-Distanz
        # Wenn die Distanz kleiner oder gleich 1 ist, wird die Antwort als richtig betrachtet

        <# Debug-Ausgaben
        Write-Host "AntwortOffeneFrage: [$AntwortOffeneFrage]" -ForegroundColor Yellow
        Write-Host "RichtigeAntwort: [$RichtigeAntwort]" -ForegroundColor Yellow
        Write-Host "Länge Eingabe: $($AntwortOffeneFrage.Length)" -ForegroundColor Yellow
        Write-Host "Länge RichtigeAntwort: $($RichtigeAntwort.Length)" -ForegroundColor Yellow
        #>
        if($AntwortOffeneFrage.Trim() -eq $Frage.RichtigeAntwort){
			Write-Host "Richtig" -ForegroundColor Green
			return $true
		}
		elseif ((LevenshteinDistance -Antwort $AntwortOffeneFrage.Trim() -RichtigeAntwort $Frage.RichtigeAntwort.Trim()) -le [int]$TolerierteAbweichung){
            Write-Host "Das lassen wir nochmal gelten. Richtig waere: $($Frage.RichtigeAntwort)" -ForegroundColor Yellow
            return $true
        } else {
			Write-Host "Falsch. Die richtige Antwort wäre: $($Frage.RichtigeAntwort)" -ForegroundColor Red
                if ($Erklärung){
                    Write-Host "`nDie Erklärung lautet: $($Frage.Erklärung)"
                }
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

    # Sonderfall: Wenn eine der beiden Zeichenketten leer ist, ist die Distanz gleich der Länge der anderen Zeichenkette
    if ($n -eq 0) { return $m }
    if ($m -eq 0) { return $n }

    # Matrix zur Speicherung der Distanzen erstellen
    $d = New-Object 'int[,]' ($n + 1), ($m + 1)

    # Matrix initialisieren
    for ($i = 0; $i -le $n; $i++) { $d[$i, 0] = $i }
    for ($j = 0; $j -le $m; $j++) { $d[0, $j] = $j }

    # Die Matrix mit den Distanzen füllen
    for ($i = 1; $i -le $n; $i++) {
        for ($j = 1; $j -le $m; $j++) {
            if ($Antwort[$i - 1] -eq $RichtigeAntwort[$j - 1]) {
                $cost = 0
            } else {
                $cost = 1
            }
            # Berechnung der minimalen Distanz unter Berücksichtigung von Einfügen, Löschen und Ersetzen
            $loeschen = $d[($i -1), $j] +1
            $einfuegen = $d[$i, ($j - 1)] +1
            $ersetzen = $d[($i - 1), ($j - 1)] + $cost
            $d[$i, $j] = [Math]::Min([Math]::Min($loeschen, $einfuegen), $ersetzen)

        }
    }
    # Die Levenshtein-Distanz zurückgeben
    return $d[$n, $m]
}

#===============================================================
