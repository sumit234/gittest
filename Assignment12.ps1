<#  ........................Assignment 12................................#>
<#   

Write PowerShell function which list number of VM’s per resource pool and list Host, Cluster,
Number of VMs and number of templates

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
		pool
	}
	else{
		Write-Host "Your connection was not successful, please verify your username name and password"
	}
}

function pool
{
Get-VMHost |Select name,
		@{n="ResourcePool"; e={$_ | Get-ResourcePool}},	
		@{N=“Cluster“;E={Get-Cluster -VMHost $_}},
		@{N=“NumVM“;E={($_ |Get-VM).Count}}, 
		@{N=“NumTemplates“;E={($_ |Get-Template).Count}} |Sort Cluster,Name
 
}
CheckConnection 
