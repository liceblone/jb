unit UPublicCtrl;

interface
 uses     Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,UnitAdoDataset,StdCtrls,Buttons,ExtCtrls,DBCtrls,Menus,winsock,UnitGrid,
  ComCtrls,ADODB,Grids,Editor,UPublicFunction,   QRPrntr,       barcode,barcode2 ,unitBarCodeTest ,
  QRCtrls, QuickRpt,  jpeg ,
   DB,FhlKnl,datamodule,DBGrids,ActnList;

  function isinteger(value:string):boolean;
  function LocalIP:string;
  procedure GetMacAddrFromIP(const IP: String;var Mac: String);


  
type Tedit_Mtn= class(TEdit)
  private
    FDown:boolean;
    FOldX : TPoint;
    FOldY : TPoint;
    FRectList: array[1..8] of TRect;
    FPosList: array[1..8] of Integer;
    FisUserMode: Boolean;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure WmNcHitTest(var Msg: TWmNcHitTest); message wm_NcHitTest;
    procedure WmSize(var Msg: TWmSize); message wm_Size;
    procedure SetisUserMode(const Value: Boolean);

  public
    FCollector:Tstrings;
    BoxId:string;        //记录boxid，删除控键时用到  2006-5-8
    FieldID        :integer;
    DLDataSourceType :Integer;    // 0 as maindataset  , 1 as dlgrid  dl
     KeyValue :integer;
    constructor Create(AOwner: TComponent); override;
    property isUserMode:Boolean read FisUserMode write SetisUserMode default False;
end;

type Tlabel_Mtn= class(Tlabel)
  private
    FECaption: string;
    FDown:boolean;
    FOldX : TPoint;
    FOldY : TPoint;
    FRectList: array[1..8] of TRect;
    FPosList: array[1..8] of Integer;
    FisUserMode: Boolean;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;  X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure WmNcHitTest(var Msg: TWmNcHitTest); message wm_NcHitTest;
    procedure WmSize(var Msg: TWmSize); message wm_Size;
    procedure SetisUserMode(const Value: Boolean);
  public
    FCollector:Tstrings;
    BoxId:string;        //记录boxid，删除控键时用到  2006-5-8
       KeyValue:integer;
    constructor Create(AOwner: TComponent); override;
    Procedure SetCollector(value:Tstrings);
    property  isUserMode:Boolean read FisUserMode write SetisUserMode default False;
    property  ECaption :string read FECaption write FECaption;
end;

type TGrpQueryRecord=class(Tscrollbox)
    private
    FTableName:string;
    FDbgrid:TDbgrid;
    public
    LabelName:Tlabel;
    ComBoxFieldCname:TFhlComboBox;
    TStrLstFieldEname:Tstringlist;
    OptCombobox: TFhlComboBox;
    OptStrLst: Tstringlist;
    ValGroupBox:Tgroupbox;
    Btnqry:Tspeedbutton;

    Sqlexpress:Tstringlist;

    LKPFieldValues:Tstringlist;

    fldval:variant;   //字段值
    fldName:string;    //字段名
    constructor create(aowner:Tcomponent);override;
    destructor  destroy;override;
    procedure IniQuickQuery(PDbgrid:TDbgrid;Filter:boolean=false);
    Procedure BtnClick(sender:TObject);
    function GetSqlCon:string;
    procedure FldComboBoxChange(Sender: TObject);
end;

type TGrpSelRecord=class(Tscrollbox)
public
    TargetDbGrid:TDbGrid;

    MtDataset:Tadodataset;
    MtDatasource:TDatasource;

    Lable:Tlabel;
    lkpCombobox:Tdblookupcombobox;
    SelectType:boolean;
    TableName:string;

    listdataset:Tadodataset;
    ListDataSource:TDataSource;

    popupmenu:Tpopupmenu;
    MenuClear:Tmenuitem;
    MenuAll:Tmenuitem;

    IsFilter:boolean;
    constructor create(aowner:Tcomponent);override;
    procedure IniGrpBox(PDbGrid:TDbGrid);
    Procedure Click(sender:Tobject);
    Procedure DBLClick(sender:Tobject);
    procedure MenuClearClick(sender:Tobject);
    procedure MenuALLClick(sender:Tobject);

end;

type TUserField  =class  (Tobject)
    FieldID:integer;
    FieldEname:string;
    fieldtype:integer;
    fieldKind:string;
    length:integer;
    fieldFormat:string ;
    caption:string;
    PcikList:string;
    OnlyPick:boolean;
    LkpDatasetID:string;
    keyField:string;
    LkpKeyField:string;
    LkpResultField:string;
    ListField:string;
   // constructor create;
end;
Type TDbControl=class (Tobject)
    lableCaption :string;
    BindField  :TUserField;
    CtrlTypeID:integer;
    ClickAct:integer;
    DBLClickAct:integer;
    ExitAct:integer;
        constructor create;
        destructor Destroy;
end;
Type TSumType=(STEmpty,STSum,STAvg,STFirst,STLast,STMax,STMin) ;
type TChyColumn=Class( Tcolumn)
 public
     isAsc:boolean;
     DeciamlFormat:string;
     colid:string;

     GroupValue:string;
     SumType:TSumType ;
