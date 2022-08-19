<#
.Description
PokeMini emulator by JustBurn v0.60
#>
param(
[switch] $uninstall,
[string] $prefix
)

$DOWNLOAD_URL='https://sourceforge.net/projects/pokemini/files/0.60/pokemini_060_windev.zip/download'

if ($prefix) {
	if (! $pokemini) {
		Write-Host "pokemini not installed"
		exit 1
	}

	Write-Output $pokemini
} elseif ($uninstall) {
	if ($pokemini) {
		Remove-Item $pokemini -Force -Recurse -ErrorAction SilentlyContinue
		Remove-Config 'pokemini'
		. .\installers\inc\registry.ps1
		Unregister-FileExtension 'min'
	}
} elseif (! $pokemini) {
	Write-Host 'Downloading...'
	Download $DOWNLOAD_URL 'pokemini_windev.zip'
	Write-Host 'Unzipping...'
	Expand-Archive -Path 'pokemini_windev.zip' -DestinationPath 'tools\pokemini'
	Remove-Item -Path 'pokemini_windev.zip'
	$pokemini = Resolve-Path 'tools\pokemini'
	Add-Config 'pokemini' $pokemini

	if (Read-YN 'Set path environment variable for Pokemini') {
		Update-Path $pokemini
		Write-Host '...done'
	} else {
		Write-Host "You can always add this folder to your PATH variable later:"
		Write-Host "  $pokemini"
	}

	if (Read-YN 'Associate .min files with PokeMini') {
		$exe = "$pokemini\PokeMini.exe"
		$dbg = "$pokemini\PokeMiniD.exe"
		$color = "$pokemini\color_mapper.exe"
		. .\installers\inc\registry.ps1
		Register-FileExtension 'min' -ProgID 'PokeMini_min' -Name 'Pokemon mini ROM' -Icon "`"$exe`",1" -Commands @{
			open = "`"$exe`" `"%1`""
			debug = @{
				Name = '&Debug'
				Command = "`"$dbg`" `"%1`""
			}
		}
		Register-FileExtension 'minc' -ProgID 'PokeMini_minc' -Name 'PokeMini ROM color file' -Icon "`"$exe`",2" -Commands @{
			open = "`"$color`" `"%1`""
		}
		Write-Host '...done'
	}
}
