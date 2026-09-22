# Funktionen und Fragen mit Dot-source laden
#. (Join-Path $PSScriptRoot 'quiz_function.ps1')
. "$PSScriptRoot\quiz_function.ps1"
$Fragen = . "$PSScriptRoot\fragen.ps1"

#-------------------
# Hauptschleife
#-------------------

do {
	# --- Start ---
    Clear-Host
    Titelbild
	$AusgewaehlteFragenKategorie = FragenKategorie $Fragen
	#Ladebalken 10
	Clear-Host
	Titelbild
    $AnzahlFragen = FragenAnzahl $Fragen
	#Ladebalken 10
	Clear-Host
	$a = ModusSelektion
	$Toleranz = $a.Toleranzwert
	Ladebalken 10
	
	
    $AusgewaehlteFragen = $AusgewaehlteFragenKategorie | Get-Random -Count $AnzahlFragen
	
    $Score = 0
	[array]$FalscheFragen = @()
	do {
		if ($Fehlerbeantworten -eq "j"){
			$AusgewaehlteFragen = $FalscheFragen
			$FalscheFragen = @()
		}
		foreach ($Frage in $AusgewaehlteFragen) {
			Clear-Host
			if (AbfrageAntwort -Frage $Frage, -Toleranz $Toleranz) {
				$Score++
			} else {
				$FalscheFragen += $Frage
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

Write-Host "Bis zum nächsten Mal!" -ForegroundColor Cyan