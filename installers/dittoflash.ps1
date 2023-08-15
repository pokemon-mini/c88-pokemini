<#
.Description
Flashes Pokemon mini ROMs to the DITTO mini flash card
#>
param(
[switch] $uninstall,
[string] $prefix
)

$DOWNLOAD_URL='https://www.pokemon-mini.net/download/tools/Ditto_Flash_1.00.zip'

if ($prefix) {
	if (! $dittoflash) {
		Write-Host "dittoflash not installed"
		exit 1
	}

	Write-Output $dittoflash
} elseif ($uninstall) {
	if ($dittoflash) {
		Remove-Item $dittoflash -Force -Recurse -ErrorAction SilentlyContinue
		Remove-Config 'dittoflash'
		. .\installers\inc\registry.ps1
		Remove-FileExtensionCommand 'min' ''
	}
} elseif (! $dittoflash) {
	Write-Host 'Downloading...'
	Download $DOWNLOAD_URL 'dittoflash.zip'
	Write-Host 'Unzipping...'
	Expand-Archive -Path 'dittoflash.zip' -DestinationPath 'tools\Ditto Flash'
	Remove-Item -Path 'dittoflash.zip'
	$dittoflash = Resolve-Path 'tools\Ditto Flash'
	Add-Config 'dittoflash' $dittoflash

	. .\installers\inc\registry.ps1
	if (Get-FileExtensionRegistration 'min') {
		if (Read-YN 'Add "Flash to DITTO mini" to the context menu for .min files') {
			$exe = "$dittoflash\DittoFlashWin.exe"
			Add-FileExtensionCommand 'min' 'flashditto' -Name 'Flash to DITTO mini' -Command "`"$exe`" `"%1`"" -Icon "`"$exe`""
			Write-Host '...done'
		}
	}
}

return $true
