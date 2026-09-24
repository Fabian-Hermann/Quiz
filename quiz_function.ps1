# ==============================================================
# quiz_function.ps1
# Sammlung aller Funktionen fuer das PowerShell-Quiz in main.ps1
# ==============================================================

Set-StrictMode -Version Latest

#===============================================================
function Show-Ladebalken {
    <#
    .SYNOPSIS
        Zeigt einen einfachen textbasierten Ladebalken an.
    .PARAMETER Laenge
        Anzahl der Segmente, aus denen der Balken besteht.
    #>
    [CmdletBinding()]
    param(
        [int]$Laenge = 15
    )

    for ($i = 1; $i -le $Laenge; $i++) {
        $Balken = "#" * $i
        $Punkte = "." * ($Laenge - $i)
        Write-Host "`r[$Balken$Punkte]" -NoNewline
        Start-Sleep -Milliseconds 30
    }
    Write-Host ""
}

#===============================================================
function Show-DiscoLadebalken {
    <#
    .SYNOPSIS
        Ladebalken mit umlaufenden Farben ("Disco-Effekt").
    .PARAMETER Laenge
        Anzahl der Segmente, aus denen der Balken besteht.
    #>
    [CmdletBinding()]
    param(
        [int]$Laenge = 15
    )

    $Farben = @("Yellow", "Cyan", "Green", "Red")
    $FarbIndex = 0

    for ($i = 1; $i -le $Laenge; $i++) {
        $Balken = "#" * $i
        $Punkte = "." * ($Laenge - $i)

        Write-Host "`r[$Balken$Punkte]" -ForegroundColor $Farben[$FarbIndex] -NoNewline
        Start-Sleep -Milliseconds 50

        $FarbIndex = ($FarbIndex + 1) % $Farben.Count
    }
    Write-Host ""
}

#===============================================================
function Show-Titelbild {
    <#
    .SYNOPSIS
        Zeigt den ASCII-Art-Titelbildschirm an.
    #>
    Write-Host @"
   ____        _    
  / __ \__  __(_)___
 / / / / / / / /_  /
/ /_/ / /_/ / / / /_
\___\_\__,_/_/ /___/

"@ -ForegroundColor Yellow
}

#===============================================================
function Select-FragenKategorie {
    <#
    .SYNOPSIS
        Laesst den Nutzer eine Kategorie aus dem Fragenpool waehlen.
    .PARAMETER Fragen
        Array aller verfuegbaren Fragen.
    .OUTPUTS
        Teilmenge von $Fragen, die zur gewaehlten Kategorie gehoert.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [array]$Fragen
    )

    $EinzigartigeKategorien = $Fragen.Kategorie | Select-Object -Unique

    Write-Host "[1] Alle Kategorien"
    for ($i = 0; $i -lt $EinzigartigeKategorien.Count; $i++) {
        Write-Host "[$($i + 2)] $($EinzigartigeKategorien[$i])"
    }

    $MaxIndex = $EinzigartigeKategorien.Count + 1
    $AusgewaehlteKategorie = $null

    while ($null -eq $AusgewaehlteKategorie) {
        $Eingabe = Read-Host "Waehle eine Kategorie aus"

        if ($Eingabe -notmatch '^\d+$') {
            Write-Host "Bitte eine Zahl eingeben." -ForegroundColor Red
            continue
        }

        $EingabeZahl = [int]$Eingabe

        if ($EingabeZahl -lt 1 -or $EingabeZahl -gt $MaxIndex) {
            Write-Host "Bitte eine Zahl zwischen 1 und $MaxIndex eingeben." -ForegroundColor Red
            continue
        }

        $AusgewaehlteKategorie = $EingabeZahl
    }

    if ($AusgewaehlteKategorie -eq 1) {
        return $Fragen
    }

    $Kategorieindex = $AusgewaehlteKategorie - 2
    $KategorieName = $EinzigartigeKategorien[$Kategorieindex]
    Write-Host "Du hast folgendes gewaehlt: $KategorieName"

    return $Fragen | Where-Object { $_.Kategorie -eq $KategorieName }
}

