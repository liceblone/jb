unit UnitPublicFunction;

interface
   uses
  Windows,SysUtils,Classes,WinSock,ActiveX,controls,shellapi ,TLHelp32;
  
  Function  GetHZPY(HZstr: String):String;     //�������ַ����еĺ��ֻ���ƴ������ĸ����д��
  function  GetPYIndexChar(hzchar: string):char; //��һ������ת����ƴ������ĸ����д��
  function  ChySetLocalTime(time:TSYSTEMTIME):boolean;
  function  GetAdapterInformation():string;
  procedure SetDelimitedText(const Value: string;DesStringlist:Tstringlist);
  function MaxContolTop(control:Tcontrol):integer;
Const
 MAX_ADAPTER_NAME_LENGTH        = 256;
 MAX_ADAPTER_DESCRIPTION_LENGTH = 128;
 MAX_ADAPTER_ADDRESS_LENGTH     = 8;

type
  PIPAdapterInfo = ^TIPAdapterInfo;
  TIPAdapterInfo = Record   // IP_ADAPTER_INFO

  Next                : PIPAdapterInfo;
  ComboIndex          : Integer;
  AdapterName         : Array[0..MAX_ADAPTER_NAME_LENGTH+3] of Char;
  Description         : Array[0..MAX_ADAPTER_DESCRIPTION_LENGTH+3] of Char;
  AddressLength       : Integer;
  Address             : Array[1..MAX_ADAPTER_ADDRESS_LENGTH] of Byte;
End;
  function JBGetVersion: string;
  function GetProcessID(TargetProcessName: string): integer;
  function HDSerialNumRead: PChar;
  function GetIPByName(AName:   String):   string;
  function GetGUID:string;
  function getFileTree(const filepath:string ; const filenamefilter:string):TStringlist;
  procedure DeleteFolder(DirName: TFileName);
  procedure DeleteBakFile(MyPath,MyFile:string;Days:integer);
  
implementation

Function GetAdaptersInfo(AI : PIPAdapterInfo; Var BufLen : Integer) : Integer; 
        StdCall; External 'iphlpapi.dll' Name 'GetAdaptersInfo';

//�˺���Ϊ���ĺ��� 
function  GetAdapterInformation():string;
Var 
 AI,Work : PIPAdapterInfo; 
 Size    : Integer; 
 Res     : Integer; 
 I       : Integer; 

 Function MACToStr(ByteArr : PByte; Len : Integer) : String; 
 Begin 
   Result := ''; 
   While (Len > 0) do Begin
     Result := Result+IntToHex(ByteArr^,2)+'-';
     ByteArr := Pointer(Integer(ByteArr)+SizeOf(Byte)); 
     Dec(Len); 
   End; 
   SetLength(Result,Length(Result)-1); { remove last dash } 
 End; 

begin 
 Size := 5120; 
 GetMem(AI,Size); 
 Res := GetAdaptersInfo(AI,Size); 
 If (Res <> ERROR_SUCCESS) Then Begin 
   SetLastError(Res); 
   RaiseLastWin32Error; 
 End; 
  Begin 
   Work := AI; 
   I := 1; 
   Repeat 
     GetAdapterInformation:=MACToStr(@Work^.Address,Work^.AddressLength); 
     //����Ĵ����ǽ�������ַ�͸����ڵı��� 
     Inc(I); 
     Work := Work^.Next; 
   Until (Work = nil); 
 End; 
 FreeMem(AI); 
end;      //�˺���Ϊ���ĺ���



function  ChySetLocalTime(time:TSYSTEMTIME):boolean;
begin
    {
    time.wYear :=2006;
    time.wMonth :=12;
    time.wDay :=1   ;
    time.wHour :=9;
    time.wMinute :=50;
    time.wSecond :=20;
     }
    try
        SetLocalTime (time);
        result:=true;
    except
        result:=false;
    end

end;
Function GetHZPY(HZstr: String):String;
Var
  lcPY,lcHZ:String;
  i:integer;
  Strchar:   array   of   Char;
