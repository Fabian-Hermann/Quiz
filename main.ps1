# Funktionen und Fragen mit Dot-source laden
#. (Join-Path $PSScriptRoot 'quiz_function.ps1')
. "$PSScriptRoot\quiz_function.ps1"
#$Fragen = . "$PSScriptRoot\fragen.ps1"
$Fragen = Import-Csv "$PSScriptRoot\Daten\fragen.csv" -Delimiter ";"

#-------------------
# Hauptschleife
#-------------------

do {
	# --- Start ---
    Clear-Host
    Titelbild
	# Write-Host $Fragen.GetType()
	
	#$AusgewaehlteFragenKategorieXXX = FragenKategorie $Fragen
	#[array]$AusgewaehlteFragenKategorie = $AusgewaehlteFragenKategorieXXX
	#Write-Host $AusgewaehlteFragenKategorie.getType() -ForegroundColor yellow
	$AusgewaehlteFragenKategorie = FragenKategorie $Fragen
	# Ladebalken 20
	Clear-Host

	Titelbild
    $AnzahlFragen = FragenAnzahl $Fragen
	# Ladebalken 20
	Clear-Host
	$ModusArray = ModusSelektion
	$Toleranz = $ModusArray.Toleranzwert
	$Erklärung = $ModusArray.isErklärung
	# Ladebalken 20
	
	
    $AusgewaehlteFragen = $AusgewaehlteFragenKategorie | Get-Random -Count $AnzahlFragen
	
    $Score = 0
	[array]$FalscheFragen = @()
	do {
		if ($Fehlerbeantworten -eq "j"){
			$AusgewaehlteFragen = $FalscheFragen
			$FalscheFragen = @()
		}
		foreach ($Frage in $AusgewaehlteFragen) {
			$Frage.ID = [int]$Frage.ID
    		$Frage.RichtigeAntwort = [int]$Frage.RichtigeAntwort
    		$Frage.Antworten = $Frage.Antworten -split '\|'
			Clear-Host
			if (AbfrageAntwort -Frage $Frage -Toleranz $Toleranz) {
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