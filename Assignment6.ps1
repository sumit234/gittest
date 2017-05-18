<#  ........................Assignment 6................................#>
<#    Write PowerShell functions which list how many cpu’s, 
      the amount of memory, average cpu usage for x amount of days and the average memory usage.

#>

#Add-PSSnapin VMware.VimAutomation.Core

Write-Host "Check Connection with Esxi-Host!!!!"

Write-Host "Num Args:" $args.Length;
$arg1 = $args[0]
$arg2 = $args[1]
$arg3 = $args[2]

Write-Host $arg1
Write-Host $arg2
Write-Host $arg3

function CheckConnection{
	Param($ip=$arg1,$user=$arg2,$pswd=$arg3)

	Connect-VIServer -Server $ip -user "$user" -password "$pswd"
	if($?){
		Write-Host "You are connected to host $ip successfully"
		getdetails
	}
	else{
		Write-Host "Your connection was not successful, please verify your username name and password"
	}
}


function getdetails{


$Day = $(Read-Host "Enter day")


                   Get-VM | Where {$_.PowerState -eq "PoweredOn"} | 
                   Select Name, VMHost, NumCpu, MemoryMB, 
                   @{N="Cpu.UsageMhz.Average";E={[Math]::Round((($_ |Get-Stat -Stat cpu.usagemhz.average -Start ($Day).AddHours(-24)-IntervalMins 5 -MaxSamples (12) |Measure-Object Value -Average).Average),2)}}, 
                   @{N="Mem.Usage.Average";E={[Math]::Round((($_ |Get-Stat -Stat mem.usage.average -Start ($Day).AddHours(-24)-IntervalMins 5 -MaxSamples (12) |Measure-Object Value -Average).Average),2)}} `
                   | Export-Csv C:\Users\Administrator\Desktop\completed\report.csv 
}
CheckConnection