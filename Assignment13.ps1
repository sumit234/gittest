<#  ........................Assignment 13................................#>
<#   
Write PowerShell function which add additional 100GB virtual disk to Windows machine

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
		ExtendDisk
	}
	else{
		Write-Host "Your connection was not successful, please verify your username name and password"
	}
}

function ExtendDisk{
$vm = read-Host "Enter name of VM"
$size = read-Host "Enter size to be extended of VM"
Get-vm $vm | where {$_.Name -eq "Hard Disk 1"} | Set-HardDisk -CapacityGB $size -Confirm:$false
Get-HardDisk $vm 
}
CheckConnection