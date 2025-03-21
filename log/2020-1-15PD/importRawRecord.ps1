cls


Function QuerySQL($SQL)
{
	write-host $SQL
	$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
	$SqlConnection.ConnectionString = "Data Source = $SQLServer; Initial Catalog = $SQLDBName; User ID=sa;Password=Jbdata1"
	#Data Source=127.0.0.1;Initial Catalog=master;User ID=sa;Password=xx

	$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
	$SqlCmd.CommandText = $SQL
	$SqlCmd.Connection = $SqlConnection
	# write-host $SqlConnection.ConnectionString
	# write-host $SQL
    if ($SQL.ToUpper().StartsWith("SELECT"))
    {
        $SqlCmd.ExecuteNonQuery()
        reutrn null
    }
    else{
     
    	$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
    	$SqlAdapter.SelectCommand = $SqlCmd
    	$DataSet = New-Object System.Data.DataSet
    	 
    	
    	$return = $SqlAdapter.Fill($DataSet)
    	 
    	$SqlConnection.Close()
 
    }
	return $DataSet 
}

 


function gothroughExcel($FilePath )
{
cls
    $objExcel = New-Object -ComObject Excel.Application
    # Disable the 'visible' property so the document won't open in excel
    $objExcel.Visible = $false
     
    #Specify the path of the excel file
    #$FilePath = "C:\\github\\jb\\log\\2020-1-15PD\\过道整件\\A地.xls" #$File.FullName
     
    # Open the Excel file(ReadOnly mode) and save it in $WorkBook
    $WorkBook = $objExcel.Workbooks.Open($FilePath, $true)
    # Load the WorkSheet
    $WorkSheet = $WorkBook.Sheets.Item(1)
     
     $rowNo =0 
    for($i =1 ;$i -lt 10000; $i++){ 
         if ($WorkSheet.Cells.item($i,1).Text.trimend() -eq "")
         {break}
          if ($WorkSheet.Cells.item($i,1).Text.trimend() -eq "规格")
         {continue}
         
          $rowNo =$rowNo+1 
        $txt = $WorkSheet.Cells.item($i,1).Text +","+$WorkSheet.Cells.item($i,2).Text  
        
        $sql=[string]::Format(" insert into  RsUserDataLog..TPDRawData(frowNo, ftxt ,FRawBarCode,FFileName ,fyear , fwhcode)
    select '{0}' ,'{1}' ,'{2}','{3}' ,2021,'01'  ",
     $rowNo ,$txt , $WorkSheet.Cells.item($i,2).Text  ,$FilePath  )
     
     
        $rlt=  QuerySQL($sql)
        #echo $sql  
    }
 
$WorkBook.Close()
$objExcel.Quit()
Stop-Process -Name excel


}


function gothroughMachineExcel($FilePath )
{
cls
    $objExcel = New-Object -ComObject Excel.Application
    # Disable the 'visible' property so the document won't open in excel
    $objExcel.Visible = $false
     
    #Specify the path of the excel file
    #$FilePath = "C:\\github\\jb\\log\\2020-1-15PD\\过道整件\\A地.xls" #$File.FullName
     
    # Open the Excel file(ReadOnly mode) and save it in $WorkBook
    $WorkBook = $objExcel.Workbooks.Open($FilePath, $true)
    # Load the WorkSheet
    $WorkSheet = $WorkBook.Sheets.Item(1)
     
     $rowNo =0
    for($i =1 ;$i -lt 10000; $i++){ 
         if ($WorkSheet.Cells.item($i,1).Text.trimend() -eq "")
         {break}
          if ($WorkSheet.Cells.item($i,1).Text.trimend() -eq "FinvCode")
         {continue}
         
          $rowNo =$rowNo+1 
        $txt = $WorkSheet.Cells.item($i,1).Text +","+$WorkSheet.Cells.item($i,2).Text  +","+$WorkSheet.Cells.item($i,10).Text
        
        $FinvCode = $WorkSheet.Cells.item($i,1).Text
        $FHsBarCode= $WorkSheet.Cells.item($i,2).Text
        $FQty = $WorkSheet.Cells.item($i,10).Text
        
        $sql=[string]::Format(" insert into  RsUserDataLog..TPDRawData(
        frowNo, Finvcode,ftxt ,FQty,FRawBarCode,FFileName ,fyear , fwhcode)
    select '{0}' ,'{1}' ,'{2}','{3}' ,'{4}','{5}',2021,'01'  ",
     $rowNo ,$FinvCode,$txt ,$FQty, $FHsBarCode,$FilePath  )
     
     
        $rlt=  QuerySQL($sql)
 
    }
 
$WorkBook.Close()
$objExcel.Quit()
Stop-Process -Name excel


}

function getFiles($WorkingDir, $Filter)
{ 
    while((Test-Path -Path $WorkingDir -PathType Container) -eq $false)
    {
        $WorkingDir = Read-Host "Please enter a valid directory path"
    }
    $Files = Get-ChildItem -Path $WorkingDir -recurse -Filter $Filter
    return $Files
}

function insertTxtLines($dataFile)
{
    $lines =Get-Content $dataFile

    $rowNo = 0 
    foreach ($line in $lines)
    {
    if  ($line.trimend()-eq ""){
    continue
    }
     $rowNo =$rowNo+1 
    $pinsertsql=[string]::Format(" insert into  RsUserDataLog..TPDRawData(frowNo, ftxt ,FFileName ,fyear , fwhcode)
    select '{0}' ,'{1}' ,'{2}' ,2021,'01'",
     $rowNo ,$line, $dataFile  )

    $rlt=  QuerySQL($pinsertsql)
    echo $pinsertsql  
    } 
}
 


 
$SQLServer = 'jb99999.xicp.net,7709'
$SQLDBName = "jbHzUserData"

#QuerySQL('select 1')
<#
$WorkingDir ="C:\github\jb\log\2020-1-15PD\sj"
$files=getFiles $WorkingDir  "*.xls"

foreach($file in $files)
{
 gothroughExcel $file.FullName
}



$WorkingDir ="C:\github\jb\log\2020-1-15PD\"
$files=getFiles $WorkingDir  "*.txt"

foreach($file in $files)
{
 insertTxtLines $file.FullName
}
  
  
  
$WorkingDir ="C:\github\jb\log\2020-1-15PD\机器盘点"
$files=getFiles $WorkingDir  "*.xls"

foreach($file in $files)
{
 gothroughMachineExcel $file.FullName
}
  #>


#$WorkingDir ="C:\github\jb\log\2020-1-15PD\芯片区2\芯片区（2）"
$WorkingDir ="C:\github\盘点\2021-12-22\补条码"

$files=getFiles $WorkingDir  "*.txt"

foreach($file in $files)
{
 insertTxtLines $file.FullName
}
  
  