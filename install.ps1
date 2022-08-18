<#
.Description
Pokemon mini tool installer v0.0.1
.EXAMPLE
PS> .\install.ps1 c88tools
.SYNOPSIS
Used to install tools for developing on or playing with the Pokemon mini.
#>
param(
[string] $tool = 'c88tools',
[switch] $uninstall,
[switch] $list,
[switch] $prefix
) 

$cwd = Get-Location
cd "${PSScriptRoot}" >$null

if (! (Test-Path -Path config.ps1)) {
	New-Item config.ps1 -type file
}

cd "installers" >$null

# Commands
if ($list) {
	foreach ($file in Get-ChildItem *.ps1) {
		$name = "$(Split-Path -Path "$file" -Leaf)" -replace '\..*$', ''
		$tmp = Get-Help $file
		Write-Host "${name}: $($tmp[0].description.Text)"
	}
} elseif ($uninstall) {
	$yn = Read-Host -prompt "Are you sure you want to uninstall $tool (y/n)?"
	if ("$yn" -ne "y") {
		cd "${cwd}" >$null
		exit
	}
	$cmd = @{
		uninstall = $true
	}
	$start = 'Uninstalling'
	$success = 'Uninstalled successfully!'
	$failure = 'Uninstallation failed.'
} elseif ($prefix) {
	$cmd = @{
		prefix = '.'
	}
	$start = ''
	$success = ''
	$failure = ''
} else {
	$cmd = @{}
	$start = 'Installing'
	$success = 'Installed successfully!'
	$failure = 'Installation failed.'
}

if (Test-Path -Path "$tool.ps1") {
	if ($start) { Write-Host "$start $tool..." }
	if (& ".\$tool.ps1" @cmd | Out-Host) {
		if ($success) { Write-Host "$success" }
	} else {
		if ($failure) { Write-Host "$failure" }
		cd "${cwd}" >$null
		exit 1
	}
} else {
	Write-Host "No tool $tool found..."
	cd "${cwd}" >$null
	exit 2
}

cd "${cwd}" >$null
