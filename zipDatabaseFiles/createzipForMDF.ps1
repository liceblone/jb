##############################################################################################
##  
##  For publishing all resources
##  
##  usage:
##        C:\TestProjects\createZipByPs\createzipForMDF.sp1 -Filter "*.bak" -TargetFolders "C:\TestProjects\createZipByPs"
##
##############################################################################################

 #param($Filter, $TargetFolders)

## test
$Filter="*.txt"
$TargetFolders ="C:\TestProjects\createZipByPs"

cls
$BaseDir= $(get-location).path+"\" 
Write-Host $BaseDir 
Write-Host $Filter 
Write-Host $TargetFolders 

 

<################################################################   
##load assembly Ionic.Zip.Reduced
$assm = [System.Reflection.Assembly]::LoadFrom($BaseDir + "\Ionic.Zip.Reduced.dll");
 
 
 function  zip($fileName)
 {
    $zipfile =  new-object Ionic.Zip.ZipFile

    $zipfile.AddFile($fileName)
    
    $ZipName = $BaseDir+[System.IO.Path]::GetFileNameWithoutExtension($fileName)+".zip"
    Write-Host "Compressing "$ZipName
    $zipfile.Save($ZipName)
    $zipfile.Dispose() 
 }


#updte scripts 3.2
$files = @() + (Get-ChildItem ($TargetFolders) -Include $filter -Recurse)
foreach ($file in $files)
{
 $file.FullName
     zip $file.FullName

}
 


Write-Host "  completed"
#>