begin
  lcHZ:='';
  SetLength(Strchar, Length(HZstr));
  Move(HZstr[1],   Strchar[0],   Length(HZstr));
  for i:=1 to length(HZstr) do
  begin
    if (lcHZ='') and (ord(Strchar[i-1])<128) then  //�Ǻ���
    begin
      lcPy:=lcPy+Strchar[i-1];
      Continue;
    end
    else
    begin
      if lcHZ='' then
      begin
        lcHZ:=Strchar[i-1];     //���ֵ�һ���ֽڵİ������
        Continue;
      end;
      begin
         lchz:= lchz+Strchar[i-1]; //�������ֽڰ�����ֺϲ���һ������
         lcPy:= lcPY+ GetPYIndexChar(lcHZ);
      end;
    end;
    lcHZ:='';
  end;
  Result:=lcPy;
end;



function   GetPYIndexChar(hzchar:   string):   char;
begin
    case   Word(hzchar[1])   shl   8   +   Word(hzchar[2])   of
              $B0A1..$B0C4:   result   :=   'A';     
              $B0C5..$B2C0:   result   :=   'B';     
              $B2C1..$B4ED:   result   :=   'C';
              $B4EE..$B6E9:   result   :=   'D';
              $B6EA..$B7A1:   result   :=   'E';
              $B7A2..$B8C0:   result   :=   'F';
              $B8C1..$B9FD:   result   :=   'G';
              $B9FE..$BBF6:   result   :=   'H';
              $BBF7..$BFA5:   result   :=   'J';
              $BFA6..$C0AB:   result   :=   'K';
              $C0AC..$C2E7:   result   :=   'L';
              $C2E8..$C4C2:   result   :=   'M';
              $C4C3..$C5B5:   result   :=   'N';
              $C5B6..$C5BD:   result   :=   'O';
              $C5BE..$C6D9:   result   :=   'P';
              $C6DA..$C8BA:   result   :=   'Q';
              $C8BB..$C8F5:   result   :=   'R';
              $C8F6..$CBF9:   result   :=   'S';
              $CBFA..$CDD9:   result   :=   'T';
              $CDDA..$CEF3:   result   :=   'W';
              $CEF4..$D188:   result   :=   'X';
              $D1B9..$D4D0:   result   :=   'Y';
              $D4D1..$D7F9:   result   :=   'Z';
          else
              result   :=   char(0);
          end;
end;

 procedure SetDelimitedText(const Value: string;DesStringlist:Tstringlist);
var
  P, P1: PChar;
  S: string;
  Delimiter,QuoteChar:char;
