unit splash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, jpeg, StdCtrls,inifiles,shellapi, IdBaseComponent, IdComponent,  ADODB,   
  IdTCPConnection, IdTCPClient, IdFTP, Sockets, WinSock, IdHTTP,NB30,UPublic,unitPublicFunction;

type
  TClientData = packed record
    Id: Integer;
    SetupDateTime: TDateTime;
    Encyption: TDateTime;
  end;
  TsplashFrm = class(TForm)
    Image1: TImage;
    HintLabel1: TLabel;
    CancelLabel1: TLabel;
    Label1: TLabel;
    IdHTTP1: TIdHTTP;
    xLabel1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ShowHint(Str:String='');
    procedure WantConnStr(AReqCmd:string='1';ATurn:boolean=True);
    function  SetConnection:Boolean;
    procedure CancelLabel1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HintLabel1DblClick(Sender: TObject);
    function GetRemoteConnStr:widestring;
    function ConnectbyRawIP(AdoCnn:TADOConnection;rawIP:string):String;
    procedure xLabel1DblClick(Sender: TObject);

  private
    fCancel:Boolean;
    fReqCmd:string;
  public
    { Public declarations }
    cAddr1    :string;
    cStation  :string;
    cStationRit:string;

  end;

const
  cRegFile='\winsys32.dll';
var
  SplashFrm:TSplashFrm;
  
implementation
uses datamodule, desktop;
{$R *.DFM}
function GetClientDataFile: string;
  function GetSysDir:string;
  begin  {
    setlength(result,48);
    result:='                                                 ';
    getsystemdirectory(pchar(result),48);
    result:=trim(result);   }
    result:='C:\Program Files';
  end;

begin
  Result:=GetSysDir+cRegFile;
end;

function get_ComputerName:string;
var ch:array[0..127]of char;
sz:dword;
begin
sz := sizeof(ch);
getComputerName(ch,sz);
result := ch;
end;
procedure WriteClientData(id: Integer);
const
  s = 'dfsdfsdkjfksdjfkds9348403924dfjdsf';
var
  ARegFile:file of TClientData;
  a: TClientData;
begin
  AssignFile(ARegFile,GetClientDataFile);
  ReWrite(ARegFile);
  try
    a.Id :=id;
    a.SetupDateTime := now;
    a.Encyption := now+51;
    Write(ARegFile,a);
  finally
    CloseFile(ARegFile);
  end;
end;

function GetClientData: TclientData;
var
  ARegFile:file of TclientData;
  f: string;
begin
  Result.Id := -1;
  f := GetClientDataFile;
    if FileExists(f) then
    begin
          AssignFile(ARegFile,f);
          try
              ReSet(ARegFile);
              try
                if not Eof(ARegFile) then
                  Read(ARegFile,Result);
              except
                //Result:=False;
              end;
          finally
            CloseFile(ARegFile);
          end;
  end;
end;

Procedure  SetClientData(Id:string);
var
  ARegFile:file of TclientData;
  FileName: string;

  F:Textfile;

begin
  try
    FileName:= GetClientDataFile;
    AssignFile(F, FileName);
    ReWrite(F);
    Writeln(F, Id);
    Closefile(F);
  except      {
      FileName:=cRegFile ;
      AssignFile(F, FileName);
      ReWrite(F);
      Writeln(F, Id);
      Closefile(F);}
  end;

end;
procedure GetMacID(var MacID: PChar);
var LanaEnum: PLanaEnum;
    Adapter: PAdapterStatus;
    RetCode: Char;
    NCB: PNCB;
    i: integer;
