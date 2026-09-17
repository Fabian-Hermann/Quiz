# Funktionen und Fragen mit Dot-source laden
. "$PSScriptRoot\quiz_function.ps1"
$Fragen = . "$PSScriptRoot\fragen.ps1"

#-------------------
# Hauptschleife
#-------------------

do {
    Clear-Host
    Titelbild
	$AusgewaehlteFragenKategorie = FragenKategorie $Fragen
	
	
    $AnzahlFragen = FragenAnzahl $Fragen
	
    Ladebalken 15

    $AusgewaehlteFragen = $AusgewaehlteFragenKategorie | Get-Random -Count $AnzahlFragen
	Write-Host $AusgewaehlteFragen -ForegroundColor Red
	
    $Score = 0

    foreach ($Frage in $AusgewaehlteFragen) {
        Clear-Host
        if (AbfrageAntwort $Frage) {
            $Score++
        }
        Read-Host "`nWeiter mit Enter"
    }

    #Resultat
    Write-Host "Du hast $Score von $AnzahlFragen Fragen richtig beantwortet." -ForegroundColor Cyan

    $NochmalSpielen = Read-Host "`nNochmal spielen? (j/n)"

} while ($NochmalSpielen -eq "j")

# Write-Host "Bis zum nächsten Mal!" -ForegroundColor Cyan