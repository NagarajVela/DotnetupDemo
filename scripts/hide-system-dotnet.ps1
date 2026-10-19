# Run as Administrator, BEFORE recording.
# Takes "C:\Program Files\dotnet\" out of the SYSTEM PATH so the recording machine
# looks like a fresh machine (no machine-wide dotnet on PATH).
# Nothing is deleted - Visual Studio's .NET stays on disk. Undo with restore-system-dotnet.ps1.
$backup = Join-Path $PSScriptRoot 'system-path.backup.txt'
$path = [Environment]::GetEnvironmentVariable('PATH', 'Machine')
if (-not (Test-Path $backup)) { Set-Content -Path $backup -Value $path -Encoding utf8 }
$kept = $path -split ';' | Where-Object { $_ -and ($_.TrimEnd('\') -ne "$env:ProgramFiles\dotnet") }
[Environment]::SetEnvironmentVariable('PATH', ($kept -join ';'), 'Machine')
Write-Host "System PATH saved to $backup and dotnet entry removed. Open a NEW terminal."
