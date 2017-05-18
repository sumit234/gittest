<#  ........................Assignment 4................................#>
<# "Write PowerShell function NumberOfVMStatus() which displays following:

1. Number of power “On” virtual machines connected with Esxi host currently along with their names

2. Number of power “Off” virtual machines connected with Esxi host currently along with their names"
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
		PowerState
	}
	else{
		Write-Host "Your connection was not successful, please verify your username name and password"
	}
}


function PowerState{

 	Write-Host("VM with On state :") 
	(Get-VM |Where {$_.PowerState -eq "PoweredOn"}).Count

	Get-VM |Where {$_.PowerState -eq "PoweredOn"}| select Name

	Write-Host("VM with Off state :") 
	(Get-VM |Where {$_.PowerState -eq "PoweredOff"}).Count
	Get-VM |Where {$_.PowerState -eq "PoweredOff"}| select Name

}

CheckConnection