begin
  NCB := AllocMem(SizeOf(TNCB));
  Adapter := AllocMem(SizeOf(TAdapterStatus));
  LanaEnum := AllocMem(SizeOf(TLanaEnum));
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Fillchar(NCB^, SizeOf(TNCB), 0);
  Fillchar(Adapter^, SizeOf(TAdapterStatus), 0);
  Fillchar(LanaEnum^, SizeOf(TLanaEnum), 0);
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  LanaEnum.Length := chr(0);
  NCB.ncb_command := chr(NCBENUM);
  NCB.ncb_buffer  := Pointer(LanaEnum);
  NCB.ncb_length  := SizeOf(LanaEnum);
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  i := 0;
  repeat
    Fillchar(NCB^, SizeOf(TNCB), 0);
    NCB.ncb_command  := chr(NCBRESET);
    NCB.ncb_lana_num := LanaEnum.lana[I];
    Netbios(NCB);
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Fillchar(NCB^, SizeOf(TNCB), 0);
    NCB.ncb_command  := chr(NCBASTAT);
    NCB.ncb_lana_num := LanaEnum.lana[I];
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //必须是16位****************************************************************
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    NCB.ncb_callname := '*               ';
    NCB.ncb_buffer   := Pointer(Adapter);
    NCB.ncb_length   := SizeOf(TAdapterStatus);
    RetCode          := Netbios(NCB);
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //---- calc MacID from mac-address[2-5] XOR mac-address[1]...***************
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    if (RetCode=chr(0)) or (RetCode=chr(6))
    then lstrcpy(MacID, PChar(IntToHex(Ord(Adapter.adapter_address[0]), 2) + '-' +
                              IntToHex(Ord(Adapter.adapter_address[1]), 2) + '-' +
                              IntToHex(Ord(Adapter.adapter_address[2]), 2) + '-' +
                              IntToHex(Ord(Adapter.adapter_address[3]), 2) + '-' +
                              IntToHex(Ord(Adapter.adapter_address[4]), 2) + '-' +
                              IntToHex(Ord(Adapter.adapter_address[5]), 2)));
    Inc(i);
  until (i>=Ord(LanaEnum.Length)) or (MacID<>'00-00-00-00-00-00');
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  FreeMem(LanaEnum);
  FreeMem(Adapter);
  FreeMem(NCB);
end;  

function GetAdapterInfo(Adapter_num: Char; var AMac_Addr: string): Boolean;
type
  TStat = record
    Adapt: TAdapterStatus;
    Name_Buffer: TNameBuffer;
  end;
var
  P: PNCB;
  Adapter: TStat;
  Temp: Char;