#===============================================================
function Get-FragenAnzahl {
    <#
    .SYNOPSIS
        Fragt den Nutzer, wie viele Fragen gestellt werden sollen.
    .PARAMETER Fragen
        Bereits nach Kategorie gefilterte Fragen, deren Anzahl die Obergrenze bildet.
    .OUTPUTS
        [int] Gueltige Anzahl gewuenschter Fragen (1..Fragen.Count).
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [array]$Fragen
    )

    $Maximum = $Fragen.Count
    Write-Host "Anzahl verfuegbarer Fragen: $Maximum"

    $Anzahl = 0
    do {
        $Eingabe = Read-Host "Wie viele Fragen moechtest du?"

        if ($Eingabe -notmatch '^\d+$') {
            Write-Host "Bitte eine gueltige Zahl eingeben." -ForegroundColor Yellow
            continue
        }

        $Anzahl = [int]$Eingabe

        if ($Anzahl -eq 0) {
            Write-Host "Die Anzahl muss mindestens 1 sein." -ForegroundColor Yellow
        }
        elseif ($Anzahl -gt $Maximum) {
            Write-Host "Das momentane Maximum ist: $Maximum" -ForegroundColor Yellow
        }
    } while ($Anzahl -eq 0 -or $Anzahl -gt $Maximum)

    Write-Host "Du hast ausgewaehlt: $Anzahl"
    return $Anzahl
}

#===============================================================
function Select-Modus {
    <#
    .SYNOPSIS
        Laesst den Nutzer den Spielmodus waehlen und liefert die zugehoerigen Einstellungen.
    .OUTPUTS
        [hashtable] mit Toleranzwert, HatJoker, ZeigeErklaerung.
    #>
    [CmdletBinding()]
    param()

    Write-Host "Welchen Modus moechtest du?`n" -ForegroundColor Cyan
    Write-Host "[1] Einfache Abfrage"
    Write-Host "[2] Lernmodus (mit Erklaerung der Antworten)"
    Write-Host "[3] Pruefungsmodus`n"

    do {
        $Eingabe = Read-Host "Geben Sie eine Zahl ein (1 - 3)"
    } until ($Eingabe -in '1', '2', '3')

    switch ($Eingabe) {
        '1' { return @{ Toleranzwert = 0.4; HatJoker = $true;  ZeigeErklaerung = $false } }
        '2' { return @{ Toleranzwert = 0.5; HatJoker = $false; ZeigeErklaerung = $true } }
        '3' { return @{ Toleranzwert = 0.1; HatJoker = $false; ZeigeErklaerung = $false } }
    }
}

#===============================================================
function Test-Antwort {
    <#
    .SYNOPSIS
        Stellt eine einzelne Frage, fragt die Antwort ab und prueft sie.
    .PARAMETER Frage
        Ein einzelnes Fragen-Objekt (nicht das ganze Array).
    .PARAMETER Toleranz
        Toleranzfaktor fuer offene Fragen (Levenshtein-Distanz).
    .PARAMETER ZeigeErklaerung
        Ob bei falscher Antwort eine Erklaerung angezeigt werden soll.
    .PARAMETER AktuelleFrageNummer
        Laufende Nummer der Frage, nur fuer die Anzeige.
    .OUTPUTS
        [bool] $true bei richtiger, $false bei falscher Antwort.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        $Frage,

        [double]$Toleranz = 0,

        [bool]$ZeigeErklaerung = $false,

        [int]$AktuelleFrageNummer = 1,
		
		[bool]$HatJoker = $false
    )

    Write-Host "$AktuelleFrageNummer. $($Frage.Frage)" -ForegroundColor Cyan

    switch ($Frage.Typ) {
        "MultipleChoice" {
            return Test-MultipleChoiceAntwort -Frage $Frage -ZeigeErklaerung $ZeigeErklaerung -HatJoker $HatJoker -AktuelleFrageNummer $AktuelleFrageNummer
        }
        "offeneFrage" {
            return Test-OffeneAntwort -Frage $Frage -Toleranz $Toleranz -ZeigeErklaerung $ZeigeErklaerung
        }
        default {
            Write-Warning "Unbekannter Fragetyp '$($Frage.Typ)' - Frage wird uebersprungen."
            return $false
        }
    }
}

