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
	
    $Score = 0
	[array]$FalscheFragen = @()
	do {
		if ($Fehlerbeantworten -eq "j"){
			$AusgewaehlteFragen = $FalscheFragen
		}
		foreach ($Frage in $AusgewaehlteFragen) {
			Clear-Host
			if (AbfrageAntwort $Frage) {
				$Score++
			} else {
				$FalscheFragen = $FalscheFragen += $Frage
			}
			Read-Host "`nWeiter mit Enter"
		}
		
		#Resultat
		Write-Host "Du hast $Score von $AnzahlFragen Fragen richtig beantwortet." -ForegroundColor Cyan
		
		if ($Score -lt $AnzahlFragen){
			$Fehlerbeantworten = Read-Host -Prompt "Möchtest du die falsch beantworteten Fragen erneut beantworten? (j/n)"
		} else {
			$Fehlerbeantworten = "n"
		}
		
	} while ($Fehlerbeantworten -eq "j")
	
    $NochmalSpielen = Read-Host "`nNochmal spielen? (j/n)"

} while ($NochmalSpielen -eq "j")

# Write-Host "Bis zum nächsten Mal!" -ForegroundColor Cyan