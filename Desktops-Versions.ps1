Function CreateArray {

    $computer_names = Get-ADGroupmember -Identity "CR Desktops" | select -expandproperty name
   
        return $computer_names
}

ForEach ($Desktop in CreateArray) {

    $Date = Get-Date -UFormat "%Y_%m_%d"
    $Filename = $Desktop + '   ' + $Date
    $S = New-PSSession -ComputerName $Desktop

			echo "----------------------------------------------------------------------------------------------------------" >> "\\atrdc2\scripts\PowerShell\logs\Versions-Logs\$Filename.txt"
		Invoke-Command -Session $S -ScriptBlock {Get-WmiObject Win32_PnPSignedDriver| select devicename, driverversion | where {$_.devicename -like "*82579LM*"}} >> "\\atrdc2\scripts\PowerShell\logs\Versions-Logs\$Filename.txt"
			echo "----------------------------------------------------------------------------------------------------------" >> "\\atrdc2\scripts\PowerShell\logs\Versions-Logs\$Filename.txt"
		Invoke-Command -Session $S -ScriptBlock {Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion | Format-Table -Property DisplayName, DisplayVersion} >> "\\atrdc2\scripts\PowerShell\logs\Versions-Logs\$Filename.txt"
		Invoke-Command -Session $S -ScriptBlock {Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion | Format-Table -Property DisplayName, DisplayVersion} >> "\\atrdc2\scripts\PowerShell\logs\Versions-Logs\$Filename.txt"
		}