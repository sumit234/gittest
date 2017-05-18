<#  ........................Assignment 8................................#>
<#    Write PowerShell function GetDisk(_virtualMachine) which displays disk name with its current capacity, 
      free space and % of available free space for given virtual machine


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
		GetDisks
	}
	else{
		Write-Host "Your connection was not successful, please verify your username name and password"
	}
}


function GetDisks
 {    
    get-vm |select name
    $data=read-host("enter the vm")
        
    $dd=ForEach ($vm in get-vm $data){
    ($VM.Extensiondata.Guest.Disk | Select @{N="Name";E={$VM.Name}}, @{N="Capacity(MB)";
    E={[math]::Round($_.Capacity/ 1MB)}}, @{N="Free Space(MB)";E={[math]::Round($_.FreeSpace / 1MB)}}, 
    @{N="Free Space %";
    E={[math]::Round(((100* ($_.FreeSpace))/ ($_.Capacity)),0)}})}
    write-host($dd)
	} 
CheckConnection   
