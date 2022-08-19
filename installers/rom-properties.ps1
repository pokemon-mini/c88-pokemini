<#
.Description
Shows Pokemon mini ROMs' (and other ROMs') properties in Windows Explorer
#>
param(
[switch] $uninstall,
[string] $prefix
)

$DOWNLOAD_URL='https://github.com/GerbilSoft/rom-properties/releases/download/v1.9/rom-properties_1.9-windows.zip'

if ($prefix) {
	if (! $romprop) {
		Write-Host "rom-properties not installed"
		exit 1
	}

	Write-Output $romprop
} elseif ($uninstall) {
	if ($romprop) {
		Write-Host 'Select Yes then click Uninstall'
		& ".\$romprop\install.exe"
		if (Read-YN 'Did you uninstall') {
			Write-Host 'Removing folder'
			Remove-Item $romprop -Recurse
		}
	}
} elseif (! $romprop) {
	Write-Host 'Downloading...'
	Download $DOWNLOAD_URL 'romprop.zip'
	Write-Host 'Unzipping...'
	Expand-Archive -Path 'romprop.zip' -DestinationPath 'tools\ROM Properties'
	Remove-Item -Path 'romprop.zip'
	$romprop = Resolve-Path 'tools\ROM Properties'
	Add-Config 'romprop' $romprop

	Write-Host 'Select Yes then click Install'
	& ".\$romprop\install.exe"
}