end;
 
 type TQRImageLoader=class(TQRPrintable)
    private
    FField : TField;
    FDataSet : TDataSet;
    FDataField : string;
    FPicture: TPicture;
    FStretch: boolean;
    FCenter: boolean;
    FPictureLoaded: boolean;
    FImageDir: string;
    procedure PictureChanged(Sender: TObject);
    procedure SetCenter(Value: Boolean);
    procedure SetDataField(const Value: string);
    procedure SetDataSet(Value: TDataSet);
    procedure SetPicture(Value: TPicture);
    procedure SetStretch(Value: Boolean);
    procedure ResetWidthHeight(fwidth, fheight: Integer);
    procedure SetImageDir(Value: string);
  protected
    function GetPalette: HPALETTE; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure Prepare; override;
    procedure Print(OfsX, OfsY : integer); override;
    procedure UnPrepare; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetExpandedHeight(var newheight : extended ); override;
    procedure GetFieldString( var DataStr : string); override;
    procedure LoadPicture;
    property Field: TField read FField;
    property Picture: TPicture read FPicture write SetPicture;
  published
    property Center: boolean read FCenter write SetCenter default True;
    property DataField: string read FDataField write SetDataField;
    property DataSet: TDataSet read FDataSet write SetDataSet;
    property Stretch: boolean read FStretch write SetStretch default False;
    property ImageDir: string read FImageDir write SetImageDir;
  end;

 type TQRDBBarCodeImage=class(TQRPrintable)
 private
    FField : TField;
    FDataSet : TDataSet;
    FDataField : string;

    FStretch: boolean;
    FCenter: boolean;
    FPictureLoaded: boolean;

    FRatio:double;
    FBarCodeType: integer;
    FLineWidth: integer;
    FFormatSerialText: boolean;
    Barcode1 : TAsBarcode;
    FCacheBarcodeImage: boolean;
    FBarCodeShowText: boolean;

    procedure PictureChanged(Sender: TObject);
    procedure SetCenter(Value: Boolean);
    procedure SetDataField(const Value: string);
    procedure SetDataSet(Value: TDataSet);
    procedure SetStretch(Value: Boolean);
    procedure setRatio(const Value: double);
    procedure setBarCodeType(const Value: integer);
    procedure setLineWidth(const Value: integer);
    procedure SetFormatSerialText(const Value: boolean);
    procedure SetCacheBarcodeImage(const Value: boolean);
    procedure SetFBarCodeShowText(const Value: boolean);
  protected
    function GetPalette: HPALETTE; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure Prepare; override;
    procedure Print(OfsX, OfsY : integer); override;
    procedure UnPrepare; override;
  public
    FImage:TImage;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetExpandedHeight(var newheight : extended ); override;
    procedure GetFieldString( var DataStr : string); override;
    procedure ResetWidthHeight(fwidth,fheight:Integer);
    procedure LoadPicture;
    procedure SetShowTextFont(const Value: TFont);
    property Field: TField read FField;
  published
    property Center: boolean read FCenter write SetCenter default True;
    property DataField: string read FDataField write SetDataField;
    property DataSet: TDataSet read FDataSet write SetDataSet;
    property Stretch: boolean read FStretch write SetStretch default False;
    property Ratio:double read FRatio write setRatio;
    property BarCodeType :integer read FBarCodeType write setBarCodeType;
    property LineWidth:integer read FLineWidth write setLineWidth;
    property FormatSerialText :boolean read FFormatSerialText write SetFormatSerialText;
    property CacheBarcodeImage:boolean read FCacheBarcodeImage write SetCacheBarcodeImage;
    property BarCodeShowText :boolean read FBarCodeShowText Write SetFBarCodeShowText; 
    end;
implementation

{ Tedit_Mtn }
type
 ipaddr = longint;
 pulong = ^u_long;
function SendARP(DestIP: ipaddr; SrcIP: ipaddr; pMacAddr: pulong;
 PhyAddrLen: pulong): DWORD; stdcall; external 'IPHLPAPI.DLL'     ;












function LocalIP:string;//获得本机的ip地址
type
   TaPInAddr = array [0..10] of PInAddr;
   PaPInAddr = ^TaPInAddr;
var
   phe  : PHostEnt;
   pptr : PaPInAddr;
   Buffer : array [0..63] of char;
   I    : Integer;
   GInitData      : TWSADATA;


BEGIN
   WSAStartup($101, GInitData);
   Result := '';
   GetHostName(Buffer, SizeOf(Buffer));
   phe :=GetHostByName(buffer);
   IF phe = nil THEN Exit;
   pptr := PaPInAddr(Phe^.h_addr_list);
   I := 0;
   while pptr^[I] <> nil do BEGIN
     result:=StrPas(inet_ntoa(pptr^[I]^));
     Inc(I);
   END;
   WSACleanup;
END;
procedure GetMacAddrFromIP(const IP: String;
 var Mac: String);
var
 DestIP: integer;
 pmacaddr: pulong;
 addrlen: u_long;
 macaddr: array[1..6] of byte;
 p: pbyte;
 i: integer;
begin
 DestIP := inet_addr(pchar(IP)); //目标机器的IP地址
 pMacAddr := pulong(@MacAddr);
 AddrLen := sizeof(MacAddr);
 Mac := '';
 if SendARP(DestIP, 0, pMacAddr, @AddrLen) = 0 then
 begin
   p := pbyte(pMacAddr);
   if ((p <> nil) and (AddrLen > 0)) then
   begin
     for i := 1 to AddrLen do
     begin
       Mac := Mac + IntToHex(p^, 2) + '-';
       p := Pointer(Integer(p) + SizeOf(Byte));
     end;
     SetLength(Mac, Length(Mac) - 1);
   end;
 end;
 end;


  function isinteger(value:string):boolean;
  var temp:integer;
  begin
      try
          temp:=strtoint(value);
          result:=true;
      except
          result:=false;
      end;
  end;



{ GrpSelRecord }

constructor TGrpSelRecord.create(aowner: Tcomponent);
begin
  inherited;
  self.BorderStyle :=bsnone;
 // dragkind:=dkDock;
 //DragMode:=dmautoMatic;
  
  self.MtDataset :=Tadodataset.Create(self);
  self.MtDataset.Connection:=    dmfrm.ADOConnection1;

  self.MtDatasource :=TDatasource.Create(self);
  self.MtDatasource.DataSet  :=self.MtDataset ;
  self.OnDblClick :=self.DBLClick;

  Lable:=Tlabel.Create (self);
  Lable.Parent :=self;
  Lable.Caption :='过滤条件:' ;
  Lable.Left :=5;
  Lable.top :=25;

  popupmenu:=Tpopupmenu.Create (self);
  MenuClear:=Tmenuitem.Create(popupmenu);
  MenuAll:=Tmenuitem.Create(popupmenu);

  popupmenu.Items.Add(MenuAll);
  popupmenu.Items.Add(MenuClear);

  MenuClear.Caption :='删除过滤条件';
  MenuClear.OnClick :=    MenuClearClick;

  MenuAll.Caption :='全部';
  MenuAll.OnClick := MenuALLClick ;




end;

