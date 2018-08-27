cls


Function QuerySQL($SQL)
{
	write-host $SQL
	$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
	$SqlConnection.ConnectionString = "Data Source = $SQLServer; Initial Catalog = $SQLDBName; User ID=rs;Password=ZJJBDZ01!"
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


function GetTransmission_Date($lines)
{
    foreach ($line in $lines)
    {        
        if ($line.Substring(0,2).Equals("JD") ){
            return  $line.Substring(2,8);
            #write-host   $line.Substring(2,8)
            break;
        }
    }
    return ""
}

 


 
$SQLServer = 'jb99999.xicp.net,7709'
$SQLDBName = "RsUserData"

$logFile =( split-path -parent $MyInvocation.MyCommand.Definition )+ "\bcjrer02.txt"
$lines =Get-Content $logFile

Write-Host $logFile
#Write-Host [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition)
 

$FLogFileDate=Get-Item $logFile| Foreach {$_.LastWriteTime}
$FTransmission_Date=GetTransmission_Date($lines)
$pinsertsql=""

######################## delete record
$deletesql=[string]::Format("delete TRainbowProcessLog where FLogFileDate='{0}' ", $FLogFileDate)
$rlt= QuerySQL($deletesql)

foreach ($line in $lines)
{
    $FFile_ID=$line.Substring(0,2)
    
    if ($FFile_ID.Equals("JZ")){
        $FJZDataType=$line.Substring(2,2)
    }else{
        $FJZDataType=""
    }
    
    $FProcessLog=$line   
    
    
     #>
write-host $FTransmission_Date
write-host $FFile_ID
write-host $FJZDataType
write-host $FProcessLog
write-host $FLogFileDate
 #>
 
    ############ insert record
    $pinsertsql=[string]::Format("insert into TRainbowProcessLog 
                             (FTransmission_Date,FFile_ID,FJZDataType,FLogFileDate,FProcessLog)values
                             ('{0}' ,             '{1}',      '{2}'  ,   '{3}'         ,'{4}')", $FTransmission_Date,$FFile_ID,$FJZDataType,$FLogFileDate,$line )
    $rlt=  QuerySQL($pinsertsql)
 
     

    
}