begin
     Delimiter := ',';
  QuoteChar := '"';
  { SetDelimitedText(Value);}

  try
    P := PChar(Value);
    while P^ in [#1..' '] do
    {$IFDEF MSWINDOWS}
      P := CharNext(P);
    {$ELSE}
      Inc(P);
    {$ENDIF}
    while P^ <> #0 do
    begin
      if P^ = QuoteChar then
        S := AnsiExtractQuotedStr(P, QuoteChar)
      else
      begin
        P1 := P;
        while (P^ >= ' ') and (P^ <> Delimiter) do
        {$IFDEF MSWINDOWS}
          P := CharNext(P);
        {$ELSE}
          Inc(P);
        {$ENDIF}
        SetString(S, P1, P - P1);
      end;
      DesStringlist.Add(trim(S));
      while P^ in [#1..' '] do
      {$IFDEF MSWINDOWS}
        P := CharNext(P);
      {$ELSE}
        Inc(P);
      {$ENDIF}
      if P^ = Delimiter then
      begin
        P1 := P;
        {$IFDEF MSWINDOWS}
        if CharNext(P1)^ = #0 then
        {$ELSE}
        Inc(P1);
        if P1^ = #0 then
        {$ENDIF}
          DesStringlist.Add('');
        repeat
          {$IFDEF MSWINDOWS}
          P := CharNext(P);
          {$ELSE}
          Inc(P);
          {$ENDIF}
        until not (P^ in [#1..' ']);
      end;
    end;
  finally
  end;
end;





function GetProcessID(TargetProcessName: string): integer;
var  ProcessName:string;
ProcessID : integer; //���̱�ʾ��
i : integer; 
ContinueLoop:BOOL;
FSnapshotHandle:THandle; //���̿��վ��
FProcessEntry32:TProcessEntry32; //������ڵĽṹ����Ϣ
begin
    result:=-1;
    FSnapshotHandle:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0); //����һ�����̿���
    FProcessEntry32.dwSize:=Sizeof(FProcessEntry32);
    ContinueLoop:=Process32First(FSnapshotHandle,FProcessEntry32); //�õ�ϵͳ�е�һ������
    //ѭ������
    while ContinueLoop do
    begin

        ProcessName := FProcessEntry32.szExeFile;
        ProcessID := FProcessEntry32.th32ProcessID;
        if ProcessName= TargetProcessName then
        begin
       
        result :=  ProcessID ;
        break;
    end
    else
        ContinueLoop:=Process32Next(FSnapshotHandle,FProcessEntry32);


    end;
end;

function   JBGetVersion: string;
  var
      VerInfoSize:   DWORD;   
      VerInfo:   Pointer;   
      VerValueSize:   DWORD;   
      VerValue:   PVSFixedFileInfo;   
      Dummy:   DWORD;
      dwProductVersionMS,dwProductVersionLS:DWORD;   
      sTemp,FName:   String;   
  begin   
      FName   :=   ParamStr(0);   
      VerInfoSize   :=   GetFileVersionInfoSize(PChar(FName),   Dummy);   
      GetMem(VerInfo,   VerInfoSize);   
      GetFileVersionInfo(PChar(ParamStr(0)),   0,   VerInfoSize,   VerInfo);   
      VerQueryValue(VerInfo,   '\',   Pointer(VerValue),   VerValueSize);   
      with   VerValue^   do
      begin   
          dwProductVersionMS   :=   dwFileVersionMS;   
          dwProductVersionLS   :=   dwFileVersionLS;   
    
          sTemp   :=Format('%d.%d.%d.%d',   [   
              dwProductVersionMS   shr   16,   
              dwProductVersionMS   and   $FFFF,   
              dwProductVersionLS   shr   16,   
              dwProductVersionLS   and   $FFFF   
              ]);   
      end;   
    //  ShowMessage(sTemp);
    
      FreeMem(VerInfo,   VerInfoSize);
    result:= sTemp;
end;


function HDSerialNumRead: PChar;
const
  IDENTIFY_BUFFER_SIZE = 512;
type
  TIDERegs = packed record
     bFeaturesReg: BYTE; // Used for specifying SMART "commands".
     bSectorCountReg: BYTE; // IDE sector count register
     bSectorNumberReg: BYTE; // IDE sector number register
     bCylLowReg: BYTE; // IDE low order cylinder value
     bCylHighReg: BYTE; // IDE high order cylinder value
     bDriveHeadReg: BYTE; // IDE drive/head register
     bCommandReg: BYTE; // Actual IDE command.
     bReserved: BYTE; // reserved for future use. Must be zero.
  end;

  TSendCmdInParams = packed record
    // Buffer size in bytes
    cBufferSize: DWORD;
    // Structure with drive register values.
    irDriveRegs: TIDERegs;
    // Physical drive number to send command to (0,1,2,3).
    bDriveNumber: BYTE;
    bReserved: array[0..2] of Byte;
    dwReserved: array[0..3] of DWORD;
    bBuffer: array[0..0] of Byte; // Input buffer.
  end;

  TIdSector = packed record
    wGenConfig: Word;
    wNumCyls: Word;
    wReserved: Word;
    wNumHeads: Word;
    wBytesPerTrack: Word;
    wBytesPerSector: Word;
    wSectorsPerTrack: Word;
    wVendorUnique: array[0..2] of Word;
    sSerialNumber: array[0..19] of CHAR;
    wBufferType: Word;
    wBufferSize: Word;
    wECCSize: Word;
    sFirmwareRev: array[0..7] of Char;
    sModelNumber: array[0..39] of Char;
    wMoreVendorUnique: Word;
    wDoubleWordIO: Word;
    wCapabilities: Word;
    wReserved1: Word;
    wPIOTiming: Word;
    wDMATiming: Word;
    wBS: Word;
    wNumCurrentCyls: Word;
    wNumCurrentHeads: Word;
    wNumCurrentSectorsPerTrack: Word;
    ulCurrentSectorCapacity: DWORD;
    wMultSectorStuff: Word;
    ulTotalAddressableSectors: DWORD;
    wSingleWordDMA: Word;
    wMultiWordDMA: Word;
    bReserved: array[0..127] of BYTE;
  end;

  PIdSector = ^TIdSector;

  TDriverStatus = packed record
    // ���������صĴ�����룬�޴��򷵻�0
    bDriverError: Byte;
    // IDE����Ĵ��������ݣ�ֻ�е�bDriverError Ϊ SMART_IDE_ERROR ʱ��Ч
    bIDEStatus: Byte;
    bReserved: array[0..1] of Byte;
    dwReserved: array[0..1] of DWORD;
  end;

  TSendCmdOutParams = packed record
    // bBuffer�Ĵ�С
    cBufferSize: DWORD;
    // ������״̬
    DriverStatus: TDriverStatus;
    // ���ڱ�������������������ݵĻ�������ʵ�ʳ�����cBufferSize����
    bBuffer: array[0..0] of BYTE;
  end;
var
  hDevice : THandle;
  cbBytesReturned : DWORD;
  SCIP : TSendCmdInParams;
  aIdOutCmd : array[0..(SizeOf(TSendCmdOutParams) + IDENTIFY_BUFFER_SIZE - 1) - 1] of Byte;
  IdOutCmd : TSendCmdOutParams absolute aIdOutCmd;

  procedure ChangeByteOrder(var Data; Size: Integer);
  var
    ptr : PChar;
    i : Integer;
    c : Char;
  begin
    ptr := @Data;

    for I := 0 to (Size shr 1) - 1 do
    begin
      c := ptr^;
      ptr^ := (ptr + 1)^;
      (ptr + 1)^ := c;
      Inc(ptr, 2);
    end;
  end;
begin
  Result := ''; // ��������򷵻ؿմ�

  if SysUtils.Win32Platform = VER_PLATFORM_WIN32_NT then  // Windows NT, Windows 2000
  begin
    // ��ʾ! �ı����ƿ���������������������ڶ����������� '\\.\PhysicalDrive1\'
    hDevice := CreateFile('\\.\PhysicalDrive0', GENERIC_READ or GENERIC_WRITE,
                          FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
  end
  else // Version Windows 95 OSR2, Windows 98
    hDevice := CreateFile('\\.\SMARTVSD', 0, 0, nil, CREATE_NEW, 0, 0);

    if hDevice = INVALID_HANDLE_VALUE then Exit;

    try
      FillChar(SCIP, SizeOf(TSendCmdInParams) - 1, #0);
      FillChar(aIdOutCmd, SizeOf(aIdOutCmd), #0);
      cbBytesReturned := 0;

      // Set up data structures for IDENTIFY command.
      with SCIP do
      begin
        cBufferSize := IDENTIFY_BUFFER_SIZE;

        // bDriveNumber := 0;
        with irDriveRegs do
        begin
          bSectorCountReg := 1;
          bSectorNumberReg := 1;

          // if Win32Platform=VER_PLATFORM_WIN32_NT then bDriveHeadReg := $A0
          // else bDriveHeadReg := $A0 or ((bDriveNum and 1) shl 4);
          bDriveHeadReg := $A0;
          bCommandReg := $EC;
        end;
      end;

      if not DeviceIoControl(hDevice, $0007C088, @SCIP, SizeOf(TSendCmdInParams) - 1,
                            @aIdOutCmd, SizeOf(aIdOutCmd), cbBytesReturned, nil) then Exit;
    finally
      CloseHandle(hDevice);
    end;

    with PIdSector(@IdOutCmd.bBuffer)^ do
    begin
      ChangeByteOrder(sSerialNumber, SizeOf(sSerialNumber));
      (Pchar(@sSerialNumber) + SizeOf(sSerialNumber))^ := #0;

      Result := Pchar(@sSerialNumber);

      end;
end;
function   GetIPByName(AName:   String):   string;
  type   
      TaPInAddr   =   array   [0..10]   of   PInAddr;
      PaPInAddr   =   ^TaPInAddr;   
  var   
      phe:   PHostEnt;   
      pptr:   PaPInAddr;   
      Buffer:   array   [0..63]   of   char;
      I:   Integer;   
      GInitData:   TWSADATA;   
  begin   
      WSAStartup($101,   GInitData);   
      Result   :=   '';   
      StrPCopy(Buffer,   AName);   
      phe   :=   GetHostByName(buffer);   
      if   phe   =   nil   then   Exit;   
      pptr   :=   PaPInAddr(Phe^.h_addr_list);   
      I   :=   0;   
      while   pptr^[I]   <>   nil   do   
      begin   
          Result:=StrPas(inet_ntoa(pptr^[I]^));   
          Inc(I);   
      end;   
      WSACleanup;   
  end;

  function  GetGUID:string;
 var
  sGUID  : string;
  TmpGUID: TGUID;
begin
       if CoCreateGUID(TmpGUID) = S_OK then
      sGUID := GUIDToString(TmpGUID) ;

      result:=sGUID;
end;

function MaxContolTop(control:Tcontrol):integer  ;
var i, top, controlTop:integer;
begin
   top :=0;
   for i:=0 to control.ComponentCount -1  do
   begin
     if ( control  .Components[i] is Tcontrol ) then
     begin
      controlTop :=( control  .Components[i] as Tcontrol ).top+ ( control  .Components[i] as Tcontrol ).Height ;
      if top < controlTop then
          top := controlTop  ;

      end;
   end;
   result:=top+20;
end;

function getFileTree(const filepath:string ; const filenamefilter:string):TStringlist;
var
  sr:TSearchrec;
  fileName:string;
  I:integer;
begin
   result:=TStringlist.Create;
   if Findfirst( filepath+'\'+ filenamefilter ,faanyfile,sr)=0 then
   begin
     repeat
        if (sr.Name = '.') or (sr.Name='..') then continue;
        if sr.Attr = fadirectory then
        begin
          result.Add(sr.Name);
          result.AddStrings(getFileTree(filepath+'\'+sr.Name, filenamefilter )) ;
        end

        else
          result.Add(sr.Name);
     until findnext(sr) <>0;
     findclose(sr);
   end;
end;

procedure DeleteFolder(DirName: TFileName);

Var
T : TSHFileOpStruct;
P:String;
begin
  P:= DirName;//Edit1.Text;//Ŀ¼��
  With T do
  Begin
  Wnd:=0;
  wFunc:=FO_DELETE;
  pFrom:=Pchar(P);
  pTo:=nil;
  fFlags:=FOF_ALLOWUNDO+FOF_NOCONFIRMATION+FOF_NOERRORUI;//��־��������ָ�������ȷ�ϲ�����ʾ������Ϣ
  hNameMappings:=nil;
  fAnyOperationsAborted:=False;
  End;
  SHFileOperation(T);
end;

procedure DeleteBakFile(MyPath,MyFile:string;Days:integer);
var Found:integer;
    MySearchRec:TSearchRec;
    FileName:string;
begin
  FileName:=MyPath+MyFile;
  Found:=FindFirst(FileName, faAnyFile, MySearchRec);
  while Found=0 do
  begin
    if (Date-FileDateToDateTime(MySearchRec.Time))>Days then
    begin
      DeleteFile(MyPath+MySearchRec.Name);
    end;
    Found:=FindNext(MySearchRec);
  end;
  FindClose(MySearchRec);
end;
end.

