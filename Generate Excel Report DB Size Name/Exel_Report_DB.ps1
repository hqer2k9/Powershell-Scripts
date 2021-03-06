# --------------------------------------------------------------------------------------
# Script: Exel_Report_DB.ps1
# Script Version: v1.0
# Author: Ingo Bechtle
# comments: Get's all Databases from the servers listed in the SQL_Servers.txt and generates a nice excel export 
# --------------------------------------------------------------------------------------

get-date

#Add Excel Com Object
$Excel = New-Object -ComObject Excel.Application
$Excel.visible = $True
$Excel = $Excel.Workbooks.Add()
$Sheet = $Excel.Worksheets.Item(1)

#Variable for row counting
$intRow = 1

#Dont wanna copy everything, simple foreach for multiple servers
#Just type in your servers
foreach ($instance in get-content "C:\temp\SQL_Servers.txt")
{

     #Create column headers
     $Sheet.Cells.Item($intRow,1) = "INSTANCE NAME:"
     $Sheet.Cells.Item($intRow,2) = $instance
     $Sheet.Cells.Item($intRow,1).Font.Bold = $True
     $Sheet.Cells.Item($intRow,2).Font.Bold = $True

     $intRow++

     $Sheet.Cells.Item($intRow,1) = "DATABASE NAME"
     $Sheet.Cells.Item($intRow,2) = "SIZE (MB)"
	  
     #Format column headers
     for ($col = 1; $col -le 2; $col++)
     {
          $Sheet.Cells.Item($intRow,$col).Font.Bold = $True
          $Sheet.Cells.Item($intRow,$col).Interior.ColorIndex = 48
          $Sheet.Cells.Item($intRow,$col).Font.ColorIndex = 34
     }

     $intRow++
	 
     #Load SQL Assembly for usage
     [System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | out-null

     #smo connection for server instances
     $s = New-Object ('Microsoft.SqlServer.Management.Smo.Server') $instance

	 #get all databases
     #if you have databases starting with master*, model*, msdb* or tempdb* they will not be listed!
	 $dbs = $s.Databases -notmatch "master|model|msdb|tempdb"
	 
     #using the format option to highlight stuff
     ForEach ($db in $dbs) 
     {

          #Divide the value of SpaceAvailable by 1KB 
          $dbSpaceAvailable = $db.SpaceAvailable/1KB 

          #Format the results to a number with three decimal places 
          $dbSpaceAvailable = "{0:N3}" -f $dbSpaceAvailable
          $Sheet.Cells.Item($intRow, 1) = $db.Name
          $Sheet.Cells.Item($intRow, 2) = "{0:N3}" -f $db.Size
		  
		  $intRow ++

     }

$intRow ++

}

#Finaly autofit the columns
$Sheet.UsedRange.EntireColumn.AutoFit()