unit LZW;

////////////////////////////////////////////////////////////////////////////
//
//  LZW compression routines
//
//  (c) 2004 SCH
//
////////////////////////////////////////////////////////////////////////////
interface

{$DEFINE noLZWDebugTXTs}
uses
  {$IFDEF LZWDebugTXTs}
  indep,
  {$ENDIF}
  Classes, SysUtils;

{$DEFINE noLZWOnProgress}
type
  TLZWStats = record
    Elapsed: TDateTime;
    Speed, // bytes/sec
    Ratio: real;
    {$IFDEF LZWOnProgress}
    OnProgress: procedure(const Position, Size: Integer) of object;
    {$ENDIF}
    end;

var
  LZWEncodeStat,
  LZWDecodeStat: TLZWStats;

function LZWEncode(sInput: string) : string; overload;

function LZWDecode(sInput: string) : string; overload;

procedure LZWEncode(sInput, sOutput: TMemoryStream); overload;

procedure LZWDecode(sInput, sOutput: TMemoryStream); overload;

implementation

type
  ELZWError = Exception;

const
  cMAX_LZW_TABLE_ENTRY = $1000-1;

//cMAX_LZW_TABLE_ENTRY = $110-1;
{$IFDEF LZWDebugTXTs}
var
  debS: string;

