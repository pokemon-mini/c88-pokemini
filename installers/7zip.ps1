<#
.Description
For extracting .7z archives
#>
param(
[switch] $uninstall,
[string] $prefix
)

if ([Environment]::Is64BitOperatingSystem) {
	$DOWNLOAD_URL = 'https://www.7-zip.org/a/7z2409-x64.exe'
} else {
	$DOWNLOAD_URL = 'https://www.7-zip.org/a/7z2409.exe'
}

if ($prefix) {
	if (! $sevenzip) {
		Write-Host "7zip not installed"
		exit 1
	}

	Split-Path $sevenzip
} elseif ($uninstall) {
	if ($sevenzip) {
		if (Get-Command choco) {
			choco uninstall 7zip
		} elseif (Get-Command winget) {
			winget uninstall 7zip.7zip
		} else {
			$dir = Split-Path $sevenzip
			Write-Host 'Select Yes then click Uninstall'
			& "$dir\Uninstall.exe"
		}
		Remove-Config 'sevenzip'
	}
} elseif (! $sevenzip) {
	if ($loc = Get-Command 7z) {
		Add-Config 'sevenzip' $loc[0].Source
	} elseif (Get-Command choco) {
		Start-Process choco -ArgumentList "install 7zip" -Verb runAs
		Add-Config 'sevenzip' "$env:ChocolateyInstall\bin\7z.exe"
	} elseif (Get-Command winget) {
		winget install 7zip.7zip
		Add-Config 'sevenzip' "C:\Program Files\7-Zip\7z.exe"
	} else {
		Download $DOWNLOAD_URL '7zip.exe'
		Write-Host 'Make sure to copy the destination folder to your clipboard then click Install'
		.\7zip.exe
		$sevenzip = Read-Host 'Where did you install it? (right-click to paste)'
		$sevenzip += '\7z.exe'
		Add-Config 'sevenzip' $sevenzip
	}
}

return $true
