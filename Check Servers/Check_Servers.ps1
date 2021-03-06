# --------------------------------------------------------------------------------------
# Script: Check_Servers.ps1
# Script Version: v1.0
# Author: Ingo Bechtle
# comments: Checks Spooler Service of Remote Machine (Like Ping)
# --------------------------------------------------------------------------------------

while (1){

#Dont list errors in here....
$script:ErrorActionPreference = "silentlyContinue"

#create Com-Object for Messagebox
$wshshell = new-object -comobject wscript.shell

#Defying the servers, you can replace the first Machine (Host running the Script)
$servers = $env:computername#, "Server2", "Server3", "Server4"

#Here starts the loop
foreach ($server in $servers)
 { 
    #Best method for checking is not pinging, since pings can vary hard. 
    #Instead we are looking for the spooler Service (Spooler is always up) 
    $status = (get-service -Name spooler -ComputerName $server).Status 
    if ($status -eq "Running") {
        $server + " is running" 
    }
     
    else 
    
    {
     $server + " is down! " + (Get-Date) | Out-File "C:\Temp\NOPINGSERVER.txt"
     $server + " is down! Check C:\Temp\NOPINGSERVER.txt for time and date!"
     #Do a message box to warn me, simple dialog (0), for time 5 (5), disapear after 5
     $Answer = $wshshell.popup("Server Not Running!!!!!",5,"Check status!",0)
     foreach ($server in $servers) {
     #Try to resolve the spooler Service in time interval
     while ( (get-service -Name spooler -ComputerName $server).Status -ne "Running" )
     { 
     "Waiting for $server ..." 
     Start-Sleep -Seconds 10 
     } 
     "$server is Up!" 
     } 
    } 
 }
     #Dont do it like every 2 seconds, get some time
     start-sleep 5
	 
	}