{$ENDIF}
(*
procedure LZWEncode_reference(sInput, sOutput: TMemoryStream);
const
  cClear = 256;
  cEOD = 257;
type
  TIdxElem = record
    code, Len: Cardinal;
  end;
  TIdx = array of TIdxElem;
  var
  CodeTable: array [0..cMAX_LZW_TABLE_ENTRY] of string;
  CodeSt: array [0..255] of TIdx;
  LongestCode,
  idxCodeTable,
  code: Cardinal;
  wrCodeLen,
  wrBuffer,
  wrBitCnt: Cardinal;
  Cnt: Integer;
  Buf: string;
  posI: Int64;
  tmp: Byte;

  {$IFDEF LZWDebugTXTs}
  procedure WrDebCodeTable;
  var
    I: Integer;
    S: string;
  begin
    S:='CodeTable:'+CRLF;
    for I := 258 to idxCodeTable-1 do S:=S+IntToStr(I)+TAB+CodeTable[I]+CRLF;
    debS:=debS+S;
  end;

  {$ENDIF}
  procedure WriteCode(code: Cardinal); forward;

  procedure InitTable;
  var
    I: Integer;
  begin
    {$IFDEF LZWDebugTXTs}
    WrDebCodeTable;
    {$ENDIF}
    WriteCode(cClear);
    wrCodeLen:=9;
    for I := 0 to 255 do begin
      CodeTable[I]:=Chr(I);
      SetLength(CodeSt[I], 1);
      CodeSt[I][0].code:=I;
      CodeSt[I][0].Len:=1;
    end;
    idxCodeTable:=cEOD+1;
    LongestCode:=1;
  end;

  procedure ExpandTable(code: Cardinal; B: Byte);
  var
    StartingChar: Byte;
    I: Integer;
    J: Cardinal;
    T: TIdxElem;
  begin
    {$IFDEF LZWDebugTXTs}
    //    debS:=debS+'IDX: '+inttostr(idxcodetable)+tab+CodeTable[idxCodeTable]+crlf;
    debS:=debS+'IDX: '+IntToStr(idxCodeTable)+CRLF;
    {$ENDIF}
    CodeTable[idxCodeTable]:=CodeTable[code]+Chr(B);
    StartingChar:=Ord(CodeTable[idxCodeTable][1]);
    I:=High(CodeSt[StartingChar])+1;
    SetLength(CodeSt[StartingChar], I+1);
    CodeSt[StartingChar][I].code:=idxCodeTable;
    J:=Length(CodeTable[idxCodeTable]);
    if J>LongestCode then LongestCode:=J;
    CodeSt[StartingChar][I].Len:=J;
    //CodeSt[..] should be sorted to increasing order to find longest match first
    I:=High(CodeSt[StartingChar]);
    while I>0 do begin
      if CodeSt[StartingChar][I].Len<CodeSt[StartingChar][I-1].Len then begin
        T:=CodeSt[StartingChar][I];
        CodeSt[StartingChar][I]:=CodeSt[StartingChar][I-1];
        CodeSt[StartingChar][I-1]:=T;
      end;
      Dec(I);
    end;
    Inc(idxCodeTable);
    case idxCodeTable of
      512 ,
      1024 ,
      2048: Inc(wrCodeLen);
    end;
  end;

  procedure WriteCode(code: Cardinal);
  var
    tmp: Byte;
  begin
    {$IFDEF LZWDebugTXTs}
    debS:=debS+IntToStr(code)+CRLF;
    {$ENDIF}
    wrBuffer:=(wrBuffer shl wrCodeLen) or code;
    wrBitCnt:=wrBitCnt+wrCodeLen;
    while wrBitCnt>=8 do begin
      tmp:=Byte(wrBuffer shr (wrBitCnt-8));
      sOutput.Write(tmp, 1);
      wrBitCnt:=wrBitCnt-8;
    end;
    if (code=cEOD) and (wrBitCnt>0) then begin
      tmp:=Byte(wrBuffer shl (8-wrBitCnt));
      sOutput.Write(tmp, 1);
    end;
  end;

  function SearchMatch : Integer;
  var
    I: Integer;
    T: ^ TIdx;
  begin
    Result:=-1; //never will be returned
    T:=@CodeSt[Ord(Buf[1])];
    for I := High(T^) downto 0 do if Pos(CodeTable[T^[I].code], Buf)=1 then begin
      Result:=T^[I].code;
      Exit;
    end;
  end;
begin
  LZWEncodeStat.Elapsed:=Now;
  {$IFDEF LZWDebugTXTs}
  debS:='';
  idxCodeTable:=1;
  {$ENDIF}
  sInput.Position:=0;
  wrCodeLen:=9;
  wrBitCnt:=0;
  wrBuffer:=0;
  InitTable;
  repeat
    SetLength(Buf, LongestCode);
    posI:=sInput.Position;
    Cnt:=sInput.Read(Buf[1], LongestCode);
    if Cnt>0 then begin
      if idxCodeTable>4095 then InitTable;
      SetLength(Buf, Cnt);
      //getting longest matching code
      code:=SearchMatch;
      sInput.Position:=posI+Length(CodeTable[code]);
      WriteCode(code);
      //expanding table with current code + next char
      posI:=sInput.Position;
      Cnt:=sInput.Read(tmp, 1);
      sInput.Position:=posI;
      if Cnt>0 then ExpandTable(code, tmp);
    end;

  until Cnt=0;
  WriteCode(cEOD);
  with LZWEncodeStat do begin
    Elapsed:=Now-Elapsed;
    if sInput.Size<>0 then Ratio:=sOutput.Size/sInput.Size else Ratio:=sOutput.Size/1;
    Speed:=Elapsed/EncodeTime(0, 0, 1, 0);
    if Speed<>0 then Speed:=sInput.Size/Speed;
  end;

  {$IFDEF LZWOnProgress}
  LZWEncodeStat.OnProgress:=nil;
  {$ENDIF}
  {$IFDEF LZWDebugTXTs}
  WrDebCodeTable;
  StringToFile('encode_reference.txt', debS);

  {$ENDIF}
  end;

procedure LZWDecode_reference(sInput, sOutput: TMemoryStream);
const
  cClear = 256;
  cEOD = 257;
var
  CodeTable: array [0..4095] of string;
  idxCodeTable,
  code: Integer;
  rdCodeLen,
  rdBuffer,
  rdBitCnt: Cardinal;

  procedure InitTable;
  var
    I: Integer;
  begin
    rdCodeLen:=9;
    for I := 0 to 255 do begin
      CodeTable[I]:=Chr(I);
    end;
    idxCodeTable:=cEOD+1;
  end;

  procedure ExpandPrev(B: Char);
  begin
    if idxCodeTable>258 then CodeTable[idxCodeTable-1]:=CodeTable[idxCodeTable-1]+B;
  end;

  procedure ExpandTable(code: Integer);
  begin
    CodeTable[idxCodeTable]:=CodeTable[code];
    Inc(idxCodeTable);
    case idxCodeTable of
      512 ,
      1024 ,
      2048: Inc(rdCodeLen);
    end;
  end;

  function ReadCode : Cardinal;
  var
    tmp: Byte;
    I: Integer;
  begin
    while rdBitCnt<rdCodeLen do begin
      I:=sInput.Read(tmp, 1);
      if I<>1 then raise ELZWError.Create('LZWDecode: End of stream');
      rdBuffer:=rdBuffer shl 8+tmp;
      rdBitCnt:=rdBitCnt+8;
    end;
    Result:=rdBuffer shr (rdBitCnt-rdCodeLen);
    rdBitCnt:=rdBitCnt-rdCodeLen;
    if rdBitCnt>0 then rdBuffer:=rdBuffer shl (32-rdBitCnt) shr (32-rdBitCnt) else rdBuffer:=
                                 0;
  end;
begin
  sInput.Position:=0;
  rdBitCnt:=0;
  rdBuffer:=0;
  InitTable; //just for sure
  code:=ReadCode;
  while code<>cEOD do begin
    case code of
        cEOD:;
      cClear: InitTable;
    else begin
      if code>=idxCodeTable then raise ELZWError.Create('LZWDecode: code>=idxCodeTable');
      ExpandPrev(CodeTable[code][1]);
      sOutput.Write(CodeTable[code][1], Length(CodeTable[code]));
      ExpandTable(code);
    end;
    end;
    code:=ReadCode;
  end;
end;

*)
function StringLComp(const Str1, Str2: PChar; MaxLen: Cardinal) : Integer; assembler;
asm

         PUSH EDI
         PUSH ESI
         MOV  EDI,EDX            //EDX=@str2
         MOV  ESI,EAX            //EAX=@str1
         OR   ECX,ECX            //ECX=MaxLen
         JE   @@1
         XOR  EDX,EDX
         XOR  EAX,EAX
         REPE CMPSB
         MOV  AL,[ESI-1]
         MOV  DL,[EDI-1]
         SUB  EAX,EDX
  @@1:
         POP  ESI
         POP  EDI
