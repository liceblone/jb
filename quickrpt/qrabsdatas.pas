unit QRAbsDatas;
//********************************************************************
//
// TQRAbstractTable : TDataset with no underlying data
//
//
// (c) QBS 2003
//
//********************************************************************
interface
uses windows, classes, controls, stdctrls, sysutils, db;

const
     MAX_STRING = 64000;
type

    TQRDataAbsSetEvent = procedure( const DataStr : string; Field : TField; buffer : pointer;
                                 var MoreData : boolean ) of object;

   TQRAbsTable = class(TDataset)
   private
     FOnSetFieldValue : TQRDataAbsSetEvent;
     FRecBufSize: Word;
     FRecordSize : word;
     FDefFieldLen : integer;
     FRecordCount : longint;
     FCurRecord : longint;
     FEOF : Boolean;
     FBOF : Boolean;
     //FActive : boolean;
     FDoneFielddefs : boolean;
     FFieldnames : TStringlist;
     procedure ClearData;
   protected
     // abstracts from TDataset
     function AllocRecordBuffer: PChar; override;
     procedure FreeRecordBuffer(var Buffer: PChar); override;
     procedure GetBookmarkData(Buffer: PChar; Data: Pointer); override;
     function GetBookmarkFlag(Buffer: PChar): TBookmarkFlag; override;
     function GetRecord(Buffer: PChar; GetMode: TGetMode; DoCheck: Boolean): TGetResult; override;
     function GetRecordSize: Word; override;
     procedure InternalAddRecord(Buffer: Pointer; Append: Boolean); override;
     procedure InternalClose; override;
     procedure InternalDelete; override;
     procedure InternalFirst; override;
     procedure InternalGotoBookmark(Bookmark: Pointer); override;
     procedure InternalHandleException; override;
     procedure InternalInitFieldDefs; override;
     procedure InternalInitRecord(Buffer: PChar); override;
     procedure InternalLast; override;
     procedure InternalOpen; override;
     procedure InternalPost; override;
     procedure InternalSetToRecord(Buffer: PChar); override;
     function IsCursorOpen: Boolean; override;
     procedure SetBookmarkFlag(Buffer: PChar; Value: TBookmarkFlag); override;
     procedure SetBookmarkData(Buffer: PChar; Data: Pointer); override;
     procedure SetFieldData(Field: TField; Buffer: Pointer); overload; override;
     procedure SetFieldData(Field: TField; Buffer: Pointer; NativeFormat: Boolean); overload; override;
     procedure ActivateBuffers; override;
     procedure CreateFields; override;
     function GetRecordCount: Longint; override;
     function GetRecno: Longint; override;
   public
     constructor Create(AOwner: TComponent);override;
     destructor Destroy;override;
     function GetFieldData(Field: TField; Buffer: Pointer): Boolean; overload; override;
     procedure Moveby( dist : integer );
     procedure Next;
   published
     property Active;
     property OnSetFieldValue : TQRDataAbsSetEvent read FOnSetFieldValue write FOnSetFieldValue;
     property RecordCount : longint read FRecordCount;
     property CurrentRecord : longint read FCurRecord;
     property DefFieldLen : integer read FDefFieldLen write FDefFieldLen default 50;
     property EOF : boolean read FEOF;
     property BOF : boolean read FBOF;
     property Fielddefs;
     property BeforeOpen;
     property AfterOpen;
     property BeforeClose;
     property AfterClose;
     property BeforeScroll;
     property AfterScroll;
   end;

   Function StripXChars( ss : string ) : string;
   
implementation

constructor TQRAbsTable.Create(AOwner: TComponent);
begin
      inherited create( aOwner );
      FFieldnames := TStringlist.create;
      FRecordSize := 5000;
end;

destructor TQRAbsTable.Destroy;
begin
     FFieldnames.free;
     inherited;
end;

function TQRAbsTable.GetRecno: Longint;
begin
    result := FCurRecord;
end;


procedure TQRAbsTable.InternalOpen;
begin
    if Active then exit;
    FFieldnames.Clear;
    FEOF := false;
    FBOF := true;
    InternalInitFieldDefs;
    Createfields;
    FCurRecord := 0;
    ActivateBuffers;
end;

procedure TQRAbsTable.Moveby( dist : integer );
begin
    inc( FCurRecord, dist );
    if FCurRecord < 0 then
    begin
         FCurRecord := 0;
         FBOF := true;
         FEOF := false;
    end
    else if FCurRecord >= FRecordCount then
    begin
         FCurRecord := FRecordCount - 1;
         FEOF := true;
         FBOF := false;
    end;
