##############################################################################################
##  
##  For publishing all resources
##  
##  usage:
##        C:\TestProjects\createZipByPs\createzipForMDF.sp1 -Filter "*.bak -TargetFolders "E:\Integration\HRCM.Trunk\Packages\Release\"
##
##############################################################################################

## param($Filter, $TargetFolders)

## test
$Filter="*.txt"
$TargetFolders ="C:\TestProjects\createZipByPs"


cls
$BaseDir= $(get-location).path+"\" 
Write-Host $BaseDir 
Write-Host $Filter 
Write-Host $TargetFolders 

 