end;

procedure LZWEncode(sInput, sOutput: TMemoryStream); overload;
const
  cClear = 256;
  cEOD = 257;
type
  TIdxElem = record
    code, Len: Cardinal;
  end;
  TIdx = array of TIdxElem;
  var
  CodeTable: array [0..cMAX_LZW_TABLE_ENTRY] of string;
  CodeSt: array [0..255] of TIdx;
  LongestCode,
  idxCodeTable,
  code,
  prevCode: Cardinal;
  wrCodeLen,
  wrBuffer,
  wrBitCnt: Cardinal;
  Cnt: Integer;
  Buf: string;
  posI: Int64;
  {$IFDEF LZWOnProgress}
  OnProgressCtr: Integer;
  {$ENDIF}
  flBuffer: array [0..8191] of Byte;
  flCnt: Integer;

  {$IFDEF LZWDebugTXTs}
  procedure WrDebCodeTable;
  var
    I: Integer;
    S: string;
  begin
    S:='CodeTable:'+CRLF;
    for I := 258 to idxCodeTable-1 do S:=S+IntToStr(I)+TAB+CodeTable[I]+CRLF;
    debS:=debS+S;
  end;

  {$ENDIF}
  procedure WriteCode(code: Cardinal); forward;

  procedure InitTable;
  var
    I: Integer;
  begin
    {$IFDEF LZWDebugTXTs}
    WrDebCodeTable;
    {$ENDIF}
    WriteCode(cClear);
    wrCodeLen:=9;
    for I := 0 to 255 do begin
      CodeTable[I]:=Chr(I);
      SetLength(CodeSt[I], 1);
      CodeSt[I][0].code:=I;
      CodeSt[I][0].Len:=1;
    end;
    idxCodeTable:=cEOD+1;
    LongestCode:=1;
  end;

  procedure ExpandTable(code: Cardinal; StartingChar: Byte);
  var
    I: Integer;
    J: Cardinal;
    T: TIdxElem;
  begin
    prevCode:=code;
    CodeTable[idxCodeTable]:=CodeTable[code];
    {$IFDEF LZWDebugTXTs}
    debS:=debS+'IDX: '+IntToStr(idxCodeTable)+CRLF;
    {$ENDIF}
    I:=High(CodeSt[StartingChar])+1;
    SetLength(CodeSt[StartingChar], I+1);
    CodeSt[StartingChar][I].code:=idxCodeTable;
    J:=Length(CodeTable[idxCodeTable])+1;
    if J>LongestCode then LongestCode:=J;
    CodeSt[StartingChar][I].Len:=J;
    //CodeSt[..] should be sorted to increasing order to find longest match first
    I:=High(CodeSt[StartingChar]);
    while I>0 do begin
      if CodeSt[StartingChar][I].Len<CodeSt[StartingChar][I-1].Len then begin
        T:=CodeSt[StartingChar][I];
        CodeSt[StartingChar][I]:=CodeSt[StartingChar][I-1];
        CodeSt[StartingChar][I-1]:=T;
      end;
      Dec(I);
    end;
    Inc(idxCodeTable);
    case idxCodeTable of
      $200 ,
      $400 ,
      $800//,$1000,$2000,$4000,$8000
        : Inc(wrCodeLen);
    end;
  end;

  procedure FlushBuffer;
  begin
    if flCnt>0 then sOutput.Write(flBuffer[0], flCnt);
    flCnt:=0;
  end;

  procedure WriteCode(code: Cardinal);
  var
    tmp: Byte;
  begin
    {$IFDEF LZWDebugTXTs}
    debS:=debS+IntToStr(code)+CRLF;
    {$ENDIF}
    wrBuffer:=(wrBuffer shl wrCodeLen) or code;
    wrBitCnt:=wrBitCnt+wrCodeLen;
    while wrBitCnt>=8 do begin
      tmp:=Byte(wrBuffer shr (wrBitCnt-8));
      flBuffer[flCnt]:=tmp;
      Inc(flCnt);
      wrBitCnt:=wrBitCnt-8;
    end;
    if (code=cEOD) and (wrBitCnt>0) then begin
      tmp:=Byte(wrBuffer shl (8-wrBitCnt));
      flBuffer[flCnt]:=tmp;
      Inc(flCnt);
    end;
    if flCnt>High(flBuffer)-5 then FlushBuffer;
  end;

  function SearchMatch : Integer;
  var
    I: Integer;
    T: ^ TIdx;
  begin
    Result:=-1; //never will be returned
    T:=@CodeSt[Ord(Buf[1])];
    for I := High(T^) downto 0 do begin
      if StringLComp(@Buf[1], @CodeTable[T^[I].code][1], Length(CodeTable[T^[I].code]))=0 then begin
        Result:=T^[I].code;
        Exit;
      end;
    end;
  end;
