<#
    BIOS date offset tool for VirtualBox virtual machines
    Khalid Ali 2019
    http://khalidali.co.uk

    Purpose:
        This tool allows you to automate the otherwise tedious process
        off specifying an date offset for an Oracle VirtualBox virtual
        machine. 

    Why:
        As of the latest commit date for this repo, VirtualBox does not
        provide GUI-based options for modifying the virtual machine's
        system (or BIOS/UEFI) date. Unlike the simple methods for doing so
        for VMware and Virtual PC VMs, VirtualBox requires you call an executable
        to pass in the offset for the BIOS date (related to host system date) in 
        milliseconds. This script aims to automate this process a bit to make it
        quicker and more accessible.

    Weaknesses:
        - No input validation on the input variables.
        - For locating the VirtualBox installation on the host machine, this scrippt
          only asks for a drive letter. It always assumes VBoxManage.exe is in
          "GivenDriveLetter:\Program Files\Oracle\VirtualBox\".
#>

# Get
$targetYear = Read-Host "Enter target BIOS date year (XXXX)"
$targetMonth = Read-Host "Enter target BIOS date month (XX)"
$targetDay = Read-Host "Enter target BIOS date day (XX)"
$vbDrive = Read-Host "Enter drive letter VirtualBox is located on (X)"
$vmName = Read-Host "Enter VirtualBox virtual machine name"

# Calculate
$startDate = (GET-DATE)
$endDate = [DateTime]"$targetMonth/$targetDay/$targetYear 00:00"
$dateDiff = New-TimeSpan –Start $startDate –End $endDate
$msDiff = [Math]::Round($dateDiff.TotalMilliseconds)

# Run
[System.Diagnostics.Process]::Start("${vbDrive}:\Program Files\Oracle\VirtualBox\VBoxManage.exe", "setextradata ""$vmName"" ""VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled"" 1")
[System.Diagnostics.Process]::Start("${vbDrive}:\Program Files\Oracle\VirtualBox\VBoxManage.exe", "modifyvm ""$vmName"" --biossystemtimeoffset $msDiff")