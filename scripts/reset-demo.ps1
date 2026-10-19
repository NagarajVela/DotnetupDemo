# Run in a normal (non-admin) PowerShell to get back to the starting state before a re-take.
# Removes ONLY what this demo created: the script's install, dotnetup + its installs, and the
# user-level PATH / DOTNET_ROOT entries for those folders.
$scriptDir   = "$env:LOCALAPPDATA\Microsoft\dotnet"
$dotnetupDir = "$env:LOCALAPPDATA\dotnetup"
$toolDir     = "$HOME\.dotnetup"

if (Get-Command dotnetup -ErrorAction SilentlyContinue) { dotnetup env clear }

foreach ($dir in $scriptDir, $dotnetupDir, $toolDir) {
    if (Test-Path $dir) { Remove-Item $dir -Recurse -Force; Write-Host "Removed $dir" }
}

$userPath = [Environment]::GetEnvironmentVariable('PATH', 'User')
$kept = $userPath -split ';' | Where-Object { $_ -and ($_ -notlike "$scriptDir*") -and ($_ -notlike "$dotnetupDir*") -and ($_ -notlike "$toolDir*") }
[Environment]::SetEnvironmentVariable('PATH', ($kept -join ';'), 'User')
[Environment]::SetEnvironmentVariable('DOTNET_ROOT', $null, 'User')

# dotnetup env clear should already have cleaned the profile; show anything left behind.
if ((Test-Path $PROFILE) -and (Select-String -Path $PROFILE -Pattern 'dotnetup' -Quiet)) {
    Write-Warning "Your `$PROFILE still mentions dotnetup - remove those lines by hand:"
    Select-String -Path $PROFILE -Pattern 'dotnetup'
}
Remove-Item (Join-Path $PSScriptRoot '..\dotnet-install.ps1') -ErrorAction SilentlyContinue
Write-Host "Reset done. Open a NEW terminal."
