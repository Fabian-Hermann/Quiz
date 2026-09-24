function Debug-Variable {
    param(
        $Wert
    )

    Write-Host "================ DEBUG ================" -ForegroundColor Cyan

    # Wert
    Write-Host "Wert: [$Wert]"

    # Typ
    if ($null -eq $Wert) {
        Write-Host "Typ: [NULL]" -ForegroundColor Red
    }
    else {
        Write-Host "Typ: [$($Wert.GetType().FullName)]"
    }

    # Anzahl / Länge
    if ($null -eq $Wert) {
        Write-Host "Count: [NULL]"
    }
    elseif ($Wert -is [System.Array]) {
        Write-Host "Count: [$($Wert.Count)]"
    }
    else {
        Write-Host "Length: [$($Wert.ToString().Length)]"
    }

    # Array-Inhalte
    if ($Wert -is [System.Array]) {
        Write-Host "Array-Inhalte:" -ForegroundColor Yellow

        for ($i = 0; $i -lt $Wert.Count; $i++) {
            Write-Host "  [$i] = [$($Wert[$i])]"
        }
    }
    # Properties bei Objekten
    if ($null -ne $Wert -and $Wert -isnot [System.Array] -and $Wert -isnot [System.ValueType] -and $Wert -isnot [string]) {
        Write-Host "Properties:" -ForegroundColor Yellow
        $Wert.PSObject.Properties | ForEach-Object {
            Write-Host "  $($_.Name) = [$($_.Value)]"
        }
    }
    Write-Host "========================================" -ForegroundColor Cyan
}