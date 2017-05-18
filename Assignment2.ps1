<#  ........................Assignment 2................................#>
<#    Write PowerShell function which accepts hostname, username, password as parameter to connect to Esxi host. 
If connection is successful then print message “You are connected to host XXX successfully” else throw error message “Your connection was not successful, 
please verify your username name and password. #>

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
		
	}
	else{
		Write-Host "Your connection was not successful, please verify your username name and password"
	}
}
CheckConnection