begin
  LZWEncodeStat.Elapsed:=Now;
  {$IFDEF LZWDebugTXTs}
  idxCodeTable:=1;
  debS:='';
  {$ENDIF}
  flCnt:=0;
  sInput.Position:=0;
  wrCodeLen:=9;
  wrBitCnt:=0;
  wrBuffer:=0;
  InitTable;
  {$IFDEF LZWOnProgress}
  OnProgressCtr:=0;
    {$ENDIF}
  prevCode:=cEOD;
  repeat
    SetLength(Buf, LongestCode);
    posI:=sInput.Position;
    Cnt:=sInput.Read(Buf[1], LongestCode);
    if Cnt>0 then begin
      {$IFDEF LZWOnProgress}
      if Assigned(LZWEncodeStat.OnProgress) and ((sInput.Position and not $FFFF)<>OnProgressCtr) then begin
        OnProgressCtr:=sInput.Position and not $FFFF;
        LZWEncodeStat.OnProgress(sInput.Position, sInput.Size);
      end;
      {$ENDIF}
      //adding char to previous code in table
      if idxCodeTable>cMAX_LZW_TABLE_ENTRY then begin
        InitTable;
      end else begin
        if idxCodeTable-1>cEOD then begin //ExpandPrev(Buf[1]);
          CodeTable[idxCodeTable-1]:=CodeTable[idxCodeTable-1]+Buf[1];
        end;
      end;
      SetLength(Buf, Cnt);
      //getting longest matching code
      code:=SearchMatch;
      sInput.Position:=posI+Length(CodeTable[code]);
      WriteCode(code);
      //expanding table with code + next char
      ExpandTable(code, Ord(Buf[1]));
    end;

  until Cnt=0;
  WriteCode(cEOD);
  FlushBuffer;
  with LZWEncodeStat do begin
    Elapsed:=Now-Elapsed;
    if sInput.Size<>0 then Ratio:=sOutput.Size/sInput.Size else Ratio:=sOutput.Size/1;
    Speed:=Elapsed/EncodeTime(0, 0, 1, 0);
    if Speed<>0 then Speed:=sInput.Size/Speed;
  end;

  {$IFDEF LZWOnProgress}
  LZWEncodeStat.OnProgress:=nil;
  {$ENDIF}
  {$IFDEF LZWDebugTXTs}
  WrDebCodeTable;
  StringToFile('encode.txt', debS);
  {$ENDIF}
  end;

