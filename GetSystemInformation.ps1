
##Nov 19, 2019 created

Clear-Host

##initial
#Step 1:
$isOutFile = Test-Path D:\yl-A02.txt
$dateandtime = Get-Date -DisplayHint DateTime
$PassDate = $dateandtime.AddDays(-90)
#Step 2:
$Printer = Get-WmiObject -Class Win32_Printer | Format-list Name, PrinterStatus
$PrinterNum = Get-WmiObject -Class Win32_Printer | Measure-Object | select -Property Count
$PhysicalMem = Get-WmiObject -Class Win32_PhysicalMemory | Format-List Name, Capacity
$PhysicalMemSticks = Get-WmiObject -Class Win32_PhysicalMemory | Measure-Object | select -Property Count
$PhysicalMemTotal = Get-WmiObject -Class Win32_PhysicalMemory | Measure-Object -sum capacity | select -Property Sum
$OS = Get-WmiObject -Class Win32_OperatingSystem | Format-List SerialNumber, Version
$DeskTop = Get-WmiObject -class Win32_desktop | Format-List Name, ScreenSaverActive
#Step 3:
$LocalBios = Get-WmiObject -Class Win32_Bios | Format-Table -Property Name, Version
$Battery = Get-WmiObject -Class Win32_Battery | Format-Table -Property Name, EstimatedRunTime, EstimatedChargeRemaining
$SerialPort = Get-WmiObject Win32_SerialPort | Format-Table Name, ProviderType
$SerialPortNum = Get-WmiObject Win32_SerialPort | Measure-Object | select -Property Count
#Step 4:
$LogicDisk = Get-WmiObject -Class Win32_logicaldisk | Format-Table -Property DeviceID, Size
$LogicDiskTotal = 0
Get-WmiObject -Class Win32_logicaldisk | Select-Object Size | ForEach-Object {$LogicDiskTotal = $LogicDiskTotal + $_.size}

#Set default location
Set-Location "D:\"

##Step 1
#If same file exists
if ($isOutFile)
{
    Remove-Item "yl-a02.txt"
    New-Item -Name "yl-A02.txt" -ItemType file
}
else
{
    New-Item -Name "yl-A02.txt" -ItemType file
}

#If now is in date light saving
if ($dateandtime.IsDaylightSavingTime())
{
	"The data $dateandtime is the day light saving time" > D:\yl-A02.txt
}
else
{
	"The data $dateandtime is not the day light saving time" > D:\yl-A02.txt
}

#If 90 days before is in date light saving
if($PassDate.IsDaylightSavingTime())
{
	"90 days before, the date is $PassDate" >> D:\yl-A02.txt
	"The date $PassDate is the day light saving time" >> D:\yl-A02.txt
}
else
{
	"90 days before, the date is $PassDate" >> D:\yl-A02.txt
	"The date $PassDate is not the day light saving time" >> D:\yl-A02.txt
}


##Step 2
"" >> D:\yl-A02.txt
"Step 2:" >> D:\yl-A02.txt
"" >> D:\yl-A02.txt

#Get Printers
if($PrinterNum.Count -eq 0)
{
    "There is no printer" >> D:\yl-A02.txt
}
else
{
    $Printer >> D:\yl-A02.txt
    "There were " + $PrinterNum.Count + " printers found" >> D:\yl-A02.txt
}

#Get physical memory
if($PhysicalMem)
{
    $PhysicalMem >> D:\yl-A02.txt
}
else
{
    "Did not get Memory information" >> D:\yl-A02.txt
}

#Sticks & Total GB
if($PhysicalMemSticks -and $PhysicalMemTotal.Sum)
{
    "There were " + $PhysicalMemSticks.Count + " memory stick(s) found" >> D:\yl-A02.txt
    "Memory in GB: " + $PhysicalMemTotal.Sum/1gb >> D:\yl-A02.txt
}
else
{
    "Did not get Memory sticks or size information" >> D:\yl-A02.txt
}

#OS information
if($OS)
{
    $OS >> D:\yl-A02.txt
}
else
{
    "Did not get OS information" >> D:\yl-A02.txt
}

#OS desktop
if($DeskTop)
{
    $DeskTop >> D:\yl-A02.txt
}
else
{
    "Did not get deskTop information" >> D:\yl-A02.txt
}


##Step 3
"" >> D:\yl-A02.txt
"Step 3:" >> D:\yl-A02.txt
"" >> D:\yl-A02.txt

#BIOS
if($LocalBios)
{
    $LocalBios >> D:\yl-A02.txt
}
else
{
    "Did not get local BIOS information" >> D:\yl-A02.txt
}

#Battery
if($Battery)
{
    $Battery >> D:\yl-A02.txt
}
else
{
    "Did not get Battery information" >> D:\yl-A02.txt
}

#Serial port
if($SerialPort -and $SerialPortNum)
{
    $SerialPort >> D:\yl-A02.txt
    "There were " + $SerialPortNum.Count + " serial port(s) found" >> D:\yl-A02.txt
    #"Hello"
}
else
{
    "Did not get Serial Port information" >> D:\yl-A02.txt
    #"HI"
}

##Step 4
"" >> D:\yl-A02.txt
"Step 4:" >> D:\yl-A02.txt
"" >> D:\yl-A02.txt

#All drives
if($LogicDisk)
{
    $LogicDisk >> D:\yl-A02.txt
}
else
{
    "Did not get logical disck information" >> D:\yl-A02.txt
}

#Total disk capacity
if($LogicDiskTotal)
{
    "Total capacity of all fixed drives: " + $LogicDiskTotal/1gb + " GB" >> D:\yl-A02.txt
}
else
{
    "Did not get logical disk capacity information" >> D:\yl-A02.txt
}