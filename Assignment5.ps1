<#  ........................Assignment 5................................#>
<#    Write PowerShell function ListVMFromLocalStore() which list all VM’s located on local storage along with 
      their file name and available disk space.
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
		ListVMFromLocalStore
	}
	else{
		Write-Host "Your connection was not successful, please verify your username name and password"
	}
}



function ListVMFromLocalStore() {
Get-Datastore |select Name
$dataStore=read-host("Enter the Datastore name ")
$path=read-host("Enter the path where you want to store details ")
Get-Datastore |where {$_.Name -match $dataStore} |Get-VM |Get-HardDisk |select Filename,CapacityGB |Export-Csv $path} 

}CheckConnection 