procedure LZWDecode(sInput, sOutput: TMemoryStream); overload;
const
  cClear = 256;
  cEOD = 257;
var
  CodeTable: array [0..cMAX_LZW_TABLE_ENTRY] of string;
  idxCodeTable,
  code: Integer;
  rdCodeLen,
  rdBuffer,
  rdBitCnt: Cardinal;
  {$IFDEF LZWOnProgress}
  OnProgressCtr: Integer;
  {$ENDIF}
  {$IFDEF LZWDebugTXTs}
  procedure WrDebCodeTable;
  var
    I: Integer;
    S: string;
  begin
    S:='CodeTable:'+CRLF;
    for I := 258 to idxCodeTable-1 do S:=S+IntToStr(I)+TAB+CodeTable[I]+CRLF;
    debS:=debS+S;
  end;

  {$ENDIF}
  procedure InitTable;
  var
    I: Integer;
  begin
    {$IFDEF LZWDebugTXTs}
    WrDebCodeTable;
    {$ENDIF}
    rdCodeLen:=9;
    for I := 0 to 257 do CodeTable[I]:=Chr(Byte(I));
    idxCodeTable:=cEOD+1;
  end;

  function ReadCode : Cardinal;
  var
    tmp: Byte;
    I: Integer;
  begin
    while rdBitCnt<rdCodeLen do begin
      I:=sInput.Read(tmp, 1);
      if I<>1 then raise ELZWError.Create('LZWDecode: End of stream');
      rdBuffer:=rdBuffer shl 8+tmp;
      rdBitCnt:=rdBitCnt+8;
    end;
    Result:=rdBuffer shr (rdBitCnt-rdCodeLen);
    {$IFDEF LZWDebugTXTs}
    debS:=debS+IntToStr(Result)+CRLF;
    {$ENDIF}
    rdBitCnt:=rdBitCnt-rdCodeLen;
    if rdBitCnt>0 //
    then rdBuffer:=rdBuffer shl (32-rdBitCnt) shr (32-rdBitCnt) //
    else rdBuffer:=0;
  end;
