<#  ........................Assignment 10................................#>
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
$testArray = [System.Collections.ArrayList]@()
$tempArray = Get-Datastore

foreach($item in $tempArray)
{

    $arrayID = $testArray.Add($item)
     write-host($arrayID,$item)
}

   
$dataStore=read-host("Enter the Datastore name ")


$num = Get-Datastore $dataStore | Select @{N=”TotalVMs”;E={@($_ | Get-VM ).Count}}| Export-Csv -Path C:\Users\Administrator\Desktop\completed\assign10.csv
	write-host($num)

}
CheckConnection