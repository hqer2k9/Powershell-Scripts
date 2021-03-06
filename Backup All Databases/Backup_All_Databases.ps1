# --------------------------------------------------------------------------------------
# Script: Backup_All_Databases.ps1
# Script Version: v1.0
# Author: Ingo Bechtle
# comments: Backups all MSSQL Databases into a *.BAK file
# --------------------------------------------------------------------------------------

#Invoke of SQL Server Snapin
Add-PSSnapin SqlServerCmdletSnapin100

#Choose path to sql script directory and your server instance
invoke-sqlcmd -inputfile "C:\Temp\Backup_All_Databases.sql" -serverinstance ".\sqlexpress"