<#  ........................Assignment 7................................#>
<#    Write PowerShell function which lists how many VM’s were on each host.

#>


#Add-PSSnapin VMware.VimAutomation.Core
Write-Host "List VM's on each Esxi-Host!!!!"
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
		getNumberOfVMOnHost
	}
	else{
		Write-Host "Your connection was not successful, please verify your username name and password"
	}
}

function getNumberOfVMOnHost{

			 Get-VM | Select Name ,@{N="ESX Host";E={Get-VMHost -VM $_}}
			
	
}

CheckConnection