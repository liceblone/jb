
##############################################################################################################
##    set-executionpolicy remotesigned
##    get IP
##    usage: C:\Source\JBSource\瑞萨系统\PSScript\GetIp.ps1 -ExePath C:\Source\JBSource\jingbei.exe
##############################################################################################################


Param($ExePath)
cls

function GetIP()
{
    $IPList = netstat -an | findstr 7709
    $IP= $IPList[0].replace("    ",",").replace("   ",",").split(",")[2]
  #   $IPList[0].replace("    ",",").replace("   ",",").split(",")[2]
    return $IP
}

function LaunchJBEXE()
{
    $jb = $ExePath #"C:\Source\JBSource\jingbei.exe" 
    #$jb =  "C:\Source\JBSource\jingbei.exe" 
    $P = start-process $jb  #-wait

    sleep(1)
    Get-Process jingbei | Stop-Process
}
cls
LaunchJBEXE
return  GetIP
 