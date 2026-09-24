# ==============================================================
# main.ps1
# Einstiegspunkt des PowerShell-Quiz
# ==============================================================

Set-StrictMode -Version Latest

#. "$PSScriptRoot\quiz_function.ps1"




# quiz_function.ps1 vorhanden

try {
    . "$PSScriptRoot\quiz_function.ps1"
}
catch { 
	Write-Output "Fehler: quiz_function.ps1 konnte nicht geladen werden. Idiot!" 
	Write-Host "Fehler: quiz_function.ps1 konnte nicht geladen werden. Idiot!" -ForegroundColor Red
	Read-Host "`nWeiter mit Enter"
	exit
}

Ist CSV Vorhanden

try {
	$PfadFragen = Join-Path $PSScriptRoot "Daten\fragen.csv"
	$Fragen = Import-Csv -Path $PfadFragen -Delimiter ";"
    # Get-Item ". "$PSScriptRoot\quiz_function.ps1"" -ErrorAction Stop
}
catch {
	Write-Output "Fehler: Die CSV-Datei konnte nicht geladen werden."
	Write-Host "Fehler: Die CSV-Datei konnte nicht geladen werden." -ForegroundColor Red
	Read-Host "`nWeiter mit Enter"
	exit
}

# $PfadFragen = Join-Path $PSScriptRoot "Daten\fragen.csv"
# $Fragen = Import-Csv -Path $PfadFragen -Delimiter ";"




#-------------------
# Hauptschleife
#-------------------
do {
    Clear-Host
    Show-Titelbild

    $FragenDerKategorie = Select-FragenKategorie -Fragen $Fragen
    Show-DiscoLadebalken -Laenge 30
    Clear-Host

    Show-Titelbild
    $AnzahlFragen = Get-FragenAnzahl -Fragen $FragenDerKategorie
    Clear-Host

    $Modus = Select-Modus
    $Toleranz = $Modus.Toleranzwert
    $ZeigeErklaerung = $Modus.ZeigeErklaerung
	$HatJoker = $Modus.HatJoker

    $AusgewaehlteFragen = $FragenDerKategorie | Get-Random -Count $AnzahlFragen
    $Score = 0
    [array]$FalscheFragen = @()
    $FragenErneutBeantworten = $false

    do {
        if ($FragenErneutBeantworten) {
            $AusgewaehlteFragen = $FalscheFragen
            $FalscheFragen = @()
        }

        $AktuelleFrageNummer = 0

        foreach ($Frage in $AusgewaehlteFragen) {
            $Frage.ID = [int]$Frage.ID
            $Frage.Antworten = $Frage.Antworten -split '\|'

            Clear-Host

            $AktuelleFrageNummer++
            # Write-Host "Frage $AktuelleFrageNummer von $($AusgewaehlteFragen.Count)"

            $IstRichtig = Test-Antwort -Frage $Frage -Toleranz $Toleranz `
                -ZeigeErklaerung $ZeigeErklaerung -AktuelleFrageNummer $AktuelleFrageNummer `
				-HatJoker $HatJoker

            if ($IstRichtig) {
                $Score++
            }
            else {
                $FalscheFragen += $Frage
            }

            Read-Host "`nWeiter mit Enter"
        }

        Write-Host "Du hast $Score von $AnzahlFragen Fragen richtig beantwortet." -ForegroundColor Cyan

        if ($Score -lt $AnzahlFragen) {
            $Antwort = Read-Host "Moechtest du die falsch beantworteten Fragen erneut beantworten? (j/n)"
            $FragenErneutBeantworten = ($Antwort -eq "j")
        }
        else {
            $FragenErneutBeantworten = $false
        }

    } while ($FragenErneutBeantworten)

    $NochmalSpielen = Read-Host "`nNochmal spielen? (j/n)"

} while ($NochmalSpielen -eq "j")

Write-Host "Bis zum naechsten Mal!" -ForegroundColor Cyan
Show-DiscoLadebalken -Laenge 30
