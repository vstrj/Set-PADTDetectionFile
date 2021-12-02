function Set-PADTDetectionFile {
    <#
    .SYNOPSIS
        Creates a detection .tag file to use for intune or SCCM
    .DESCRIPTION
        Creates a detection .tag file to use for intune or SCCM. Default values will use $appName and $appScriptVersion from Deploy-Application.ps1.
        Detection Folder, App name and version can be set via parameters.
    .PARAMETER DetectionFolder
        Specifies in which folder the .tag file should be created. Default is set to "$($env:ProgramData)\PADTInstalled"
    .PARAMETER DetectionName
        Specifies what Application name should be used for the .tag file. Default is $appName from Deploy-Application.ps1.
    .PARAMETER DetectionVersion
        Specifies what Version number should be used for the .tag file. Default is $appScriptVersion from Deploy-Application.ps1.
    .PARAMETER DetectionValue
        Specifies what Value should be used for the .tag file. Default is "Installed"
    .PARAMETER Remove
        Removes the detection .tag file.
    .EXAMPLE
        Set-PADTDetectionFile
    .EXAMPLE
        Set-PADTDetectionFile -Remove
    .EXAMPLE
        Set-PADTDetectionFile -DetectionFolder "C:\Temp" -Name "MyApp" -DetectionVersion "1.0.2" -DetectionValue "MyOwnValue"
    .NOTES
        This is should be run under Post-Installation, preferably under some if-statement to verify the installation.
        Or under the Post-Uninstallation with the -Remove switch.
    .LINK
        http://vstrj.com
    #>
    [CmdletBinding()]
    param(
    [Parameter(ValueFromPipeline)]
    [String] $DetectionFolder = "$($env:ProgramData)\PADTInstalled",
    [Parameter(ValueFromPipeline)]
    [String] $DetectionName = $appName,
    [Parameter(ValueFromPipeline)]
    [String] $DetectionVersion = $appScriptVersion,
    [Parameter(ValueFromPipeline)]
    [String] $DetectionValue = "Installed",
    [Parameter(ValueFromPipeline)]
    [Switch] $Remove
    )
    Begin {
		## Get the name of this function and write header
		[string]${CmdletName} = $PSCmdlet.MyInvocation.MyCommand.Name
		Write-FunctionHeaderOrFooter -CmdletName ${CmdletName} -CmdletBoundParameters $PSBoundParameters -Header
	}
    process {
        if (-not $Remove){
            If (-not (Test-Path $DetectionFolder))
                {
                Write-Log -Message "PADT-Detection folder does not exsis, creating folder!"
                New-Folder -Path $DetectionFolder
                }
                Write-Log -Message "Creating Tagfile $appName$appScriptVersion.tag"
                Set-Content -Path "$DetectionFolder\$DetectionName$DetectionVersion.tag" -Value $DetectionValue
        }
        else {
            Write-Log -Message "Removing TagFile"
            Remove-File -Path "$DetectionFolder\$DetectionName$DetectionVersion.tag"
        }   
    }
    End {
		Write-FunctionHeaderOrFooter -CmdletName ${CmdletName} -Footer
    }
}