<#
.Description
PokeMini emulator by JustBurn v0.60
#>
param(
[switch] $uninstall,
[string] $prefix
)

. ..\config.ps1

$DOWNLOAD_URL='https://sourceforge.net/projects/pokemini/files/0.60/pokemini_060_windev.zip/download'

if ($prefix) {
	if (! $pokemini) {
		Write-Host "pokemini not installed"
		exit 1
	}

	Write-Output "$pokemini"
} elseif ($uninstall) {
	if ($pokemini) {
		Remove-Item "$pokemini" -Force -Recurse -ErrorAction SilentlyContinue
		Set-Content -Path '..\config.ps1' -Value (Get-Content -Path '..\config.ps1' | Select-String -Pattern '^\$pokemini =' -NotMatch)
		Remove-Item -Path HKCR:\.min, HKCR:\.minc, HKCR:\PokeMini_min, HKCR:\PokeMini_minc -Recurse -ErrorAction SilentlyContinue
	}
} elseif (! $pokemini) {
	Write-Host 'Downloading...'
	Invoke-WebRequest -Uri "$DOWNLOAD_URL" -OutFile '..\pokemini_windev.zip' -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::FireFox
	Write-Host 'Unzipping...'
	Expand-Archive -Path '..\pokemini_windev.zip' -DestinationPath '..\tools\pokemini'
	Remove-Item -Path '..\pokemini_windev.zip'
	$pokemini = Resolve-Path '..\tools\pokemini'
	Write-Host 'Saving to config...'
	Write-Output "`$pokemini = `"$pokemini`"" >> '..\config.ps1'

	$yn = Read-Host 'Set path environment variable for Pokemini (y/n)?'
	if ($yn -eq 'y') {
		$userpath = Get-ItemProperty -Path HKCU:\Environment -Name Path
		setx Path "$($userpath.Path);$pokemini"
		set PATH "$env:PATH;$pokemini"
		Write-Host '...done'
	} else {
		Write-Host "You can always add this folder to your PATH variable later:"
		Write-Host "  $pokemini"
	}

	$yn = Read-Host 'Associate .min files with PokeMini (y/n)?'
	if ($yn -eq 'y') {
		$exe = "$pokemini\PokeMini.exe" -replace '\\', '\\'
		$dbg = "$pokemini\PokeMiniD.exe" -replace '\\', '\\'
		$color = "$pokemini\color_mapper.exe" -replace '\\', '\\'
		Write-Output @"
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\.min]
@="PokeMini_min"

[HKEY_CLASSES_ROOT\.minc]
@="PokeMini_minc"


[HKEY_CLASSES_ROOT\PokeMini_min]
@="Pokemon mini ROM"

[HKEY_CLASSES_ROOT\PokeMini_min\DefaultIcon]
@="$exe,1"

[HKEY_CLASSES_ROOT\PokeMini_min\shell]
@="debug"

[HKEY_CLASSES_ROOT\PokeMini_min\shell\open]

[HKEY_CLASSES_ROOT\PokeMini_min\shell\open\command]
@="\"$exe\" \"%1\""

[HKEY_CLASSES_ROOT\PokeMini_min\shell\debug]
@="&Debug"

[HKEY_CLASSES_ROOT\PokeMini_min\shell\debug\command]
@="\"$dbg\" \"%1\""


[HKEY_CLASSES_ROOT\PokeMini_minc]
@="PokeMini ROM color file"

[HKEY_CLASSES_ROOT\PokeMini_minc\DefaultIcon]
@="$exe,2"

[HKEY_CLASSES_ROOT\PokeMini_minc\shell]

[HKEY_CLASSES_ROOT\PokeMini_minc\shell\open]

[HKEY_CLASSES_ROOT\PokeMini_minc\shell\open\command]
@="\"$color\" \"%1\""
"@ > '..\pokemini.reg'
		if (Start-Process reg -ArgumentList 'import ..\pokemini.reg' -Verb runAs) {
			Remove-Item -Path '..\pokemini.reg'
		}
		Write-Host '...done'
	}
}
