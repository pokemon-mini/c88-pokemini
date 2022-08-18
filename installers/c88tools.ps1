<#
.Description
Official EPSON S1C88 build tools + srec_cat
#>
param(
[switch] $uninstall,
[string] $prefix
)

. ..\config.ps1

$DOWNLOAD_URL='https://github.com/logicplace/c88-pokemini/releases/download/s1c88/c88tools.zip'

if ($prefix) {
	if (! $c88tools) {
		Write-Host "c88tools not installed"
		exit 1
	}

	Switch ($prefix) {
		'.' { Write-Output "$c88tools"; break }
		{ 'alc88', 'ar88', 'as88', 'c88', 'c88spawn', 'cc88', 'ice88ur', 'lc88', 'lk88', 'mk88', 'pr88', 'sed88', 'sy88', 'wb88' -eq $_ } {
			Write-Output "$c88tools\bin\$_.exe"
			break;
		}
		'db88' { Write-Output "$c88tools\db88\db88.exe"; break }
		'obpw88' { Write-Output "$c88tools\writer\obpw\obpw88.exe"; break }
		default { Write-Host "Unknown tool $_"; exit 2 }
	}
} elseif ($uninstall) {
	if ($c88tools) {
		Remove-Item "$c88tools" -Force -Recurse -ErrorAction SilentlyContinue
		Set-Content -Path '..\config.ps1' -Value (Get-Content -Path '..\config.ps1' | Select-String -Pattern '^\$c88tools =' -NotMatch)
		Write-Host 'You will have to remove any entry in the path variable yourself.'
	}
} elseif (! $c88tools) {
	Write-Host 'Downloading...'
	Invoke-WebRequest -Uri "$DOWNLOAD_URL" -OutFile '..\c88tools.zip'
	Write-Host 'Unzipping...'
	Expand-Archive -Path '..\c88tools.zip' -DestinationPath '..\c88tools'
	Remove-Item -Path '..\c88tools.zip'
	$c88tools = Resolve-Path '..\c88tools'
	Write-Host 'Saving to config...'
	Write-Output "`$c88tools = `"$c88tools`"" >> '..\config.ps1'

	$yn = Read-Host 'Set environment variables for the build tools (y/n)?'
	if ($yn -eq 'y') {
		$userpath = Get-ItemProperty -Path HKCU:\Environment -Name Path
		setx Path "$($userpath.Path);$c88tools\bin"
		$env:PATH = "$env:PATH;$c88tools\bin"
		setx C88INC $c88tools\include
		setx C88LIB $c88tools\lib
		$env:C88INC = "$c88tools\include"
		$env:C88LIB = "$c88tools\lib"
		Write-Host '...done'
	} else {
		Write-Host "You can always them later:"
		Write-Host "  Add to PATH: $c88tools\bin"
		Write-Host "  C88INC=$c88tools\include"
		Write-Host "  C88LIB=$c88tools\lib"
	}
}

exit 0
