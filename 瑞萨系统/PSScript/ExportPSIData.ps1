##############################################################################################################
##
##    export sql script to to files
##    usage: C:\ExportPSIData.ps1 -FBeginDate "2014-1-24"  -FEndDate "2014-1-24"
##############################################################################################################


Param($FBeginDate , $FEndDate )
cls
 
$a =(Get-Date)
$FBeginDate = $a.ToShortDateString()
$FEndDate = $a.ToShortDateString()


$SQLServer = 'jb99999.xicp.net,7709'
$SQLDBName = "RsUserData"


Function QuerySQL($SQL)
{
write-host $SQL
$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Data Source = $SQLServer; Initial Catalog = $SQLDBName; User ID=rs;Password=ZJJBDZ01!"
#Data Source=127.0.0.1;Initial Catalog=master;User ID=sa;Password=xx

$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText = $SQL
$SqlCmd.Connection = $SqlConnection
write-host $SqlConnection.ConnectionString
 
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd
$DataSet = New-Object System.Data.DataSet
 
write-host $SQL
$return = $SqlAdapter.Fill($DataSet)
 
$SqlConnection.Close()
 
if ($return -eq 0) { #Notifies that No accounts were created
 echo "failed"
}
else{
write-host "success"
}
return $DataSet 
}
 
$SqlQuery =" Pr_GetPSIData '"+$FBeginDate+"','"+$FEndDate+"'  "
  
 
$PSIFile="C:\RENESAS_QAS\send\"+"bcjrsd02" +".txt"
 write-host $PSIFile 
 write-host  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($PSIFile)
 
   if (Test-Path  ( $PSIFile ))
  {
  Remove-Item $PSIFile
  }
  else
  {
  write-host "file not exists."
  }
  
$DataSet =QuerySQL($SqlQuery )
ForEach ($row in $DataSet.Tables[0].Rows) 
{
 add-content -value $row.FTxtValue  -path $PSIFile
 #  $row.FTxtValue
}
  

 <#  Copy-Item $ProcFile -Destination "\PSIData" -force  #>