unit UPublicFunction;


interface
  uses Classes,ZLib, Windows, Messages, SysUtils, Variants,  Graphics, Controls, Forms, DB, ADODB,
  Dialogs, StdCtrls,Jpeg , DBGrids,Excel2000,ComObj,ActiveX;

const
  UPFLAG='��';
  DOWNFLAG='��';


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
end;

type
  TStrPointer = ^string;

  Function  GetHZPY(HZstr: String):String;     //�������ַ����еĺ��ֻ���ƴ������ĸ����д��
  function  GetPYIndexChar(hzchar: string):char; //��һ������ת����ƴ������ĸ����д��
  procedure DeCompressStream(V: Tmemorystream);
  function  Isinteger(s:string):boolean;
  function  Isnumeric(s:string):boolean;
  function  BooleanToString(value:boolean):string;
  procedure SetDelimitedText(const Value: string;DesStringlist:Tstringlist); //���ַ��ַ���
  procedure ScreenCap(LeftPos,TopPos,RightPos,BottomPos:integer;Path:String);
  procedure QExportExcel(AdbGrid:TDBGrid;Fn:String;Vis:Boolean;RepeatCnt:integer=1);//zxh 08.2.18
  procedure QExportCSV(AdbGrid:TDBGrid;Fn:String );

  function  GetGUID:string;
  function  GetSysVersion :  string;
  function  GetAdapterInformation():string;

  function  WriteTxtFile( logfilename, content:string):boolean;
implementation

uses UPublicCtrl,UnitGrid;

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
procedure DeCompressStream(V: Tmemorystream);
var
  mysize: integer;
  myUNCompression: TDecompressionStream;
  temp: pchar;

begin
  mysize:=0;
  v.ReadBuffer(mysize, sizeof(mysize));
  myUNCompression := TDecompressionStream.Create(v);
  getmem(temp, mysize);
  myUNCompression.ReadBuffer(temp^, mysize);
  freeandnil(myUNCompression);
  v.Clear;

  v.WriteBuffer(temp^, mysize);
  
  freemem(temp);
end;

 function  Isinteger(s:string):boolean;
 var i:integer;
 begin
     try
        i:=strtoint(s);
        result:=true;
     except
        result:=false;
     end;
 end;
function  BooleanToString(value:boolean):string;
begin
    if   value then
       result:='1'
    else
       result:='0';
end;
 function  Isnumeric(s:string):boolean;
 var i:real;
 begin
     try
        i:=strtofloat(s);
        result:=true;
     except
        result:=false;
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
procedure  ScreenCap(LeftPos,TopPos,RightPos,BottomPos:integer;Path:String);
var
  RectWidth,RectHeight:integer;
  SourceDC,DestDC,Bhandle:integer;
  Bitmap:TBitmap;
  MyJpeg: TJpegImage;
  Stream:TMemoryStream;
begin
  MyJpeg:= TJpegImage.Create;
  RectWidth:=RightPos-LeftPos;
  RectHeight:=BottomPos-TopPos;
  SourceDC:=CreateDC('DISPLAY','','',nil);
  DestDC:=CreateCompatibleDC(SourceDC);
  Bhandle:=CreateCompatibleBitmap(SourceDC,
  RectWidth,RectHeight);
  SelectObject(DestDC,Bhandle);
  BitBlt(DestDC,0,0,RectWidth,RectHeight,SourceDC,
  LeftPos,TopPos,SRCCOPY);
  Bitmap:=TBitmap.Create;
  Bitmap.Handle:=BHandle;
  Stream := TMemoryStream.Create;
  Bitmap.SaveToStream(Stream);
  Stream.Free;
  try
    MyJpeg.Assign(Bitmap);
    MyJpeg.CompressionQuality:=70;
    MyJpeg.Compress;
    MyJpeg.SaveToFile(Path);
  finally
    MyJpeg.Free;
    Bitmap.Free;
    DeleteDC(DestDC);
    ReleaseDC(Bhandle,SourceDC);
  end;
end   ;

procedure QExportCSV(AdbGrid:TDBGrid;Fn:String );//zxh 08.2.18
var
  csvFile: TextFile;
  i,j:integer;
  CellValue, LineStr:string;
  saveDlg:TsaveDialog;
