
cls
$Path =Split-Path -Parent $MyInvocation.MyCommand.Definition
$SQLServer = $Path+"\GetIp.ps1"  -ExePath C:\Source\JBSource\jingbei.exe   # 'jb99999.xicp.net,7709'


$ip= C:\Source\JBSource\瑞萨系统\PSScript\GetIp.ps1  -ExePath C:\Source\JBSource\jingbei.exe

echo $ip