#===============================================================
function Test-MultipleChoiceAntwort {
    <#
    .SYNOPSIS
        Zeigt eine MultipleChoice-Frage an und prueft die Antwort.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        $Frage,
		$HatJoker,
        [bool]$ZeigeErklaerung = $false,
		$AktuelleFrageNummer
    )

    $Antworten = @($Frage.Antworten)
    $RichtigerIndex = [int]$Frage.RichtigeAntwort - 1
	
    # Ausgabe der Antworten in zwei Spalten
    for ($i = 0; $i -lt $Antworten.Count; $i += 2) {
        $Links = "[$($i + 1)] $($Antworten[$i])"

        if ($i + 1 -lt $Antworten.Count) {
            $Rechts = "[$($i + 2)] $($Antworten[$i + 1])"
            Write-Host ("{0,-50}{1}" -f $Links, $Rechts)
        }
        else {
            Write-Host $Links
        }
    }

    $Eingabe = Read-Host "`nDeine Wahl"
    $RichtigeAntwortText = $Antworten[$RichtigerIndex]
	
	if ($Antworten.Count -gt 2 -and $HatJoker){
		if ($Eingabe -eq "Joker"){
			[array]$AusschlussIndex = @(0, 1, 2, 3)
			$AusschlussIndex = $($AusschlussIndex -ne $RichtigerIndex)
			$Zwischenindex = $($Ausschlussindex | Get-Random -Count 1)
			$AusschlussIndex = $($AusschlussIndex -ne $Zwischenindex)
			$Antworten[$($Ausschlussindex[0])] = ""
			$Antworten[$($Ausschlussindex[1])] = ""
			Clear-Host
			Write-Host "$AktuelleFrageNummer. $($Frage.Frage)" -ForegroundColor Cyan
			for ($i = 0; $i -lt $Antworten.Count; $i += 2) {
				$Links = "[$($i + 1)] $($Antworten[$i])"

				if ($i + 1 -lt $Antworten.Count) {
					$Rechts = "[$($i + 2)] $($Antworten[$i + 1])"
					Write-Host ("{0,-50}{1}" -f $Links, $Rechts)
				}
				else {
					Write-Host $Links
				}
			}
		}
		$HatJoker = $false
		$Eingabe = Read-Host "`nDeine Wahl"
	}

	
    $IstRichtig = ($Eingabe -eq $Frage.RichtigeAntwort) -or ($Eingabe -eq $RichtigeAntwortText)

    if ($IstRichtig) {
        Write-Host "Richtig" -ForegroundColor Green
        return $true
    }

    Write-Host "Falsch. Die richtige Antwort ist: $RichtigeAntwortText" -ForegroundColor Red
    if ($ZeigeErklaerung) {
        Write-Host "`nDie Erklaerung: $($Frage.Erklaerung)"
    }
    return $false
}

#===============================================================
function Test-OffeneAntwort {
    <#
    .SYNOPSIS
        Zeigt eine offene Frage an und prueft die Antwort per Levenshtein-Toleranz.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        $Frage,

        [double]$Toleranz = 0,

        [bool]$ZeigeErklaerung = $false
    )

    $Eingabe = (Read-Host "Gib deine Antwort ein").Trim()
    $RichtigeAntwort = $Frage.RichtigeAntwort.Trim()

    if ($Eingabe -eq $RichtigeAntwort) {
        Write-Host "Richtig" -ForegroundColor Green
        return $true
    }

    $TolerierteAbweichung = if ($RichtigeAntwort.Length -le 4) {
        0
    }
    else {
        [Math]::Round($RichtigeAntwort.Length * $Toleranz, 0)
    }

    $Distanz = Get-LevenshteinDistance -Antwort $Eingabe -RichtigeAntwort $RichtigeAntwort

    if ($Distanz -le [int]$TolerierteAbweichung) {
        Write-Host "Das lassen wir nochmal gelten. Richtig waere: $RichtigeAntwort" -ForegroundColor Yellow
        return $true
    }

    Write-Host "Falsch. Die richtige Antwort waere: $RichtigeAntwort" -ForegroundColor Red
    if ($ZeigeErklaerung) {
        Write-Host "`nDie Erklaerung: $($Frage.Erklaerung)"
    }
    return $false
}

#===============================================================
function Get-LevenshteinDistance {
    <#
    .SYNOPSIS
        Berechnet die Levenshtein-Distanz zwischen zwei Zeichenketten.
    .PARAMETER Antwort
        Die vom Nutzer eingegebene Zeichenkette.
    .PARAMETER RichtigeAntwort
        Die als richtig hinterlegte Zeichenkette.
    .OUTPUTS
        [int] Levenshtein-Distanz.
    #>
    [CmdletBinding()]
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
            $Kosten = if ($Antwort[$i - 1] -eq $RichtigeAntwort[$j - 1]) { 0 } else { 1 }

            $Loeschen  = $d[($i - 1), $j] + 1
            $Einfuegen = $d[$i, ($j - 1)] + 1
            $Ersetzen  = $d[($i - 1), ($j - 1)] + $Kosten

            $d[$i, $j] = [Math]::Min([Math]::Min($Loeschen, $Einfuegen), $Ersetzen)
        }
    }

    return $d[$n, $m]
}

#===============================================================
# TODO: Joker-Mechanik ist NOCH nicht implementiert.
# function Invoke-Joker {
    # param($Frage)
# }
