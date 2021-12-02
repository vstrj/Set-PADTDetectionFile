# Set-PADTDetectionFile
Function for the Extensions for Powershell Application Toolkit.
Creates a .tag file that can be used by SCCM or Intune as a detectionmethod.
Copy the function to AppDeployToolkitExtensions.ps1
Requires the rest of PADT.

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
