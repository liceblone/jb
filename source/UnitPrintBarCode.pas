unit UnitPrintBarCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ActnList, DB, ADODB, StdCtrls,RepBarCode ,FhlKnl,
  ExtCtrls, Menus,UnitGrid,DBGrids, Buttons;

type
   TBarCodeGroupbox=class(Tgroupbox)
   lblLastPrintCaption, lblLastPrintTime, lblBarCodeCaption:Tlabel;
  lblQtyCaption :Tlabel;
  BtnPreview ,BtnPrint :Tbutton;
  txtBarCode,txtQtyValue: TEdit;
  private
    FPackageBarCode: string;
    FBillCode: string;
    FBillDLF_ID:string;
    FBarCodeQty: string;
    FLastPrintTime: string;
    Fdataset:Tdataset;
   public
    { Public declarations }
    property PackageBarCode:string read FPackageBarCode write FPackageBarCode  ;
    property BillCode:string read FBillCode write FBillCode  ;
    property BarCodeQty:string read FBarCodeQty write FBarCodeQty  ;
    property LastPrintTime:string read FLastPrintTime write FLastPrintTime  ;

    procedure createControls(pDataset:Tdataset);

    procedure ButtonPreviewClick(Sender: TObject);
    procedure UpdateLastPrintTime;
end;