begin
  LZWDecodeStat.Elapsed:=Now;
  {$IFDEF LZWDebugTXTs}
  debS:='';
  idxCodeTable:=1;
  {$ENDIF}
  sInput.Position:=0;
  rdBitCnt:=0;
  rdBuffer:=0;
  InitTable; //just for sure
  code:=ReadCode;
  {$IFDEF LZWOnProgress}
  OnProgressCtr:=0;
    {$ENDIF}
  while code<>cEOD do begin
    {$IFDEF LZWOnProgress}
    if Assigned(LZWDecodeStat.OnProgress) and ((sInput.Position and not $FFFF)<>OnProgressCtr) then begin
      OnProgressCtr:=sInput.Position and not $FFFF;
      LZWDecodeStat.OnProgress(sInput.Position, sInput.Size);
    end;
    {$ENDIF}
    case code of
        cEOD:;
      cClear: InitTable;
    else begin
      if code>=idxCodeTable then raise ELZWError.Create('LZWDecode: code>=idxCodeTable');
      CodeTable[idxCodeTable-1]:=CodeTable[idxCodeTable-1]+CodeTable[code][1];
      sOutput.Write(CodeTable[code][1], Length(CodeTable[code]));
      CodeTable[idxCodeTable]:=CodeTable[code];
      {$IFDEF LZWDebugTXTs}
      debS:=debS+'IDX: '+IntToStr(idxCodeTable)+CRLF;
      {$ENDIF}
      Inc(idxCodeTable);
      case idxCodeTable of
        $200 ,
        $400 ,
        $800//,$1000,$2000,$4000,$8000
          : Inc(rdCodeLen);
      end;
    end;
    end;
    code:=ReadCode;
  end;
  {$IFDEF LZWDebugTXTs}
  WrDebCodeTable;
  {$ENDIF}
  with LZWDecodeStat do begin
    Elapsed:=Now-Elapsed;
    if sInput.Size<>0 then Ratio:=sOutput.Size/sInput.Size else Ratio:=sOutput.Size/1;
    Speed:=Elapsed/EncodeTime(0, 0, 1, 0);
    if Speed<>0 then Speed:=sInput.Size/Speed;
  end;

  {$IFDEF LZWOnProgress}
  LZWEncodeStat.OnProgress:=nil;
  {$ENDIF}
  {$IFDEF LZWDebugTXTs}
  StringToFile('decode.txt', debS);
  {$ENDIF}
  end;

function LZWEncode(sInput: string) : string; overload;
var
  ssInput,
  ssOutput: TMemoryStream;
begin
  ssInput:=TMemoryStream.Create;
  ssOutput:=TMemoryStream.Create;
  try
    if Length(sInput)>0 then ssInput.Write(sInput[1], Length(sInput));
    ssInput.Position:=0;
    ssOutput.Position:=0;
    ssOutput.Size:=0;
    LZWEncode(ssInput, ssOutput);
    ssOutput.Position:=0;
    SetLength(Result, ssOutput.Size);
    if ssOutput.Size>0 then ssOutput.Read(Result[1], ssOutput.Size);
  finally
    ssOutput.Free;
    ssInput.Free;
  end;
end;

function LZWDecode(sInput: string) : string; overload;
var
  ssInput,
  ssOutput: TMemoryStream;
begin
  ssInput:=TMemoryStream.Create;
  ssOutput:=TMemoryStream.Create;
  try
    if Length(sInput)>0 then ssInput.Write(sInput[1], Length(sInput));
    ssOutput.Position:=0;
    ssOutput.Size:=0;
    LZWDecode(ssInput, ssOutput);
    ssOutput.Position:=0;
    SetLength(Result, ssOutput.Size);
    if ssOutput.Size>0 then ssOutput.Read(Result[1], ssOutput.Size);
  finally
    ssOutput.Free;
    ssInput.Free;
  end;
end;

begin
  {$IFDEF LZWOnProgress}
  LZWEncodeStat.OnProgress:=nil;
  LZWDecodeStat.OnProgress:=nil;
  {$ENDIF}
end.