procedure TGrpSelRecord.Click(sender: Tobject);
var consql,sql:string;
var i:integer;
var LkpCombo:TdblookupCombobox;
begin
//consql:=self.TargetDbGrid

     for i:=0 to self.ComponentCount -1 do
     begin
         if self.Components[i] is  TdblookupCombobox then
            LkpCombo:= ( self.Components[i]as  TdblookupCombobox  )   ;
     end;

     if   LkpCombo.Text ='' then
     consql:= ''
     else
     begin
        consql:=   LkpCombo.ListSource.DataSet.fieldbyname (LkpCombo.DataField ).AsString ;
        if consql<>'' then
        begin
            listdataset.Edit ;
            listdataset.FieldByName('createtime').AsDateTime  :=now;
            listdataset.FieldByName('UseCount').AsInteger :=listdataset.FieldByName('UseCount').AsInteger+1;
            listdataset.Post ;
        end;
     end;
     self.TargetDbGrid.DataSource.DataSet.Filtered:=false;             //query
     self.TargetDbGrid.DataSource.DataSet.Filter :=  consql;
     self.TargetDbGrid.DataSource.DataSet.Filtered:=true;;



end;

procedure TGrpSelRecord.IniGrpBox(PDbGrid:TDbGrid);
var sql:string;

begin
    self.TargetDbGrid:=  PDbGrid;


    lkpCombobox:=TFhlDbLookupComboBox.Create (self);
    lkpCombobox.Parent :=self;
    lkpCombobox.Top :=lable.Top-2 ;
    lkpCombobox.Left :=   lable.Left +lable.Width +10;
    lkpCombobox.Visible :=true;
    lkpCombobox.DataSource :=self.MtDatasource ;
    lkpCombobox.Width :=120;
    lkpCombobox.DropDownRows:=10;

    lkpCombobox.OnClick :=     Click;
    lkpCombobox.PopupMenu :=self.popupmenu ;


    self.Width :=self.lkpCombobox.Left +self.lkpCombobox.Width +40;

    sql:='select str0  as sqlcon from '+fhlknl1.Connection.DefaultDatabase +'.dbo.Sys_QueryParameters where 1<>1' ;
    self.MtDataset.CommandText :=sql;
    self.MtDataset.Open ;
    self.lkpCombobox.KeyField :='sqlcon';//MtDataset.fieldbyname()
    self.lkpCombobox.DataField :='sqlcon';//
    listdataset:=Tadodataset.Create (self);
    ListDataSource:=TDataSource.Create(self);
    ListDataSource.DataSet :=listdataset;
    listdataset.Connection :=dmfrm.ADOConnection1 ;
//    listdataset.CommandText :='select top 10 * from sys_FilterOrqtyCon where loginid='+quotedstr(logininfo.LoginId )+'  and gridid='+inttostr(self.TargetDbGrid.tag )+' order by Createtime';
    listdataset.CommandText :='select top 10 sqlCon,AlisName ,createtime,UseCount from sys_FilterOrqtyCon where gridid='+inttostr(self.TargetDbGrid.tag )
                            +' union  all '
                            +' select top 1 '+quotedstr('')+','+quotedstr('全部')+'  as AlisName,Getdate() ,0 from sys_FilterOrqtyCon  '
                            +' order by createtime desc , UseCount desc  ';
    listdataset.Open ;

    self.lkpCombobox.ListSource := ListDataSource;
    lkpCombobox.ListField :='AlisName';


    if IsFilter then
     self.Caption :='快捷过滤'
  else
     self.Caption :='快捷查询';
end;

procedure TGrpSelRecord.DBLClick(sender: Tobject);

begin


   

end;

procedure TGrpSelRecord.MenuClearClick(sender: Tobject);
begin

    if listdataset.FieldByName('sqlCon').AsString <>'' then
    begin
     self.MtDataset.FieldByName('sqlcon').Value:=null;
     self.listdataset.Delete ;
    end;
end;

procedure TGrpSelRecord.MenuALLClick(sender: Tobject);
begin
    self.MtDataset.FieldByName('sqlcon').Value:=null;
   // self.listdataset.FieldByName('alisname').AsString :='全部';
    self.Click(self.lkpCombobox );
end;

{ Tedit_Mtn }

constructor Tedit_Mtn.Create(AOwner: TComponent);
begin
    inherited;
    self.ShowHint :=true;
    FieldID:=-1;
    self.BoxId :='-1';
end;

