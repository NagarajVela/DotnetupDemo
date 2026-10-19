# Round 1, the "old way" fix shown in s2: make the script's install survive a new terminal.
$dir = "$env:LOCALAPPDATA\Microsoft\dotnet"
[Environment]::SetEnvironmentVariable("PATH", "$dir;" + [Environment]::GetEnvironmentVariable("PATH","User"), "User")
[Environment]::SetEnvironmentVariable("DOTNET_ROOT", $dir, "User")