type
  TFrmPrintBarCode = class(TForm)
    ActionList1: TActionList;
    AddAction: TAction;
    CopyAction: TAction;
    EditAction: TAction;
    DeleteAction: TAction;
    SaveAction: TAction;
    CancelAction: TAction;
    FirstAction: TAction;
    PriorAction: TAction;
    NextAction: TAction;
    LastAction: TAction;
    CloseAction: TAction;
    ToolBar1: TToolBar;
    ToolButton7: TToolButton;
    FirstBtn: TToolButton;
    PriorBtn: TToolButton;
    NextBtn: TToolButton;
    LastBtn: TToolButton;
    ToolButton12: TToolButton;
    ExtBtn: TToolButton;
    DataSet: TADODataSet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    ToolButton1: TToolButton;
    ActPrint: TAction;
    ToolButton2: TToolButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    pnlContent: TPageControl;
    TabBarCodeInput: TTabSheet;
    ScrollTop: TScrollBox;
    Label5: TLabel;
    LblState: TLabel;
    statLabel1: TLabel;
    PnlLeft: TPanel;
    PnlGrid: TPanel;
    PnlRight: TPanel;
    mtDataSet1: TADODataSet;
    mtDataSource1: TDataSource;
    ActionList2: TActionList;
    MailAction1: TAction;
    PrintAction1: TAction;
    OpenAction1: TAction;
    NewAction1: TAction;
    RemoveAction1: TAction;
    CancelAction1: TAction;
    SaveAction1: TAction;
    CheckAction1: TAction;
    ImportAction1: TAction;
    AppendAction1: TAction;
    DeleteAction1: TAction;
    RefreshAction1: TAction;
    LocateAction1: TAction;
    CloseAction1: TAction;
    HelpAction1: TAction;
    FirstAction1: TAction;
    PriorAction1: TAction;
    NextAction1: TAction;
    ActShowHead: TAction;
    LastAction1: TAction;
    FaxAction1: TAction;
    ActInfo: TAction;
    ActLocate: TAction;
    ActEdit: TAction;
    ActSetBit: TAction;
    ActSaveExecDLProc: TAction;
    UserLog: TAction;
    ActUncheck: TAction;
    ActSaveHaveTextFomula: TAction;
    ActChkChg: TAction;
    ActProperty: TAction;
    actMainLog: TAction;
    InActiveBill: TAction;
    ActiveBill: TAction;
    actMDLookup: TAction;
    Actlock: TAction;
    Actunlock: TAction;
    ActPrintBarCode: TAction;
    ActPrintBarCodeWhMove: TAction;
    ActSLInvoiceCheck: TAction;
    ActSLPrint: TAction;
    ActRemoveBill: TAction;
    ActSLPrint2: TAction;
    dlDataSet1: TADODataSet;
    DlDataSource1: TDataSource;
    MainMenu1: TMainMenu;
    BtnCreateBarCode: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    btnPrintOneBarcode: TToolButton;
    ToolButton6: TToolButton;
    btnPrintAllBarCode: TToolButton;
    procedure FirstActionExecute(Sender: TObject);
    procedure PriorActionExecute(Sender: TObject);
    procedure NextActionExecute(Sender: TObject);
    procedure LastActionExecute(Sender: TObject);
    procedure ActPrintExecute(Sender: TObject);
    procedure CloseActionExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ScrollTopDblClick(Sender: TObject);
    procedure BtnCreateBarCodeClick(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPrintOneBarcodeClick(Sender: TObject);
    procedure btnPrintAllBarCodeClick(Sender: TObject);
    procedure dlDataSet1AfterScroll(DataSet: TDataSet);
    procedure dlDataSet1CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    FParameterDataSet:Tdataset;
    FBillCode :string;
    FDLID :string;
    FBillDLF_ID :string;
    fBillex:TBillDictEx;
    DBGridDL:TModelDbGrid;

  public
    { Public declarations }
    Procedure InitFrm(frmid :string );
    procedure Initial( pBillCode:string; pDataSet:Tdataset;F_IDFieldName :string);overload;
    procedure Initial( pDataSet: Tdataset);overload;

    procedure printBarCode(pbarCode:String);
    procedure PriviewBarCode(pbarCode:String);
    procedure DBLClick(sender: Tobject);
    procedure OpenBill(BillCode: string);
    procedure CloseBill;

  end;

var
  FrmPrintBarCode: TFrmPrintBarCode;

implementation
      uses datamodule,UnitCreateComponent;
{$R *.dfm}


procedure TFrmPrintBarCode.InitFrm(frmid: string);
var i:integer;
begin
      if Not FhlKnl1.Cf_GetDict_Bill_Ex(frmid,fBillex) then Close;     //etDict_Bill

     { self.LblTitle.Caption := fBillex.Maincaption ;;
      self.Caption  := fBillex.Maincaption ;
      if fBillex.ActID<>-1 then
       FhlKnl1.Tb_CreateActionBtns_Ex(self.ToolBar1,self.ActionList1,inttostr(fBillex.ActID),logininfo.EmpId,SELF.FWindowsFID );
              }

       FhlUser.SetDataSet(mtDataSet1,fBillex.mtDataSetId,Null,false);
       if (fBillex.TopBoxID <>'-1')and (fBillex.TopBoxID <>'') then      //top or buttom      create label and dbcontrol
      FhlKnl1.Cf_SetBox( (fBillex.TopBoxId),MtDataSource1,selF.ScrollTop ,dmFrm.dbCtrlActionList1);



      FhlUser.SetDbGridAndDataSet(self.DBGridDL ,fBillex.dlGridId,Null,true,true);
      //fhlknl1.Cf_DeleteDbGridUnAuthorizeCol(fBillex.dlGridId,DBGridDL,logininfo.EmpId ,self.FWindowsFID,logininfo.SysDBPubName) ;
     {  fDbGridColsColor:=VarArrayCreate([0,self.DBGridDL.Columns.Count-1],varVariant);
     for i:=0 to DBGridDL.Columns.Count-1 do
     fDbGridColsColor[i]:=DBGridDL.Columns[i].Color;
      
    OpenCloseAfter(false);    }

end;


procedure TFrmPrintBarCode.Initial( pDataSet: Tdataset);
begin
Initial(self.FBillCode , self.FParameterDataSet, 'moveF_ID');
end;

procedure TFrmPrintBarCode.Initial( pBillCode:string;  pDataSet: Tdataset ; F_IDFieldName: string);
  var
  i, top:integer;
  GrpBox:TBarCodeGroupbox;
  wareid :string;
begin


    FDLID    := pdataset.fieldbyname('dlid').AsString;
    wareid   := pdataset.fieldbyname('wareid').AsString;
    //PhOrdFID
    if pdataset.FindField(F_IDFieldName)<>nil then
        FBillDLF_ID := pdataset.fieldbyname(F_IDFieldName).AsString; 


    FParameterDataset:=pDataset;

    FBillCode := pBillCode;
    dataset.Close;
    DataSet.CommandText:='select *from tbarcodeIO where  FBillDLF_ID ='+quotedstr(FBillDLF_ID)+' order by  FPackageBarcode, FBarCode desc';
    dataset.Open;

    dataset.First;

    self.Height:=ScrollTop.Height+top+200;

    OpenBill(FBillDLF_ID);
      
end;

procedure TFrmPrintBarCode.printBarCode(pbarCode: String);
begin
//
end;

procedure TFrmPrintBarCode.PriviewBarCode(pbarCode: String);
 var RepBillFrm:TRepBarCodeFrm;
 var sql:string;
begin

  RepBillFrm:=TRepBarCodeFrm.Create(nil);
  RepBillFrm.GetPageCfg();
  try
    sql:= 'exec PR_GeneratorBarCode '+quotedstr(self.FBillCode);
    fhlknl1.Kl_GetUserQuery(sql);
    RepBillFrm.SetBillRep(  fhlknl1.User_Query);
    RepBillFrm.PreviewModal;

  finally
    FreeAndNil(RepBillFrm);
    Screen.Cursor:=crDefault;
  end;
     { }
end;

{ TBarCodeGroupbox }



procedure TBarCodeGroupbox.ButtonPreviewClick(Sender: TObject);
 var RepBillFrm:TRepBarCodeFrm;

begin
  UpdateLastPrintTime;
  RepBillFrm:=TRepBarCodeFrm.Create(nil);
  RepBillFrm.GetPageCfg();
  try

    RepBillFrm.SetBillRep(    fhlknl1.Ds_GetBarCodeList(self.FBillDLF_ID,self.FBillCode ,self.FPackageBarCode,'ONE'));
    RepBillFrm.PreviewModal;

  finally
    FreeAndNil(RepBillFrm);
    Screen.Cursor:=crDefault;
  end;
     { }
end;
 

procedure TBarCodeGroupbox.createControls(pDataset:Tdataset);
begin
        self.Fdataset:=pdataset;
        FLastPrintTime:= Fdataset.fieldbyname('FLastPrintTime').AsString;
        FPackageBarCode:=  Fdataset.fieldbyname('FPackageBarCode').AsString;
        FBarCodeQty:=    Fdataset.fieldbyname('FBarCodeQty').AsString;

        lblLastPrintCaption:=Tlabel.Create(self);
        lblLastPrintCaption.Caption:='最后打印时间：';
        lblLastPrintCaption.Parent:=self;
        lblLastPrintCaption.Left:=16;
        lblLastPrintCaption.Top:=8;

        lblLastPrintTime:=Tlabel.Create(self);
        lblLastPrintTime.Caption:= self.FLastPrintTime;
        lblLastPrintTime.Parent:=self;
        lblLastPrintTime.Left:=112;
        lblLastPrintTime.Top:=8;

        lblBarCodeCaption:=Tlabel.Create(self);
        lblBarCodeCaption.Caption:='条码：';
        lblBarCodeCaption.Parent:=self;
        lblBarCodeCaption.Left:=16;
        lblBarCodeCaption.Top:=32;

        lblQtyCaption:=Tlabel.Create(self);
        lblQtyCaption.Caption:='数量：';
        lblQtyCaption.Parent:=self;
        lblQtyCaption.Left:=16;
        lblQtyCaption.Top:=56;

  

        txtBarCode:= TEdit.Create(self);
        txtBarCode.ReadOnly:=true;
        txtBarCode.color:=clScrollBar;
        txtBarCode.Text:= self.FPackageBarCode;
        txtBarCode.Parent:=self;
        txtBarCode.Left:= 112;
        txtBarCode.Top:= 32  ;

        txtQtyValue:= TEdit.Create(self);
        txtQtyValue.ReadOnly:=true;
        txtQtyValue.color:=clScrollBar;
        txtQtyValue.Text:= FBarCodeQty;
        txtQtyValue.Parent:=self;
        txtQtyValue.Left:= 112;
        txtQtyValue.Top:= 56  ;

        BtnPreview:=Tbutton.Create(self);
        BtnPreview.Parent:=self;
        BtnPreview.Caption:='预览打印';
        BtnPreview.Left:= 272;
        BtnPreview.Top:= 24;
        BtnPreview.OnClick:=self.ButtonPreviewClick;

        BtnPrint:=Tbutton.Create(self);
        BtnPrint.Caption:='打印'; 
        BtnPrint.Parent:=self;
        BtnPrint.Left:= 272;
        BtnPrint.Top:= 56;
       // BtnPrint.OnClick:=self.ButtonPrintClick;
end;

procedure TFrmPrintBarCode.FirstActionExecute(Sender: TObject);
begin
  self.FParameterDataSet.First;
  Initial(  self.FParameterDataSet);

end;

procedure TFrmPrintBarCode.PriorActionExecute(Sender: TObject);
begin
self.FParameterDataSet.Prior;
Initial(  self.FParameterDataSet);

end;

procedure TFrmPrintBarCode.NextActionExecute(Sender: TObject);
begin
self.FParameterDataSet.Next;
Initial(  self.FParameterDataSet);

end;

procedure TFrmPrintBarCode.LastActionExecute(Sender: TObject);
begin
self.FParameterDataSet.Last;
Initial(  self.FParameterDataSet);

end;

procedure TFrmPrintBarCode.ActPrintExecute(Sender: TObject);
var dataset: TCustomADODataSet;
var RepBarCodeFrm: TRepBarCodeFrm  ;
begin
  RepBarCodeFrm:=TRepBarCodeFrm.Create(nil);
  RepBarCodeFrm.GetPageCfg();

  try
    if not  dlDataSet1.IsEmpty    then
    begin
      dataset:= fhlknl1.Ds_GetBarCodeList(FBillDLF_ID,'' ,'','ALL' ) ;
      RepBarCodeFrm.SetBillRep( dataset  );
      RepBarCodeFrm.PreviewModal;
    end;

  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFrmPrintBarCode.CloseActionExecute(Sender: TObject);
begin
self.Close;
end;




procedure TBarCodeGroupbox.UpdateLastPrintTime;
begin
//   fdataset.Locate('FPackageBarCode',self.PackageBarCode, []);
    {
   fdataset.Edit;
   fdataset.FieldByName('FlastPrintTIme').Value:=now;
   self.lblLastPrintTime.Caption:=datetimetostr(now);
   fdataset.Post;  }
end;

procedure TFrmPrintBarCode.OpenBill(BillCode: string);
var  i:Integer;
begin
   self.fBillex.BillCode := BillCode;
   FhlKnl1.Ds_OpenDataSet(mtDataSet1,varArrayof([BillCode]));

   if (mtDataSet1.RecordCount<1) and (BillCode<>'0000') then
   begin
     self.fBillex.BillCode:='0000';
     //MessageDlg(#13#10+'没有找到编号为"'+BillCode+'"的单据记录.',mtInformation,[MbYes],0);
     CloseBill;
     Exit;
   end;
   FhlKnl1.Ds_OpenDataSet(dlDataSet1,varArrayof([BillCode]));
   FhlKnl1.SetColFormat(self.DBGridDL  );

   if (not  mtDataSet1.IsEmpty) and (dlDataSet1.IsEmpty )then
   NewAction1.Visible :=false;

   //OpenCloseAfter(true);
end;

procedure TFrmPrintBarCode.CloseBill;
begin
   mtDataSet1.Close;
   dlDataSet1.Close;
   //OpenCloseAfter(false);
end;

procedure TFrmPrintBarCode.DBLClick(sender: Tobject);
var CrtCom:TfrmCreateComponent    ;
begin
    // modeltpe:=Bill;
  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;
    //    CrtCom.fbilldict:=  fbilldict;
    CrtCom.mtDataSet1:= self.dlDataSet1  ;
    CrtCom.mtDataSetId :=inttostr(self.dlDataSet1.tag) ;
    CrtCom.TOPBoxId := (self.fBillex.TopBoxID );
    CrtCom.DLGrid :=self.DBGridDL  ;
    CrtCom.DlGridId :=self.fBillex.dlGridId ;
    CrtCom.TopOrBtm :=true;


    try
    CrtCom.Show;
    finally

    end;

end;
end;
procedure TFrmPrintBarCode.FormCreate(Sender: TObject);
begin
    DBGridDL:=TModelDbGrid.create (self);
    DBGridDL.DataSource :=self.DlDataSource1 ;
    DBGridDL.Align :=alclient;
    DBGridDL.Parent :=PnlGrid;
    DBGridDL.OnDblClick := DBLClick;
    DBGridDL.PopupMenu :=dmFrm.DbGridPopupMenu1 ;
    
end;

procedure TFrmPrintBarCode.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  begin
 if SaveAction1.Enabled then
 begin
   case Key of
     vk_Return:begin
                 if ssCtrl in Shift then
                 begin
                    if  SaveAction1.Visible  then
                    SaveAction1.Execute    ;//.Click
                    if  ActSaveHaveTextFomula.Visible then
                    ActSaveHaveTextFomula.Execute    ;//.Click

                 end  ;

                 if Not (ActiveControl is TDbGrid) then
                 begin

                      FhlKnl1.Vl_DoBoxEnter(ActiveControl) ;
                 end
                 else
                    with TDBGrid(ActiveControl) do
                    begin
                        if FhlKnl1.Dg_SetSelectedIndex(TDbGrid(ActiveControl),False) then
                        begin
                        
                              DataSource.DataSet.Append;
                        end;
                    end;
               end;
     vk_Escape:begin
              CancelAction1.Execute;
             end;
     vk_Delete:begin
                 if DeleteAction1.Visible or logininfo.Sys then
                 DeleteAction1.Execute;
             end;    
             
   end;
 end;

end;


procedure TFrmPrintBarCode.ScrollTopDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ; 
begin
    if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
    begin
        CrtCom:=TfrmCreateComponent.Create(self);
        CrtCom.TOPBoxId :=self.fBillex.TopBoxID  ;
        CrtCom.TopOrBtm:=true;
        CrtCom.mtDataSet1:=self.mtDataSet1  ;
        CrtCom.mtDataSetId :=inttostr(self.mtDataSet1.tag);
        if self.DBGridDL <>nil then
        begin
        CrtCom.DlGridId :=inttostr(self.DBGridDL.Tag ) ;
        CrtCom.DLGrid :=self.DBGridDL ;
        end;
        CrtCom.ShowModal ;
        CrtCom.Free ;
    end;
end;

procedure TFrmPrintBarCode.BtnCreateBarCodeClick(Sender: TObject);
var sql:string;
begin
    if mtDataSet1.State in [dsEdit, dsInsert] then
        mtDataSet1.Post;

    if (mtDataSet1.fieldbyname('FQtyItems').Value =null )  then
    begin
       MessageDlg('请输入数量.',mtWarning,[mbOk],0);
       abort;
    end;
   
    mtDataSet1.UpdateBatch;

    sql:= 'exec PR_GeneratorBarCode '+quotedstr( mtDataSet1.fieldbyname('FBillCode').AsString ) ;
    sql:= sql +','+quotedstr( mtDataSet1.fieldbyname('FBillDLF_ID').AsString ) ;
    sql:= sql +','+quotedstr( mtDataSet1.fieldbyname('FQtyitems').AsString ) ;
    sql:= sql +','+quotedstr( mtDataSet1.fieldbyname('FpackageQty').AsString ) ;

    fhlknl1.Kl_GetUserQuery(sql);
    self.dlDataSet1.Close;
    self.dlDataSet1.Open;
    Initial(  self.FParameterDataSet );
    
end;

procedure TFrmPrintBarCode.ToolButton3Click(Sender: TObject);
var sql:string;
begin
    //delete  TBarcodeIO where    FBillDLF_ID= '62E39227-DF72-4FC3-95EE-3510A09F7CCB'
   
    sql:= 'delete  TBarcodeIO where    FBillDLF_ID=  '+quotedstr( mtDataSet1.fieldbyname('FBillDLF_ID').AsString ) ;
    fhlknl1.Kl_GetUserQuery(sql,false);
    self.dlDataSet1.Close;
    self.dlDataSet1.Open;
end;

procedure TFrmPrintBarCode.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//    if RepBarCodeFrm<>nil then
//        freeandnil(RepBarCodeFrm);
end;

procedure TFrmPrintBarCode.btnPrintOneBarcodeClick(Sender: TObject);
 var RepBillFrm:TRepBarCodeFrm;
 var FPackageBarCode:string;
begin
 // UpdateLastPrintTime;
  RepBillFrm:=TRepBarCodeFrm.Create(nil);
  RepBillFrm.GetPageCfg();
  try
     FPackageBarCode := self.dlDataSet1.fieldbyname('FPackageBarCode').AsString ;
     
     RepBillFrm.SetBillRep(    fhlknl1.Ds_GetBarCodeList(self.FBillDLF_ID,self.FBillCode ,FPackageBarCode,'ONE'));
    RepBillFrm.PreviewModal;

  finally
    FreeAndNil(RepBillFrm);
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFrmPrintBarCode.btnPrintAllBarCodeClick(Sender: TObject);
var dataset: TCustomADODataSet;
var RepBarCodeFrm: TRepBarCodeFrm  ;
begin
  RepBarCodeFrm:=TRepBarCodeFrm.Create(nil);
  RepBarCodeFrm.GetPageCfg();

  try
    if not  dlDataSet1.IsEmpty    then
    begin
      dataset:= fhlknl1.Ds_GetBarCodeList(FBillDLF_ID,'' ,'','ALL' ) ;
      RepBarCodeFrm.SetBillRep( dataset  );
      RepBarCodeFrm.Print ;
    end;

  finally
    Screen.Cursor:=crDefault;
  end;
end;
procedure TFrmPrintBarCode.dlDataSet1AfterScroll(DataSet: TDataSet);
begin
     statLabel1.Caption:=intTostr(dlDataSet1.RecNo)+'/'+intTostr(dlDataSet1.RecordCount);

end;

procedure TFrmPrintBarCode.dlDataSet1CalcFields(DataSet: TDataSet);
begin
      if dataset.FindField('MyIndex')<>nil then
      begin
            with DataSet do begin
                   FieldByName('MyIndex').asInteger:=Abs(RecNo);//Is fkCalculated
                   if ((FindField(fBillex.DlPriceFld )<>nil ) and  ( FindField(fBillex.DlFundFld )<>nil) ) then

                      FieldByName(fBillex.DlFundFld ).asCurrency:=FieldByName(fBillex.QtyFld ).asFloat*FieldByName(fBillex.DlPriceFld).asFloat;

            end;
      end;
end;

end.