begin
  try
      fn:=ExtractFilePath(application.exename)+fn+'.csv';
      AssignFile(csvFile, Fn);

      if FileExists(fn) then
          Append(csvFile)
      else
          ReWrite(csvFile);

      if  AdbGrid.DataSource.DataSet.IsEmpty then exit;

      AdbGrid.DataSource.DataSet.DisableControls ;

      for i := 0 to AdbGrid.Columns.Count-1 do
      begin
          if AdbGrid.Columns[i].Visible then
          begin
              CellValue:= AdbGrid.Columns[i ].Title.Caption;
              LineStr := LineStr+CellValue+',';
          end;
      end;
      Writeln(csvFile, LineStr);
      
      with AdbGrid.DataSource.DataSet do
      begin
         First;
         while not Eof do
         begin
              LineStr :='';
              for j := 0 to AdbGrid.Columns.Count - 1 do
              begin
                  if AdbGrid.Columns[j].Visible then
                  begin
                      if FindField (AdbGrid.Columns[j].FieldName )=nil then
                        CellValue:=''
                      else
                      begin
                        CellValue:=trim(FieldByName(AdbGrid.Columns[j].FieldName).AsString) ;
                      end;
                      LineStr := LineStr+CellValue+',';
                  end;
              end;
              Writeln(csvFile, LineStr);
              Next;
           end;
       end;
         CloseFile(csvFile);
        saveDlg:= TsaveDialog.Create(nil);
        saveDlg.Filter:='.csv';
        saveDlg.FileName := fn;
        if  saveDlg.Execute then
        begin
            copyfile(pchar(fn),pchar( saveDlg.FileName),false);
        end;
  finally
    freeandnil(saveDlg);

     deletefile(fn);
    AdbGrid.DataSource.DataSet.EnableControls  ;
    //excelapp.quit; //�˳�EXCEL���
  end;
end;

procedure QExportExcel(AdbGrid:TDBGrid;Fn:String;Vis:Boolean ;RepeatCnt:integer=1);//zxh 08.2.18
var
  ExcelApp: Variant;
  i,j,m,ii,p,MaxVisiableIndex:integer;
  k: Array [0..100] of integer;
  CellValue:string;
begin
  try
      ExcelApp := CreateOleObject('Excel.Application');
  except
      application.MessageBox('ϵͳ�е�MS Excel���û�а�װ��װ����ȷ��','����',MB_ICONERROR+MB_OK);
      exit;
  end;
  ExcelApp.visible:=vis;
  try
   begin
    excelapp.caption:=fn;//'Ӧ�ó������ Microsoft Excel';
    ExcelApp.WorkBooks.Add;
    //д�������
    m:=1;
    for i := 1 to AdbGrid.Columns.Count do
     begin
      if AdbGrid.Columns[i-1].Visible then
      begin
          k[i]:=1;
          if i>MaxVisiableIndex then MaxVisiableIndex:=i;
      end
      else
          k[i]:=0;
     end;

    for p:=0 to  RepeatCnt-1 do
    for i := 1 to AdbGrid.Columns.Count do
    begin
      if k[i]=1 then
        begin
           ExcelApp.Cells[1,m+p].Value := AdbGrid.Columns[i - 1].Title.Caption;
           if i< MaxVisiableIndex then
           inc(m);
        end;
    end;

      if   AdbGrid.DataSource.DataSet.IsEmpty then exit;
      AdbGrid.DataSource.DataSet.DisableControls ;
      with AdbGrid.DataSource.DataSet do
       begin
        First;
        i:=2;
         while not Eof do
         begin
              m:=0;
              for p:=0 to  RepeatCnt-1 do
              begin
                if not Eof then
                for j := 0 to AdbGrid.Columns.Count - 1 do
                begin
                  if k[j+1]=1 then
                  begin
                    if FindField (AdbGrid.Columns[j].FieldName )=nil then
                      CellValue:=''
                    else
                    begin
                      CellValue:=trim(FieldByName(AdbGrid.Columns[j].FieldName).AsString) ;
                      if  (   ADbGrid.DataSource.DataSet.FieldByName ( AdbGrid.Columns[j].FieldName)is  TNumericField)  then
                          ExcelApp.Cells[i,m+1+p].NumberFormatLocal:=TChyColumn(AdbGrid.Columns[j]).DeciamlFormat
                      else
                              ExcelApp.Cells[i,m+1+p].NumberFormatLocal:='@';    

                    end;
                    ExcelApp.Cells[i,m+1+p].value := CellValue;
                    if j< MaxVisiableIndex - 1 then
                    inc(m);
                  end;
                end;
                Next;
              end;
           // Next;
            Inc(i);
           end;
       end;
       {if TModelDbGrid(AdbGrid).NeedSumRow then
          for j := 0 to AdbGrid.Columns.Count - 1 do
           if  AdbGrid.Columns[j].Visible then
           if  (   ADbGrid.DataSource.DataSet.FieldByName ( AdbGrid.Columns[j].FieldName)is  TNumericField)  then
           begin
                ExcelApp.Cells[i,m-2 +p].NumberFormatLocal:=TChyColumn(AdbGrid.Columns[j]).DeciamlFormat ;
                ExcelApp.Cells[i,m -2+p].value := TChyColumn(AdbGrid.Columns[j]).GroupValue ;
           end; }

     end;
  finally
    AdbGrid.DataSource.DataSet.EnableControls  ;
    //excelapp.quit; //�˳�EXCEL���
  end;
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

function    GetSysVersion :  string;
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

function  WriteTxtFile( logfilename, content:string):boolean;
var
    wLogFile :TextFile;
begin
  try
      AssignFile(wLogFile,logfilename);
      if FileExists(logfilename) then
        Append(wLogFile)
      else
      begin
        ReWrite(wLogFile);
      end;

      Writeln(wLogFile, content );//formatdatetime('yyyy"-"mm"-"dd',dt)+' '+formatdatetime('hh":"nn":"ss',Now) +' ');

  finally
    CloseFile(wLogFile);
  end;
end;

end.
