unit UnitBillEx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ActnList, DB, ADODB, ToolWin, Grids, DBGrids,FhlKnl, StrUtils,
   UnitLookUpImport, datamodule,  StdCtrls, ExtCtrls,UnitGrid,UnitModelFrm,DBCtrls  ,UPublic
  , UnitSearchBarCode,UnitCommonInterface ,UnitPublicFunction   , UnitChyGrid  ,quickrpt
  ,XPMenu, FR_Class ,UnitBarcodePrintingProgress;

type
  TFrmBillEx = class(TFrmModel,IParentSearch)
    Panel1: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    ScrollTop: TScrollBox;
    Label3: TLabel;
    ToolBar1: TToolBar;
    mtDataSource1: TDataSource;
    DlDataSource1: TDataSource;
    dlDataSet1: TADODataSet;
    mtDataSet1: TADODataSet;
    ActionList1: TActionList;
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
    LastAction1: TAction;
    FaxAction1: TAction;
    MainMenu1: TMainMenu;
    ToolButton2: TToolButton;
    LblState: TLabel;
    PnlRight: TPanel;
    PnlLeft: TPanel;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ActInfo: TAction;
    PnlFunction: TPanel;
    ControlBar1: TControlBar;
    ToolBar2: TToolBar;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    BtnShowHead: TToolButton;
    ActShowHead: TAction;
    BtnRecLocate: TToolButton;
    ActLocate: TAction;
    GroupBox1: TGroupBox;
    CmbFlds: TComboBox;
    EdtValues: TEdit;
    Label2: TLabel;
    Label1: TLabel;
    LblTitle: TLabel;
    PnlGrid: TPanel;
    ActEdit: TAction;
    ToolButton8: TToolButton;
    ActSetBit: TAction;
    ActSaveExecDLProc: TAction;
    UserLog: TAction;
    ToolButton9: TToolButton;
    ActUncheck: TAction;
    PgBarSave: TProgressBar;
    ActSaveHaveTextFomula: TAction;
    ActChkChg: TAction;
    ActProperty: TAction;
    actMainLog: TAction;
    statLabel1: TLabel;
    btnCtrl: TToolButton;
    InActiveBill: TAction;
    ActiveBill: TAction;
    actMDLookup: TAction;
    PnlContent: TPanel;
    PnlBtm: TPanel;
    ScrollBtm: TScrollBox;
    Actlock: TAction;
    Actunlock: TAction;
    ActPrintBarCode: TAction;
    ActPrintBarCodeWhMove: TAction;
    ActSLInvoiceCheck: TAction;
    ActSLPrint: TAction;
    ActRemoveBill: TAction;
    ActSLPrint2: TAction;
    ActCreateWhmove: TAction;
    ActBarCodeInput: TAction;
    SplitterLeft: TSplitter;
    ActChkSL_Invoice: TAction;
    ActTransBill: TAction;
    ActSaveSl_invoice: TAction;
    ActOri: TAction;
    ActCreateSLinvoice: TAction;
    ActSort: TAction;
    ActPrintLabelCfg: TAction;
    ActPlateLabelPreview: TAction;
    ActSaveWoOwner: TAction;
    ActOutItemPrintLabel: TAction;
    ActPlatePrintLabel: TAction;
    ActPerPartNoPlateLabelPreview: TAction;
    ActPlateClientBarCodePreviewByWare: TAction;
    ActPlateClientBarCodePreviewWholeBill: TAction;
    ActPrintBarCodePhOrd: TAction;
    ActPlateClientBarCodePrintWholeBill: TAction;
    ActPrintEveryPackageLabel: TAction;
    ActPlateClientBarCodePreviewWholeBillV2: TAction;
    ActCreateDeliveryLabel: TAction;
    ActDeliveryLabelPrint: TAction;
    ActMulFormatPrint: TAction;
    procedure OpenCloseAfter(IsOpened:Boolean);
    procedure SetCtrlStyle(fEnabled:Boolean);
    procedure SetRitBtn;
    procedure RefreshLockButton;
    function  isChecked:boolean;
    procedure SetCheckStyle(IsChecked:Boolean);
    procedure SetBillStyle(fReadOnly:Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseBill;
    procedure EditPostAfter(IsEnabled:Boolean);
    procedure ScrollTopDblClick(Sender: TObject);
    procedure ScrollBtmDblClick(Sender: TObject);
    procedure DBGridDLDblClick(Sender: TObject);
    procedure dlDataSet1CalcFields(DataSet: TDataSet);
    procedure dlDataSet1AfterPost(DataSet: TDataSet);
    procedure DlDataSource1StateChange(Sender: TObject);
    procedure mtDataSource1StateChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridDLExit(Sender: TObject);
    procedure OpenAction1Execute(Sender: TObject);
    procedure CloseAction1Execute(Sender: TObject);
    procedure CancelAction1Execute(Sender: TObject);
    procedure UpdateSysFieldsAndCalValue;
    procedure Ds_UpdateAllRecs(fGrid:Tdbgrid;fFields,fValues:Variant;PPgBarSave:Tprogressbar ;DelOnCalEvent:boolean=true);
    procedure SaveAction1Execute(Sender: TObject);
    procedure ImportAction1Execute(Sender: TObject);
    procedure CheckAction1Execute(Sender: TObject);
    procedure ActInfoExecute(Sender: TObject);
    procedure FirstAction1Execute(Sender: TObject);
    procedure PriorAction1Execute(Sender: TObject);
    procedure NextAction1Execute(Sender: TObject);
    procedure LastAction1Execute(Sender: TObject);
    procedure AppendAction1Execute(Sender: TObject);
    procedure NewAction1Execute(Sender: TObject);
    procedure DeleteAction1Execute(Sender: TObject);
    procedure dlDataSet1AfterScroll(DataSet: TDataSet);
    procedure ActSaveWithOutDLExecute(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure ActRemMchSvPayExecute(Sender: TObject);
    procedure ActlocateExecute(Sender: TObject);
    procedure CmbFldsChange(Sender: TObject);
    procedure EdtValuesKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActDeleteExecute(Sender: TObject);
    procedure ActSlAftMchOrderExecute(Sender: TObject);
    procedure BtnRecLocateClick(Sender: TObject);
    procedure ActShowHeadExecute(Sender: TObject);
    procedure PnlBtmDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure RemoveAction1Execute(Sender: TObject);
    procedure ActEditExecute(Sender: TObject);
    procedure ActSetBitExecute(Sender: TObject);
    procedure PrintAction1Execute(Sender: TObject);
    procedure ActSaveExecDLProcExecute(Sender: TObject);
    procedure ActUncheckExecute(Sender: TObject);
    procedure RefreshAction1Execute(Sender: TObject);
    procedure ActSaveHaveTextFomulaExecute(Sender: TObject);
    procedure ActChkChgExecute(Sender: TObject);
    procedure UserLogExecute(Sender: TObject);
    procedure ActPropertyExecute(Sender: TObject);
    procedure btnCtrlClick(Sender: TObject);
    procedure InActiveBillExecute(Sender: TObject);
    procedure ActiveBillExecute(Sender: TObject);
    procedure actMDLookupExecute(Sender: TObject);
    procedure ActlockExecute(Sender: TObject);
    procedure SetLock(lock:boolean);
    procedure ActunlockExecute(Sender: TObject);
    procedure ActPrintBarCodeExecute(Sender: TObject);
    procedure GeneratorBarcode(F_IDFieldName:string) ;
    procedure ActPrintBarCodeWhMoveExecute(Sender: TObject);
    procedure ActSLInvoiceCheckExecute(Sender: TObject);
    procedure ActSLPrintExecute(Sender: TObject);
    procedure ActRemoveBillExecute(Sender: TObject);
    procedure ActSLPrint2Execute(Sender: TObject);
    procedure HidePriceAmtFields(  hide:boolean);
    procedure ActCreateWhmoveExecute(Sender: TObject);
    procedure ActBarCodeInputExecute(Sender: TObject);
    procedure ActChkSL_InvoiceExecute(Sender: TObject);
    procedure ActTransBillExecute(Sender: TObject);
    procedure ActSaveSl_invoiceExecute(Sender: TObject);
    procedure ActOriExecute(Sender: TObject);
    procedure ActCreateSLinvoiceExecute(Sender: TObject);
    procedure ActSortExecute(Sender: TObject);
    procedure ActPrintLabelCfgExecute(Sender: TObject);
    procedure ActPlateLabelPreviewExecute(Sender: TObject);
    procedure ActSaveWoOwnerExecute(Sender: TObject);
    procedure ActOutItemPrintLabelExecute(Sender: TObject);
    procedure ActPlatePrintLabelExecute(Sender: TObject);
    procedure ActPerPartNoPlateLabelPreviewExecute(Sender: TObject);
    procedure ActPlateClientBarCodePreviewByWareExecute(Sender: TObject);
    procedure ActPlateClientBarCodePreviewWholeBillExecute(Sender: TObject);
    procedure ActPrintBarCodePhOrdExecute(Sender: TObject);
    procedure ActPlateClientBarCodePrintWholeBillExecute(Sender: TObject);
    procedure ActPrintEveryPackageLabelExecute(Sender: TObject);
    procedure ActPlateClientBarCodePreviewWholeBillV2Execute( Sender: TObject);
    procedure ActCreateDeliveryLabelExecute(Sender: TObject);
    procedure ActDeliveryLabelPrintExecute(Sender: TObject);
    procedure ActMulFormatPrintExecute(Sender: TObject);

  private
    { Private declarations }
    F_ParamData:TDataset;
    fBillex:TBillDictEx;
    fOpenBillDict:TLkpImportDict;
    fOpenImportDict:TLkpImportDict;
    fDbGridColsColor:Variant;
    FrmLoopUpImPortEx:TFrmLoopUpImPortEx      ;//相关
    FrmImPort:TFrmLoopUpImPortEx      ;              //录入
    F_FlagFldName,F_FlagCompeleteState:string;
    isDesc : boolean;
    BackOnCalcFields: TDataSetNotifyEvent ;
    DBGridDL:TChyDbGrid;
    listBarCodeQty:Tstringlist;
    frmSearchBarCode:TFrmSearchBarCode ;
    FrmOpenForm:TFrmLoopUpImPortEx ;
    

  public
    PAuthoriseTmpTable:string;
    Procedure InitFrm(frmid :string );
    Procedure OpenBill(BillCode :string );
    procedure SetParamDataset(PDataset:Tdataset);
    procedure DBLClick(sender :Tobject);
    function  FirstCommarSection(Pstr:string):string;
    procedure  BarCodeSearch(BarCodeList:TStringList);
    procedure  AppendRecord(fdataSet:TdataSet);
    function   AddBarCode :boolean;
    function   RemoveBarCode :boolean;
    procedure  EnableDsCaculation(enabled:boolean) ;
    procedure SetIsPrinted;
    function  AftSaveBillExecute:boolean;
    procedure RefreshLookUpDataset;
    procedure DBGrid1DrawColumnCellFntClr(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure CheckAllowToSave(actionName:string);
    procedure GetBarcodeFolder (bDeleteImages:Boolean);
 
    { Public declarations }
  end;

const
  cBillManId='F_BillManId';
  cIsChk='F_IsChk';
  cChkTime='F_ChkTime';

var
  FrmBillEx: TFrmBillEx;

implementation
        uses   Editor,   UnitCreateComponent,UPublicFunction,UnitFrmAnalyserEx  ,UnitMDLookupImport  ,UnitPrintLabel
         ,RepBarCode, UnitPrintBarCode,TabGrid, repbill,UnitPickWareshouse, UnitPickSLOrderDL, UnitClientBarcodePrint
         ,UnitDeliveryLabel ,UnitMulPrintModule;
{$R *.dfm}

procedure TFrmBillEx.InitFrm(frmid: string);
var i:integer;
begin
      if Not FhlKnl1.Cf_GetDict_Bill_Ex(FrmId,fBillex) then Close;     //etDict_Bill

      self.LblTitle.Caption := fBillex.Maincaption ;;
      self.Caption  := fBillex.Maincaption ;
      if fBillex.ActID<>-1 then
       FhlKnl1.Tb_CreateActionBtns_Ex(self.ToolBar1,self.ActionList1,inttostr(fBillex.ActID),logininfo.EmpId,SELF.FWindowsFID );

       FhlUser.SetDataSet(mtDataSet1,fBillex.mtDataSetId,Null,false);
       if (fBillex.TopBoxID <>'-1')and (fBillex.TopBoxID <>'') then      //top or buttom      create label and dbcontrol
      FhlKnl1.Cf_SetBox( (fBillex.TopBoxId),MtDataSource1,selF.ScrollTop ,dmFrm.dbCtrlActionList1);

      if (fBillex.BtmBoxID<>'-1')and (fBillex.BtmBoxID<>'')   then
      FhlKnl1.Cf_SetBox( (fBillex.BtmBoxId),MtDataSource1,SELF.PnlBtm  ,dmFrm.dbCtrlActionList1);

      FhlUser.SetDbGridAndDataSet(self.DBGridDL ,fBillex.dlGridId,Null,true,true);
      //fhlknl1.Cf_DeleteDbGridUnAuthorizeCol(fBillex.dlGridId,DBGridDL,logininfo.EmpId ,self.FWindowsFID,logininfo.SysDBPubName) ;
        fDbGridColsColor:=VarArrayCreate([0,self.DBGridDL.Columns.Count-1],varVariant);
     for i:=0 to DBGridDL.Columns.Count-1 do
     fDbGridColsColor[i]:=DBGridDL.Columns[i].Color;

     OpenCloseAfter(false);
     if (self.fBillex.ImportID ='-1') or (self.fBillex.ImportID ='') then
     ImportAction1.Visible :=false;

     if trim(self.fBillex.ChkProc) =''  then
     begin
        CheckAction1.Visible :=false ;
        ActChkSL_Invoice.Visible :=false ;
     end;
     if (self.fBillex.ChkFieldName ='' )  then
         LblState.Visible :=false;

end;

procedure TFrmBillEx.OpenBill(BillCode: string);
var  i:Integer;
begin
   self.fBillex.BillCode := BillCode;
   FhlKnl1.Ds_OpenDataSet(mtDataSet1,varArrayof([BillCode]));
   if self.frmSearchBarCode<> nil then
        frmSearchBarCode.OpenBill(BillCode);

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

   OpenCloseAfter(true);

   self.DBGridDL.Refresh;
end;

procedure TFrmBillEx.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if listBarCodeQty<>nil then
        freeandnil(listBarCodeQty);

    if PAuthoriseTmpTable<>'' then
        fhlknl1.Kl_GetQuery2('drop table '+ PAuthoriseTmpTable  ,false );
     Action:=caFree;
end;

procedure TFrmBillEx.OpenAction1Execute(Sender: TObject);
begin
    if FrmOpenForm = nil then
    begin
        FrmOpenForm:=TFrmLoopUpImPortEx.Create(nil);
        FrmOpenForm.Visible:=false;
        FrmOpenForm.iniFrm(self.fBillex.OpenID );
        FrmOpenForm.Height:=500;
    end;
    FrmOpenForm.ShowModal ;

    if FrmOpenForm.ModalResult =mrok then
    begin
        self.OpenBill(FrmOpenForm.dlDataSet1.fieldbyname(self.fBillex.mkeyfld ).AsString );
    end;
end;
procedure TFrmBillEx.OpenCloseAfter(IsOpened:Boolean);
var i:integer;
begin
  if (self.mtDataSet1.LockType = ltReadOnly ) and (self.dlDataSet1.locktype=ltReadOnly)   then
  begin
    NewAction1.Enabled:=false;
    CloseAction1.Enabled:=true;
    exit;
  end;

  if IsOpened then
     SetRitBtn
  else
  begin
    for i:=0 to ToolBar1.ButtonCount -1 do
    begin
       if ToolBar1.Buttons[i].Action<>nil then
       Taction(ToolBar1.Buttons[i].Action).Enabled :=false;
    end;
    NewAction1.Enabled:=true;
    OpenAction1.Enabled :=true;
    FirstAction1.Enabled:=((F_ParamData<>nil) and ( F_ParamData.Active ));
    PriorAction1.Enabled:=FirstAction1.Enabled;
    LastAction1 .Enabled:=FirstAction1.Enabled;
    NextAction1 .Enabled:=FirstAction1.Enabled;
  end;

  if   self.mtDataSet1.State in  [dsEdit,dsinsert] then
    CloseAction1.Enabled :=false
  else
    CloseAction1.Enabled :=true ;

  if not IsOpened then
       SetCtrlStyle(IsOpened);


end;
procedure TFrmBillEx.SetCtrlStyle(fEnabled:Boolean);
 var bkColor:TColor;
begin
  // dmFrm.SetDataSetStyle(mtDataSet1,fReadOnly);
  if fEnabled then
    bkColor:=clWhite
  else
    bkColor:=clCream;
  // bkColor:=clWhite;

  FhlKnl1.Vl_SetCtrlStyle(bkColor,self.ScrollTop ,fEnabled);
  FhlKnl1.Vl_SetCtrlStyle(bkColor,self.PnlBtm ,fEnabled);
  FhlKnl1.Dg_SetDbGridStyle(self.DBGridDL ,not  fEnabled,bkColor,fDbGridColsColor);
end;
procedure TFrmBillEx.SetRitBtn;
var LstChkState:Tstrings;
begin
    PrintAction1.Enabled:= ( mtDataSet1.Active ) and ( not mtDataSet1.IsEmpty  ) ;
    ActSort.Enabled:= ( mtDataSet1.Active ) and ( not mtDataSet1.IsEmpty  ) ;
    ActOri.Enabled :=  ( mtDataSet1.Active ) and ( not mtDataSet1.IsEmpty  ) ;
    ActSLPrint.Enabled :=printAction1.Enabled;
    ActSLPrint2.Enabled :=printAction1.Enabled;
    ActTransBill.Enabled :=printAction1.Enabled;
    MailAction1.Enabled:=true;
    FaxAction1.Enabled:=true;
    NewAction1.Enabled:=true;
    RemoveAction1.Enabled:= (not mtDataSet1.IsEmpty );
    ActRemoveBill.Enabled :=  RemoveAction1.Enabled;
    ActInfo.Enabled :=true;
    ActProperty.Enabled :=true;
    SetCheckStyle(isChecked);

    if fBillex.IsNeedEdit then  //2007-7-16
    begin
        SetCheckStyle(FALSE);
    end
    else 
    begin
        if trim(fbillex.IsChkValue)='' then
        if mtDataSet1.findfield(cIsChk)<>nil then
           SetCheckStyle(mtDataSet1.FieldByName(cIsChk).AsBoolean);
    end;

    RefreshLockButton;
end;
procedure TFrmBillEx.SetCheckStyle(IsChecked:Boolean);
begin
  if (trim(self.fBillex.ChkFieldName) <>'' ) then
  LblState.Visible :=true;
  if IsChecked then begin
     SetBillStyle(IsChecked);
     RemoveAction1.Enabled:=false and (not mtDataSet1.IsEmpty );
     ActRemoveBill.Enabled :=  RemoveAction1.Enabled;
     LblState.caption :='已审';
  end
  else begin
     SetBillStyle(false);
     RemoveAction1.Enabled:= (not mtDataSet1.IsEmpty );
     ActRemoveBill.Enabled :=  RemoveAction1.Enabled;
     LblState.caption :='未审';
  end;

  CheckAction1.Enabled :=  (not IsChecked ) and (not mtDataSet1.IsEmpty );
  ActChkSL_Invoice.Enabled :=CheckAction1.Enabled;
  ActSLInvoiceCheck.Enabled :=CheckAction1.Enabled ;

  ActPrintBarCode.Enabled :=not  SaveAction1.Enabled   ;
  ActCreateDeliveryLabel.Enabled :=not  SaveAction1.Enabled   ;
  ActPrintBarCodeWhMove.Enabled  :=not  SaveAction1.Enabled   ;
  ActPrintBarCodePhOrd .Enabled  :=not  SaveAction1.Enabled   ;
  ActPrintLabelCfg.Enabled       := mtDataSet1.RecordCount >0  ;
  ActPlatePrintLabel.Enabled     := ActPrintLabelCfg.Enabled   ;
  ActPlateClientBarCodePreviewByWare.enabled := ActPrintLabelCfg.Enabled   ;
  ActPlateClientBarCodePreviewWholeBill.enabled := ActPrintLabelCfg.Enabled   ;
  ActPlateClientBarCodePreviewWholeBillV2.enabled := ActPrintLabelCfg.Enabled   ;
  ActPlateClientBarCodePrintWholeBill.enabled := ActPrintLabelCfg.Enabled   ;
  ActPerPartNoPlateLabelPreview .Enabled     := ActPrintLabelCfg.Enabled   ;
  ActPlateLabelPreview .Enabled     := ActPrintLabelCfg.Enabled   ;
  ActOutItemPrintLabel.Enabled   := ActPrintLabelCfg.Enabled   ;
  ActPrintEveryPackageLabel.Enabled   := ActPrintLabelCfg.Enabled   ;
  ActDeliveryLabelPrint.Enabled   := ActPrintLabelCfg.Enabled   ;
  ActMulFormatPrint.Enabled   := ActPrintLabelCfg.Enabled   ;
  ActCreateWhmove.Enabled        :=not  SaveAction1.Enabled and IsChecked   ;


  ActUncheck.Enabled :=IsChecked ;
  ActChkChg.Enabled :=IsChecked ;
  ActCreateSLinvoice.Enabled  := IsChecked ;
  if (( self.mtDataSet1.FindField ('FisCls')<>nil)and (IsChecked )) then
  begin
     //( TToolButton(actClose.ActionComponent))   .Visible:=not mtDataSet1.FieldByName('FisCls').AsBoolean ;
     //( TToolButton(actBillOpen.ActionComponent)).Visible:=    mtDataSet1.FieldByName('FisCls').AsBoolean ;
    InActiveBill.Enabled  :=not mtDataSet1.FieldByName('FisCls').AsBoolean ;
    ActiveBill.Enabled :=not InActiveBill.Enabled  ;
  end
  else
  begin
    InActiveBill.Enabled  :=false;
    ActiveBill.Enabled :=false;
  end;
  
end;
procedure TFrmBillEx.SetBillStyle(fReadOnly:Boolean);
begin
 //set btn.enabled to false
// LinkAction1.Enabled:=Not fReadOnly;
 ImportAction1.Enabled:=Not fReadOnly;

 ActBarCodeInput.Enabled  := true;
 actMDLookup.Enabled:=Not fReadOnly;

 AppendAction1.Enabled:=( Not fReadOnly ) ;
 DeleteAction1.Enabled:= ( Not fReadOnly )  ;
 SetCtrlStyle(Not fReadOnly);
end;
procedure TFrmBillEx.CloseAction1Execute(Sender: TObject);
begin
self.Close;
end;


procedure TFrmBillEx.ScrollTopDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ; 
begin
  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;
//    CrtCom.fbilldict:=  fbilldict;
    CrtCom.mtDataSet1:= self.mtDataSet1 ;
    CrtCom.mtDataSetId :=self.fBillex.mtDataSetId ;
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

procedure TFrmBillEx.ScrollBtmDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
begin
// modeltpe:=Bill;
  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;
//    CrtCom.fbilldict:=  fbilldict;
    CrtCom.mtDataSet1:= self.mtDataSet1 ;
    CrtCom.mtDataSetId :=self.fBillex.mtDataSetId ;
     CrtCom.TOPBoxId := (self.fBillex.BtmBoxID  );
   CrtCom.DLGrid :=self.DBGridDL  ;
   CrtCom.DlGridId :=self.fBillex.dlGridId ;
    CrtCom.TopOrBtm :=false;
 

try
    CrtCom.Show;
finally

end;
 end;
end;

procedure TFrmBillEx.DBGridDLDblClick(Sender: TObject);
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

procedure TFrmBillEx.dlDataSet1CalcFields(DataSet: TDataSet);
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

procedure TFrmBillEx.CancelAction1Execute(Sender: TObject);
begin 

  if MessageDlg(fsDbCancel,mtConfirmation,[mbYes,mbNo],0)=mrYes then
  begin
      if self.dlDataSet1.State in [dsinsert,dsedit] then
      self.dlDataSet1.Cancel;

      if self.mtDataSet1.State in [dsinsert,dsedit] then
      self.mtDataSet1.Cancel;
      CloseBill ;
      OpenBill(fBillex.BillCode);
   end;

end;

procedure TFrmBillEx.CloseBill;
begin
   mtDataSet1.Close;
   dlDataSet1.Close;
   OpenCloseAfter(false);
end;
procedure TFrmBillEx.UpdateSysFieldsAndCalValue;
var  sql:string;
var i:integer;
begin

  //  update  FLstEditEmp  FlstEditTime  FPhoneticize
     {
   sql:='select B.NameField   ,B.TableEname  '
       +'  From T201 A '
       +'  join ' +logininfo.SysDBPubName+'.dbo.Tallusertable B on A.F16=B.TableEname '
       +'  where B.FisBasicTable=1 and  A.f01 ='+inttostr(mtDataSet1.Tag );
   fhlknl1.Kl_GetQuery2(sql);
   if not fhlknl1.FreeQuery.IsEmpty then
   begin
        if mtDataSet1.FindField (fhlknl1.FreeQuery.FieldByName('NameField').AsString )<>nil then
          if mtDataSet1.FindField ('FPhoneticize')<>nil then
            if mtDataSet1.FieldByName (fhlknl1.FreeQuery.FieldByName('NameField').AsString).Value<>null then
              mtDataSet1.FieldByName ('FPhoneticize').Value := GetHZPY(mtDataSet1.FieldByName (fhlknl1.FreeQuery.FieldByName('NameField').AsString).Value );
   end;
     }

   if  mtDataSet1.FindField  ('FLstEditEmp') <>nil then
       mtDataSet1.FieldByName ('FLstEditEmp').Value :=  logininfo.EmpId ;
   if  mtDataSet1.FindField  ('FlstEditTime') <>nil then
       mtDataSet1.FieldByName ('FlstEditTime').Value :=now;


end;

procedure TFrmBillEx.Ds_UpdateAllRecs(fGrid:TDBgrid;fFields,fValues:Variant;PPgBarSave:Tprogressbar;DelOnCalEvent:boolean=true);
var bk:Pointer;
var i:integer;
var BackOnCalcFields: TDataSetNotifyEvent ;
var fDataSet:TDataSet;

function isFieldVisiable(pFieldName:string)  :Boolean ;
var rlt:Boolean;
var i:integer;
begin
    rlt:=false;
    for i:=0 to fGrid.Columns.Count -1 do
    if  (fGrid.Columns[i].FieldName = pFieldName ) and (fGrid.Columns[i].Visible ) then
    begin
      rlt:=True;
      Break;
    end;
    result:= rlt;
end;

begin
     fDataSet:= fGrid.DataSource.DataSet ;

     PPgBarSave.Visible :=true;
     PPgBarSave.Max :=fDataSet.RecordCount ;
      
     with fDataSet do
     begin
       bk:=GetBookmark;
     //  DisableControls;
       First;
       while not Eof do
       begin
          application.ProcessMessages ;
          PPgBarSave.Position := fDataSet.RecNo ;
          if trim(fBillex.DlPriceFld)<>'' then
            if  dlDataSet1.FindField(fBillex.DlPriceFld)<>nil then
              if  dlDataSet1.FieldByName(fBillex.DlPriceFld  ).Value = null  then
              begin
                 showmessage('请填写单价!');
                 abort;
              end   ;

          for i:=0 to fDataSet.Fields.Count -1 do
          begin
            if  (fDataSet.Fields[i].FieldKind  <> fkCalculated ) then
            if fDataSet.Fields[i] is TFloatFieldEx then
              if TFloatFieldEx (fDataSet.Fields[i]).CalField <>'' then
              begin
              
                if fDataSet.findfield(   TFloatFieldEx (fDataSet.Fields[i]).CalField)<>nil then
                begin
                    fDataSet.Edit;
                    if fDataSet.fieldbyname(   TFloatFieldEx (fDataSet.Fields[i]).CalField).Value =null then
                      fDataSet.Fields[i].Value :=0
                    else
                      if fDataSet.Fields[i].Value=null then
                        fDataSet.Fields[i].Value := fDataSet.fieldbyname(   TFloatFieldEx (fDataSet.Fields[i]).CalField).Value
                      else
                        if not isFieldVisiable(fDataSet.Fields[i].FieldName ) then
                           fDataSet.Fields[i].Value := fDataSet.fieldbyname(   TFloatFieldEx (fDataSet.Fields[i]).CalField).Value
                        else
                           fDataSet.Fields[i].Value:=fDataSet.Fields[i].Value;
                    fDataSet.Post;
                end;

              end;
          end;

          if dlDataSet1.findField(fBillex.QtyFld  )<>nil then
            if dlDataSet1.FieldByName(fBillex.QtyFld  ).AsFloat    = 0    then
            begin
               showmessage('请填写数量!');
               abort;
            end ;
         BackOnCalcFields:= fDataSet.OnCalcFields ;
         if DelOnCalEvent then
         fDataSet.OnCalcFields :=nil ;
         FHLKNL1.Ds_AssignValues(fDataSet,fFields,fValues,False);
         fDataSet.OnCalcFields :=BackOnCalcFields ;
         Next;
       end;
         
       //     EnableControls;
       GotoBookmark(bk);
     end;
     PPgBarSave.Visible :=false;
end;

procedure TFrmBillEx.SaveAction1Execute(Sender: TObject);
var  s,ss,f:widestring;
//var  fDict:TBeforePostDict;
var  pKeys,DLKeyFLDs:Tstrings;
var i:integer;
var MtValues:variant;
var BackOnCalcFields ,BackUpDLBeforePost: TDataSetNotifyEvent ;
begin
// if (ImportAction1.ActionComponent <>nil) and TToolbutton(ImportAction1.ActionComponent ).Down then
 //   TToolbutton(ImportAction1.ActionComponent ).Click;

 try
    CheckAllowToSave( (sender as Taction).Name );
    if self.dlDataSet1.State in [dsinsert ,dsEdit	] then
    begin
       dlDataSet1.Post;
    end;
    if    dlDataSet1.RecordCount <1 then
    begin
       showmessage('请加明细记录!');
       abort;
    end;
    
    Screen.Cursor:=CrSqlWait;
      //AutoKey
      if (mtDataSet1.State=dsInsert) and (fBillex.AutoKeyId<>'') then
      begin
         if fBillex.BillCode='0000' then
         begin
           fBillex.BillCode:=dmFrm.GetMyId(fBillex.AutoKeyID );
             try
               pKeys:=Tstringlist.Create ;
               pKeys.CommaText :=   fBillex.mkeyfld;
               for i:=0 to pKeys.Count -1 do
               begin
                  mtDataSet1.FieldByName(pKeys[i]).AsString:=fBillex.BillCode;
               end;
             finally
                freeandnil(pKeys) ;
             end;
           end;
      end;

      BackUpDLBeforePost:= dlDataSet1.BeforePost ;
      dlDataSet1.BeforePost:=nil;
      if  mtDataSet1.State in [dsedit,dsInsert]  then
      begin
        UpdateSysFieldsAndCalValue;
      end;
      DLKeyFLDs:=Tstringlist.Create ;
      DLKeyFLDs.CommaText :=fBillex.fkeyfld;
      MtValues :=FhlKnl1.Ds_GetFieldsValue(mtDataSet1,fBillex.mkeyfld);
      BackOnCalcFields:= dlDataSet1.OnCalcFields ;
     // dlDataSet1.OnCalcFields :=nil;                //加快保存速度
      Ds_UpdateAllRecs(Self.DBGridDL , fBillex.fkeyfld ,  MtValues  ,self.PgBarSave ,false  );
      freeandnil(DLKeyFLDs) ;
      dlDataSet1.BeforePost :=BackUpDLBeforePost ;
      try
           dmfrm.ADOConnection1.BeginTrans ;
           mtDataSet1.UpdateBatch;
           dlDataSet1.UpdateBatch;  //调换了个顺序 ,影响所有bill模板

           if (frmSearchBarCode<>nil) and not frmSearchBarCode.BarCodeDataSet.IsEmpty   then
           begin
               frmSearchBarCode.Save(fBillex.BillCode); 
           end;
       //   dlDataSet1.OnCalcFields:=BackOnCalcFields ;
      except
          on err:exception do
          begin
            //  EditPostAfter(True);
            dmfrm.ADOConnection1.RollbackTrans ;
            Screen.Cursor:=crDefault;
            showmessage(err.Message );
            exit;
          end;
      end;
      dmfrm.ADOConnection1.CommitTrans ;

      if not   self.AftSaveBillExecute  then
      begin
           abort;
      end
      else
          EditPostAfter(True);

      
  finally
     Screen.Cursor:=crDefault;
  end;
end;
procedure TFrmBillEx.EditPostAfter(IsEnabled:Boolean);
begin
    if IsEnabled then
       SetRitBtn
    else
    begin
     NewAction1.Enabled:=IsEnabled;
     RemoveAction1.Enabled:=IsEnabled and (not mtDataSet1.IsEmpty );
     ActRemoveBill.Enabled :=  RemoveAction1.Enabled;
     CheckAction1.Enabled:=IsEnabled and (not mtDataSet1.IsEmpty );
     ActChkSL_Invoice.Enabled := CheckAction1.Enabled;
     ActSLInvoiceCheck.Enabled :=CheckAction1.Enabled ;

     ActPrintBarCode.Enabled        :=not  SaveAction1.Enabled and not CheckAction1.Enabled ;
     ActCreateDeliveryLabel.Enabled :=not  SaveAction1.Enabled and not CheckAction1.Enabled ;
     ActPrintBarCodeWhMove.Enabled :=not  SaveAction1.Enabled and not CheckAction1.Enabled ;
     ActPrintBarCodePhOrd.Enabled :=not  SaveAction1.Enabled and not CheckAction1.Enabled ;
     ActPrintLabelCfg.Enabled      :=mtDataSet1.RecordCount >0  ;
     ActPlatePrintLabel.Enabled          := ActPrintLabelCfg.Enabled   ;
     ActPlateClientBarCodePreviewByWare.enabled           := ActPrintLabelCfg.Enabled   ;
     ActPlateClientBarCodePreviewWholeBill.enabled        := ActPrintLabelCfg.Enabled   ;
     ActPlateClientBarCodePreviewWholeBillV2.enabled      := ActPrintLabelCfg.Enabled   ;
     ActPlateClientBarCodePrintWholeBill.enabled          := ActPrintLabelCfg.Enabled   ;
     ActPerPartNoPlateLabelPreview.Enabled := ActPrintLabelCfg.Enabled   ;
     ActPlateLabelPreview .Enabled         := ActPrintLabelCfg.Enabled   ;
     ActOutItemPrintLabel.Enabled          := ActPrintLabelCfg.Enabled   ;
     ActPrintEveryPackageLabel.Enabled     := ActPrintLabelCfg.Enabled   ;
     ActDeliveryLabelPrint .Enabled         := ActPrintLabelCfg.Enabled   ;
     ActMulFormatPrint.Enabled   := ActPrintLabelCfg.Enabled   ;
     ActCreateWhmove.Enabled               := not  SaveAction1.Enabled  and not CheckAction1.Enabled ;
    end;
    OpenAction1.Enabled:=IsEnabled;
    RefreshAction1.Enabled:=IsEnabled;
    FirstAction1.Enabled:=((F_ParamData<>nil) and ( F_ParamData.Active ));
    PriorAction1.Enabled:=FirstAction1.Enabled;
    NextAction1.Enabled:=FirstAction1.Enabled;
    LastAction1.Enabled:=FirstAction1.Enabled;
    CloseAction1.Enabled:=IsEnabled;
    PrintAction1.Enabled:=IsEnabled;
    MailAction1.Enabled:=IsEnabled;
    FaxAction1.Enabled:=IsEnabled;
    SaveAction1.Enabled:=Not IsEnabled;
    ActSaveWoOwner.Enabled:=Not IsEnabled;
    ActSaveExecDLProc.Enabled  :=SaveAction1.Enabled;
    self.ActSaveHaveTextFomula.Enabled :=SaveAction1.Enabled;
    ActSaveSl_invoice.Enabled  :=SaveAction1.Enabled;
    CancelAction1.Enabled:=Not IsEnabled;
    ActEdit.Enabled  :=not SaveAction1.Enabled;
  //  ActOri.Enabled := IsEnabled;

    RefreshLockButton;
end;

procedure TFrmBillEx.ImportAction1Execute(Sender: TObject);
begin
    if FrmImPort=nil then
    begin
        FrmImPort:=TFrmLoopUpImPortEx.Create(nil);
        FrmImPort.BillCodeField :=self.fBillex.mkeyfld;
        FrmImPort.iniFrm(self.fBillex.ImportID,'',self.dlDataSet1 ,self.mtDataSet1 ,self.DBGridDL  );
        FrmImPort.AutoSize :=true;
        FrmImPort.Visible:=true;
        FrmImPort.Dock(self.ScrollBtm,FrmImPort.ClientRect    );
        FrmImPort.Align :=alclient  ;
    end  ;

    ScrollBtm.Visible :=TToolbutton(Taction(Sender).ActionComponent ).Down ;
    if ScrollBtm.Visible then
    begin
        self.WindowState  := wsMaximized;
    end;

   FrmImPort.Visible:=  TToolbutton(Taction(Sender).ActionComponent ).Down ;
   PnlBtm.Visible :=not TToolbutton(Taction(Sender).ActionComponent ).Down ;
   if    PnlBtm.Visible then
    PnlBtm.Height := MaxContolTop(PnlBtm);
    if (FrmImPort.ActiveControl<>nil) and FrmImPort.Visible  and FrmImPort.Enabled  then
      FrmImPort.SetFocusEditor; 

end;
procedure TFrmBillEx.dlDataSet1AfterPost(DataSet: TDataSet);
begin
    FhlKnl1.Ds_AssignValues(mtDataSet1,self.fBillex.mtSumFlds ,FhlKnl1.Ds_SumFlds(DataSet,self.fBillex.dlSumFlds),false,false);
end;

procedure TFrmBillEx.DlDataSource1StateChange(Sender: TObject);
begin
  if (DlDataSource1.State=dsEdit) or (DlDataSource1.State=dsInsert) then begin
     DBGridDL.Options:=DBGridDL.Options-[dgColumnResize];
     EditPostAfter(false);
  end
  else
     DBGridDL.Options:=DBGridDL.Options+[dgColumnResize];
end;

procedure TFrmBillEx.mtDataSource1StateChange(Sender: TObject);
begin
  if (MtDataSource1.State=dsEdit) or (MtDataSource1.State=dsInsert) then
     EditPostAfter(false);
end;

procedure TFrmBillEx.CheckAction1Execute(Sender: TObject);
begin
  if self.mtDataSet1.IsEmpty then exit;
  Screen.Cursor:=CrSqlWait;
  try
    FhlUser.CheckRight(fBillex.ChkRightId );
    if   dmFrm.ExecStoredProc(fBillex.chkproc,varArrayof([fBillex.billcode,LoginInfo.EmpId,LoginInfo.LoginId]), true) then
    begin

    end;
    OpenBill(fBillex.BillCode);
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFrmBillEx.ActInfoExecute(Sender: TObject);
begin
    if   (self.mtDataSet1.Active ) and (not self.mtDataSet1.IsEmpty )then
    begin
          if FrmLoopUpImPortEx=nil then
          begin
          FrmLoopUpImPortEx:=TFrmLoopUpImPortEx.Create(self);
          FrmLoopUpImPortEx.AutoSize :=true;
          FrmLoopUpImPortEx.Align :=altop ;
          FrmLoopUpImPortEx.Dock(self.ScrollBtm,FrmLoopUpImPortEx.ClientRect    );
          FrmLoopUpImPortEx.iniFrm(inttostr(Taction(Sender).ActionComponent.Tag  ),'',self.mtDataSet1 );
          FrmLoopUpImPortEx.Visible:=true;
          end
          else
          FrmLoopUpImPortEx.Visible :=TToolbutton(Taction(Sender).ActionComponent ).Down ;
    
    end
    else
    begin
        TToolbutton(Taction(Sender).ActionComponent ).Down:=false ;
        showmessage('请先选择订购单');
    end;

end;

procedure TFrmBillEx.FirstAction1Execute(Sender: TObject);
begin
  if (F_ParamData<>nil) and ( F_ParamData.Active )then
  begin
      F_ParamData.First ;
      self.OpenBill(F_ParamData.FieldValues [  FirstCommarSection(fBillex.mkeyfld)] ) ;
  end;
end;

procedure TFrmBillEx.PriorAction1Execute(Sender: TObject);
begin
  if (F_ParamData<>nil) and ( F_ParamData.Active )then
  begin
      F_ParamData.Prior ;
          while (F_ParamData.FieldValues [FirstCommarSection(fBillex.mkeyfld)] =self.fBillex.BillCode )and   (not F_ParamData.Bof)do
      F_ParamData.Prior ;
      self.OpenBill(F_ParamData.FieldValues [FirstCommarSection(fBillex.mkeyfld)] ) ;
  end;
end;

procedure TFrmBillEx.NextAction1Execute(Sender: TObject);
begin
  if (F_ParamData<>nil) and ( F_ParamData.Active )then
  begin
      F_ParamData.Next ;
      while (F_ParamData.FieldValues [FirstCommarSection(fBillex.mkeyfld)] =self.fBillex.BillCode )and   (not F_ParamData.Eof)do
        F_ParamData.Next;

      self.OpenBill(F_ParamData.FieldValues [FirstCommarSection(fBillex.mkeyfld)] ) ;
  end;
end;

procedure TFrmBillEx.LastAction1Execute(Sender: TObject);
begin
  if (F_ParamData<>nil) and ( F_ParamData.Active )then
  begin
      F_ParamData.Last  ;
      self.OpenBill(F_ParamData.FieldValues [FirstCommarSection(fBillex.mkeyfld)] ) ;
  end;
end;

procedure TFrmBillEx.SetParamDataset(PDataset: Tdataset);
begin
self.F_ParamData :=PDataset;
end;
 
procedure TFrmBillEx.FormKeyDown(Sender: TObject; var Key: Word;
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
                    if  ActSaveSl_invoice.Visible then
                     ActSaveSl_invoice.Execute;
                    if ActSaveWoOwner.Visible then
                       ActSaveWoOwner.Execute ;
                 end ;

                 if Not (ActiveControl is TDbGrid) then
                 begin
                    if ((FrmImPort<>nil) and (FrmImPort.ActiveControl<>nil) ) then
                    begin
                      if (ActiveControl.Parent= FrmImPort.ScrollBoxCtrlPanel) then
                          FrmImPort.OpnDlDsBtn1.Click    ; 
                    end
                    else
                      FhlKnl1.Vl_DoBoxEnter(ActiveControl) ;
                 end
                 else if ((FrmImPort<>nil) and (ActiveControl= FrmImPort.DBGridDL) ) then
                 begin
                      FrmImPort.ActPick.Execute ;
                      self.DBGridDL.SetFocus;
                 end
                 else if (ActiveControl = self.DBGridDL) then
                    with TDBGrid(ActiveControl) do
                    begin
                        if FhlKnl1.Dg_SetSelectedIndex(TDbGrid(ActiveControl),False) then
                        begin
                          if (FrmImPort<>nil) and (FrmImPort.Visible) then
                              FrmImPort.SetFocusEditor  
                          else
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
 end else
 begin
   case Key of
     vk_Escape:begin
             CloseAction1.Execute;
             end;
             {  }
     vk_Insert:begin
              if ssCtrl in Shift then
              begin
                 if self.ActEdit.Visible or logininfo.sys then
                 ActEdit.Execute  ;
              end
              else
                 if self.NewAction1.Visible or logininfo.Sys then
                 NewAction1.Execute ;
             end;

     vk_Delete:begin
                 if DeleteAction1.Visible or logininfo.Sys then
                 DeleteAction1.Execute;
             end;    

     vk_Home:FirstAction1.Execute;//.Click;
     vk_End:LastAction1.Execute;//.Click;
     vk_Prior:priorAction1.Execute;
     vk_Next:nextAction1.Execute;
     vk_Print:
     begin
         if (printAction1.Visible)  then
             printAction1.Execute;

         if ActSLPrint.Visible then
            ActSLPrint.Execute ;
     end;
      vk_Return:begin
                     if self.FrmImPort <>nil then
                      FrmImPort.OpnDlDsBtn1.Click ;
                 end;

   end;
 end;

end;

procedure TFrmBillEx.AppendAction1Execute(Sender: TObject);
begin
if    not (dlDataSet1.LockType = ltReadOnly) then
 dlDataSet1.Append;
end;

procedure TFrmBillEx.DBGridDLExit(Sender: TObject);
begin
    if self.dlDataSet1.State in [dsinsert,dsedit] then
    begin
        self.dlDataSet1.Post;
    end;

end;

procedure TFrmBillEx.NewAction1Execute(Sender: TObject);
begin
    if    not (mtDataSet1.LockType = ltReadOnly) then
    begin
      OpenBill('0000');
      RefreshLookUpDataset;
      FhlUser.AssignDefault(mtDataSet1,false);
      mtDataSet1.Append;
      FhlKnl1.Vl_FocueACtrl(ScrollTop);
      listBarCodeQty.Clear;

    end;
end;
procedure TFrmBillEx.RefreshLookUpDataset;
var i:integer;
begin
    for i:=0 to self.dlDataSet1.FieldCount -1 do
    begin
        if dlDataSet1.Fields[i].FieldKind =fkLookup then
           if dlDataSet1.Fields[i].DataSet<>nil then
           begin
              dlDataSet1.Fields[i].DataSet.Close;
              dlDataSet1.Fields[i].DataSet.Open ;
           end;

    end;
end;
procedure TFrmBillEx.DeleteAction1Execute(Sender: TObject);
begin
    if    not (dlDataSet1.LockType = ltReadOnly) then
    begin
       if not dlDataSet1.IsEmpty then
       begin
          dlDataSet1.Delete;
          EditPostAfter(false);
          //  dlDataSet1.Refresh;
          dlDataSet1AfterPost(self.dlDataSet1);
       end;
    end;
end;


procedure TFrmBillEx.dlDataSet1AfterScroll(DataSet: TDataSet);
begin
     statLabel1.Caption:=intTostr(dlDataSet1.RecNo)+'/'+intTostr(dlDataSet1.RecordCount);
end;

procedure TFrmBillEx.ActSaveWithOutDLExecute(Sender: TObject);
var  s,ss,f:widestring;
//var  fDict:TBeforePostDict;
//var  pKeys:Tstrings;
var i:integer;


begin

 { if    dlDataSet1.RecordCount <1 then
    begin
       showmessage('请加明细记录!');
       abort;
    end;  }

    if trim(fBillex.DlPriceFld)<>'' then
    if  dlDataSet1.FieldByName(fBillex.DlPriceFld  ).Value = null  then
    begin
       showmessage('请填写单价!');
       abort;
    end   ;
    if trim(fBillex.QtyFld)<>'' then
    if   dlDataSet1.FieldByName(fBillex.QtyFld  ).Value = null  then
    begin
       showmessage('请填写数量!');
       abort;
    end   ;

    Screen.Cursor:=CrSqlWait;


        //AutoKey
        if (mtDataSet1.State=dsInsert) and (fBillex.AutoKeyId<>'') then
        begin
                 fBillex.BillCode:=dmFrm.GetMyId(fBillex.AutoKeyID );
                 mtDataSet1.FieldByName(fBillex.mkeyfld).AsString:=fBillex.BillCode;
        end;


       Ds_UpdateAllRecs(self.DBGridDL ,varArrayof([fBillex.fkeyfld ]),varArrayof([fBillex.BillCode]),self.PgBarSave );
       if self.dlDataSet1.State in [dsinsert ,dsEdit	] then
       begin
            dlDataSet1.Post;
       end;

       //if mtDataSet1.State in [dsinsert ,dsEdit	] then
                 begin
                          try

                               mtDataSet1.UpdateBatch;
                               dlDataSet1.UpdateBatch;  //调换了个顺序 ,影响所有bill模板
                          except
                                  on err:exception do
                                  begin
                                    //  EditPostAfter(True);
                                    Screen.Cursor:=crDefault;
                                    showmessage(err.Message );
                                      exit;
                                  end;
                          end;
          end;
        {   }
        EditPostAfter(True);
     Screen.Cursor:=crDefault;
end;

procedure TFrmBillEx.Action1Execute(Sender: TObject);
//var UserQkRpt1 :TUserQkRpt;
var bk:TBookmark;
begin
    {
  Screen.Cursor:=crSqlWait;

  UserQkRpt1:=TUserQkRpt.Create(Application);
  try
    UserQkRpt1.SetBillRep( (self.fBillex.TopBoxId), (fBillex.BtmBoxId),self.mtDataSet1 ,self.DBGridDL ,fBillex.Maincaption );
    UserQkRpt1.PreviewModal;//Preview;
  finally
    FreeAndNil(UserQkRpt1);
    Screen.Cursor:=crDefault;
  end;
   }
end;

procedure TFrmBillEx.ActRemMchSvPayExecute(Sender: TObject);
begin

 sDefaultVals:='';
 sDefaultVals:='F_SourceBillCode='+self.mtDataSet1.fieldbyname('F_MchReturnID').AsString  +','  ;
  sDefaultVals:=sDefaultVals+'F_note='+'残机扣款：'+self.mtDataSet1.fieldbyname('F_MchReturnID').AsString +','  ;
  sDefaultVals:=sDefaultVals+'F_PayerSvCode='+ self.mtDataSet1.fieldbyname('F_SvCenterCode').AsString  ;


 TEditorFrm(FhlUser.ShowEditorFrm('125',self.mtDataSet1.fieldbyname('F_MchReturnID').AsString ,nil)).ShowModal;
end;

procedure TFrmBillEx.ActlocateExecute(Sender: TObject);
var i:integer;
begin
  PnlFunction.Visible :=TToolbutton(Taction(Sender).ActionComponent ).Down ;



      if CmbFlds.Items.Count =0 then
      begin
          for i:=0 to DBGridDL.Columns.Count-1 do
          begin
              if DBGridDL.Columns[i].Visible  then
              CmbFlds.Items.Add(DBGridDL.Columns[i].Title.Caption  );
          end;
          CmbFlds.ItemIndex :=0;
          CmbFlds.Hint :=DBGridDL.Columns[0].FieldName  ;
      end ;

end;

procedure TFrmBillEx.CmbFldsChange(Sender: TObject);
var i:integer;
begin

      for i:=0 to self.DBGridDL.Columns.Count -1 do
      begin
             if  DBGridDL.Columns[i].Title.Caption =   CmbFlds.Text  then
                   if self.dlDataSet1.FieldByName(DBGridDL.Columns[i].FieldName).FieldKind in [fkData]   then
                     CmbFlds.Hint:=DBGridDL.Columns[i].FieldName ;
      end ;

end;

procedure TFrmBillEx.EdtValuesKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var LstChkState:Tstrings;
begin
  inherited; 
    if EdtValues.Text <>'' then
    begin
      if  self.dlDataSet1.Locate(CmbFlds.Hint,EdtValues.Text ,[]) then
         if dlDataSet1.FindField('IsLocated')<>nil then
         begin
            if mtDataSet1.FindField(fBillex.ChkFieldName)<>nil then
            begin
                  LstChkState:=Tstringlist.Create ;
                  LstChkState.CommaText :=fbillex.IsChkValue;
                   if not LstChkState.IndexOf( mtDataSet1.FieldByName (fBillex.ChkFieldName).AsString )>-1 then
                   begin
                      dlDataSet1.Edit ;
                      dlDataSet1.Fieldbyname('IsLocated').AsBoolean :=true;
                      dlDataSet1.Post ;
                   end;


                  LstChkState.Free ;
            end;


         end;

       self.DBGridDL.SelectedIndex :=dlDataSet1.RecNo ;
    end;
end;

procedure TFrmBillEx.ActDeleteExecute(Sender: TObject);
begin
    if MessageDlg(#13#10+'确定要删除吗？',mtInformation,[mbOk,mbCancel],0)=mrOk then
         if not dlDataSet1.IsEmpty then
         begin
         dlDataSet1.Delete;
         if  (  dlDataSet1.LockType in [ltBatchOptimistic]) then
         begin
             EditPostAfter(false);
             dlDataSet1.Refresh;
         end;
         end;
 
end;

procedure TFrmBillEx.ActSlAftMchOrderExecute(Sender: TObject);
var  FrmBillEx:TFrmBillEx;
begin
  FrmBillEx:=TFrmBillEx.Create(nil);
       FrmBillEx.InitFrm('1027');
       if mtDataSet1.fieldbyname('F_MchApplyID').AsString  <>'' then 
        FrmBillEx.OpenBill( mtDataSet1.fieldbyname('F_MchApplyID').AsString  );
       FrmBillEx.FormStyle :=fsnormal;
       FrmBillEx.Hide;
     //  FrmBillEx.AutoSize:=true;
      FrmBillEx.Position :=poDesktopCenter;
       FrmBillEx.ScrollBtm.Visible :=true;
    //   FrmBillEx.SetParamDataset(self.dlAdoDataSet1 );
      
  sDefaultVals:='';
  sDefaultVals:='F_OrderType=1,'  ;
  sDefaultVals:=sDefaultVals+'F_MchReturnID='+ self.mtDataSet1.fieldbyname('F_MchReturnID').AsString  +','  ;
  sDefaultVals:=sDefaultVals+'F_note='+'售后还机：'+self.mtDataSet1.fieldbyname('F_MchReturnID').AsString ;


   FrmBillEx.ShowModal ;
end;

procedure TFrmBillEx.BtnRecLocateClick(Sender: TObject);
begin
PnlFunction.Visible := BtnRecLocate.Down;
end;

procedure TFrmBillEx.ActShowHeadExecute(Sender: TObject);
begin
self.ScrollTop.Visible :=self.BtnShowHead.Down;
end;

procedure TFrmBillEx.PnlBtmDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
    //    FrmUserDefineReport1: TFrmUserDefineReport;
begin
  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then  
  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;
    CrtCom.mtDataSet1:= self.mtDataSet1 ;
    CrtCom.mtDataSetId :=self.fBillex.mtDataSetId ;
    CrtCom.TOPBoxId := (self.fBillex.BtmBoxID );
    CrtCom.DLGrid :=self.DBGridDL  ;
    CrtCom.DlGridId :=self.fBillex.dlGridId ;
    CrtCom.TopOrBtm :=true;
    try
    CrtCom.Show;
    finally

    end;
  end;
end;

procedure TFrmBillEx.DBGrid1DrawColumnCellFntClr(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var i:integer;
var color:TColor;
begin
  if DBGridDL.DataSource.DataSet.IsEmpty then exit;

  if   dlDataSet1.FindField('FntClr') <>nil then
  begin
      DBGridDL.Canvas.Font.Color:=StringToColor(dlDataSet1.FieldByName('FntClr').AsString);
      FhlKnl1.Dg_DrawLineFont(Sender,Rect,DataCol,Column,State,DBGridDL.Canvas.Font);
  end
  else
  begin
      i:=  DBGridDL.CurrentRow    ;
      if  i   = dlDataSet1.RecNo   then
      begin
         color:=StringToColor('clblue');
      end
      else
         color:=StringToColor('clblack');

      DBGridDL.Canvas.Font.Color := color ;
      FhlKnl1.Dg_DrawLineFont(Sender,Rect,DataCol,Column,State,DBGridDL.Canvas.Font);
  end;

end;

procedure TFrmBillEx.FormCreate(Sender: TObject);
begin
    listBarCodeQty:= Tstringlist.Create;
    DBGridDL:=TChyDbGrid.create (self);
    DBGridDL.DataSource :=self.DlDataSource1 ;
    DBGridDL.Align :=alclient;
    DBGridDL.Parent :=PnlGrid;
    DBGridDL.OnDblClick := DBLClick;
    DBGridDL.PopupMenu  :=dmFrm.DbGridPopupMenu1 ;
    DBGridDL.OnDrawColumnCell:=DBGrid1DrawColumnCellFntClr   ;
    btnCtrl.Visible     :=logininfo.Sys ;
end;



procedure TFrmBillEx.DBLClick(sender: Tobject);
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
procedure TFrmBillEx.RemoveAction1Execute(Sender: TObject);
var MainTable,DLTable, sql:String;
var qry:Tadoquery;
var MKeyField,DLKeyField:string;
begin

    if self.mtDataSet1.FindField('FisSys')<>nil then
      if mtDataSet1.FieldByName ('FisSys').AsBoolean then
      begin
        showmessage('系统生成的单据不能删除！');
        exit;
      end;

    if self.mtDataSet1.FindField('islock')<>nil then
        if  mtDataSet1.FieldByName('islock').AsBoolean  then
        begin
             showmessage('请先解锁！' );
             exit;
        end;


 if MessageDlg(#13#10+'确实要删除这张单据?',mtInformation,[mbYes,mbNo],0)=mrNo then
 exit;

  fhlknl1.Kl_GetQuery2('select * From T201 where f01='+inttostr( mtDataSet1.tag));
  MainTable:=fhlknl1.FreeQuery.fieldbyname('F16').AsString;

  fhlknl1.Kl_GetQuery2('select * From T201 where f01='+inttostr( dlDataSet1.tag));
  DLTable:=fhlknl1.FreeQuery.fieldbyname('F16').AsString;

  if (MainTable<>'') and (DLTable<>'') then
  begin
    try
      qry:=Tadoquery.Create (nil);
      qry.Connection :=dmfrm.ADOConnection1 ;

      dmfrm.ADOConnection1.BeginTrans;

      while (not dlDataSet1.Eof )do
      begin
        dlDataSet1.Next ;
      end;

      MKeyField:=fBillex.mkeyfld ;
      DLKeyField:= fBillex.fkeyfld;
      if Pos(',',MKeyField  )<>0 then
      MKeyField  :=LeftStr(MKeyField , Pos(',',MKeyField  )-1 );
      if Pos(',',DLKeyField )<>0 then
      DLKeyField  :=LeftStr(DLKeyField, Pos(',',DLKeyField  )-1 );

      qry.SQL.Clear;
      qry.SQL.Add( 'delete TBarcodeIO where FbillCode='+quotedstr( fBillex.BillCode ) )  ;
      qry.ExecSQL;
      qry.SQL.Clear;
      qry.SQL.Add( 'delete '+DLTable+' where '+DLKeyField  +'='+quotedstr( fBillex.BillCode ) )  ;
      qry.ExecSQL;
      qry.SQL.Clear;
      qry.SQL.Add('delete '+MainTable+' where '+  MKeyField  +'='+quotedstr( fBillex.BillCode ) )  ;
      qry.ExecSQL;

      sql:='delete from Tbarcode where   FbillCode='+quotedstr(fBillex.BillCode);//+'  or FoutpackageBarCode ='+quotedstr(fbilldict.BillCode);
      fhlknl1.Kl_GetUserQuery(sql,false);
      if (FrmImPort<>nil) and ( FrmImPort.frmSearchBarCode<>nil) then
              FrmImPort.frmSearchBarCode.RefreshBill;//( self.fBillex.BillCode);

      dmfrm.ADOConnection1.CommitTrans ;
      self.mtDataSet1.Close;
      self.dlDataSet1.Close;
      qry.Free ;
      OpenBill(fBillex.BillCode);
    except
      on E:Exception do
      begin
        dmfrm.ADOConnection1.RollbackTrans ;
        showmessage(e.Message);
      end;
    end;
  end;

end;

procedure TFrmBillEx.ActEditExecute(Sender: TObject);
begin
  self.mtDataSet1.Edit ;

  // EditPostAfter(false);
end;

procedure TFrmBillEx.ActSetBitExecute(Sender: TObject);
begin
  inherited;

if not dlDataSet1.IsEmpty then
begin
  if self.dlDataSet1.FindField('FisBit')<>nil then
  begin
     dlDataSet1.Edit;
     dlDataSet1.FieldByName('FisBit').AsBoolean:=not dlDataSet1.FieldByName('FisBit').AsBoolean ;
     dlDataSet1.Open ;
  end;
end;
end;

procedure TFrmBillEx.PrintAction1Execute(Sender: TObject);
var printID:string;
var
  bk:TBookmark;
begin
  FhlUser.CheckToolButtonRight( inttostr(fBillex.ActID) ,(sender as Taction).Name );
  Screen.Cursor:=crSqlWait;
  bk:=dlDataSet1.GetBookmark;
  dlDataSet1.DisableControls;

  //hide field
  RepBillFrm:=TRepBillFrm.Create(Application);
  try
    RepBillFrm.SetBillRep( self.fBillex .TopBoxId,fBillex.BtmBoxId,mtDataSet1, self.DBGridDL);
    RepBillFrm.PreviewModal;//Preview;
  finally
    FreeAndNil(RepBillFrm);
    dlDataSet1.EnableControls;
    Screen.Cursor:=crDefault;
  end;
  dlDataSet1.GotoBookmark(bk);
    //restore field
    
end;
procedure TFrmBillEx.ActSaveExecDLProcExecute(Sender: TObject);
var
  fbk:TBookmark;
  i:integer;
begin
 CheckAllowToSave( (sender as Taction).Name );

 if (ImportAction1.ActionComponent <>nil) and TToolbutton(ImportAction1.ActionComponent ).Down then
    TToolbutton(ImportAction1.ActionComponent ).Click;

 if dlDataSet1.State in [dsedit] then
   dlDataSet1.Post ;

   dlDataSet1.First;
   while (not self.dlDataSet1.Eof )  do
  begin
     FhlUser.DoExecProc(dlDataSet1,null);
     dlDataSet1.Next;
   end;
  EditPostAfter(True);
  Screen.Cursor:=crDefault;
  self.OpenBill(self.fBillex.BillCode ) ; {  }
end;

procedure TFrmBillEx.ActUncheckExecute(Sender: TObject);
begin
  inherited;
    if self.mtDataSet1.IsEmpty then exit;
    Screen.Cursor:=CrSqlWait;
    try
    FhlUser.CheckRight(self.fBillex.UnChkRightId );
    if  dmFrm.ExecStoredProc(fBillex.UnChkProc ,varArrayof([fBillex.BillCode ,LoginInfo.EmpId,LoginInfo.LoginId])) then
    begin
       
    end;
    OpenBill(fBillex.BillCode);
    finally
    Screen.Cursor:=crDefault;
    end;
end;

procedure TFrmBillEx.RefreshAction1Execute(Sender: TObject);
begin
  inherited;
  mtDataSet1.Close;
  dlDataSet1.Open;
  OpenBill(fBillex.BillCode);

end;

procedure TFrmBillEx.ActSaveHaveTextFomulaExecute(Sender: TObject);
var  s,ss,f:widestring;
//var  fDict:TBeforePostDict;
var  pKeys,DLKeyFLDs:Tstrings;
var i:integer;
var MtValues:variant;
var BackOnCalcFields,BackUpDLBeforePost: TDataSetNotifyEvent ;
begin

// if (ImportAction1.ActionComponent <>nil) and TToolbutton(ImportAction1.ActionComponent ).Down then
 //   TToolbutton(ImportAction1.ActionComponent ).Click;

 try
   CheckAllowToSave( (sender as Taction).Name );
   
    self.dlDataSet1.AfterPost :=nil;
    if self.dlDataSet1.State in [dsinsert ,dsEdit	] then
    begin
       dlDataSet1.Post;
    end;
    if    dlDataSet1.RecordCount <1 then
    begin
       showmessage('请加明细记录!');
       abort;
    end;

    Screen.Cursor:=CrSqlWait;
      //AutoKey
      if (mtDataSet1.State=dsInsert) and (fBillex.AutoKeyId<>'') then
      begin
         fBillex.BillCode:=dmFrm.GetMyId(fBillex.AutoKeyID );
         pKeys:=Tstringlist.Create ;
         pKeys.CommaText :=   fBillex.mkeyfld;
         mtDataSet1.DisableControls   ;

         for i:=0 to pKeys.Count -1 do
         begin
            mtDataSet1.FieldByName(pKeys[i]).AsString:=fBillex.BillCode;
         end;
         pKeys.Free ;
      end;

      BackUpDLBeforePost:= dlDataSet1.BeforePost ;
      dlDataSet1.BeforePost:=nil;
      if  mtDataSet1.State in [dsedit,dsInsert]  then
      begin
        UpdateSysFieldsAndCalValue;
      end;
      DLKeyFLDs:=Tstringlist.Create ;
      DLKeyFLDs.CommaText :=fBillex.fkeyfld;
      MtValues :=FhlKnl1.Ds_GetFieldsValue(mtDataSet1,fBillex.fkeyfld);
      BackOnCalcFields:= dlDataSet1.OnCalcFields ;
     // dlDataSet1.OnCalcFields :=nil;                //加快保存速度
      Ds_UpdateAllRecs(self.DBGridDL , fBillex.fkeyfld ,  MtValues  ,self.PgBarSave   );
      freeandnil(DLKeyFLDs) ;
      //2010-1-30  无法计算总金额
      FhlKnl1.Ds_AssignValues(mtDataSet1,self.fBillex.mtSumFlds ,FhlKnl1.Ds_SumFlds(self.dlDataSet1 ,self.fBillex.dlSumFlds),false,false);

      dlDataSet1.BeforePost:=BackUpDLBeforePost   ;
      try
           mtDataSet1.UpdateBatch;
           dlDataSet1.UpdateBatch;  //调换了个顺序 ,影响所有bill模板
           if (FrmImPort<>nil) and ( FrmImPort.frmSearchBarCode<>nil) then
              FrmImPort.frmSearchBarCode.Save( self.fBillex.BillCode);
      except  ////
          on err:exception do
          begin
            //  EditPostAfter(True);
            Screen.Cursor:=crDefault;
            showmessage(err.Message );
            exit;
          end;
      end;
     EditPostAfter(True);
     self.OpenBill(self.fBillex.BillCode ) ;
  finally
     mtDataSet1.EnableControls ;
     Screen.Cursor:=crDefault;
  end;
end;

procedure TFrmBillEx.ActChkChgExecute(Sender: TObject);
begin
     self.mtDataSet1.Edit ;
     self.DBGridDL.Enabled := true;
     self.DBGridDL.ReadOnly := false;
     DBGridDL.Options:=DBGridDL.Options+[dgEditing];
     SetCtrlStyle(true);
     ImportAction1.Enabled := true;
     DeleteAction1.Enabled :=true;

end;

procedure TFrmBillEx.UserLogExecute(Sender: TObject);
begin
{
    if MessageDlg('选择yes查看表头日志,NO查看明细日志 ',mtInformation,[mbYes,mbNo],0)=mrYes then
      FhlUser.showLogwindow(self.mtDataSet1 ,fBillex.TopBoxID ,fBillex.BtmBoxID)
    else
      fhluser.showLogwindow (self.DBGridDL  );
 }
end;

procedure TFrmBillEx.ActPropertyExecute(Sender: TObject);
var sql:string;
var
  frmid:string;
  fBillType:string;
  BillFrm:TFrmBillEx;
  EditorFrm:TEditorFrm ;
  Code ,tmpWindowsFID:string;
  FrmBillEx:TFrmBillEx ;
  LstParameterFLDs:Tstrings;
  i:integer;
  form:TAnalyseEx;
begin
   try
    sql:='select  A.F19,A.F17,A.F20 ,B.F_ID From T525 A  join '+ logininfo.SysDBPubName +'.dbo.T511 B  on A.F17=B.F06 where A.F02='+inttostr(fBillex.ActID )+' and A.f16=' +inttostr(Taction(Sender).Index )
        +' and A.f17=' +inttostr(Taction(Sender).ActionComponent.Tag  )+' and A.f04='+quotedstr( Ttoolbutton( Taction(Sender).ActionComponent).Caption   );
    fhlknl1.Kl_GetQuery2 (sql  );
    fBillType:=fhlknl1.FreeQuery.FieldByName('F19').AsString  ;
    frmid:=fhlknl1.FreeQuery.FieldByName('F17').AsString      ;
    tmpWindowsFID:=fhlknl1.FreeQuery.FieldByName('F_ID').AsString      ;
    if uppercase(fBillType)=uppercase('Analyser') then
    begin
        if self.dlDataSet1.FindField('sDefaultVals')<>nil then
        sDefaultVals:=self.dlDataSet1.fieldbyname('sDefaultVals').AsString;
        form:=TAnalyseEx.Create(Application)  ;

        form.hide;
        form.FWindowsFID :=tmpWindowsFID;
        form.InitFrm(frmid,null);
        //formstyle:=fsMDIChild;

        form.Showmodal;
    end;


    if uppercase(fBillType)=uppercase('CRM') then
    begin

        if self.dlDataSet1.FindField('sDefaultVals')<>nil then
        sDefaultVals:=self.dlDataSet1.fieldbyname('sDefaultVals').AsString;
        FhlUser.ShowCRMFrm(frmid);
    end;
    if uppercase(fBillType)=uppercase('BillEx') then
    begin
      if not self.dlDataSet1.IsEmpty then
      begin
      LstParameterFLDs:=Tstringlist.Create ;
      LstParameterFLDs.CommaText :=fhlknl1.FreeQuery.FieldByName('F20').AsString      ;//  fDict.QryParamsFLDs ;
      for i:=0 to  LstParameterFLDs.Count -1 do
      begin
        if   self.dlDataSet1.FindField (LstParameterFLDs[i])<>nil then
        begin
           if self.dlDataSet1.FieldByName (LstParameterFLDs[i]).AsString <>'' then
           begin
               Code:=self.dlDataSet1.FieldByName (LstParameterFLDs[i]).AsString  ;
               break;
           end;
        end;
      end;
      end;

      FrmBillEx:=TFrmBillEx.Create(nil);
      FrmBillEx.SetParamDataset(self.dlDataSet1);
      FrmBillEx.FWindowsFID :=  tmpWindowsFID ;
      FrmBillEx.InitFrm(FrmId);
      if Code<>'' then
      begin
         FrmBillEx.OpenBill( code  );
      end;
      FrmBillEx.FormStyle :=fsnormal;
      FrmBillEx.Hide;
      FrmBillEx.Position :=poDesktopCenter;
      FrmBillEx.ScrollBtm.Visible :=true;
	  
      FrmBillEx.ShowModal ;
    end;
except
  on err:exception do
  showmessage(err.Message );
end;
end;

procedure TFrmBillEx.btnCtrlClick(Sender: TObject);
//var  FrmCtrlConfig:TFrmCtrlConfig ;
begin
  {
  try
    FrmCtrlConfig:=TFrmCtrlConfig.Create(nil) ;

    if  ( self.pnlbtm.ControlCount =0 )
     or ( messagedlg('设置表头控键?',  mtWarning,[mbyes,mbno],0)=mryes ) then
      FrmCtrlConfig.boxid :=self.fBillex.TopBoxID

    else
      FrmCtrlConfig.boxid :=self.fBillex.BtmBoxID  ;

    FrmCtrlConfig.ShowModal ;
  finally
    FrmCtrlConfig.Free;
  end;
  }

end;

function TFrmBillEx.FirstCommarSection(Pstr: string): string;
begin
  if Pos(',',Pstr)<>0 then
    Result:=LeftStr(  Pstr, pos(',',Pstr)-1)
  else
    Result :=Pstr;
end;
 

procedure TFrmBillEx.InActiveBillExecute(Sender: TObject);
begin
  inherited;

  if (self.dlDataSet1.FindField('FIsCls')<>nil) then
  begin
    while not dlDataSet1.Eof do
    begin
      dlDataSet1.Edit;
      dlDataSet1.FieldByName ('FIsCls').AsBoolean :=true;
      dlDataSet1.Next;
    end;
//    dlDataSet1.Post;
  end;

  if (self.mtDataSet1.FindField('FIsCls')<>nil) then
  begin
      mtDataSet1.Edit;
      mtDataSet1.FieldByName ('FIsCls').AsBoolean :=true;
     // mtDataSet1.Post;
  end;
end;

procedure TFrmBillEx.ActiveBillExecute(Sender: TObject);
begin
   inherited;
  if (self.dlDataSet1.FindField('FIsCls')<>nil) then
  begin 
    while not dlDataSet1.Eof do
    begin
      dlDataSet1.Edit;
      dlDataSet1.FieldByName ('FIsCls').AsBoolean :=true;
      dlDataSet1.Next;
    end;
  end;

  if (self.mtDataSet1.FindField('FIsCls')<>nil) then
  begin
      mtDataSet1.Edit;
      mtDataSet1.FieldByName ('FIsCls').AsBoolean :=false;
  end;
end;

procedure TFrmBillEx.actMDLookupExecute(Sender: TObject);
var FrmMDImport:TFrmMDLookupImport          ;
begin
    FrmMDImport:=TFrmMDLookupImport.Create(nil);
    FrmMDImport.iniFrm(self.fBillex.OpenID,'',self.dlDataSet1 ,self.mtDataSet1   );
    FrmMDImport.ShowModal ;
    FrmMDImport.Free ;
end;

procedure TFrmBillEx.ActlockExecute(Sender: TObject);
begin
    FhlUser.CheckToolButtonRight(inttostr(fBillex.ActID) , (sender as Taction).Name );
    SetLock  ( true);
end;

procedure TFrmBillEx.SetLock(lock:boolean);
var ResultHint:string;
var ReturnBool:boolean;
begin
    if   mtDataSet1.State in [dsinsert,dsedit] then
    begin
        exit;
    end;

    if self.mtDataSet1.IsEmpty then
    begin
        showmessage('请先打开单据!');
        exit;
    end;
    if self.mtDataSet1.FindField('islock')<>nil then
    begin
       try

          if   dmFrm.ExecStoredProc('pr_LockSl_invoice',varArrayof([fBillex.billcode,LoginInfo.EmpId,LoginInfo.LoginId])) then
          begin

          end;
          OpenBill(fBillex.BillCode);


       finally
            
       end;
       self.ScrollTop.Enabled :=not lock;
       self.ScrollBtm.Enabled :=not lock;
       self.PnlBtm.Enabled :=not lock;
       self.DBGriddl.ReadOnly  :=  lock;
    end;


end;
procedure TFrmBillEx.ActunlockExecute(Sender: TObject);
begin
  FhlUser.CheckToolButtonRight(inttostr(self.fBillex.ActID) , (sender as Taction).Name );
  SetLock  ( false);
end;

procedure TFrmBillEx.RefreshLockButton;
var Checked:boolean;
begin

    Checked:=isChecked;

    Actlock.Visible:= (mtDataSet1.FindField('IsLock')<>nil)    and (not Checked);
    Actunlock.Visible:= (mtDataSet1.FindField('IsLock')<>nil) and  (not Checked);

   if  (mtDataSet1.FindField('IsLock')<>nil)
                     and (    mtDataSet1.State in [dsBrowse] )
                     and (not mtDataSet1.IsEmpty)
                     and ( (not SaveAction1.Enabled)  or (not ActSaveSl_invoice.Enabled) ) then

    Actunlock.Enabled:= ((mtDataSet1.FieldByName('IsLock').Value ='True') or   mtDataSet1.FieldByName('IsLock').AsBoolean  ) and (not Checked);

    Actlock.Enabled:= not Actunlock.Enabled;
end;

function TFrmBillEx.isChecked: boolean;
var LstChkState:Tstringlist;
var checkedValue: string;
begin
    if (mtDataSet1.Active) then
    checkedValue:=mtDataSet1.FieldByName (fBillex.ChkFieldName).AsString;

    if mtDataSet1.FindField(fBillex.ChkFieldName)<>nil then
    begin
          self.LblState.Visible :=false;
          LstChkState:=Tstringlist.Create ;
          LstChkState.CommaText :=fbillex.IsChkValue;
           if LstChkState.IndexOf( checkedValue )>-1 then
             result:=true // SetCheckStyle(true)
          else
             result:=false;//SetCheckStyle(false);
          LstChkState.Free ;
    end  ;
end;

procedure TFrmBillEx.GeneratorBarcode(F_IDFieldName: string);
var RepBillFrm:TRepBarCodeFrm;
var sql:string;
var i, j,cnt :integer;
var FrmPrintBarCode: TFrmPrintBarCode;
var bk:Tbookmark;

begin
  if dlDataSet1.IsEmpty then
     abort ;

  begin
      bk:= dldataset1.GetBookmark;
     
      sql:= 'exec Pr_CopyMoveDLToBarcodeIOM '+quotedstr(self.mtDataSet1.fieldbyname('code').AsString) ;
      fhlknl1.Kl_GetUserQuery(sql, false);



      sql:= 'exec PR_GeneratorBarCode '+quotedstr(self.mtDataSet1.fieldbyname('code').AsString) ;
     // fhlknl1.Kl_GetUserQuery(sql);
      sql:= 'exec Pr_InsertFPackageBarcode '+quotedstr(self.mtDataSet1.fieldbyname('code').AsString)  ;
      //fhlknl1.Kl_GetUserQuery(sql,false);
      dldataset1.GotoBookmark(bk);
      dlDataSet1.EnableControls;
  end;
  try
    FrmPrintBarCode:=TFrmPrintBarCode.create(nil);
    FrmPrintBarCode.InitFrm ('17');
    FrmPrintBarCode.Initial(self.fBillex.BillCode, self.dlDataSet1,F_IDFieldName);

    FrmPrintBarCode.ShowModal;
  finally
    FrmPrintBarCode.Free;
  end;
 {
  RepBillFrm:=TRepBarCodeFrm.Create(nil);
  try
    sql:= 'exec PR_GeneratorBarCode '+quotedstr(self.mtDataSet1.fieldbyname('code').AsString) ;
    fhlknl1.Kl_GetUserQuery(sql);
    RepBillFrm.SetBillRep(  fhlknl1.User_Query);
    RepBillFrm.PreviewModal;

  finally
    FreeAndNil(RepBillFrm);
    Screen.Cursor:=crDefault;
  end;
      }
end;

procedure TFrmBillEx.ActPrintBarCodeExecute(Sender: TObject);
begin
if self.fBillex.ID   ='6' then
  GeneratorBarcode('PhOrdFID') ;

if self.fBillex.ID   ='23' then
  GeneratorBarcode('F_ID')  ;

end;

procedure TFrmBillEx.ActPrintBarCodeWhMoveExecute(Sender: TObject);
begin
  if logininfo.WhId ='009'  then
    GeneratorBarcode('moveF_ID')
  else
    showmessage('采购仓库调时生成条码');
end;

procedure TFrmBillEx.ActSLInvoiceCheckExecute(Sender: TObject);
var
  i:integer;
  s: widestring;
  frm:TTabGridFrm;
  Msg:string;
begin

    if MessageDlg('确定要审核吗?',mtConfirmation,[mbYes, mbNo],0)=mrno  then exit;

      i:=0;
      Screen.Cursor:=CrSqlWait;
      try

        FhlUser.CheckRight(self.fBillex.ChkRightId);
        FhlUser.SetDataSet(dmFrm.FreeDataSet1,'657',varArrayof([fBillex.billcode,LoginInfo.EmpId,LoginInfo.LoginId]),True);
        if Not dmFrm.FreeDataSet1.IsEmpty then
        begin
          with dmFrm.FreeDataSet1 do
          begin
            while not eof do
            begin
                if FieldByName('myStok').AsFloat<FieldByName('Qty').AsFloat then
                    i:=i+1
                else begin
                    Edit;
                    FieldByName('SndQty').AsFloat:=FieldByName('Qty').AsFloat;
                    Post;
                end;
                next;
            end;
            First;
          end;
          if Not ((i=0) and (MessageDlg(#13#10'提示: 本单所有的产品库存均足够,是否根据发货单一次出库?',mtInformation,[mbYes,mbNo],0)=mrYes)) then
          begin
            frm:=TTabGridFrm.Create(Application);
            with frm do
            begin
                Label1.Caption:='提示: 至少有 '+intTostr(i)+' 种商品的库存不够发货,请输入本次发货量:';
                DataSource1.DataSet:=dmFrm.FreeDataSet1;
                FhlUser.SetDbGrid('480',DbGrid1);
                hide;
                if ShowModal<>mrOk then
                begin
                   Free;
                   Abort;
                end;
            end;
            frm.Tag:=0;
            while frm.Tag=0 do
            begin
                s:='';
                with dmFrm.FreeDataSet1 do
                begin
                    First;
                    while not eof do
                    begin
                        if FieldByName('SndQty').AsString='' then
                          s:='提示:本次发货数量不能为空,如果本次没有发货则必须在相应栏填入0.'
                        else if FieldByName('SndQty').AsFloat<0 then
                          s:='提示:本次发货数量不能小于0,请按 确定 重新录入'
                        else if (FieldByName('SndQty').AsFloat>FieldByName('myStok').AsFloat) then
                          s:='提示:本次发货数量不能大于库存数量.'
                        else if (FieldByName('SndQty').AsFloat>FieldByName('Qty').AsFloat) then
                          s:='提示:本次发货数量不能大于本单总的发货数量.';
                        if s<>'' then break;
                        next;
                     end;
                 end;
                  if s<>'' then
                  begin
                      MessageDlg(#13#10+s,mtWarning,[mbOk],0);
                      if frm.ShowModal<>mrOk then
                      begin
                       FreeAndNil(frm);
                       Abort;
                      end;
                  end
                  else
                      frm.Tag:=1;
            end;
            freeandnil(frm);
          end;
          //
        dmFrm.FreeDataSet1.UpdateBatch();
        if not  dmFrm.ExecStoredProc('sl_invoice_out',varArrayof([LoginInfo.WhId,fBillex.billcode,LoginInfo.EmpId])) then
        begin
              if dmFrm.FreeStoredProc1.Parameters.Items[1].Direction  =pdOutput then
              begin
              Msg:=dmFrm.FreeStoredProc1.Parameters.Items[1].Value;
              MessageDlg(#13#10+Msg,mtError,[mbOk],0);
              Abort;
              end;
        end;


       end;
      finally
          dmFrm.FreeDataSet1.Close;
          OpenBill(fBillex.BillCode);
          Screen.Cursor:=crDefault;
      end;

end;

procedure TFrmBillEx.ActSLPrintExecute(Sender: TObject);
var
  bk:TBookmark;
begin
  RefreshAction1.Execute;     //refresh first
  FhlUser.CheckToolButtonRight(inttostr(fBillex.ActID),  (sender as Taction).Name );
  Screen.Cursor:=crSqlWait;
  bk:=dlDataSet1.GetBookmark;
  dlDataSet1.DisableControls;
   SetIsPrinted;
  //hide field
  RepBillFrm:=TRepBillFrm.Create(Application);
  try
    mtDataSet1.Close;
    mtDataSet1.Open;
    RepBillFrm.SetBillRep(self.fBillex .TopBoxId,fBillex.BtmBoxId,mtDataSet1,self.DBGridDL);
    RepBillFrm.PreviewModal;//Preview;
  finally
    FreeAndNil(RepBillFrm);
    dlDataSet1.EnableControls;
    Screen.Cursor:=crDefault;
  end;
  dlDataSet1.GotoBookmark(bk);
    //restore field

end;

procedure TFrmBillEx.ActRemoveBillExecute(Sender: TObject);
var sql:string;
begin
    if self.mtDataSet1.FindField('FisSys')<>nil then
      if mtDataSet1.FieldByName ('FisSys').AsBoolean then
      begin
        showmessage('系统生成的单据不能删除！');
        exit;
      end;
      
    if self.mtDataSet1.FindField('islock')<>nil then
        if  mtDataSet1.FieldByName('islock').AsBoolean  then
        begin
             showmessage('请先解锁！' );
             exit;
        end;


    if mtDataSet1.State in [dsinsert,dsedit] then
      mtDataSet1.Cancel;

    if    not (mtDataSet1.LockType = ltReadOnly) then
    begin
      if MessageDlg(#13#10+'警告! 所有本单的数据将被删除且无法恢复,您确定吗?   ',mtWarning,mbOkCancel,0)=mrOk then
      begin
      Screen.Cursor:=CrSqlWait;
        try
          try
              dmfrm.ADOConnection1.BeginTrans    ;
              FhlUser.DoExecProc(mtDataSet1,null);
              fhlknl1.Kl_GetUserQuery(sql,false);

          
              dmfrm.ADOConnection1.CommitTrans;
          except
              on err:exception do
              begin
                  dmfrm.ADOConnection1.RollbackTrans ;
                   showmessage('弃单失败！'+err.Message  );
                  exit;
              end;
          end;

          CloseBill;

        finally
         Screen.Cursor:=crDefault;
        end;
      end;
    end;
 
end;

procedure TFrmBillEx.ActSLPrint2Execute(Sender: TObject);
var
  bk:TBookmark;
begin
  RefreshAction1.Execute;     //refresh first
  FhlUser.CheckToolButtonRight(inttostr(fBillex.ActID),  (sender as Taction).Name );
  Screen.Cursor:=crSqlWait;
  bk:=dlDataSet1.GetBookmark;
  dlDataSet1.DisableControls;
   SetIsPrinted;
  HidePriceAmtFields(true);
  //hide field
  RepBillFrm:=TRepBillFrm.Create(Application);
  try
    mtDataSet1.Close;
    mtDataSet1.Open;
    RepBillFrm.SetBillRep(fBillex.TopBoxId,'145',mtDataSet1, self.DBGridDL);
    RepBillFrm.PreviewModal;//Preview;

    HidePriceAmtFields(false);
  finally
    FreeAndNil(RepBillFrm);
    dlDataSet1.EnableControls;
    Screen.Cursor:=crDefault;
  end;
  dlDataSet1.GotoBookmark(bk);
   
end;
procedure TFrmBillEx.HidePriceAmtFields(  hide:boolean);
var i:integer;
begin
  for i:=0  to   DBGridDL.Columns.Count-1 do
  begin
       if  ( (DBGridDL.Columns[i].FieldName ='Price' ) or ( DBGridDL.Columns[i].FieldName ='Fund') ) then
       begin
          DBGridDL.Columns[i].Visible := not hide;
       end
  end;
end;
procedure TFrmBillEx.ActCreateWhmoveExecute(Sender: TObject);

begin
 //10008
 if not mtDataSet1.IsEmpty  then
 begin
      FhlUser.ShowTabEditorFrm('10008', varArrayof([mtDataSet1.FieldByName('code').asstring]),nil,false,-11,true,true,true);

      OpenBill(fBillex.BillCode);
 end;
end;

procedure TFrmBillEx.ActBarCodeInputExecute(Sender: TObject);
begin
    if (frmSearchBarCode=nil ) then
     begin
         frmSearchBarCode:=TFrmSearchBarCode.Create(nil);
         frmSearchBarCode.BtnImport.Visible :=false;
         frmSearchBarCode.Width:=260;
         frmSearchBarCode.Parent  :=pnlleft;
         frmSearchBarCode.IniForm(self ,self.fBillex.BillCode);
     end;

      if    TToolbutton(Taction(Sender).ActionComponent ).Down then
      begin
          PnlLeft.Width:=260;
           //frmSearchBarCode.AutoSize :=true;
          frmSearchBarCode.Top:=15;
          frmSearchBarCode.Height :=frmSearchBarCode.Height;
          frmSearchBarCode.Visible:=true;
          frmSearchBarCode.Dock(self.PnlLeft,frmSearchBarCode.ClientRect  );
      end
      else
      begin
        PnlLeft.Width:=1;
        frmSearchBarCode.Visible :=false;
      end;
     // ScrollBoxCtrlPanel.Visible:=not GrpBarCode.Visible ;



end;

procedure TFrmBillEx.AppendRecord(fdataSet: TdataSet);
begin
//
end;

procedure TFrmBillEx.BarCodeSearch(BarCodeList: TStringList);
var i:integer;
begin
    if (ImportAction1.ActionComponent <>nil) and (ImportAction1.ActionComponent as Ttoolbutton).Down then
    begin
        (ImportAction1.ActionComponent as Ttoolbutton).Down :=false;
        (ImportAction1.ActionComponent as Ttoolbutton).Click;
    end;

    
    //if not frmSearchBarCode.DataSource1.DataSet.IsEmpty and ( not self.isChecked )then
    if  ( not self.isChecked )then
    begin
    {
        frmSearchBarCode.DataSource1.DataSet.DisableControls ;
        frmSearchBarCode.DataSource1.DataSet.First;
        for  i:=0  to frmSearchBarCode.DataSource1.DataSet.RecordCount -1 do
        begin
          if frmSearchBarCode.DataSource1.DataSet.FieldByName('wareid').AsInteger = dlDataSet1 .FieldByName('wareid').AsInteger then
              sumValue := sumValue+ frmSearchBarCode.DataSource1.DataSet.FieldByName('FBarCodeQty').Value ;

          frmSearchBarCode.DataSource1.DataSet.Next;
        end;
        frmSearchBarCode.DataSource1.DataSet.EnableControls  ;
    }


        //if sumValue>0 then
        begin
             if not self.isChecked then
             begin
               if not (dlDataSet1.State  in [dsEdit, dsinsert]) then
                   self.dlDataSet1.Edit ;
               if  self.listBarCodeQty.IndexOfName(dlDataSet1 .FieldByName('wareid').AsString )>-1 then
               begin
                    dlDataSet1.FieldByName( 'Qty').Value :=  strtoint(listBarCodeQty.Values [dlDataSet1 .FieldByName('wareid').AsString ]);
               end;
               //self.dlDataSet1.Post;
             end;
        end;
    end;
end;

function TFrmBillEx.AddBarCode: boolean;
var resultset: tdataset;
var sql:string;
var barcode :string;
var PackageCodeExisted:boolean ;
var SumBarCodeQty : integer;
begin
   barcode :=  frmSearchBarCode.EdtBarCode.Text;
   SumBarCodeQty :=0;

   { alter proc Pr_GetBarCodeInfomation
 @FPackageBarCode varchar(30),
 @wareid varchar(20)='',
 @OutWhid varchar(20)='',
 @InWhid varchar(20)='',
 @ClientID varchar(20)=''  
   sql:= ' select distinct stg.FBarCode , stg.FBarCodeQty , stg.FPackageBarcode, stg.FPackageqty, dl.WareId , dl.Qty ,dl.F_ID  ';
   sql:= sql + ' from sl_invoice m join sl_invoicedl dl on m.Code = dl.InvoiceId join TBarcodeStorage stg   on stg.Wareid = dl.WareId where isnull(m.IsChk ,0)=0     ';
   sql:= sql + ' and   ( stg.FPackageBarCode ='+ quotedstr(leftstr(  barcode  ,length(Barcode)-4));
   sql:= sql + ' or stg.FBarCode =  '+  quotedstr(leftstr( barcode ,length(Barcode)-1))   +')' ;
                     }

   sql:= ' exec Pr_GetBarCodeInfomation  '+  quotedstr( barcode )   ;
   sql:= sql + ' , '+ quotedstr(leftstr(  barcode  ,length(Barcode)-4));
   sql:= sql + ' , '+ quotedstr(self.dlDataSet1.fieldbyname('invoicedlF_ID').AsString  );

   fhlknl1.Kl_GetUserQuery(sql);
   resultset:=fhlknl1.User_Query;
   if resultset.IsEmpty then
      result:= false
   else
   begin
       if  dlDataSet1.Locate('wareid', resultset.FieldByName('wareid').Value,[])   then
           result := true;

       PackageCodeExisted :=     frmSearchBarCode.BarCodeDataSet.Locate('FPackageBarCode',frmSearchBarCode.EdtBarCode.Text,[] );

       if  (( not   PackageCodeExisted ) and   result )  then
        begin
            frmSearchBarCode.BarCodeDataSet.Append;
            //self.BarCodeDataSet.FieldByName('FOutBillCode').Value :=fbillCode;
            frmSearchBarCode.BarCodeDataSet.FieldByName('wareid').Value :=resultset.FieldByName('wareid').Value;
            frmSearchBarCode.BarCodeDataSet.FieldByName('FBarCodeQty').Value :=resultset.FieldByName('FBarCodeQty').Value;
            frmSearchBarCode.BarCodeDataSet.FieldByName('FPackageBarCode').Value :=frmSearchBarCode.EdtBarCode.Text;

            if pos('-','frmSearchBarCode.EdtBarCode.Text')>0 then
               frmSearchBarCode.BarCodeDataSet.FieldByName('FBarCode').Value :=frmSearchBarCode.EdtBarCode.Text;
            frmSearchBarCode.BarCodeDataSet.FieldByName('whid').Value :=self.mtDataSet1.fieldbyname('InWhId').Value;
            frmSearchBarCode.BarCodeDataSet.FieldByName('FIOType').Value :='MO';
            frmSearchBarCode.BarCodeDataSet.FieldByName('OutWhId').Value := self.mtDataSet1.fieldbyname('OutWhId').Value;

            if listBarCodeQty.IndexOfName( resultset.FieldByName('wareid').AsString ) >-1 then
            begin
                SumBarCodeQty := strtoint( listBarCodeQty.Values[resultset.FieldByName('wareid').AsString] );
                SumBarCodeQty := SumBarCodeQty + resultset.FieldByName('FBarCodeQty').AsInteger ;
                listBarCodeQty.Values[resultset.FieldByName('wareid').AsString] := inttostr(SumBarCodeQty);
            end
            else
                listBarCodeQty.Add(resultset.FieldByName('wareid').AsString +'='+ resultset.FieldByName('FBarCodeQty').AsString );

            frmSearchBarCode.BarCodeDataSet.Post;
        end;
    end;

end;

function TFrmBillEx.RemoveBarCode: boolean;
var SumBarCodeQty,  deletedQty:integer;
var wareid:string;
begin
   SumBarCodeQty :=0;
   if frmSearchBarCode<> nil then
      if  not  self.isChecked then
      begin
        wareid := frmSearchBarCode.BarCodeDataSet.FieldByName('wareid').AsString  ;
        deletedQty := frmSearchBarCode.BarCodeDataSet.FieldByName('FBarCodeQty').AsInteger ;
        frmSearchBarCode.BarCodeDataSet.Delete;

        if listBarCodeQty.IndexOfName(   wareid  ) >-1 then
           SumBarCodeQty := strtoint( listBarCodeQty.Values[wareid] );

        SumBarCodeQty := SumBarCodeQty - deletedQty ;
        listBarCodeQty.Values[wareid]:= inttostr(SumBarCodeQty);
      end;
end;

procedure TFrmBillEx.SetIsPrinted;
var msg:string;
begin
    if  mtDataSet1.Active  and ( mtDataSet1.FindField('isprinted')<>nil ) then
    begin
       //if not mtdataset1.FieldByName('isprinted' ).AsBoolean then
       begin
            if not  dmFrm.ExecStoredProc('Pr_sl_invoice_Print',varArrayof([LoginInfo.WhId,fBillex.billcode,LoginInfo.EmpId])) then
            begin
                  if dmFrm.FreeStoredProc1.Parameters.Items[1].Direction  =pdOutput then
                  begin
                    Msg:=dmFrm.FreeStoredProc1.Parameters.Items[1].Value;
                    MessageDlg(#13#10+Msg,mtError,[mbOk],0);
                    Abort;
                  end;
            end;
            // fhlknl1.Kl_GetUserQuery('update   sl_invoice set isprinted= 1 where code ='+quotedstr(self.fBillex.BillCode), false);
       end;
    end;
end;

procedure TFrmBillEx.ActChkSL_InvoiceExecute(Sender: TObject);
var
  i:integer;
  s: widestring;
  frm:TTabGridFrm;
  Msg:string;
begin
  if  TToolbutton( Taction(Sender).ActionComponent).Caption  ='审核' then
  begin
    if MessageDlg('确定要审核吗?',mtConfirmation,[mbYes, mbNo],0)=mrno  then exit;

    //if fbilldict.Id='19' then
    begin
      i:=0;
      Screen.Cursor:=CrSqlWait;
      try
        FhlUser.CheckRight(self.fBillex.ChkRightId );
        FhlUser.SetDataSet(dmFrm.FreeDataSet1,'657',varArrayof([fBillex.billcode,LoginInfo.EmpId,LoginInfo.LoginId]),True);
        if Not dmFrm.FreeDataSet1.IsEmpty then
        begin
          with dmFrm.FreeDataSet1 do
          begin
            while not eof do
            begin
                if FieldByName('myStok').AsFloat<FieldByName('Qty').AsFloat then
                    i:=i+1
                else begin
                    Edit;
                    FieldByName('SndQty').AsFloat:=FieldByName('Qty').AsFloat;
                    Post;
                end;
                next;
            end;
            First;
          end;
          if Not ((i=0) and (MessageDlg(#13#10'提示: 本单所有的产品库存均足够,是否根据发货单一次出库?',mtInformation,[mbYes,mbNo],0)=mrYes)) then
          begin
            frm:=TTabGridFrm.Create(Application);
            with frm do
            begin
                Label1.Caption:='提示: 至少有 '+intTostr(i)+' 种商品的库存不够发货,请输入本次发货量:';
                DataSource1.DataSet:=dmFrm.FreeDataSet1;
                FhlUser.SetDbGrid('480',DbGrid1);
                hide;
                if ShowModal<>mrOk then
                begin
                   Free;
                   Abort;
                end;
            end;
            frm.Tag:=0;
            while frm.Tag=0 do
            begin
                s:='';
                with dmFrm.FreeDataSet1 do
                begin
                    First;
                    while not eof do
                    begin
                        if FieldByName('SndQty').AsString='' then
                          s:='提示:本次发货数量不能为空,如果本次没有发货则必须在相应栏填入0.'
                        else if FieldByName('SndQty').AsFloat<0 then
                          s:='提示:本次发货数量不能小于0,请按 确定 重新录入'
                        else if (FieldByName('SndQty').AsFloat>FieldByName('myStok').AsFloat) then
                          s:='提示:本次发货数量不能大于库存数量.'
                        else if (FieldByName('SndQty').AsFloat>FieldByName('Qty').AsFloat) then
                          s:='提示:本次发货数量不能大于本单总的发货数量.';
                        if s<>'' then break;
                        next;
                     end;
                 end;
                  if s<>'' then
                  begin
                      MessageDlg(#13#10+s,mtWarning,[mbOk],0);
                      if frm.ShowModal<>mrOk then
                      begin
                       FreeAndNil(frm);
                       Abort;
                      end;
                  end
                  else
                      frm.Tag:=1;
            end;
            freeandnil(frm);
          end;
          //
        dmFrm.FreeDataSet1.UpdateBatch();
        if not  dmFrm.ExecStoredProc('sl_invoice_out',varArrayof([LoginInfo.WhId,fBillex.billcode,LoginInfo.EmpId])) then
        begin
              if dmFrm.FreeStoredProc1.Parameters.Items[1].Direction  =pdOutput then
              begin
              Msg:=dmFrm.FreeStoredProc1.Parameters.Items[1].Value;
              MessageDlg(#13#10+Msg,mtError,[mbOk],0);
              Abort;
              end;
        end;


       end;
      finally
          dmFrm.FreeDataSet1.Close;
          OpenBill(fBillex.BillCode);
          Screen.Cursor:=crDefault;
      end;
    end;
    {
    else begin
        Screen.Cursor:=CrSqlWait;
        try
          FhlUser.CheckRight(fbilldict.CheckRitId);
          dmFrm.ExecStoredProc(fbilldict.chkproc,varArrayof([fbilldict.billcode,LoginInfo.EmpId,LoginInfo.LoginId]));
          OpenBill(fbilldict.BillCode);
        finally
         Screen.Cursor:=crDefault;
         end;
    end;
    }
  end
  else begin
     if MessageDlg('确定要弃审吗?',mtConfirmation,[mbYes, mbNo],0)=mrno  then exit;
    Screen.Cursor:=CrSqlWait;
    try
      FhlUser.CheckRight(fBillex.UnChkRightId );
      dmFrm.ExecStoredProc(fBillex.unchkproc,varArrayof([fBillex.billcode,LoginInfo.EmpId,LoginInfo.LoginId]));
      OpenBill(fBillex.BillCode);
    finally
     Screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TFrmBillEx.ActTransBillExecute(Sender: TObject);
var EditorFrm:TEditorFrm;
var fCode:string;
begin

  try
    fCode:=  mtDataSet1.fieldbyname('F_TranBillCode').AsString;
    sDefaultVals:='';
    sDefaultVals:=sDefaultVals+'F_TranBillCode='+fCode;
    sDefaultVals:=sDefaultVals+',ClientName='+mtDataSet1.fieldbyname('ClientName').AsString;
    sDefaultVals:=sDefaultVals+',Clientid='+mtDataSet1.fieldbyname('Clientid').AsString;
    sDefaultVals:=sDefaultVals+',DeliverAddr='+mtDataSet1.fieldbyname('DeliverAddr').AsString;
    sDefaultVals:=sDefaultVals+',LinkTel='+mtDataSet1.fieldbyname('LinkTel').AsString;

    EditorFrm:=TEditorFrm.Create (nil);
    EditorFrm.Visible :=false;
    EditorFrm.InitFrm('42',fCode,nil,nil  );

    EditorFrm.ShowModal  ;
    if EditorFrm.ADODataSet1.FindField('F_TranBillCode')<>nil then
        fCode:=  EditorFrm.ADODataSet1.fieldbyname('F_TranBillCode').AsString;
        
    fhlknl1.Kl_GetUserQuery('update   sl_invoice set F_TranBillCode= '+quotedstr(fcode)+' where F_TranBillCode is  null and code ='+quotedstr(self.fBillex.BillCode), false);

    self.OpenBill(self.fBillex.BillCode);
  finally
      freeandnil(EditorFrm);
      sDefaultVals:='';
  end;

end;

procedure TFrmBillEx.ActSaveSl_invoiceExecute(Sender: TObject);
var  s,ss,f:widestring;
var  pKeys,DLKeyFLDs:Tstrings;
var i:integer;
var MtValues:variant;
var BackOnCalcFields ,BackUpDLBeforePost: TDataSetNotifyEvent ;
begin

 try
    CheckAllowToSave( (sender as Taction).Name );

    if self.dlDataSet1.State in [dsinsert ,dsEdit	] then
    begin
       dlDataSet1.Post;
    end;
    if    dlDataSet1.RecordCount <1 then
    begin
       showmessage('请加明细记录!');
       abort;
    end;

    Screen.Cursor:=CrSqlWait;
      //AutoKey
      if (mtDataSet1.State=dsInsert) and (fBillex.AutoKeyId<>'') then
      begin
         if fBillex.BillCode='0000' then
         begin
           fBillex.BillCode:=dmFrm.GetMyId(fBillex.AutoKeyID );
             try
               pKeys:=Tstringlist.Create ;
               pKeys.CommaText :=   fBillex.mkeyfld;
               for i:=0 to pKeys.Count -1 do
               begin
                  mtDataSet1.FieldByName(pKeys[i]).AsString:=fBillex.BillCode;
               end;
             finally
                freeandnil(pKeys) ;
             end;
           end;
      end;

      BackUpDLBeforePost:= dlDataSet1.BeforePost ;
      dlDataSet1.BeforePost:=nil;
      if  mtDataSet1.State in [dsedit,dsInsert]  then
      begin
        UpdateSysFieldsAndCalValue;
      end;
      DLKeyFLDs:=Tstringlist.Create ;
      DLKeyFLDs.CommaText :=fBillex.fkeyfld;
      MtValues :=FhlKnl1.Ds_GetFieldsValue(mtDataSet1,fBillex.mkeyfld);
      BackOnCalcFields:= dlDataSet1.OnCalcFields ;
     // dlDataSet1.OnCalcFields :=nil;                //加快保存速度
      Ds_UpdateAllRecs(Self.DBGridDL , fBillex.fkeyfld ,  MtValues  ,self.PgBarSave ,false  );
      freeandnil(DLKeyFLDs) ;
      dlDataSet1.BeforePost :=BackUpDLBeforePost ;

      with mtDataSet1 do
         begin
             if (FieldByName('PayFund').AsFloat<0) or
               (FieldByName('OtherFund').AsFloat<0) then
             begin
                  MessageDlg(#13#10'[本单收款]及[其它收款]不能小于零,保存失败!',mtInformation,[mbOk],0);
                  DBGridDL.SetFocus;
                  Abort;
             end;
             if ( mtDataSet1.FieldByName('OtherFund').AsFloat  + mtDataSet1.FieldByName('WareFund').AsFloat
                  - mtDataSet1.FieldByName('GetFund').AsFloat      >0.01
                  ) then
             begin
                  MessageDlg(#13#10'[实际应收]=[其它收款]+[货款总额]!',mtInformation,[mbOk],0);
                  DBGridDL.SetFocus;
                  Abort;
             end;
         end;

      try
           dmfrm.ADOConnection1.BeginTrans    ;
           mtDataSet1.UpdateBatch;
           dlDataSet1.UpdateBatch;  //调换了个顺序 ,影响所有bill模板

           if (frmSearchBarCode<>nil) and not frmSearchBarCode.BarCodeDataSet.IsEmpty   then
           begin
               frmSearchBarCode.Save(fBillex.BillCode);
           end;
      except
          on err:exception do
          begin
            dmfrm.ADOConnection1.RollbackTrans ;
            Screen.Cursor:=crDefault;
            showmessage('保存失败！'+err.Message  );
            exit;
          end;
      end;
      dmfrm.ADOConnection1.CommitTrans ;
      GetBarcodeFolder(true);
      
      if not   self.AftSaveBillExecute  then
      begin
           abort;
      end
      else
          EditPostAfter(True);

   //  self.OpenBill(self.fBillex.BillCode ) ;    2010-7-11
  finally
     Screen.Cursor:=crDefault;
  end;
end;



function TFrmBillEx.AftSaveBillExecute: boolean;
 var TrAfterSave:      TTrAfterSave;
begin
    result:=true;

    if  FhlKnl1.Cf_GetDict_afterSave( 'Billex'+ fBillex.ID  , TrAfterSave) then
    begin
          if Not dmFrm.ExecStoredProc(TrAfterSave.ProcName,FhlKnl1.Vr_MergeVarArray(FhlUser.GetSysParamsVal(TrAfterSave.sysPrama   ),FhlKnl1.Ds_GetFieldsValue(self.dlDataSet1 ,TrAfterSave.UserPrama))) then
          begin
              result:=false;
              MessageDlg(#13#10+TrAfterSave.ErrHint ,mtError,[mbOk],0);
              abort;
         end;

    end;
end; 

procedure TFrmBillEx.CheckAllowToSave(actionName:string);
begin
    if mtDataSet1.FindField('BillManId')  <>nil then
     if mtDataSet1.fieldbyname('BillManId').AsString <> logininfo.EmpId then
     begin
         MessageDlg(#13#10'只有制单人才有相应单据的修改权限!',mtWarning,[mbOk],0);
         Abort;
     end   ;

  FhlUser.CheckToolButtonRight( inttostr(fBillex.ActID) ,actionName);
end;

procedure TFrmBillEx.ActOriExecute(Sender: TObject);
var sql:string;
var
  frmid,keyValue:string;
  fBillType:string;
  BillFrm:TFrmBillEx;
  EditorFrm:TEditorFrm ;
  Code ,tmpWindowsFID:string;
  FrmBillEx:TFrmBillEx ;
  LstParameterFLDs:Tstrings;
  i:integer;
  form:TAnalyseEx;
begin
  try
      FhlUser.CheckToolButtonRight( inttostr( fBillex.actid)  , (sender as Taction).Name );

      try
        LstParameterFLDs:=Tstringlist.Create ;

        sql:='select  A.F19,A.F17,A.F20 ,B.F_ID From T525 A  join '+ logininfo.SysDBPubName +'.dbo.T511 B  on A.F17=B.F06 where A.F02='+ inttostr( fBillex.actid) +' and A.f16=' +inttostr(Taction(Sender).Index )
            +' and A.f17=' +inttostr(Taction(Sender).ActionComponent.Tag  )+' and A.f04='+quotedstr( Ttoolbutton( Taction(Sender).ActionComponent).Caption   );
        fhlknl1.Kl_GetQuery2 (sql  );
        fBillType:=fhlknl1.FreeQuery.FieldByName('F19').AsString  ;
        frmid:=fhlknl1.FreeQuery.FieldByName('F17').AsString      ;
        tmpWindowsFID:=fhlknl1.FreeQuery.FieldByName('F_ID').AsString      ;

        if uppercase(fBillType)=uppercase('Analyser') then
        begin
            if dlDataSet1.FindField('sDefaultVals')<>nil then
            sDefaultVals:= dlDataSet1.fieldbyname('sDefaultVals').AsString;

            LstParameterFLDs.CommaText :=fhlknl1.FreeQuery.FieldByName('F20').AsString      ;//  fDict.QryParamsFLDs ;
            for i:=0 to  LstParameterFLDs.Count -1 do
            begin
                if ( dlDataSet1.FindField (LstParameterFLDs[i])<>nil ) then
                LstParameterFLDs[i]:=LstParameterFLDs[i]+'='+ dlDataSet1.fieldbyname(LstParameterFLDs[i]).AsString;
            end;
            if LstParameterFLDs.Count>0 then
            sDefaultVals:=LstParameterFLDs.CommaText ;

            form:=TAnalyseEx.Create(Application)  ;
            form.FormStyle :=fsnormal;
            form.hide;
            form.FWindowsFID :=tmpWindowsFID;
            form.InitFrm(frmid,null);
            form.ShowModal;
        end;

        if uppercase(fBillType)=uppercase('BillEx') then
        begin
          if not self.dlDataSet1.IsEmpty then
          begin
            LstParameterFLDs.CommaText :=fhlknl1.FreeQuery.FieldByName('F20').AsString      ;//  fDict.QryParamsFLDs ;
            for i:=0 to  LstParameterFLDs.Count -1 do
            begin
              if   dlDataSet1.FindField (LstParameterFLDs[i])<>nil then
              begin
                 if dlDataSet1.FieldByName (LstParameterFLDs[i]).AsString <>'' then
                 begin
                     Code:=dlDataSet1.FieldByName (LstParameterFLDs[i]).AsString  ;
                     break;
                 end;
              end;
            end;
          end;

          FrmBillEx:=TFrmBillEx.Create(nil);
          FrmBillEx.SetParamDataset(dlDataSet1  );
          FrmBillEx.FWindowsFID :=  tmpWindowsFID ;
          FrmBillEx.InitFrm(FrmId);
          if Code<>'' then
          begin
             FrmBillEx.OpenBill( code  );
          end;
          FrmBillEx.FormStyle :=fsnormal;
          FrmBillEx.Hide;
          FrmBillEx.Position :=poDesktopCenter;
          FrmBillEx.ScrollBtm.Visible :=true;

          FrmBillEx.ShowModal ;
        end;
      finally
        sDefaultVals:='';
        LstParameterFLDs.Free;
      end;
  except
    on err:exception do
    showmessage(err.Message );
  end;
end;

procedure TFrmBillEx.ActCreateSLinvoiceExecute(Sender: TObject);
//808
var
  frmid,keyValue:string;
  Code ,sql :string;
  FrmBillEx:TFrmBillEx ;
  i,j:integer;
begin
  try
      FhlUser.CheckToolButtonRight( inttostr( fBillex.actid)  , (sender as Taction).Name );

      try

          sql:=sql+' exec Pr_GetOrderDLForDelivery ' +quotedstr( self.fBillex.BillCode  ) ;
          fhlknl1.Kl_GetUserQuery  (sql  );
          if  not fhlknl1.User_Query.IsEmpty   then
          begin
              FrmBillEx:=TFrmBillEx.Create(nil);
              FrmBillEx.SetParamDataset(dlDataSet1  );
              FrmBillEx.InitFrm('14');
              FrmBillEx.FormStyle :=fsnormal;
              FrmBillEx.Position :=poDesktopCenter;
              FrmBillEx.ScrollBtm.Visible :=true;

              FrmBillEx.NewAction1.Execute;
              FrmBillEx.mtDataSet1.FieldByName('Clientid').Value := self.mtDataSet1.FieldByName('Clientid').Value ;
              FrmBillEx.mtDataSet1.FieldByName('ClientName').Value := self.mtDataSet1.FieldByName('ClientName').Value ;      
              FrmBillEx.mtDataSet1.FieldByName('Note').Value := self.mtDataSet1.FieldByName('Note').Value ;

              FrmBillEx.dlDataSet1.DisableControls ;
 
              fhlknl1.User_Query.First;
              for i:= 0 to  fhlknl1.User_Query.RecordCount -1 do
              begin  //WareId,PartNo,Brand,Qty,Origin,pack
                 FrmBillEx.dlDataSet1.Append ;
                 FrmBillEx.dlDataSet1.FieldByName('wareid').Value := fhlknl1.User_Query.FieldByName('wareid').Value ;
                 FrmBillEx.dlDataSet1.FieldByName('PartNo').Value := fhlknl1.User_Query.FieldByName('PartNo').Value ;
                 FrmBillEx.dlDataSet1.FieldByName('Brand').Value  := fhlknl1.User_Query.FieldByName('Brand').Value ;
                 FrmBillEx.dlDataSet1.FieldByName('Origin').Value := fhlknl1.User_Query.FieldByName('Origin').Value ;
                 FrmBillEx.dlDataSet1.FieldByName('pack').Value   := fhlknl1.User_Query.FieldByName('pack').Value ;
                 FrmBillEx.dlDataSet1.FieldByName('Qty').Value    := fhlknl1.User_Query.FieldByName('remainQty').Value ;
                 FrmBillEx.dlDataSet1.FieldByName('Price').Value    := fhlknl1.User_Query.FieldByName('Price').value ;
                 FrmBillEx.dlDataSet1.FieldByName('bhnote').Value    := fhlknl1.User_Query.FieldByName('dlnote').Value ;
                 FrmBillEx.dlDataSet1.FieldByName('SLOrderID').Value    := fhlknl1.User_Query.FieldByName('F_ID').Value ;
                 if (fhlknl1.User_Query.FindField('ClientOrderNo')  <>nil ) then
                    FrmBillEx.dlDataSet1.FieldByName('ClientOrderNo').Value    := fhlknl1.User_Query.FieldByName('ClientOrderNo').Value ;
                 if ( (fhlknl1.User_Query.FindField('FMinPackageQty')  <>nil) and (fhlknl1.User_Query.findfield('FMinPackageQty')<>nil) ) then
                    FrmBillEx.dlDataSet1.FieldByName('FMinPackageQty').Value    := fhlknl1.User_Query.FieldByName('FMinPackageQty').Value ;

                 FrmBillEx.dlDataSet1.Post;
                 fhlknl1.User_Query.Next;
              end;
              FrmBillEx.Hide;
              FrmBillEx.dlDataSet1.EnableControls  ;
              FrmBillEx.ShowModal ;
              RefreshAction1.Execute;
          end;
      finally
         fhlknl1.User_Query.Close;
      end;
  except
    on err:exception do
    showmessage(err.Message );
  end;
end;

procedure TFrmBillEx.ActSortExecute(Sender: TObject);
var strSort:string;
begin

isDesc:= not isDesc;
if isDesc  then
  strSort:=   DBGridDL.Columns[0].FieldName + ' DESC'
else
  strSort:=   DBGridDL.Columns[0].FieldName + ' ASC';

TCustomAdoDataSet(self.dlDataSet1 ).Sort:= strSort;
 
end;

procedure TFrmBillEx.ActPrintLabelCfgExecute(Sender: TObject);
var sql:string;
    FrmPrintCfg: TFrmBillEx;
begin
    try   {
        sql:=' insert into TLabelPrintingCfg( invoiceid,dlid,wareid,PartNo,Brand,Pack,Qty,FMinPackageQty,bhNote,ClientOrderNo) ';
        sql:=sql+ ' select top 100 sldl.invoiceid,sldl.dlid,sldl.wareid,sldl.PartNo,sldl.Brand,sldl.Pack,sldl.Qty,isnull(sldl.FMinPackageQty, sldl.Qty),sldl.bhNote,sldl.ClientOrderNo  ';
        sql:=sql+ ' from sl_invoicedl sldl left join TLabelPrintingCfg cfg on sldl.invoiceid = cfg.invoiceid and sldl.WareId = cfg.wareid where cfg.invoiceid  is null ';
        sql:=sql+ ' and sldl.InvoiceId = '+quotedstr(fBillex.BillCode );
         }
         sql:='exec Pr_MergeLabelPrintingCfg '  +quotedstr(fBillex.BillCode );

        fhlknl1.Kl_GetUserQuery (sql, false);


        FrmPrintCfg:=TFrmBillEx.Create(nil);

        FrmPrintCfg.SetParamDataset(dlDataSet1  );
        //  FrmBillEx.FWindowsFID :=  tmpWindowsFID ;
        FrmPrintCfg.InitFrm('22');
        FrmPrintCfg.OpenBill( fBillex.BillCode  );
        FrmPrintCfg.FormStyle :=fsnormal;
        FrmPrintCfg.Hide;
        FrmPrintCfg.Position :=poDesktopCenter;
        FrmPrintCfg.ScrollBtm.Visible :=true;

        FrmPrintCfg.ShowModal ;
    finally
        freeandnil(FrmPrintCfg);
    end;
end;

procedure TFrmBillEx.ActPlateLabelPreviewExecute(Sender: TObject);
var frm:TQrLabelPrinting;
var sql:string;
var labelDataset :TAdoDataset;
begin
  ActSaveWoOwner.Execute;
  frm:=TQrLabelPrinting.Create(nil);
  try
    frm.GetPageCfg();
    labelDataset := TAdoDataset.Create(nil);
    labelDataset.Connection := dmFrm.ADOConnection1;

    sql:= 'exec Pr_LabelPrintingData '+quotedstr(fBillex.BillCode) ;
    //fhlknl1.Kl_GetUserQuery(sql);
    labelDataset.CommandText :=sql;
    labelDataset.Open;
    frm.SetBillRep( labelDataset);
    frm.PreviewModal;
    
  finally
    freeandnil(labelDataset);
    FreeAndNil(frm);

    Screen.Cursor:=crDefault;
  end;
end;

procedure TFrmBillEx.ActSaveWoOwnerExecute(Sender: TObject);
var  s,ss,f:widestring;
//var  fDict:TBeforePostDict;
var  pKeys,DLKeyFLDs:Tstrings;
var i:integer;
var MtValues:variant;
var BackOnCalcFields ,BackUpDLBeforePost: TDataSetNotifyEvent ;
begin
// if (ImportAction1.ActionComponent <>nil) and TToolbutton(ImportAction1.ActionComponent ).Down then
 //   TToolbutton(ImportAction1.ActionComponent ).Click;

 try 
    if self.dlDataSet1.State in [dsinsert ,dsEdit	] then
    begin
       dlDataSet1.Post;
    end;
    if    dlDataSet1.RecordCount <1 then
    begin
       showmessage('请加明细记录!');
       abort;
    end;
    
    Screen.Cursor:=CrSqlWait;
      //AutoKey
      if (mtDataSet1.State=dsInsert) and (fBillex.AutoKeyId<>'') then
      begin
         if fBillex.BillCode='0000' then
         begin
           fBillex.BillCode:=dmFrm.GetMyId(fBillex.AutoKeyID );
             try
               pKeys:=Tstringlist.Create ;
               pKeys.CommaText :=   fBillex.mkeyfld;
               for i:=0 to pKeys.Count -1 do
               begin
                  mtDataSet1.FieldByName(pKeys[i]).AsString:=fBillex.BillCode;
               end;
             finally
                freeandnil(pKeys) ;
             end;
           end;
      end;

      BackUpDLBeforePost:= dlDataSet1.BeforePost ;
      dlDataSet1.BeforePost:=nil;
      if  mtDataSet1.State in [dsedit,dsInsert]  then
      begin
        UpdateSysFieldsAndCalValue;
      end;
      DLKeyFLDs:=Tstringlist.Create ;
      DLKeyFLDs.CommaText :=fBillex.fkeyfld;
      MtValues :=FhlKnl1.Ds_GetFieldsValue(mtDataSet1,fBillex.mkeyfld);
      BackOnCalcFields:= dlDataSet1.OnCalcFields ;
     // dlDataSet1.OnCalcFields :=nil;                //加快保存速度
      Ds_UpdateAllRecs(Self.DBGridDL , fBillex.fkeyfld ,  MtValues  ,self.PgBarSave ,false  );
      freeandnil(DLKeyFLDs) ;
      dlDataSet1.BeforePost :=BackUpDLBeforePost ;
      try
           dmfrm.ADOConnection1.BeginTrans ;
           mtDataSet1.UpdateBatch;
           dlDataSet1.UpdateBatch;  //调换了个顺序 ,影响所有bill模板

           if (frmSearchBarCode<>nil) and not frmSearchBarCode.BarCodeDataSet.IsEmpty   then
           begin
               frmSearchBarCode.Save(fBillex.BillCode); 
           end;
       //   dlDataSet1.OnCalcFields:=BackOnCalcFields ;
      except
          on err:exception do
          begin
            //  EditPostAfter(True);
            dmfrm.ADOConnection1.RollbackTrans ;
            Screen.Cursor:=crDefault;
            showmessage(err.Message );
            exit;
          end;
      end;
      dmfrm.ADOConnection1.CommitTrans ;

      if not   self.AftSaveBillExecute  then
      begin
           abort;
      end
      else
          EditPostAfter(True);
   //  self.OpenBill(self.fBillex.BillCode ) ;    2010-7-11
  finally
     Screen.Cursor:=crDefault;
  end;
end;


procedure TFrmBillEx.ActOutItemPrintLabelExecute(Sender: TObject);
var frm:TQrLabelPrinting;
var sql:string;
begin
  ActSaveWoOwner.Execute;
  frm:=TQrLabelPrinting.Create(nil);
  try
    frm.GetPageCfg();

    sql:= 'exec Pr_OutItemLabelPrintingData '+quotedstr(fBillex.BillCode) ;
    fhlknl1.Kl_GetUserQuery(sql);

    frm.SetBillRep(  fhlknl1.User_Query );
    frm.PreviewModal;
    
  finally
    FreeAndNil(frm);
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFrmBillEx.EnableDsCaculation(enabled: boolean);
begin
  if enabled then
  begin
      self.dlDataSet1.OnCalcFields :=BackOnCalcFields;
  end
  else
  begin
      BackOnCalcFields := self.dlDataSet1.OnCalcFields;
      dlDataSet1.OnCalcFields := nil;
  end;
end;

procedure TFrmBillEx.ActPlatePrintLabelExecute(Sender: TObject);
var frm:TQrLabelPrinting;
var sql:string;

begin
  ActSaveWoOwner.Execute;
  frm:=TQrLabelPrinting.Create(nil);
  try
    frm.GetPageCfg();

    sql:= 'exec Pr_LabelPrintingData '+quotedstr(fBillex.BillCode) ;
    fhlknl1.Kl_GetUserQuery(sql);

    frm.SetBillRep(  fhlknl1.User_Query );
    frm.Print;
    
  finally
    FreeAndNil(frm);
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFrmBillEx.ActPerPartNoPlateLabelPreviewExecute(Sender: TObject);
var frm:TQrLabelPrinting;
var sql:string;
var labelDataset :TAdoDataset;
begin
  if self.dlDataSet1.IsEmpty then
      abort;

  ActSaveWoOwner.Execute;
  frm:=TQrLabelPrinting.Create(nil);
  try
    frm.GetPageCfg();
    labelDataset := TAdoDataset.Create(nil);
    labelDataset.Connection := dmFrm.ADOConnection1;

    sql:= 'exec Pr_LabelPrintingData '+quotedstr(fBillex.BillCode) +','+ dlDataSet1.fieldbyname('wareid').AsString ;
    //fhlknl1.Kl_GetUserQuery(sql);
    labelDataset.CommandText :=sql;
    labelDataset.Open;
    frm.SetBillRep( labelDataset);
    frm.PreviewModal;
    
  finally
    freeandnil(labelDataset);
    FreeAndNil(frm);

    Screen.Cursor:=crDefault;
  end;


end;

procedure TFrmBillEx.ActPlateClientBarCodePreviewByWareExecute(Sender: TObject);
var frm:TQrClientBarCodePrint;
var sql:string;

begin
  ActSaveWoOwner.Execute;
  frm:=TQrClientBarCodePrint.Create(nil);
  try
    frm.GetPageCfg();

    sql:= 'exec Pr_ClientBarCodeLabelPrintByWare  '+quotedstr(fBillex.BillCode) +','+ dlDataSet1.fieldbyname('wareid').AsString ;
    fhlknl1.Kl_GetUserQuery(sql);

    frm.SetBillRep(  fhlknl1.User_Query  );
    frm.Preview;
    
  finally
    FreeAndNil(frm);
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFrmBillEx.ActPlateClientBarCodePreviewWholeBillExecute( Sender: TObject);
var frm:TQrClientBarCodePrint;
var sql, barcodeFileName:string;
var frmTest : Tform;
var image:TImage;
var i:integer;
begin
  //image  := TImage.Create(nil);

  ActSaveWoOwner.Execute;
  frm:=TQrClientBarCodePrint.Create(nil);
  try
    frm.GetPageCfg();

    sql:= 'exec Pr_ClientBarCodeLabelPrint  '+quotedstr(fBillex.BillCode)  ;
    fhlknl1.Kl_GetUserQuery(sql);

    frm.SetBillRep(  fhlknl1.User_Query );
    frm.Preview;
  finally
    FreeAndNil(frm);
    Screen.Cursor:=crDefault;
  end;
end;
procedure TFrmBillEx.ActPrintBarCodePhOrdExecute(Sender: TObject);
begin
   //
   GeneratorBarcode('')
end;

procedure TFrmBillEx.ActPlateClientBarCodePrintWholeBillExecute(
  Sender: TObject);
var frm:TQrClientBarCodePrint;
var sql:string;

begin
  ActSaveWoOwner.Execute;
  frm:=TQrClientBarCodePrint.Create(nil);
  try
    frm.GetPageCfg();

    sql:= 'exec Pr_ClientBarCodeLabelPrint  '+quotedstr(fBillex.BillCode)  ;
    fhlknl1.Kl_GetUserQuery(sql);

    frm.SetBillRep(  fhlknl1.User_Query );
    frm.Print;
    
  finally
    FreeAndNil(frm);
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFrmBillEx.ActPrintEveryPackageLabelExecute(Sender: TObject);
var frm:TQrLabelPrinting;
var sql:string;
begin
  ActSaveWoOwner.Execute;
  frm:=TQrLabelPrinting.Create(nil);
  try
    frm.GetPageCfg();

    sql:= 'exec Pr_OutItemEveryPackageLabelPrintingData '+quotedstr(fBillex.BillCode) ;
    fhlknl1.Kl_GetUserQuery(sql);

    frm.SetBillRep(  fhlknl1.User_Query );
    frm.PreviewModal;
    
  finally
    FreeAndNil(frm);
    Screen.Cursor:=crDefault;
  end;
end;
 {
procedure TFrmBillEx.AddPage(report: TfrReport; fileName: string);
var picview,t1,t0:TfrPictureView;
var newpage:TfrPage;
begin
  t0:=TfrPictureView(report.Pages[0].FindObject('Picture1'));
  
  report.Pages.Add;

  newpage:= report.Pages[report.Pages.Count -1]  ;
  newpage.pgWidth:=report.Pages[0].pgWidth;
  newpage.pgHeight:=report.Pages[0].pgHeight;
  newpage.pgSize := report.Pages[0].pgSize;

  picview:= TfrPictureView.Create;
  picview.Assign(t0);
  picview.ParentPage :=newpage;

  newpage.Objects.Add( picview );

  t1:=TfrPictureView(newpage.FindObject('Picture1'));
  if t1<>nil then
  t1.Picture.loadfromfile(fileName);
end;      }

procedure TFrmBillEx.ActPlateClientBarCodePreviewWholeBillV2Execute(Sender: TObject);
var frm:TQrClientBarCodePrint;
var sql, barcodeFileName:string;
var frmPrintingProgress : TfrmBarcodePrintingProgress;
var image:TImage;
var i:integer;
var filelist:Tstringlist ;
var folder:string;
begin
    //image  := TImage.Create(nil);

    folder := './barcodeImages/'+self.fBillex.BillCode+'/' ;
    GetBarcodeFolder(false);
    ActSaveWoOwner.Execute;
    frm:=TQrClientBarCodePrint.Create(nil);
    try
      frm.GetPageCfg();

      sql:= 'exec Pr_ClientBarCodeLabelPrint  '+quotedstr(fBillex.BillCode)  ;
      fhlknl1.Kl_GetUserQuery(sql);

      //frm.SetBillRep(  fhlknl1.User_Query );
      self.PgBarSave.Max := fhlknl1.User_Query.RecordCount ;
      self.PgBarSave.Visible := True;
      fhlknl1.User_Query.First;
      for i:=1 to  fhlknl1.User_Query.RecordCount do
      begin
        barcodeFileName :=folder+fhlknl1.User_Query.fieldbyname('FBarCode0').AsString + '.jpg';
        if not fileexists( barcodeFileName ) then
        begin
          image:=frm.ExportReport(  fhlknl1.User_Query );
          ImageConverter.BmpToJpeg( image, barcodeFileName);
          image.Free ;
        end;
        application.ProcessMessages ;
        self. PgBarSave.Position := i ;
        fhlknl1.User_Query.Next  ;
      end;
      //frm.InitialImageLoader(  fhlknl1.User_Query, fBillex.BillCode );
      //frm.Preview;

      frmPrintingProgress := TfrmBarcodePrintingProgress.Create(nil);
      frmPrintingProgress.ImageDir := folder;
      frmPrintingProgress.ShowModal;
    finally
      self.PgBarSave.Visible := False;
      FreeAndNil(frm);
      FreeAndNil(frmPrintingProgress);
      Screen.Cursor:=crDefault;
    end;
end;
procedure TFrmBillEx.GetBarcodeFolder(bDeleteImages:Boolean);
var folder:string;
begin
    folder :='barcodeImages';

    if not DirectoryExists(folder) then
        createdir(folder);

    folder:= 'barcodeImages\'+self.fBillex.BillCode +'\' ;
    if self.fBillex.ID ='22' then  
          if not DirectoryExists(folder) then
              createdir( folder);
    if bDeleteImages then
      DeleteBakFile(folder,'*.jpg', -1);
end;

procedure TFrmBillEx.ActCreateDeliveryLabelExecute(Sender: TObject);
var sql ,code : string;
var FrmBillEx: TFrmBillEx ;
begin
    code:=  mtDataSet1.fieldbyname('code').AsString ;
    sql:= 'exec Pr_GetDeliveryLabel '+quotedstr( mtDataSet1.fieldbyname('code').AsString ) ;
    fhlknl1.Kl_GetUserQuery(sql, false);
    try
      FrmBillEx:=TFrmBillEx.Create(nil);
      FrmBillEx.SetParamDataset(dlDataSet1  );
      FrmBillEx.FWindowsFID :=  '' ;
      FrmBillEx.InitFrm('24');
      if Code<>'' then
      begin
          FrmBillEx.OpenBill( code  );
      end;
      FrmBillEx.FormStyle :=fsnormal;
      FrmBillEx.Hide;
      FrmBillEx.Position :=poDesktopCenter;
      FrmBillEx.ScrollBtm.Visible :=true;

      FrmBillEx.ShowModal ;
    finally
      FrmBillEx.Free ;
    end;
end;

procedure TFrmBillEx.ActDeliveryLabelPrintExecute(Sender: TObject);
var dataset: TCustomADODataSet;
var frm: TDeliveryLabelPrint  ;
var sql:string;
begin
  frm:=TDeliveryLabelPrint.Create(nil);
  //frm.GetPageCfg();

  try
    if not  dlDataSet1.IsEmpty    then
    begin
      sql:= 'select * from TDeliveryLabel where Moveid =  '+quotedstr( mtDataSet1.fieldbyname('code').AsString ) +' order by pcsIndex';
      fhlknl1.Kl_GetUserQuery(sql, true);

      frm.SetBillRep( fhlknl1.User_Query  );
      frm.PreviewModal ;
    end;

  finally
    Screen.Cursor:=crDefault;
  end;
end; 

procedure TFrmBillEx.ActMulFormatPrintExecute(Sender: TObject);
 var
    printID:string;
    FrmMulModulePrint: TFrmMulModulePrint;
begin
  inherited;
  try
    printID:=self.fBillex.ID;
    FrmMulModulePrint:= TFrmMulModulePrint.Create (nil);
    FrmMulModulePrint.FrmIni(printID  ,self.mtDataSet1   ,inttostr(mtDataSet1.Tag ), self.fBillex.TopBoxId ,     fBillex.BtmBoxID ,DBGridDL  );
    FrmMulModulePrint.MaxPrintModule :=20;
    FrmMulModulePrint.ShowModal ;
  finally
    FrmMulModulePrint.Free ;
  end;
end;


end.



