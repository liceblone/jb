##############################################################################################################
##
##    CoNo into database
##    usage: C:\ImportCoNo.ps1 
##############################################################################################################

 
cls 
 
 
#test
<#
$CONOFile ="C:\Source\JBSource\瑞萨系统\PSScript\CCXW01.txt"
#>

###Production
$CONOFile = "C:\RENESAS\receive\CCXW01.txt"
<#
$SQLServer =  C:\GetIp.ps1  -ExePath C:\Source\JBSource\jingbei.exe   # 'jb99999.xicp.net,7709'
$SQLServer = $SQLServer.replace(":",",")
write-host $SQLServer
#>

$SQLServer =   'jb99999.xicp.net,7709'  
$SQLDBName = "RsUserData" 

Function QuerySQL($SQL)
{
#	write-host $SQL
	$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
	$SqlConnection.ConnectionString = "Data Source = $SQLServer; Initial Catalog = $SQLDBName; User ID=rs;Password=ZJJBDZ01"
	#Data Source=127.0.0.1;Initial Catalog=master;User ID=sa;Password=xx
  
	$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
	$SqlCmd.CommandText = $SQL
	$SqlCmd.Connection = $SqlConnection
    
    if (-not $SQL.ToUpper().StartsWith("SELECT"))
    {
        $SqlConnection.Close()
        $SqlConnection.Open();
        $SqlCmd.ExecuteNonQuery()
        return $null
    }
    else
    {
    	$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
    	$SqlAdapter.SelectCommand = $SqlCmd
    	$DataSet = New-Object System.Data.DataSet
    	$return = $SqlAdapter.Fill($DataSet)
    	 
    	$SqlConnection.Close()
    }
	return $DataSet 
}
function getDeleteSQL($DataCreateDate)
{
    $sql = "delete TCONO where FDataCreatedDate = '"+  $DataCreateDate +"'  "
    return $sql
}

function getSQL($list)
{
    $sql = "  "
    $sql =  $sql +" insert into TCONO "
    $sqlFields="("
    $sqlValues="select "

    $list.Keys | % { 
         $sqlFields +=  $_ +","
         $sqlValues += "'"+$list.Item($_).TrimEnd()+"',"
     } 
    $sql= $sql + $sqlFields.TrimEnd(",") + ")" + $sqlValues.TrimEnd(",") 
    #$sql = $sql + " where not exists (select * from TCONO where FDateCreatedDate = '"+  $DataCreateDate +"')   "  #+ $lines.length 
    return $sql
}

function BackupCoNo()
{
    $backupFolder = $CurrentDir+'\'+'BackupCONO'
    New-Item   $backupFolder -type directory -force 
    $backupCoNoFile = $backupFolder +'\'+(Get-Item $CONOFile).LastWriteTime.ToString("yyyyMMddHHmmss")+'.txt'
    copy $CONOFile   $backupCoNoFile
}
cls 
	
$CurrentDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
  
$FileCreatedDate= (Get-Item $CONOFile).LastWriteTime.ToString("yyyy/MM/dd HH:mm:ss") #LastWriteTime.toString()
BackupCoNo 
$lines =Get-Content $CONOFile


$SqlQuery="select  Start-1  as Start,Digits,FFieldName from TRainbowDataFormat where FFileType ='CO_Format'"
$DataSet =QuerySQL($SqlQuery )

$FieldsValue= @{"Washington" = "Olympia"}

$removedExisting =$True
$date = Get-Date  
$format ='yyyyMMdd'
write-host $date.ToString($format)
 
 #
foreach ($line in $lines)
{   
    $DataCreateDate = $line.Substring(202, 8) 
    
     if ($DataCreateDate  -ne $date.ToString($format))
     {    
        # continue
     }
     if ( $removedExisting   )
     {
        QuerySQL(getDeleteSQL($DataCreateDate))
        $removedExisting =$False
     }
    $FieldsValue.Clear()
    ForEach ($row in $DataSet.Tables[0].Rows) 
    { 
        $FieldsValue.Add($row.FFieldName,  $line.Substring($row.Start, $row.Digits)   ) 
    }
    # write-host `n
    $FieldsValue.Add("FFileCreatedDate", $FileCreatedDate)
    
    $sql=  getSQL($FieldsValue)
    $sql= $sql + " where not exists (select * from TCono where  FDataCreatedDate = '"+  $DataCreateDate +"' )"
    write-host $sql
    QuerySQL($sql)
}


 #  $sql="Pr_ImportCONO null"
 #  $rlt= QuerySQL($sql)
#