procedure Tedit_Mtn.MouseDown(Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
begin
    if self<>nil then
    begin
      inherited;
      FOldX := Point(X,Y);
    end;
end;

procedure Tedit_Mtn.MouseMove(Shift: TShiftState; X, Y: Integer);
var NewPoint : TPoint;
    tempPoint: TPoint;    
begin
  inherited;
  if Shift=[ssleft] then
  begin
    tempPoint.X :=   Left + X-  FOldX.x;
    tempPoint.Y:=Top + Y- FOldX.Y;
    NewPoint:= tempPoint;
    
    with Self do
      SetBounds(NewPoint.x, NewPoint.Y , Width, Height);
  end;      
end;

 

procedure Tedit_Mtn.SetisUserMode(const Value: Boolean);
begin
  FisUserMode := Value;
end;

procedure Tedit_Mtn.WmNcHitTest(var Msg: TWmNcHitTest);
var
  Pt: TPoint;
  I: Integer;
begin

  FPosList[1] := htTopLeft;         //这里为什么要这么初始化？？？不然不能改控件大小
  FPosList[2] := htTop;
  FPosList[3] := htTopRight;
  FPosList[4] := htRight;
  FPosList[5] := htBottomRight;
  FPosList[6] := htBottom;
  FPosList[7] := htBottomLeft;
  FPosList[8] := htLeft;


  Pt := Point(Msg.XPos, Msg.YPos);
  Pt := ScreenToClient(Pt);
  Msg.Result := 0;

  for I := 1 to 8 do
    if PtInRect(FRectList[I], Pt) then
      Msg.Result := FPosList[I];
  if Msg.Result = 0 then
    inherited;
end;

procedure Tedit_Mtn.WmSize(var Msg: TWmSize);
var
  R: TRect;
begin


  FRectList[1] := Rect(0, 0, 5, 5);
  FRectList[2] := Rect(Width div 2 - 3, 0, Width div 2 + 2, 5);
  FRectList[3] := Rect(Width - 5, 0, Width, 5);
  FRectList[4] := Rect(Width - 5, height div 2 - 3, Width, Height div 2 + 2);
  FRectList[5] := Rect(Width - 5, Height - 5, Width, Height);
  FRectList[6] := Rect(Width div 2 - 3, Height - 5, Width div 2 + 2, Height);
  FRectList[7] := Rect(0, Height - 5, 5, Height);
  FRectList[8] := Rect(0, Height div 2 - 3, 5, Height div 2 + 2);

//====================================================================

end;
{ TGrpQueryRecord }

procedure TGrpQueryRecord.BtnClick(sender: TObject);
var sql,consql:string;

 var i:integer;

begin

    ConSql:=GetSqlCon ;

    if ( self.OptStrLst[self.OptCombobox.Itemindex]= '') or (ConSql='') then
    begin
         showmessage('查询备件出错!')   ;
         exit;
    end;


    fhlknl1.Ds_QuickQuery (FDbgrid.DataSource.DataSet,ConSql) ;

end;

constructor TGrpQueryRecord.create(aowner: Tcomponent);
begin
      inherited create(aowner);
      self.BorderStyle :=bsnone;
    //  dragkind:=dkDock;
    //  DragMode:=dmautoMatic;

      self.LabelName:=Tlabel.Create(nil);
      LabelName.Top :=25;
      LabelName.Left :=5;
      
      self.ComBoxFieldCname:=TFhlComboBox.Create(nil);

      self.TStrLstFieldEname :=Tstringlist.Create ;

      self.OptCombobox :=  TFhlComboBox.Create(nil);

      self.OptStrLst :=Tstringlist.Create ;

      self.ValGroupBox:=Tgroupbox.Create (nil);
      self.Btnqry:=Tspeedbutton.Create(nil);

      self.Sqlexpress :=Tstringlist.Create ;
            LKPFieldValues:=Tstringlist.Create ;
end;

destructor TGrpQueryRecord.destroy;
begin
  self.LabelName.Free;

  self.ComBoxFieldCname.Free;

  self.TStrLstFieldEname.Free;

  self.OptCombobox.Free;

  self.OptStrLst.Free;
  self.ValGroupBox.Free ;
  self.Btnqry.Free;
  self.Sqlexpress.Free ;

  LKPFieldValues.Free;
  inherited;
end;

procedure TGrpQueryRecord.IniQuickQuery(PDbgrid: TDbgrid;Filter:boolean=false);
var i:integer;
begin
    //
      LabelName.Parent :=self;
      LabelName.Caption :='快捷查询：';


      ComBoxFieldCname.Parent :=self;
      ComBoxFieldCname.Top :=self.LabelName.Top -2;
      ComBoxFieldCname.Width :=100;
      ComBoxFieldCname.Left := LabelName.Left +LabelName.Width +10;
      ComBoxFieldCname.OnClick :=     FldComboBoxChange;

      OptCombobox.Parent :=self;
      OptCombobox.Top :=self.LabelName.Top -2;
      OptCombobox.Left :=ComBoxFieldCname.Left +ComBoxFieldCname.Width +10;
      OptCombobox.Width :=100;
      OptCombobox.Items.CommaText :='等于,不等于,大于,小于,大于等于,小于等于,包含,不包含,以...开头,不以...开头,以...结尾,不以...结尾';

      OptStrLst.CommaText :='=,<>,>,<,>=,<=,"like","not like","like x%","not like x%","like %x","not like %x"';

      ValGroupBox.Parent :=self;
      ValGroupBox.Top :=  OptCombobox.Top -20;
      ValGroupBox.Left := OptCombobox.Left+OptCombobox.Width +10;
      ValGroupBox.Caption :='值';
      ValGroupBox.Ctl3D :=true;
      ValGroupBox.Height := OptCombobox.Height+30;

      Btnqry.Parent :=self;
      Btnqry.Top :=self.LabelName.Top-2;
      Btnqry.Left := ValGroupBox.Left +ValGroupBox.Width +20;
      if fileexists( ExtractFileDir(Application.ExeName)+'\pic\btnqry.bmp') then
      Btnqry.Glyph.LoadFromFile(ExtractFileDir(Application.ExeName)+'\pic\btnqry.bmp');
      Btnqry.Width :=60;
      Btnqry.Caption :='查询';
      Btnqry.OnClick :=self.BtnClick;


      self.AutoSize :=true;


      self.FDbgrid := PDbgrid;
      for i:=0  to FDbgrid.Columns.Count -1 do
      begin
          if   Filter then
          begin
              if  ( FDbgrid.Columns[i].Visible ) and (not FDbgrid.Columns[i].ReadOnly  )  then
              begin
                  self.ComBoxFieldCname.Items.Add( FDbgrid.Columns[i].Title.Caption );
                  self.TStrLstFieldEname.Add(FDbgrid.Columns[i].FieldName );
              end;
          end
          else
          begin
              if  ( FDbgrid.Columns[i].Visible )   then
              begin
                  self.ComBoxFieldCname.Items.Add( FDbgrid.Columns[i].Title.Caption );
                  self.TStrLstFieldEname.Add(FDbgrid.Columns[i].FieldName );
              end;
          end;


      end;
end;
procedure TGrpQueryRecord.FldComboBoxChange(Sender: TObject);
 var ft:TFieldType;i:Integer;fld:TField;s:string;
 

begin
 for i:=ValGroupBox.ControlCount-1 downto 0 do
     ValGroupBox.Controls[i].free;



    for i:=0 to  fDBGrid.Columns.Count -1  do
    begin
       if  trim( fDBGrid.Columns[i].FieldName )  =trim(self.TStrLstFieldEname [self.ComBoxFieldCname.itemindex] )    then
       begin
          fld:=fDBGrid.Columns [i].Field  ;//fDataSet.FieldByName ()
          break;
       end;
    end;


    if not assigned(fld) then showmessage('字段查找不误，请联系管理员');
 if fld.FieldKind=fkLookup then begin
       with TFhlComboBox.Create(ValGroupBox) do begin
           Parent:=ValGroupBox;

           LKPFieldValues.Clear ;
            with fld.LookupDataSet do begin
                 First;
                 while not Eof do begin
                   Items.Append(FieldByName(fld.LookupResultField).asString);

                   LKPFieldValues.Add(FieldByName(fld.LookupKeyFields).asString);
                   Next;
                 end;
            end;



       end;
         with self.OptCombobox  do begin
              Items.Clear;
              Items.CommaText:='等于,不等于,大于,小于,大于等于,小于等于,包含,不包含,以...开头,不以...开头,以...结尾,不以...结尾';
         end;
         self.OptStrLst.Clear;
         self.OptStrLst.CommaText:='=,<>,>,<,>=,<=,"like","not like","like x%","not like x%","like %x","not like %x"';
    end
    else begin
      ft:=fld.DataType;
      if ft=ftString then begin
         //创建值编辑对象
         with TfhlEdit.Create(ValGroupBox) do begin
               Parent:=ValGroupBox;
         end;
         //格式化操作符
         with self.OptCombobox  do begin
              Items.Clear;
              Items.CommaText:='等于,不等于,大于,小于,大于等于,小于等于,包含,不包含,以...开头,不以...开头,以...结尾,不以...结尾';
         end;
         self.OptStrLst.Clear;
         self.OptStrLst.CommaText:='=,<>,>,<,>=,<=,"like","not like","like x%","not like x%","like %x","not like %x"';
      end
      else if (ft=ftDate) or (ft=ftDateTime) then begin
         with TDateTimePicker.Create(ValGroupBox) do begin
            Parent:=ValGroupBox;
            DateTime:=now;
         end;
         with self.OptCombobox do begin
              Items.Clear;
              Items.CommaText:='等于,不等于,大于,小于,大于等于,小于等于';
         end;
         self.OptStrLst.Clear;
         self.OptStrLst.CommaText:='=,<>,>,<,>=,<=';
      end
      else if ft=ftBoolean then begin
         with TRadioGroup.Create(ValGroupBox) do begin
            Parent:=ValGroupBox;
            height:=Parent.Height -5;
            align:=alClient;
            Columns:=2;
            s:=TBooleanField(fld).DisplayValues;
            Items.Append(Copy(s,Pos(';',s)+1,Length(s)));
            Items.Append(Copy(s,0,Pos(';',s)-1));
         end;
         with self.OptCombobox  do begin
              Items.Clear;
              Items.CommaText:='等于,不等于';
         end;
         self.OptStrLst.Clear;
         self.OptStrLst.CommaText:='=,<>';
      end
      else if ft=ftMemo then begin
         with TMemo.Create(ValGroupBox) do begin
            Parent:=ValGroupBox;
            Align:=alClient;
            Lines.Clear;
            ScrollBars:=ssVertical;
         end;
         with self.OptCombobox  do begin
              Items.Clear;
              Items.CommaText:='等于,不等于,大于,小于,大于等于,小于等于,包含,不包含,以...开头,不以...开头,以...结尾,不以...结尾';
         end;
         self.OptStrLst.Clear;
         self.OptStrLst.CommaText:='=,<>,>,<,>=,<=,"like","not like","like x%","not like x%","like %x","not like %x"';
      end
      else if (ft=ftCurrency) or (ft=ftInteger) or (ft=ftFloat) then begin
        with TfhlEdit.Create(ValGroupBox) do begin
             Parent:=ValGroupBox;
        end;
         with self.OptCombobox do begin
              Items.Clear;
              Items.CommaText:='等于,不等于,大于,小于,大于等于,小于等于';
         end;
         self.OptStrLst.Clear;
         self.OptStrLst.CommaText:='=,<>,>,<,>=,<=';
      end;
    end;

    with ValGroupBox.Controls[0] do
    begin
        Parent:=ValGroupBox;
        top := 20;
        left:=5;
        width:= ValGroupBox.Width -10;

       // height:=ValGroupBox.height -10;

    end;

    self.OptCombobox.ItemIndex:=0;
   
end;

function TGrpQueryRecord.GetSqlCon: string;
var sql,consql:string;
 var opt,s:wideString;

 ctrl:TControl;
 ft:TFieldtype;
 var i:integer;

Var ObjectField:Tfield;
begin
    if self.ComBoxFieldCname.Text ='' then
    begin
        showmessage('请先选择条件');
        exit;
    end;

    ctrl:=ValGroupBox.Controls[0];
    if ctrl is TEdit then
       fldval:=TEdit(ctrl).Text
    else if ctrl is TComboBox then
       fldval:=TComboBox(ctrl).Items.Strings[TComboBox(ctrl).ItemIndex]
    else if ctrl is TDateTimePicker then
       fldval:=QuotedStr(FormatDateTime('yyyy"-"mm"-"dd',TDateTimePicker(ctrl).DateTime))
    else if ctrl is TRadioGroup then
       fldval:=intTostr(TRadioGroup(ctrl).ItemIndex)
    else if ctrl is TMemo then
       fldval:=TMemo(ctrl).Text;


   for i:=0 to  fDBGrid.Columns.Count -1 do
   begin
             if trim(fDBGrid.Columns[i].FieldName )= trim(self.TStrLstFieldEname[self.ComBoxFieldCname.itemindex] ) then
             begin
                  ObjectField:=fDBGrid.Columns[i].Field     ;
                  break;
             end;
   end;


    fldName:= ObjectField.FieldName ;
    ft := ObjectField.DataType ;

    opt:=self.OptStrLst[self.OptCombobox.ItemIndex];

    if  ObjectField.FieldKind=fkLookup then             //LKP 要做转化
    begin
         fldName:= ObjectField.KeyFields ;
         if TComboBox(ctrl).ItemIndex>-1 then
             fldval:=self.LKPFieldValues [TComboBox(ctrl).ItemIndex]
         else
             fldval:='';
    end;

    if (ft=ftString) or (ft=ftMemo) then
    begin//字符及文本型
       if opt='like' then
          s:=' like ''%'+fldval+'%'''
       else if opt='not like' then
          s:=' not like ''%'+fldval+'%'''
       else if opt='like x%' then
          s:=' like '''+fldval+'%'''
       else if opt='not like x%' then
          s:=' not like '''+fldval+'%'''
       else if opt='like %x' then
          s:=' like ''%'+fldval+''''
       else if opt='not like %x' then
          s:=' not like ''%'+fldval+''''
       else
          s:=' '+opt+' '''+fldval+'''';
    end
    else
      s:=' '+opt+' '+fldval;

    Sqlexpress.Clear ;


    if ((ft=ftString) or (ft=ftMemo))and ( (fldval='') and (opt='=') ) then
         self.Sqlexpress.Append(fldName+s+'  or '+fldName+'=null')
    else if   (ft=ftboolean ) and ( (fldval='0' ) and (opt='=' ) ) then
         self.Sqlexpress.Append(fldName+s+'  or '+fldName+'=null')
    else
         self.Sqlexpress.Append(fldName+s);




    ConSql:= Sqlexpress[0];

    result:=  ConSql;
end;

{ TDbControl }

constructor TDbControl.create;
begin

      self.BindField:=TUserField.Create  ;
      BindField.FieldID :=-1;
      self.ClickAct :=-1;
      self.DBLClickAct :=-1;
      self.ExitAct :=-1;
      CtrlTypeID:=-1;
end;

destructor TDbControl.Destroy;
begin
self.BindField.Free ;
end;

{ TUserField }




{ TQRDBBarCodeImage }

constructor TQRDBBarCodeImage.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);
  ControlStyle := ControlStyle + [csFramed, csOpaque];
  FImage:=TImage.Create(nil);
  Fimage.Top:=0;
  FImage.Left:=0;
  FImage.Width := self.Width ;
  FImage.Height := self.Height ;
  FCenter := True;
  Barcode1 := TAsBarcode.Create(nil);
  Barcode1.Left := 0  ;
  Barcode1.Top:=0;
  Barcode1.Width:=self.Width ;
  Barcode1.Height:=self.Height ;

  
end;

destructor TQRDBBarCodeImage.Destroy;
begin

  freeandnil(Barcode1);
  FImage.Free;
  inherited Destroy;

end;

procedure TQRDBBarCodeImage.GetExpandedHeight(var newheight: extended);
var
  DrawPict: TPicture;
begin
    newheight := self.Height; // default in case of failure.
    DrawPict := TPicture.Create;
    try
      if assigned(FField) and (FField is TBlobField) then
      begin
        DrawPict.Assign(FField);
        newheight := DrawPict.Bitmap.Height;
      end
    finally
       drawpict.free;
    end;
end;

procedure TQRDBBarCodeImage.GetFieldString(var DataStr: string);
begin

end;

function TQRDBBarCodeImage.GetPalette: HPALETTE;
begin
  Result := 0;
 // if FPicture.Graphic is TBitmap then
  //  Result := TBitmap(FPicture.Graphic).Palette;
end;

procedure TQRDBBarCodeImage.LoadPicture;
var barcodeFileName:string;
var JPeg: TJPegImage;
begin
    if not DirectoryExists('barcodeImages') then
      createdir('barcodeImages');

    barcodeFileName := './barcodeImages/'+DataSet.fieldbyname(self.FDataField).AsString +'.jpg';

    self.FImage.Refresh;
    if DataSet.fieldbyname(self.FDataField).AsString <>'' then
    begin
      if self.BarCodeShowText then
      Barcode1.ShowText :=TBarcodeOption(1)
      else
       Barcode1.ShowText :=TBarcodeOption(0);
       
      Barcode1.Left := 1 ;   // self.Left;
      Barcode1.Typ :=  TBarcodeType(self.BarCodeType); //TBarcodeType;// bcCode128C;
      Barcode1.Modul := self.LineWidth;
      Barcode1.Ratio := self.Ratio;
      Barcode1.Height := self.Height-Barcode1.Top;
      Barcode1.Text:=  DataSet.fieldbyname(self.FDataField).AsString;
      Barcode1.ShowText :=   bcoCode ;

      if self.CacheBarcodeImage then
      begin
          if not fileExists(barcodeFileName) then
          begin
              self.FImage.Picture:=nil;
              JPeg:= TJPegImage.Create;
              Barcode1.DrawBarcode(self.FImage.Canvas );
              JPeg.Assign( self.FImage.Picture.Bitmap);
              JPeg.SaveToFile(barcodeFileName);
              freeandnil(JPeg);
           end
           else
              self.FImage.Picture.LoadFromFile(  barcodeFileName );
      end
      else
        Barcode1.DrawBarcode(self.FImage.Canvas );
    end;

      if self.FImage.Picture.Graphic= nil then
       fhlknl1.WriteLog('Graphic nil ')  ;


end;

procedure TQRDBBarCodeImage.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = DataSet) then
    DataSet := nil;

end;

procedure TQRDBBarCodeImage.Paint;
var
  W, H: Integer;
  R: TRect;
  S: string;
begin
  if Field.DisplayLabel<>'' then
  with Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := Color;
    Font := Self.Font;
    if Field <> nil then
      S := Field.DisplayLabel
    else S := Name;
    S := '(' + S + ')';
    W := TextWidth(S);
    H := TextHeight(S);
    R := ClientRect;
    TextRect(R, (R.Right - W) div 2, (R.Bottom - H) div 2, S);
  end;
  Inherited Paint;
end;


procedure TQRDBBarCodeImage.PictureChanged(Sender: TObject);
begin
  FPictureLoaded := True;
  Invalidate;

  fhlknl1.WriteLog('picture changed')
end;

procedure TQRDBBarCodeImage.Prepare;
begin
  inherited Prepare;
  if assigned(FDataSet) then
  begin
    FField := DataSet.FindField(FDataField);
    if Field is TBlobField then
    begin
      Caption := '';
    end;
  end else
    FField := nil;
end;

procedure TQRDBBarCodeImage.Print(OfsX, OfsY: integer);
var
  H: integer;
  Dest: TRect;
  DrawPict: TPicture;
begin
  LoadPicture;

  if parentreport.Exporting then
  begin
       QRPrntr.TQRExportFilter(ParentReport.ExportFilter).acceptgraphic(
                              qrprinter.XPos(OfsX + self.Size.Left),
                              qrprinter.YPos(OfsY+ self.size.top ), self );
  end;
  with QRPrinter.Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := Color;
    //DrawPict := TPicture.Create;
    H := 0;
    try
      {if assigned(FField) and (FField is TBlobField) then
      begin
        DrawPict.Assign(FField);
        if //(DrawPict.Graphic is TBitmap) and
          (DrawPict.Bitmap.Palette <> 0) then
        begin
          H := SelectPalette(Handle, DrawPict.Bitmap.Palette, false);
          RealizePalette(Handle);
        end; }

        // DrawPict.Assign(Fimage.Picture);
        DrawPict := Fimage.Picture ;
        Dest.Left := QRPrinter.XPos(OfsX + Size.Left);
        Dest.Top := QRPrinter.YPos(OfsY + Size.Top);
        Dest.Right := QRPrinter.XPos(OfsX + Size.Width + Size.Left);
        Dest.Bottom := QRPrinter.YPos(OfsY + Size.Height + Size.Top);
        if Stretch then
        begin
          if (DrawPict.Graphic = nil) or DrawPict.Graphic.Empty then
            FillRect(Dest)
          else
            with QRPrinter.Canvas do
              StretchDraw(Dest, DrawPict.Graphic);
        end else
        begin
          IntersectClipRect(Handle, Dest.Left, Dest.Top, Dest.Right, Dest.Bottom);
          Dest.Right := Dest.Left +
            round(DrawPict.Width / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.XFactor);
          Dest.Bottom := Dest.Top +
            round(DrawPict.Height / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.YFactor);
          if Center then OffsetRect(Dest,
            (QRPrinter.XSize(Size.Width) -
              round(DrawPict.Width / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.XFactor)) div 2,
            (QRPrinter.YSize(Size.Height) -
              round(DrawPict.Height / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.YFactor)) div 2);
          QRPrinter.Canvas.StretchDraw(Dest, DrawPict.Graphic);
          //QRPrinter.Canvas.Draw(0,0, DrawPict.Graphic);
          SelectClipRgn(Handle, 0);
        end;

    finally
      if H <> 0 then SelectPalette(Handle, H, True);
      //DrawPict.Free;
    end;
  end;
  inherited Print(OfsX,OfsY);
end;

procedure TQRDBBarCodeImage.ResetWidthHeight(fwidth, fheight: Integer);
begin
//
  width:=fwidth;
  height:=fheight;
  FImage.Width:=self.Width;
  Fimage.Height:=self.Height;

  Barcode1.Width:=self.Width ;
  Barcode1.Height:=self.Height ;
end;

procedure TQRDBBarCodeImage.setBarCodeType(const Value: integer);
begin
  FBarCodeType := Value;
end;

procedure TQRDBBarCodeImage.SetCacheBarcodeImage(const Value: boolean);
begin
  FCacheBarcodeImage := Value;
end;

procedure TQRDBBarCodeImage.SetCenter(Value: Boolean);
begin
  if FCenter <> Value then
  begin
    FCenter := Value;
    Invalidate;
  end;

end;

procedure TQRDBBarCodeImage.SetDataField(const Value: string);
begin
    FDataField := Value;
end;

procedure TQRDBBarCodeImage.SetDataSet(Value: TDataSet);
begin
  FDataSet := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TQRDBBarCodeImage.SetFBarCodeShowText(const Value: boolean);
begin
  FBarCodeShowText := Value;
end;

procedure TQRDBBarCodeImage.SetFormatSerialText(const Value: boolean);
begin
  FFormatSerialText := Value;
end;

procedure TQRDBBarCodeImage.setLineWidth(const Value: integer);
begin
  FLineWidth := Value;
end;


procedure TQRDBBarCodeImage.setRatio(const Value: double);
begin
  FRatio := Value;
end;

procedure TQRDBBarCodeImage.SetShowTextFont(const Value: TFont);
begin
self.Barcode1.SetShowTextFont(value);
end;

procedure TQRDBBarCodeImage.SetStretch(Value: Boolean);
begin
  if FStretch <> Value then
  begin
    FStretch := Value;
    Invalidate;
  end;
end;

procedure TQRDBBarCodeImage.UnPrepare;
begin
  FField := nil;
  inherited Unprepare;

end;
 

{ TQRImageLoader }

constructor TQRImageLoader.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csFramed, csOpaque];
  Width := 105;
  Height := 105;
  FPicture := TPicture.Create;
  
  FPicture.OnChange := PictureChanged;
  FCenter := True;  
end;

destructor TQRImageLoader.Destroy;
begin
  FPicture.Free;
  inherited Destroy;
end;

procedure TQRImageLoader.GetExpandedHeight(var newheight: extended);
var
  DrawPict: TPicture;
begin
    newheight := self.Height; // default in case of failure.
    DrawPict := TPicture.Create;
    try
      if assigned(FField) and (FField is TBlobField) then
      begin
        DrawPict.Assign(FField);
        newheight := DrawPict.Bitmap.Height;
      end
    finally
       drawpict.free;
    end;
end;


procedure TQRImageLoader.GetFieldString(var DataStr: string);
begin
  inherited;

end;

function TQRImageLoader.GetPalette: HPALETTE;
begin
  Result := 0;
  if FPicture.Graphic is TBitmap then
    Result := TBitmap(FPicture.Graphic).Palette;
end;

procedure TQRImageLoader.LoadPicture;
var fileName :string;
begin
   fileName := self.FImageDir +'/'+ self.FDataSet.fieldbyname(self.FDataField ).AsString+'.jpg' ;

   if fileexists(fileName) then 
      self.Picture.LoadFromFile(fileName);
end;

procedure TQRImageLoader.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = DataSet) then
    DataSet := nil;
end;

procedure TQRImageLoader.Paint;
var
  W, H: Integer;
  R: TRect;
  S: string;
begin
  with Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := Color;
    Font := Self.Font;
    if Field <> nil then
      S := Field.DisplayLabel
    else S := Name;
    S := '(' + S + ')';
    W := TextWidth(S);
    H := TextHeight(S);
    R := ClientRect;
    TextRect(R, (R.Right - W) div 2, (R.Bottom - H) div 2, S);
  end;
  Inherited Paint;
end;

procedure TQRImageLoader.PictureChanged(Sender: TObject);
begin
  FPictureLoaded := True;
  Invalidate;
end;

procedure TQRImageLoader.Prepare;
begin
  inherited Prepare;
  if assigned(FDataSet) then
  begin
    FField := DataSet.FindField(FDataField);
    if Field is TBlobField then
    begin
      Caption := '';
    end;
  end else
    FField := nil;
end;

procedure TQRImageLoader.Print(OfsX, OfsY: integer);
var
  H: integer;
  Dest: TRect;
  DrawPict: TPicture;
begin
  self.LoadPicture;

  if parentreport.Exporting then
  begin
         TQRExportFilter(ParentReport.ExportFilter).acceptgraphic(
                              qrprinter.XPos(OfsX + self.Size.Left),
                              qrprinter.YPos(OfsY+ self.size.top ), self );
  end;
  with QRPrinter.Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := Color;
    //DrawPict := TPicture.Create;
    H := 0;
    try
      //if assigned(FField) and (FField is TBlobField) then
      begin
        {DrawPict.Assign(FField);
        if (DrawPict.Graphic is TBitmap) and
          (DrawPict.Bitmap.Palette <> 0) then
        begin
          H := SelectPalette(Handle, DrawPict.Bitmap.Palette, false);
          RealizePalette(Handle);
        end;
        Dest.Left := QRPrinter.XPos(OfsX + Size.Left);
        Dest.Top := QRPrinter.YPos(OfsY + Size.Top);
        Dest.Right := QRPrinter.XPos(OfsX + Size.Width + Size.Left);
        Dest.Bottom := QRPrinter.YPos(OfsY + Size.Height + Size.Top);}

        DrawPict :=self.Picture ;
        if Stretch then
        begin
          if (DrawPict.Graphic = nil) or DrawPict.Graphic.Empty then
            FillRect(Dest)
          else
            with QRPrinter.Canvas do
              StretchDraw(Dest, DrawPict.Graphic);
        end
        else
        begin
        {
          IntersectClipRect(Handle, Dest.Left, Dest.Top, Dest.Right, Dest.Bottom);
          Dest.Right := Dest.Left +
            round(DrawPict.Width / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.XFactor);
          Dest.Bottom := Dest.Top +
            round(DrawPict.Height / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.YFactor);
          if Center then OffsetRect(Dest,
            (QRPrinter.XSize(Size.Width) -
              round(DrawPict.Width / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.XFactor)) div 2,
            (QRPrinter.YSize(Size.Height) -
              round(DrawPict.Height / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.YFactor)) div 2);
          QRPrinter.Canvas.StretchDraw(Dest, DrawPict.Graphic);
          }
          QRPrinter.Canvas.Draw(QRPrinter.XPos(OfsX + Size.Left  ), QRPrinter.YPos(OfsY + Size.Top ), DrawPict.Graphic);
          SelectClipRgn(Handle, 0);
        end;
      end;
    finally
      if H <> 0 then SelectPalette(Handle, H, True);
     
      //DrawPict.Free;
    end;
  end;
  inherited Print(OfsX,OfsY);
end;

procedure TQRImageLoader.ResetWidthHeight(fwidth, fheight: Integer);
begin
  width:=fwidth;
  height:=fheight;
  
end;

procedure TQRImageLoader.SetCenter(Value: Boolean);
begin
  if FCenter <> Value then
  begin
    FCenter := Value;
    Invalidate;
  end;
end;

procedure TQRImageLoader.SetDataField(const Value: string);
begin
  FDataField := Value;
end;

procedure TQRImageLoader.SetDataSet(Value: TDataSet);
begin
  FDataSet := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

 

procedure TQRImageLoader.SetImageDir(Value: string);
begin
self.FImageDir :=Value;
end;

procedure TQRImageLoader.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;


procedure TQRImageLoader.SetStretch(Value: Boolean);
begin
  if FStretch <> Value then
  begin
    FStretch := Value;
    Invalidate;
  end;

end;

procedure TQRImageLoader.UnPrepare;
begin
  FField := nil;
  inherited Unprepare;

end;

{ Tlabel_Mtn }

constructor Tlabel_Mtn.Create(AOwner: TComponent);
begin
    inherited;

    self.Visible :=true;
    self.Hint :='0'         ;
    self.Font.Name :='宋体';
    self.Font.Size:=10;
end;

procedure Tlabel_Mtn.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  if (self<>nil)and (Button=  mbLeft  ) then
  begin
    FOldX := Point(X,Y);
  end;
end;

procedure Tlabel_Mtn.MouseMove(Shift: TShiftState; X, Y: Integer);
var NewPoint : TPoint;
tempPoint: TPoint;  
begin
  inherited;
  if Shift=[ssleft] then
  begin
    tempPoint.X :=   Left + X-  FOldX.x;
    tempPoint.Y:=Top + Y- FOldX.Y;
    NewPoint:= tempPoint;

    with Self do
       SetBounds(NewPoint.x, NewPoint.Y , Width, Height);

  end;

end;


procedure Tlabel_Mtn.SetCollector(value: Tstrings);
begin
self.FCollector :=  value;
end;

procedure Tlabel_Mtn.SetisUserMode(const Value: Boolean);
begin
  FisUserMode := Value;
end;

procedure Tlabel_Mtn.WmNcHitTest(var Msg: TWmNcHitTest);
var
  Pt: TPoint;
  I: Integer;
begin

  FPosList[1] := htTopLeft;         //这里为什么要这么初始化？？？不然不能改控件大小
  FPosList[2] := htTop;
  FPosList[3] := htTopRight;
  FPosList[4] := htRight;
  FPosList[5] := htBottomRight;
  FPosList[6] := htBottom;
  FPosList[7] := htBottomLeft;
  FPosList[8] := htLeft;


  Pt := Point(Msg.XPos, Msg.YPos);
  Pt := ScreenToClient(Pt);
  Msg.Result := 0;

  for I := 1 to 8 do
    if PtInRect(FRectList[I], Pt) then
      Msg.Result := FPosList[I];
  if Msg.Result = 0 then
    inherited;
end;

procedure Tlabel_Mtn.WmSize(var Msg: TWmSize);
var
  R: TRect;
begin             
  FRectList[1] := Rect(0, 0, 5, 5);
  FRectList[2] := Rect(Width div 2 - 3, 0, Width div 2 + 2, 5);
  FRectList[3] := Rect(Width - 5, 0, Width, 5);
  FRectList[4] := Rect(Width - 5, height div 2 - 3, Width, Height div 2 + 2);
  FRectList[5] := Rect(Width - 5, Height - 5, Width, Height);
  FRectList[6] := Rect(Width div 2 - 3, Height - 5, Width div 2 + 2, Height);
  FRectList[7] := Rect(0, Height - 5, 5, Height);
  FRectList[8] := Rect(0, Height div 2 - 3, 5, Height div 2 + 2);

//====================================================================

end;

end.
