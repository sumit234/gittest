<#  ........................Assignment 3................................#>
<# "Write PowerShell function ListAllVM() which displays following:

          1. List all VM along with Number vCPU/HAL/OS Version/Service Pack"
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
		getinfo
	}
	else{
		Write-Host "Your connection was not successful, please verify your username name and password"
	}
}


function getinfo{

	Get-VM |Where {$_.PowerState -eq “PoweredOn“} |Sort Name |Select Name, NumCPU, @{N=“OSHAL“;E={(Get-WmiObject -ComputerName $_.Name-Query “SELECT * FROM Win32_PnPEntity where ClassGuid = ‘{4D36E966-E325-11CE-BFC1-08002BE10318}’“ |Select Name).Name}}, @{N=“OperatingSystem“;E={(Get-WmiObject -ComputerName $_ -Class Win32_OperatingSystem |Select Caption).Caption}}, @{N=“ServicePack“;E={(Get-WmiObject -ComputerName $_ -Class Win32_OperatingSystem |Select CSDVersion).CSDVersion}}

}

CheckConnection