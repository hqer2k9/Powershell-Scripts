# --------------------------------------------------------------------------------------
# Script: Clear_And_Copy.ps1
# Script Version: v1.0
# Author: Ingo Bechtle
# comments: Simple File Copy with excluding file
# --------------------------------------------------------------------------------------

#clear destination without sample.config before copy
Remove-Item -Recurse -Force \\NetworkShare\c$\Temp\* -Exclude "sample.config"

#Copy something without overwriting a file
$source = 'c:\Temp'
$dest = '\\NetworkShare\c$\Temp\'
$exclude = @('sample.config')
Get-ChildItem $source -Recurse -Exclude $exclude | Copy-Item -Destination {Join-Path $dest $_.FullName.Substring($source.length)}