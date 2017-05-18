<#  ........................Assignment 11................................#>
<#   

Write PowerShell function which detail the number of vCPU’s on a host and in a cluster

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
		ListHostInfo
	}
	else{
		Write-Host "Your connection was not successful, please verify your username name and password"
	}
}
function ListHostInfo() {
Invoke-Expression "C:\Users\Administrator\Desktop\completed\connection1.ps1"

foreach ($cluster in get-cluster)
{
	write-host "Cluster : ($cluster.name) "
foreach($esxiHost in ($cluster|get-vmhost|sort name))
{
	write-host "Host : ($esxiHost.name)"

foreach($vms in ($esxiHost| get-vm|sort name))
{
$hostCPU+=$vms.numcpu
}
	write-host "Number of vCpu on host : $hostCPU"
$totalCPU+=$hostCPU
$hostCPU=0
}
	write-host "Total vCPU in cluster is $totalCPU "
}

}
CheckConnection




