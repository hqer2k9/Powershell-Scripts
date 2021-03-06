# --------------------------------------------------------------------------------------
# Script: Get_Folder_Files.ps1
# Script Version: v1.0
# Author: Ingo Bechtle
# comments: Looks up folder files and list them in a file, helpfull for SQL Backup Folder
# --------------------------------------------------------------------------------------

# Here's how it's done
# Get-childItem -recurse -Path ##### shows subfolders and their files
# Please keep in mind that the following path's are examples!

"#################### Server ####################" | add-content c:\databasebaks.txt 
Get-childitem -name -Path \\Server\SQL\Backup\* | add-content c:\databasebaks.txt 
" " | add-content c:\databasebaks.txt 

"#################### Server\prod ####################" | add-content c:\databasebaks.txt 
Get-childitem -name -Path \\Server\SQLProdBackup\* | add-content c:\databasebaks.txt
" " | add-content c:\databasebaks.txt 

#Example with UNC Path
"#################### Server\backups ####################" | add-content c:\databasebaks.txt 
$path = "\\Server\d$\Program Files\Microsoft SQL Server\MSSQL10_50.Instance\MSSQL\Backup\*"
Get-childitem -name -Path $path | add-content c:\databasebaks.txt
" " | add-content c:\databasebaks.txt 

"#################### Server\temp ####################" | add-content c:\databasebaks.txt 
Get-childitem -name -Path \\Server\temp\* -Include *.bak | add-content c:\databasebaks.txt
" " | add-content c:\databasebaks.txt 