end;

procedure TQRAbsTable.InternalClose;
begin
    //ClearData;
    DestroyFields;
end;

procedure TQRAbsTable.ClearData;
begin
    FFieldnames.Clear;
    Fielddefs.Clear;
    FDoneFielddefs := false;
end;

procedure TQRAbsTable.CreateFields;
begin
    inherited;
end;

function TQRAbsTable.AllocRecordBuffer: PChar;
begin
       Result := AllocMem(FRecBufSize);
end;

procedure TQRAbsTable.FreeRecordBuffer(var Buffer: PChar);
begin
    FreeMem( buffer );
end;

procedure TQRAbsTable.GetBookmarkData(Buffer: PChar; Data: Pointer);
begin
end;

function TQRAbsTable.GetBookmarkFlag(Buffer: PChar): TBookmarkFlag;
begin
     result := bfBOF;
end;

procedure TQRAbsTable.Next;
begin
     inc(FCurRecord);
     if fcurrecord >= FRecordCount then
     begin
         fcurrecord := FRecordCount-1;
         FEOF := true;
     end;
end;

function TQRAbsTable.GetRecord(Buffer: PChar; GetMode: TGetMode; DoCheck: Boolean): TGetResult;
begin
     result := grOK;
     // FEOF may have been set by the GetFieldData call
     if FEOF then
     begin
         result := grEOF;
         exit;
     end;
     if getmode = gmNext then
     begin
          inc(FCurRecord);
     end
     else if getmode = gmPrior then
     begin
          dec(FCurRecord);
          if fcurrecord < 0 then
          begin
              fcurrecord := 0;
              FBOF := true;
              result := grBOF;
          end;
     end;
end;

function TQRAbsTable.GetRecordSize: Word;
begin
       Result := FRecordSize;
end;

procedure TQRAbsTable.InternalAddRecord(Buffer: Pointer; Append: Boolean);
begin
     // read only
end;

procedure TQRAbsTable.InternalDelete;
begin
   // read only
end;

procedure TQRAbsTable.InternalFirst;
begin
    FCurRecord := 0;
end;

procedure TQRAbsTable.InternalGotoBookmark(Bookmark: Pointer);
begin

end;

procedure TQRAbsTable.InternalHandleException;
begin

end;

procedure TQRAbsTable.InternalInitFieldDefs;
begin
   FDoneFielddefs := true;
end;

procedure TQRAbsTable.InternalInitRecord(Buffer: PChar);
begin
end;

procedure TQRAbsTable.InternalLast;
begin
    FCurRecord := FRecordcount;
end;

procedure TQRAbsTable.InternalPost;
begin

end;

procedure TQRAbsTable.InternalSetToRecord(Buffer: PChar);
begin

end;

function TQRAbsTable.IsCursorOpen: Boolean;
begin
    result := FDoneFielddefs;
end;

procedure TQRAbsTable.SetBookmarkFlag(Buffer: PChar; Value: TBookmarkFlag);
begin

end;

procedure TQRAbsTable.SetBookmarkData(Buffer: PChar; Data: Pointer);
begin

end;

procedure TQRAbsTable.SetFieldData(Field: TField; Buffer: Pointer);
begin
end;

procedure TQRAbsTable.SetFieldData(Field: TField; Buffer: Pointer; NativeFormat: Boolean);
begin
end;

function TQRAbsTable.GetFieldData(Field: TField; Buffer: Pointer): Boolean;
var
    strval : string;
    moreData : boolean;
begin
  try
      moreData := false;
      result := false;
      if assigned(FOnSetFieldValue) then
      begin
            FOnSetFieldValue( strval, field, buffer, moreData );
            FEOF := not MoreData;
            result := MoreData;
            exit;
      end
      else
          strpcopy(pchar(Buffer), 'Unset' );
    except
      result := false;
      FEOF := true;
    end;
end;

function TQRAbsTable.GetRecordCount: Longint;
begin
  Result := FRecordCount;
end;

procedure TQRAbsTable.ActivateBuffers;
begin
   inherited;
end;

//**************************** Utils **************************
function LastChar( ss : string ) : char;
begin
     result := ss[ length(ss) ];
end;

Function StripXChars( ss : string ) : string;
begin
    if lastchar( ss ) in [ '+', '*', '?' ] then
        result := copy( ss, 1, length(ss)-1)
    else
        result := ss;
end;

end.
