# Run as Administrator, AFTER recording. Puts the SYSTEM PATH back exactly as it was.
$backup = Join-Path $PSScriptRoot 'system-path.backup.txt'
if (-not (Test-Path $backup)) { throw "No backup at $backup - nothing to restore." }
[Environment]::SetEnvironmentVariable('PATH', (Get-Content $backup -Raw).Trim(), 'Machine')
Remove-Item $backup
Write-Host "System PATH restored. Open a NEW terminal."
