<#  ........................Assignment 10.1................................#>
<#   

Write PowerShell function which lists the number of VMs on each Datastore and export to CSV file

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
		countVm
	}
	else{
		Write-Host "Your connection was not successful, please verify your username name and password"
	}
}

function countVm{

             $tempArray = Get-Datastore
             foreach($item in $tempArray){

   
             $name = Get-Datastore $item | Select Name, @{N=”TotalVMs”;E={@($_ | Get-VM ).Count}}
             write-host("$name")
}
    
}CheckConnection
