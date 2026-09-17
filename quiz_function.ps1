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
    

	# $AnzahlEinzigartigeKategorie = ($Fragen | Select-Object -Unique).Count
	# Write-Host "$($AnzahlEinzigartigeKategorie)"

	$EinzigartigeKategorie = $Kategorie | Select-Object -Unique
	for ($i = 0; $i -lt $EinzigartigeKategorie.Count; $i++){
		
		Write-Host "[$($i+1)] $($EinzigartigeKategorie[$i])"
	}
	
	while($AusgewaehlteKategorie -gt $EinzigartigeKategorie.Count -or $AusgewaehlteKategorie.Count -eq 0){
			
		if($AusgewaehlteKategorie -eq 0){
			$EinzigartigeKategorieAuswahl = Write-Host "Waehle eine Kategorie aus:"
				
		}elseif ($AusgewaehlteKategorie -gt $EinzigartigeKategorie.Count){
			Write-Host "Es kommen bald weitere Kategorien hinzu"
		}
		$AusgewaehlteKategorie = Read-Host "Waehle eine Kategorie: "
	}
	
	$AusgewaehlteKategorieName = $EinzigartigeKategorie[$AusgewaehlteKategorie - 1]
	Write-Host "Du hast folgendes gewaehlt: $($AusgewaehlteKategorieName)"
    
	
	
	#foreach($EinzigeartigeKategorie in $Fragen) 
	
	
	#===========================================================
	#$AusgewaehlteFragenKategorie = $Fragen | Group-Object -NoElement
	
	
	
	
    $AusgewaehlteFragenKategorie = $Fragen | Where-Object {
        $_.Kategorie -eq $($AusgewaehlteKategorieName)
		#$Fragen.Kategorie -eq $AusgewaehlteKategorie
    }
	return $AusgewaehlteFragenKategorie
	#Write-Host $AusgewaehlteFragenKategorie.Count
	
	# Write-Host $AusgewaehlteFragenKategorie
	
	#===========================================================
}

#===============================================================

function Titelbild {
    # ZIEL: Titelbildschirm zur Begrüßung 
    # EINGABE: ASCII Art 
    # ABLAUF: 
    # AUSGABE: 
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
                Write-Host ("{0,-40}{1}" -f $links, $rechts)
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
            return $false
        }

    } elseif ($Frage.Typ -eq "offeneFrage") {

        $Antwort = Read-Host "Antwort"

        if ($Antwort.Trim().ToLower() -eq $Frage.RichtigeAntwort.Trim().ToLower()) {
            Write-Host "Richtig" -ForegroundColor Green
            return $true
        } else {
            Write-Host "Falsch. Die richtige Antwort wäre: $($Frage.RichtigeAntwort)" -ForegroundColor Red
            return $false
        }
    }
}
#===============================================================
