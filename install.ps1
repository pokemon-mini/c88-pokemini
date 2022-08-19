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
Set-Location "${PSScriptRoot}" >$null

if (! (Test-Path -Path config.ps1)) {
	New-Item config.ps1 -type file
} else {
	. .\config.ps1
}

# Commands
if ($list) {
	foreach ($file in Get-ChildItem installers\*.ps1) {
		$name = "$(Split-Path -Path "$file" -Leaf)" -replace '\..*$', ''
		$tmp = Get-Help $file
		Write-Host "${name}: $($tmp[0].description.Text)"
	}
} elseif ($uninstall) {
	$yn = Read-Host -prompt "Are you sure you want to uninstall $tool (y/n)?"
	if ("$yn" -ne "y") {
		Set-Location "${cwd}" >$null
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

# Commands for scripts to use
function Add-Config {
	param (
		[string] $Name,
		[string] $Value
	)

	Write-Host 'Saving to config...'
	Write-Output "`$$Name = `"$Value`"" | Out-File config.ps1 -Encoding utf8 -Append
}

function Remove-Config {
	param (
		[string] $Name
	)

	Write-Host 'Removing config entry...'
	Set-Content -Path config.ps1 -Value (Get-Content -Path config.ps1 | Select-String -Pattern "^\`$$Name =" -NotMatch)
}

function Read-YN {
	param (
		[string] $Question
	)

	$yn = Read-Host "$Question (y/n)?"
	'y', 'Y' -eq $yn
}

function Download {
	param (
		[string] $Uri,
		[string] $OutFile
	)

	Invoke-WebRequest -Uri $Uri -OutFile $OutFile -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::FireFox
}

function Update-Path {
	param (
		[string] $Path
	)

	$userpath = Get-ItemProperty -Path HKCU:\Environment -Name Path
	setx Path "$($userpath.Path);$Path"
	$env:PATH = "$env:PATH;$Path"
}

function Out-String {
	# Write strings to host but also return anything
	$Input | Tee-Object -variable ret | Where-Object {$_.GetType().Name -eq 'String'} | Out-Host
	$ret
}

# Import script
if (Test-Path -Path "installers\$tool.ps1") {
	if ($start) { Write-Host "$start $tool..." }
	if (& ".\installers\$tool.ps1" @cmd | Out-String) {
		if ($success) { Write-Host "$success" }
	} else {
		if ($failure) { Write-Host "$failure" }
		Set-Location $cwd >$null
		exit 1
	}
} else {
	Write-Host "No tool $tool found..."
	Set-Location $cwd >$null
	exit 2
}

Set-Location $cwd >$null
