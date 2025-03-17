<#
.Description
Game Boy Enhanced+ is an emulator which supports many Nintendo handhelds including Pokemon mini, with infrared support!
#>
param(
[switch] $uninstall,
[string] $prefix
)

$DOWNLOAD_URL='https://github.com/shonumi/gbe-plus/releases/download/1.8/gbe_1_8.7z'

if ($prefix) {
	if (! $gbeplus) {
		Write-Host "gbe-plus not installed"
		exit 1
	}

	Write-Output $gbeplus
} elseif ($uninstall) {
	if ($gbeplus) {
		Remove-Item $gbeplus -Force -Recurse -ErrorAction SilentlyContinue
		Remove-Config 'gbeplus'
	}
} elseif (! $gbeplus) {
	if (.\installers\7zip.ps1) {
		Write-Host 'Downloading...'
		Download $DOWNLOAD_URL 'gbeplus.7z'
		Write-Host 'Unzipping...'
		& $sevenzip x -o'tools' 'gbeplus.7z'
		Remove-Item -Path 'gbeplus.7z'
		$gbeplus = Resolve-Path 'tools\gbe-plus'
		Add-Config 'gbeplus' $gbeplus
		
		if (Read-YN 'Set path environment variable for GBE+') {
			Update-Path $gbeplus
			Write-Host '...done'
		} else {
			Write-Host "You can always add this folder to your PATH variable later:"
			Write-Host "  $gbeplus"
		}
	} else {
		exit 1
	}
}

return $true
