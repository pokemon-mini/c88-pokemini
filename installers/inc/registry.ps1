function Register-FileExtension {
	param (
		[Parameter(Mandatory = $true)][string] $Ext,
		[string] $ProgID,
		[string] $Name,
		[string] $Icon,
		[hashtable] $Commands
	)

	$ExistingName = Get-ItemPropertyValue "HKCU:\Software\Classes\.$Ext" -Name '(Default)' -ErrorAction SilentlyContinue
	if ($ExistingName) {
		if ($ProgID) {
			if ($ExistingName -ne $ProgID) {
				Move-Item "HKCU:\Software\Classes\$ExistingName" "HKCU:\Software\Classes\$ProgID" -Force
			}
		} else {
			$ProgID = $ExistingName
		}
	} elseif (! $ProgID) {
		$ProgID = "${Ext}_auto_file"
	}

	New-Item "HKCU:\Software\Classes\.$Ext" -ErrorAction SilentlyContinue | Out-Null
	Set-ItemProperty "HKCU:\Software\Classes\.$Ext" -Name '(Default)' -Value $ProgID
	New-Item "HKCU:\Software\Classes\$ProgID" -ErrorAction SilentlyContinue | Out-Null

	Remove-Item "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.$Ext\UserChoice" -ErrorAction SilentlyContinue

	if ($Name) {
		Set-ItemProperty "HKCU:\Software\Classes\$ProgID" -Name '(Default)' -Value $Name
	}

	if ($Icon) {
		New-Item "HKCU:\Software\Classes\$ProgID\DefaultIcon" -ErrorAction SilentlyContinue | Out-Null
		Set-ItemProperty "HKCU:\Software\Classes\$ProgID\DefaultIcon" -Name '(Default)' -Value $Icon
	}

	if ($Commands) {
		$Commands.GetEnumerator() | ForEach-Object {
			$val = $_.Value
			if ($val.GetType().Name -eq 'String') {
				Add-FileExtensionCommand $Ext $_.Key -Command $val
			} else {
				Add-FileExtensionCommand $Ext $_.Key @val
			}
		}
	}
}

function Add-FileExtensionCommand {
	param (
		[Parameter(Mandatory = $true)][string] $Ext,
		[Parameter(Mandatory = $true)][string] $Verb,
		[Parameter(Mandatory = $true)][string] $Command,
		[string] $Name,
		[string] $Icon,
		[switch] $IsDefault
	)

	if (! $Verb) {
		if ($Name) {
			$Verb = $Name.ToLower() -replace '&', ''
		} else {
			return $false
		}
	}

	$ProgID = Get-ItemPropertyValue "HKCU:\Software\Classes\.$Ext" -Name '(Default)'

	if (! $ProgID) {
		return $false
	}

	$UserShell = "HKCU:\Software\Classes\$ProgID\shell"
	$UserVerb = "$UserShell\$Verb"
	$SysVerb = "HKCU:\Software\Classes\SystemFileAssociations\.$Ext\Shell\$Verb"

	New-Item "$UserVerb\command" -Force -ErrorAction SilentlyContinue | Out-Null
	Set-ItemProperty "$UserVerb\command" -Name '(Default)' -Value $Command

	New-Item "$SysVerb\Command" -Force -ErrorAction SilentlyContinue | Out-Null
	Set-ItemProperty "$SysVerb\Command" -Name '(Default)' -Value $Command

	if ($IsDefault) {
		Set-ItemProperty $UserShell -Name '(Default)' -Value $Verb
	}

	if ($Name) {
		Set-ItemProperty $UserVerb -Name '(Default)' -Value $Name
		Set-ItemProperty $SysVerb -Name '(Default)' -Value $Name
	}

	if ($Icon) {
		Set-ItemProperty $UserVerb -Name 'Icon' -Value $Icon
		Set-ItemProperty $SysVerb -Name 'Icon' -Value $Name
	}
}

function Get-FileExtensionRegistration {
	param (
		[Parameter(Mandatory = $true)][string] $Ext
	)

	Get-Item "HKCU:\Software\Classes\.$Ext"
}

function Unregister-FileExtension {
	param (
		[Parameter(Mandatory = $true)][string] $Ext
	)

	$ProgID = Get-ItemPropertyValue "HKCU:\Software\Classes\.$Ext" -Name '(Default)' -ErrorAction SilentlyContinue
	if ($ProgID) {
		Remove-Item @(
			"HKCU:\Software\Classes\$ProgID",
			"HKCU:\Software\Classes\.$Ext",
			"HKCU:\Software\Classes\SystemFileAssociations\.$Ext"
		) -Recurse -ErrorAction SilentlyContinue	
	}
}

function Remove-FileExtensionCommand {
	param (
		[Parameter(Mandatory = $true)][string] $Ext,
		[Parameter(Mandatory = $true)][string] $Verb
	)

	$ProgID = Get-ItemPropertyValue "HKCU:\Software\Classes\.$Ext" -Name '(Default)'

	if ($ProgID) {
		Remove-Item @(
			"HKCU:\Software\Classes\$ProgID\shell\$Verb",
			"HKCU:\Software\Classes\SystemFileAssociations\.$Ext\Shell\$Verb"
		) -Recurse -ErrorAction SilentlyContinue
	}
}