begin
  New(P);
  try
  // 重置网卡，以便我们可以查询
    FillChar(P^, SizeOf(TNcb), #0);
    P^.ncb_command := Chr(NCBRESET);
    P^.ncb_lana_num := adapter_num;
    Temp := Netbios(P);
    if Temp <> Chr(NRC_GOODRET) then
    begin
      AMac_Addr := 'bad (NCBRESET): ' + P^.Ncb_retcode;
      Result := False;
      Exit;
    end;
    FillChar(P^, SizeOf(TNcb), #0);
    P^.ncb_command := Chr(NCBASTAT);
    P^.ncb_lana_num := Adapter_num;
    P^.ncb_callname := '*';
    FillChar(Adapter, SizeOf(TStat), #0);
    P^.ncb_buffer := @Adapter;
    P^.ncb_length := Sizeof(Adapter);
  // 取得网卡的信息，并且如果网卡正常工作的话，返回标准的冒号分隔格式。
    Temp := Netbios(P);
    if Temp = #0 then
    begin
      AMac_Addr := Format('%0.2x:%0.2x:%0.2x:%0.2x:%0.2x:%0.2x', [Ord(Adapter.adapt.adapter_address[0]),
        Ord(Adapter.adapt.adapter_address[1]), Ord(Adapter.adapt.adapter_address[2]),
          Ord(Adapter.adapt.adapter_address[3]), Ord(Adapter.adapt.adapter_address[4]),
          Ord(Adapter.adapt.adapter_address[5])]);
    end;
  finally
    Dispose(P);
  end;
  Result := True;
end;

function GetCpuId:string;
var
  temp:longint;
begin
  asm
    PUSH    EBX
    PUSH    EDI
    MOV     EDI,EAX
    MOV     EAX,1
    DW      $A20F
    MOV     TEMP,EDX
    POP     EDI
    POP     EBX
  end;
  result:=inttostr(temp);
end; 

type
  TCPUID = array[1..4] of Longint;

function kbGetCpuID(var CPUID : string):Boolean;
var
   CPUIDinfo : TCPUID;
function IsCPUID_Available : Boolean;
asm
  PUSHFD       {direct access to flags no possible, only via stack}
  POP     EAX     {flags to EAX}
  MOV     EDX,EAX   {save current flags}
  XOR     EAX,$200000; {not ID bit}
  PUSH    EAX     {onto stack}
  POPFD        {from stack to flags, with not ID bit}
  PUSHFD       {back to stack}
  POP     EAX     {get back to EAX}
  XOR     EAX,EDX   {check if ID bit affected}
  JZ      @exit    {no, CPUID not availavle}
  MOV     AL,True   {Result=True}
  @exit:
end;

function GetCPUIDSN : TCPUID; assembler;
asm
  PUSH    EBX         {Save affected register}
  PUSH    EDI
  MOV     EDI,EAX     {@Resukt}
  MOV     EAX,1
  DW      $A20F       {CPUID Command}
  STOSD             {CPUID[1]}
  MOV     EAX,EBX
  STOSD               {CPUID[2]}
  MOV     EAX,ECX
  STOSD               {CPUID[3]}
  MOV     EAX,EDX
  STOSD               {CPUID[4]}
  POP     EDI     {Restore registers}
  POP     EBX
end;
begin
    if IsCPUID_Available then
       begin
         CPUIDinfo:=GetCPUIDSN;
         Result := True;
       end
    else begin       //早期cpu无ID
       CPUIDinfo[1] := 0136;
       CPUIDinfo[4] := 66263155;
       Result := False;
    end;
    CPUID:=IntToHex((CPUIDinfo[1]+CPUIDinfo[2]+CPUIDinfo[3]+CPUIDinfo[4]),8);
end;


function GetMAC:string;
begin
 result:=GetAdapterInformation;
 // if kbGetCpuID(result) then
 //Result := inttostr(GetClientData.Id);
end;
function GetClientDataId:string;
begin

 Result := inttostr(GetClientData.Id);
end;
Function GetMacAddress (nIndex:Integer = 1; strFlag:string = ':') : String;
Var
  NCB : TNCB; // Netbios control block //NetBios控制块
  ADAPTER : TADAPTERSTATUS; // Netbios adapter status//取网卡状态
  LANAENUM : TLANAENUM; // Netbios lana
  intIdx : Integer; // Temporary work value//临时变量
  cRC : Char; // Netbios return code//NetBios返回值
  strTemp : String; // Temporary string//临时变量

Begin
  Result := '';
  try
    ZeroMemory(@NCB, SizeOf(NCB));
    NCB.ncb_command := Chr(NCBENUM);
    cRC := NetBios(@NCB);
    NCB.ncb_buffer := @LANAENUM;
    NCB.ncb_length := SizeOf(LANAENUM);
    cRC := NetBios(@NCB);
    If Ord(cRC)<>0 Then
      exit;
    ZeroMemory(@NCB, SizeOf(NCB));
    NCB.ncb_command := Chr(NCBRESET);
    NCB.ncb_lana_num := LANAENUM.lana[nIndex];
    cRC := NetBios(@NCB);
    If Ord(cRC)<>0 Then
      exit;
    ZeroMemory(@NCB, SizeOf(NCB));
    NCB.ncb_command := Chr(NCBASTAT);
    NCB.ncb_lana_num := LANAENUM.lana[nIndex];
    StrPCopy(NCB.ncb_callname, '*');
    NCB.ncb_buffer := @ADAPTER;
    NCB.ncb_length := SizeOf(ADAPTER);
    cRC := NetBios(@NCB);
    strTemp := InttoHex(Integer(ADAPTER.adapter_address[0]),2);
    For intIdx := 1 To 5 Do
      strTemp := strTemp +strFlag+ InttoHex(Integer(ADAPTER.adapter_address[intIdx]),2);
  except
    strTemp := '';
  end;
  Result := strTemp;
End;


function TsplashFrm.ConnectbyRawIP(AdoCnn:TADOConnection;rawIP:string): String;

begin

    try

       AdoCnn.properties['data source'].value := rawIP; 
       AdoCnn.Connected:=true;

       result:= AdoCnn.ConnectionString;
    finally
    end;

end;

function TsplashFrm.GetRemoteConnStr:widestring;
var
  a:TMemoryStream;
  fConnStr:string;
  rawip:widestring;
  inif:TIniFile;
  i:integer;
  AdoCnn:TADOConnection;
  objIdHttp:TIdHttp;
  teststr:string;
begin
    inif:=TIniFile.Create(ExtractFileDir(Application.ExeName)+'\Config.ini');
    AdoCnn:=TADOConnection.Create (nil);
    AdoCnn.CommandTimeout :=1;
try
    //showmessage('begin GetRemoteConnStr');

    for i:=1 to 1 do
    begin
      try
        objIdHttp :=TIdHttp.Create(nil);
        cStation:=inif.ReadString('FTP'+inttostr(i),'FTPFileName','');
        cStation:=  FhlKnl1.St_encrypt_Chy(cStation);
        if (cStation<> '')  then
        begin
            try
              fConnStr:=objIdHttp.Get(cStation)   ;
              AdoCnn.LoginPrompt :=false;
              AdoCnn.Connected:=False;

             // teststr:= 'OYijpMhi72MiEHtRp/8tY00vlgz3Fn83V+FvLKtDY+QDC4Q0YUfihKm0jQaVHmMe6LBXbZa4qJh7RtpB6fYIBP5T7m/psxUnIMnNNbbgUaKETv+LlV4x+ZdbU4QCIdPUS+5xTpXRhAcxJQVVWTER29HbVaXozqLCdwyHO3TBlCI=';
              // teststr:='DHOnT2u6PaQ=';
               //FhlKnl1.st_DesDecrypt(teststr);

              AdoCnn.ConnectionString :=FhlKnl1.st_DesDecrypt(fConnStr);
             // showmessage(fConnStr);
              FhlKnl1.Kl_SetReg4Mssql(AdoCnn.ConnectionString);

              cStation:=inif.ReadString('FTP'+inttostr(i),'FTPFileNameRaw','');
              if cStation<>'' then
              begin
                cStation:=  FhlKnl1.St_encrypt_Chy(cStation);
                rawIP:=objIdHttp.Get(cStation)   ;
                rawIp:= stringreplace(stringreplace(rawIP,#$D,'',[]),#$A,'',[]);
              end;
              
              if pos( AdoCnn.ConnectionString ,'Provider')>=0 then
              AdoCnn.Connected:=true;
              if AdoCnn.Connected then
              break;
            except
              //on err:exception do
              begin
                 AdoCnn.properties['data source'].value := rawIP;
                  //  AdoCnn.ConnectionString := ConnectbyRawIP(AdoCnn ,rawIP) ;

                //showmessage(err.Message );
                fConnStr:='';
              end;
            end;
        end;
      finally
         objIdHttp.Free;
      end;
    end;
    Result:=AdoCnn.ConnectionString;
finally
    freeandnil(AdoCnn);
end;

end;

procedure TsplashFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TsplashFrm.WantConnStr(AReqCmd:string='1';ATurn:boolean=True);
var
  f:Tinifile;
//  b:boolean;
//  i,j,r:integer;
  j:integer;
  fhost,fReqForm,fReqTable:string;
begin
j:=0;
  LoginInfo.LastReceiveStr:='';
  fReqForm:=format('%s,%s,%s',[FhlKnl1.Os_GetComputerName,desktopfrm.TcpServer1.LocalPort,'%s']);
  //连接中间件
  ShowHint();
  f:=TiniFile.Create(ExtractFileDir(Application.ExeName)+'\cfg.ini');
  fhost:=f.ReadString('Client','ServerName','');
  with desktopFrm.TcpClient1 do
  begin
    Disconnect;
    RemoteHost:=fhost;
//    b:=Connect;
//    while not b do
//    begin
//      if fCancel then
//      exit;
{      Sleep(500);
      if InputQuery('确定','连接失败,我要尝试以下主机:',fhost) then
        RemoteHost:=fhost
      else
        exit;
      Application.ProcessMessages;
      b:=Connect;
}
//    end;
  end;
  f.WriteString('Client','ServerName',fhost);
  f.Free;
  //获取连接字串
  if ATurn and (fReqCmd<>'') then
      with desktopFrm.TcpClient1 do
      begin
        fReqTable:=format(fReqForm,[fReqCmd]);
//        repeat
//          j:=Sendln(fReqTable);
        while (Sendln(fReqTable)<>-1) do
        begin
          Inc(j);
          if j>8 then exit;
          Sleep(500);
          Application.ProcessMessages;
        end;
        Disconnect;
      end;
//  {
    //
    ShowHint();
    fReqTable:=format(fReqForm,[AReqCmd]);
//    Sleep(500);
    with desktopFrm.TcpClient1 do
    begin
      if Not Connected then  Connect;
      repeat
        if fCancel then exit;
//        Sleep(500);
        j:=Sendln(fReqTable);
        ShowHint;
        Application.ProcessMessages;
      until j<>-1;
      Disconnect;
    end;
//    }
  //
  ShowHint();
  j:=0;
  while LoginInfo.LastReceiveStr='' do
  begin
    Inc(j);
    if fCancel or (j>28) then exit;
    Sleep(500);
    ShowHint();
    Application.ProcessMessages;
  end;
end;

function TsplashFrm.SetConnection:boolean;
var
  mac,id ,ip,ComputerName,ServerIP:string;
  i,st,ed:integer;
  ServerName,PassWord:string;
  IniLoadLocal:string;
  inif:TIniFile ;
  CnnDataSource:string ;
begin

      inif:=TIniFile.Create(ExtractFileDir(Application.ExeName)+'\Config.ini');
      LoginInfo.SysDBPubName  := inif.ReadString('DBConn','SYSPUBDataBase','');
      LoginInfo.SysDBToolName := inif.ReadString('DBConn','ToolDataBase','')   ;
      LoginInfo.IsDev         := inif.ReadBool('Config','IsDev',false)   ;
      LoginInfo.IP            := inif.ReadString('Config','IP','')   ;
      IniLoadLocal:= inif.ReadString('DBConn','LoadLocal','')   ;
      inif.Free ;

    if   IniLoadLocal='0' then
    begin

        Result:=False;// 
        Result:=LoginInfo.LastReceiveStr<>'';

        id:= GetClientDataId;
        ip:='';
        ip:=LocalIP;
        mac:=GetMac;//Address   cpuid ;


        logininfo.IsLocalServer :=false;
        LoginInfo.LastReceiveStr:= GetRemoteConnStr ;

        st:=pos('Data Source',LoginInfo.LastReceiveStr)+length('Data Source')+1;
        ed:=pos('Use Procedure for Prepare',LoginInfo.LastReceiveStr)-1;

        CnnDataSource:=copy(LoginInfo.LastReceiveStr, st ,ed-st);
        ServerIP:= GetIPByName( CnnDataSource) ;
        ShowHint('正在载入程序,请稍候...');

        LoginInfo.LastReceiveStr:= stringreplace(   LoginInfo.LastReceiveStr ,  CnnDataSource,ServerIP ,[rfReplaceAll] );

        //showmessage(LoginInfo.LastReceiveStr);

        Result:=dmFrm.ConnectServer(LoginInfo.LastReceiveStr);// and kbGetCpuID(mac);

        if Result  then   //remote
        begin
            IF   LoginInfo.SysDBPubName <>'' THEN
                FHLKNL1.Connection.DefaultDatabase :=  LoginInfo.SysDBPubName
            else
            begin
               showmessage('缺少配置文件 Config.ini');
               application.Terminate ;
            end;
            if id='-1' then
            begin
                FhlKnl1.Kl_GetQuery2('select max(id)+1 as id from sys_client  ' );
                with FhlKnl1.FreeQuery do
                begin
                    id:=  FieldByName('id').AsString;
                end;
                SetClientData(id);
            end;
            FhlKnl1.Kl_GetQuery2('select * from sys_client where mac ='+quotedstr(mac)+' and id='+quotedstr(id),true,true);
            //HDSerialNum='+quotedstr(HDSerialNumRead)+'

            with FhlKnl1.FreeQuery do
            begin
                if IsEmpty then
                begin
                    Append;
                    FieldByName('ip').AsString:=ip;
                    FieldByName('MAC').AsString:=mac;
                    FieldByName('ComputerName').AsString:=FhlKnl1.Os_GetComputerName;
                    FieldByName('Permit').AsBoolean:=False;
                    FieldByName('Version').AsString:=JbGetversion;
                    FieldByName('HDSerialNum').AsString:=HDSerialNumRead;
                    FieldByName('ProcessID').AsInteger := GetProcessID('jingbei.exe');
                    Post;
                    WriteClientData(FieldByName('Id').AsInteger);
                end
                else
                begin
                    edit;
                    // FieldByName('Permit').AsBoolean:=true;
                    FieldByName('MAC').AsString:=mac;    //update cpuid
                    FieldByName('ip').AsString:=ip;
                    FieldByName('Version').AsString:=JbGetversion;
                    FieldByName('HDSerialNum').AsString:=HDSerialNumRead;
                    FieldByName('ProcessID').AsInteger := GetProcessID('jingbei.exe');
                    Post;
                end;

              if (not FieldByName('Permit').AsBoolean) then
              begin
              //give you time to click xlable and cheat
              i:=0;
              repeat
                inc(i);
                application.ProcessMessages;
                sleep(100);
              until i>5;
                if xlabel1.tag=0 then
                Result:=False;
              end;
            end;
        end;
    end;
   ServerName:=get_ComputerName ;
   if   IniLoadLocal='1' then
    // if   uppercase(ServerName)='CHYPC2' then
     begin
          ServerName:=get_ComputerName+'' ;//Local InputBox('Input Box', 'Prompt',get_ComputerName)
          PassWord:='Jbdata1';

          LoginInfo.SysDBPubName  :='jingbeisysPub';
          LoginInfo.SysDBToolName :='cxsysTool';
          application.Title :=application.Title +'   '+ ServerName +'  本地数据库 ';
          sleep(1000);
           LoginInfo.LastReceiveStr:=format('Provider=SQLOLEDB.1;'+
          'Persist Security Info=False;'+
          'User ID=%s;'+
          'Password=%s;'+
          'Initial Catalog=%s;'+
          'Data Source=%s;'+
          'Use Procedure for Prepare=1;'+
          'Auto Translate=True;'+
          'Packet Size=4096;'+
          'Workstation ID=xts4;'+
          'Use Encryption for Data=False;'+
          'Tag with column collation when possible=False', //  FhlKnl1.Os_GetComputerName
          ['sa',PassWord,LoginInfo.SysDBPubName ,ServerName]);           // jingbeisys_06_06_23_test

          logininfo.IsLocalServer :=true;
          Result:=dmFrm.ConnectServer(LoginInfo.LastReceiveStr);
    end ;
    { 

          ServerName:='jb99999.xicp.net' ;//Local InputBox('Input Box', 'Prompt',get_ComputerName)
          PassWord:='';

          LoginInfo.SysDBPubName  :='jingbeisysPub';
          LoginInfo.SysDBToolName :='cxsysTool';

           LoginInfo.LastReceiveStr:=format('Provider=SQLOLEDB.1;'+
          'Persist Security Info=False;'+
          'User ID=%s;'+
          'Password=%s;'+
          'Initial Catalog=%s;'+
          'Data Source=%s;'+
          'Use Procedure for Prepare=1;'+
          'Auto Translate=True;'+
          'Packet Size=4096;'+
          'Workstation ID=xts4;'+
          'Use Encryption for Data=False;'+
          'Tag with column collation when possible=False', //  FhlKnl1.Os_GetComputerName
          ['sa',PassWord,LoginInfo.SysDBPubName ,ServerName]);           // jingbeisys_06_06_23_test
         // IniLoadLocal:='2'  ;
          if   IniLoadLocal='2' then
          begin
                ///application.Title :=application.Title +'   '+ ServerName +'  本地数据库 ';
                sleep(1000);
                logininfo.IsLocalServer :=true;
                Result:=dmFrm.ConnectServer(LoginInfo.LastReceiveStr);
          end ;
        }
  SplashFrm.Close;


end;


procedure TsplashFrm.ShowHint(Str:String);
var
  s:string;
begin
 if Str<>'' then
   HintLabel1.Caption:=Str
 else begin
   s:=HintLabel1.Caption;
   if copy(s,length(s)-6,6)='......' then
     s:=copy(s,1,length(s)-6);
   HintLabel1.Caption:=s+'.'
 end;
 HintLabel1.Update;
end;

procedure TsplashFrm.CancelLabel1Click(Sender: TObject);
begin
  fCancel:=True;
end;

procedure TsplashFrm.FormCreate(Sender: TObject);
begin



  fReqCmd:=''; 
end;

procedure TsplashFrm.HintLabel1DblClick(Sender: TObject);
begin
  fReqCmd:='0';
end;

procedure TsplashFrm.xLabel1DblClick(Sender: TObject);
begin
tlabel(sender).tag:=1;
end;

end.




