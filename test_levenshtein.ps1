# Funktionen laden (Dot-Sourcing: der Punkt am Anfang ist wichtig)

#. (Join-Path $PSScriptRoot 'quiz_function.ps1')

. "$PSScriptRoot\quiz_function.ps1"

$tests = @(
    @{ A = 'kitten'; B = 'sitting'; Erwartet = 3 }
    @{ A = 'hallo';  B = 'hallo';   Erwartet = 0 }
    @{ A = 'Hallo';  B = 'hallo';   Erwartet = 0 }   # -eq ignoriert Groß-/Kleinschreibung
    @{ A = 'abc';    B = 'abd';     Erwartet = 1 }
    @{ A = '';       B = 'abc';     Erwartet = 3 }
    @{ A = 'abc';    B = '';        Erwartet = 3 }
)

foreach ($t in $tests) {
    $ist = LevenshteinDistance $t.A $t.B
    if ($ist -eq $t.Erwartet) {
        Write-Host "OK     '$($t.A)' vs '$($t.B)' -> $ist" -ForegroundColor Green
    } else {
        Write-Host "FEHLER '$($t.A)' vs '$($t.B)' -> $ist (erwartet: $($t.Erwartet))" -ForegroundColor Red
    }
}