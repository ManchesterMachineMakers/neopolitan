param(
    [string] $APKFile,
    [string] $ADBPath,
    [switch] $Force
)

$APKFile = if ($APKFile) { $APKFile } else { "TeamCode.apk" }
$ADBPath = if ($ADBPath) { $ADBPath } else { "adb" }

Write-Output "Output file: " $APKFile

Write-Output "Initializing ADB"
& $ADBPath devices

if (-not [System.IO.File]::Exists($APKFile) -or $Force -eq $true) {
    Write-Output "Downloading latest release"
    Invoke-WebRequest "https://github.com/ManchesterMachineMakers/RobotController/releases/download/latest/TeamCode-release-fullRobot.apk" -OutFile $APKFile
}

Write-Output "Uninstalling previous version"
& $ADBPath uninstall com.qualcomm.ftcrobotcontroller

Write-Output "Installing new version"
& $ADBPath install $APKFile
