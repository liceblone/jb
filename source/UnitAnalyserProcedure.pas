unit UnitAnalyserProcedure;

interface


uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ComCtrls, ToolWin, DB, ADODB, ExtCtrls, StdCtrls,  DBCtrls, DateUtils,
  Menus, ActnList, TabEditor, jpeg, Buttons, FhlKnl,billOpenDlg,UnitModelFrm,UnitCreateComponent,Editor;

type
  TFrmAnalyserProcedure = class(TForm)
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    DBGrid1: TDBGrid;
    dlAdoDataSet1: TADODataSet;
    dlDataSource1: TDataSource;
    BtmPanel1: TPanel;
    Label1: TLabel;
    statLabel1: TLabel;
    ActionList1: TActionList;
    printAction1: TAction;
    refreshAction2: TAction;
    SortAction3: TAction;
    exportAction4: TAction;
    importAction5: TAction;
    closeAction6: TAction;
    subAction7: TAction;
    finderAction8: TAction;
    dsfinderAction9: TAction;
    WarePropAction10: TAction;
    DeleteAction11: TAction;
    PickWareAction12: TAction;
    TabEditorAction13: TAction;
    NewTabEditorAction14: TAction;
    TopPanel1: TPanel;
    NewBillAction15: TAction;
    EditBillAction16: TAction;
    DeleteBillAction17: TAction;
    ChkBillAction18: TAction;
    DeposeBillAction19: TAction;
    CloseBillAction20: TAction;
    VldBillAction21: TAction;
    EditorAction22: TAction;
    DetailAction23: TAction;
    dlBillAction24: TAction;
    CalcIncreaseAction25: TAction;
    dlFilterAction26: TAction;
    mtADODataSet1: TADODataSet;
    mtDataSource1: TDataSource;
    OpnDlDsBtn1: TSpeedButton;
    InitdsFinderAction27: TAction;
    Print2Action28: TAction;
    ph1Action29: TAction;
    whInvAction33: TAction;
    WhInvbAction34: TAction;
    phArriveXAction35: TAction;
    phOrdAriXAction36: TAction;
    mtBillAction37: TAction;
    mtFirstAction38: TAction;
    mtPriorAction39: TAction;
    mtNextAction40: TAction;
    mtLastAction41: TAction;
    dlLocateAction42: TAction;
    mtFilterAction43: TAction;
    mtLocateAction44: TAction;
    phOrdCloseAction45: TAction;
    phOrdAriBilAction46: TAction;
    fnCaAction47: TAction;
    slWhOutAction48: TAction;
    slHisAction49: TAction;
    fnBankInoutAction50: TAction;
    fncadlAction51: TAction;
    whWareInoutAction52: TAction;
    OpenBillAction53: TAction;
    mtProcAction54: TAction;
    slOutStpAction55: TAction;
    fnDyRprtDtlAction56: TAction;
    fnAlrdyBlAction57: TAction;
    fnChkAction58: TAction;
    fnDyRprtDtl2Action59: TAction;
    IsInvoiceAction60: TAction;
    fnItmInoutAction61: TAction;
    fnShldOutIOAction62: TAction;
    wrprice63: TAction;
    IsOutBillAction64: TAction;
    slInvoiceRecHintAction65: TAction;
    slInvoiceRecedAction1: TAction;
    slEmpSaleDlAction67: TAction;
    slClientKp2Action68: TAction;
    slClientProfitAction69: TAction;
    ywyDetailNewAction70: TAction;
    ywyDetailEdtAction71: TAction;
    ywyLinkmansAction72: TAction;
    ywyActivitysAction73: TAction;
    ywyLinkmanNewAction74: TAction;
    ywyActivityNewAction75: TAction;
    kcYdstockAction76: TAction;
    phQuotePriceAction77: TAction;
    phOrderReferAction78: TAction;
    phArriveReferAction79: TAction;
    ywyDemandAction80: TAction;
    IsInvEditAction81: TAction;
    ActionStkinAndStkout82: TAction;
    actInputInvoice83: TAction;
    mtADODataSet1IntegerField111: TIntegerField;
    actPackPic84: TAction;
    actBrandPic85: TAction;
    actPriceOutRfs86: TAction;
    actNeedInvoiceDL: TAction;
    actHaveInvoiceDL: TAction;
    actInvoice: TAction;
    actShowPInvoice: TAction;
    actChkORUnChk: TAction;
    actShowNInvoice: TAction;
    actEditPriceChange: TAction;
    actShowPriceChange: TAction;
    ToolButton1: TToolButton;
    InvoiceItem: TAction;
    ActUpdateSalePrice: TAction;
    ActInvoiceBillItem: TAction;
    ActCreatePhPlan: TAction;
    ActQueryPhPlan: TAction;
    procedure InitFrm(AFrmId:String;AmtParams:Variant);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dlAdoDataSet1AfterClose(DataSet: TDataSet);
    procedure dlAdoDataSet1AfterScroll(DataSet: TDataSet);
    procedure printAction1Execute(Sender: TObject);
    procedure refreshAction2Execute(Sender: TObject);
    procedure exportAction4Execute(Sender: TObject);
    procedure importAction1Execute(Sender: TObject);
    procedure closeAction1Execute(Sender: TObject);
    procedure finderAction1Execute(Sender: TObject);
    procedure dsfinderAction1Execute(Sender: TObject);
    procedure WarePropAction1Execute(Sender: TObject);
    procedure DeleteAction1Execute(Sender: TObject);
    procedure TabEditorAction1Execute(Sender: TObject);
    function  GetTabEditorFrm:TTabEditorFrm;
    procedure NewTabEditorAction1Execute(Sender: TObject);
    procedure NewBillAction1Execute(Sender: TObject);
    procedure EditBillAction1Execute(Sender: TObject);
    procedure ChkBillAction1Execute(Sender: TObject);
    procedure VldBillAction1Execute(Sender: TObject);
    procedure CloseBillAction1Execute(Sender: TObject);
    procedure EditorAction1Execute(Sender: TObject);
    procedure DetailAction1Execute(Sender: TObject);
    procedure dlBillAction1Execute(Sender: TObject);
    procedure dlFilterAction1Execute(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1DrawColumnCellFntClr(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure OpnDlDsBtn1Click(Sender: TObject);
    procedure Print2Action1Execute(Sender: TObject);
    procedure ph1Action1Execute(Sender: TObject);
    procedure sl1Action1Execute(Sender: TObject);
    procedure SortAction3Execute(Sender: TObject);
    procedure whInvAction1Execute(Sender: TObject);
    procedure WhInvbAction1Execute(Sender: TObject);
    procedure phArriveXAction1Execute(Sender: TObject);
    procedure phOrdAriXAction1Execute(Sender: TObject);
    procedure mtBillAction1Execute(Sender: TObject);
    procedure mtFirstAction1Execute(Sender: TObject);
    procedure mtPriorAction1Execute(Sender: TObject);
    procedure mtNextAction1Execute(Sender: TObject);
    procedure mtLastAction1Execute(Sender: TObject);
    procedure dlLocateAction1Execute(Sender: TObject);
    procedure mtFilterAction1Execute(Sender: TObject);
    procedure mtLocateAction1Execute(Sender: TObject);
    procedure phOrdCloseAction1Execute(Sender: TObject);
    procedure phOrdAriBilAction1Execute(Sender: TObject);
    procedure fnCaAction1Execute(Sender: TObject);
    procedure slWhOutAction1Execute(Sender: TObject);
    procedure slHisAction1Execute(Sender: TObject);
    procedure fnBankInoutAction1Execute(Sender: TObject);
    procedure fncadlAction1Execute(Sender: TObject);
    procedure whWareInoutAction1Execute(Sender: TObject);
    procedure OpenBillAction1Execute(Sender: TObject);
    procedure mtProcAction1Execute(Sender: TObject);
    procedure fnDyRprtDtlAction1Execute(Sender: TObject);
    procedure fnAlrdyBlAction1Execute(Sender: TObject);
    procedure fnChkAction1Execute(Sender: TObject);
    procedure slOutStpAction1Execute(Sender: TObject);
    procedure fnDyRprtDtl2Action1Execute(Sender: TObject);
    procedure fnItmInoutAction61Execute(Sender: TObject);
    procedure fnShldOutIOAction62Execute(Sender: TObject);
    procedure wrprice63Execute(Sender: TObject);
    procedure IsOutBillAction64Execute(Sender: TObject);
    procedure slInvoiceRecHintAction65Execute(Sender: TObject);
    procedure slInvoiceRecedAction1Execute(Sender: TObject);
    procedure slEmpSaleDlAction67Execute(Sender: TObject);
    procedure slClientKp2Action68Execute(Sender: TObject);
    procedure slClientProfitAction69Execute(Sender: TObject);
    procedure ywyDetailNewAction70Execute(Sender: TObject);
    procedure ywyDetailEdtAction71Execute(Sender: TObject);
    procedure ywyLinkmansAction72Execute(Sender: TObject);
    procedure ywyActivitysAction73Execute(Sender: TObject);
    procedure kcYdstockAction76Execute(Sender: TObject);
    procedure phQuotePriceAction77Execute(Sender: TObject);
    procedure phOrderReferAction78Execute(Sender: TObject);
    procedure phArriveReferAction79Execute(Sender: TObject);
    procedure ywyDemandAction80Execute(Sender: TObject);
    procedure IsInvoiceAction60Execute(Sender: TObject);
    procedure IsInvEditAction81Execute(Sender: TObject);
    procedure TopPanel1DblClick(Sender: TObject);
    procedure ActionStkinAndStkout82Execute(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure actInputInvoice83Execute(Sender: TObject);
    procedure actPackPic84Execute(Sender: TObject);
    procedure actBrandPic85Execute(Sender: TObject);
    procedure actPriceOutRfs86Execute(Sender: TObject);
    procedure actNeedInvoiceDLExecute(Sender: TObject);
    procedure actHaveInvoiceDLExecute(Sender: TObject);
    procedure actInvoiceExecute(Sender: TObject);
    procedure actShowPInvoiceExecute(Sender: TObject);
    procedure actChkORUnChkExecute(Sender: TObject);
    procedure actShowNInvoiceExecute(Sender: TObject);
    procedure actEditPriceChangeExecute(Sender: TObject);
    procedure actShowPriceChangeExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure InvoiceItemExecute(Sender: TObject);
    procedure ActUpdateSalePriceExecute(Sender: TObject);
    procedure ActInvoiceBillItemExecute(Sender: TObject);
    procedure ActCreatePhPlanExecute(Sender: TObject);
    procedure TopPanel1Click(Sender: TObject);
  private
    fFinderFrm,fdsFinderFrm:TForm;
    fTabEditorFrm:TTabEditorFrm;
    fDict:TAnalyserDict;
    fBillOpenDlgFrm:TBillOpenDlgFrm;
  public
    { Public declarations }
  end;

var
  analyserFrm: TanalyserFrm;
  const MulSelMessage:string='需要多选时请按Ctrl并点选择记录';
implementation
uses datamodule,repgrid,colProp,repset,bill, RepBill, Inv;
{$R *.dfm}

procedure TanalyserFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);

begin
 mtADODataSet1.Cancel;

 fFinderFrm.Free;
 fdsFinderFrm.Free;
 fTabEditorFrm.Free;
 Action:=caFree;

end;

procedure TanalyserFrm.InitFrm(AFrmId:String;AmtParams:Variant);
//var i:integer;
begin
  if Not FhlKnl1.Cf_GetDict_Analyser(AFrmId,fdict) then Close;
  Caption:=fDict.Caption;
  FhlKnl1.Tb_CreateActionBtns(ToolBar1,ActionList1,fDict.Actions);
  FhlUser.SetDataSet(mtAdoDataSet1,fDict.mtDataSetId,AmtParams);
  if mtAdoDataSet1.Active then
  begin
      FhlUser.AssignDefault(mtAdoDataSet1);
      if mtAdoDataSet1.IsEmpty then
      begin
          mtAdoDataSet1.Append;
      end;
  end;

  if (fDict.TopBoxId<>'-1') and (fDict.TopBoxId<>'' ) then      //top or buttom      create label and dbcontrol
    FhlKnl1.Cf_SetBox(fDict.TopBoxId,mtDataSource1,TopPanel1,dmFrm.dbCtrlActionList1);
  if (fDict.BtmBoxId<>'-1') and (fDict.BtmBoxId<> '') then
    FhlKnl1.Cf_SetBox(fDict.BtmBoxId,mtDataSource1,BtmPanel1,dmFrm.dbCtrlActionList1);
  if fDict.DblActIdx>-1 then
    DbGrid1.OnDblClick:=ActionList1.Actions[fDict.DblActIdx].OnExecute;


  FhlUser.SetDbGridAndDataSet(DbGrid1,fDict.DbGridId,null,false);

{  if dlAdoDataSet1.FindField('FntClr')<>nil then
   DbGrid1.OnDrawColumnCell:=DBGrid1DrawColumnCellFntClr
  else
  begin
      for i:=0 to self.DBGrid1.Columns.Count -1 do
      begin
          if uppercase(self.DBGrid1.Columns[i].FieldName )=  'FNTCLR' then
          begin
               DbGrid1.OnDrawColumnCell:=DBGrid1DrawColumnCellFntClr   ;
               break;
          end;
      end;

  end;
  }




  if fDict.IsOpen then
  begin
    if mtAdoDataSet1.Active then
      OpnDlDsBtn1.Click         //查询
    else
      dlAdoDataSet1.Open;
  end;
  if fDict.DlgIdx>-1 then
    ActionList1.Actions[fDict.DlgIdx].Execute;

   if   dgMultiselect in dbgrid1.Options then      //2006-7-26加入多先功能
     DBGrid1.Hint :=MulSelMessage;
end;

procedure TanalyserFrm.dlAdoDataSet1AfterClose(DataSet: TDataSet);
begin
Label1.Caption:='';
exportAction4.Enabled:=false;
end;

procedure TanalyserFrm.dlAdoDataSet1AfterScroll(DataSet: TDataSet);
begin
 statLabel1.Caption:=intTostr(dlAdoDataSet1.RecNo)+'/'+intTostr(dlAdoDataSet1.RecordCount);
end;

procedure TanalyserFrm.printAction1Execute(Sender: TObject);
begin
if self.DBGrid1.DataSource.DataSet.Active  then
 FhlKnl1.Rp_DbGrid(intTostr(DbGrid1.Tag),DbGrid1,self.fDict.Caption );
end;

procedure TanalyserFrm.refreshAction2Execute(Sender: TObject);
begin
  if dlAdoDataSet1.Active then
    FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);
end;

procedure TanalyserFrm.exportAction4Execute(Sender: TObject);
begin
if self.DBGrid1.DataSource.DataSet.Active  then
 with dmFrm.OpenDialog1 do
 begin
   Filter:='FHL数据包(*.fhl)|*.fhl';
   if Execute then
   begin
     Screen.Cursor:=crHourGlass;
     try
       dlAdoDataSet1.SaveToFile(ChangeFileExt(FileName,'.fhl'));
     finally
       Screen.Cursor:=crDefault;
     end;
   end;
 end;
end;

procedure TanalyserFrm.importAction1Execute(Sender: TObject);
begin
 with dmFrm.OpenDialog1 do
 begin
   Filter:='FHL数据文件(*.fhl)|*.fhl';
   if Execute then
      dlAdoDataSet1.LoadFromFile(FileName);
 end;
end;

procedure TanalyserFrm.closeAction1Execute(Sender: TObject);
begin
close;
end;

procedure TanalyserFrm.finderAction1Execute(Sender: TObject);
begin
   FhlUser.ShowFinderFrm(dlAdoDataSet1,fFinderFrm,fDict.FinderId);
end;

procedure TanalyserFrm.dsfinderAction1Execute(Sender: TObject);
  var fParams:variant;
begin
  fParams:=FhlUser.ShowdsFinderFrm(fdsFinderFrm,fDict.dsFinderId);
  if Not VarIsNull(fParams) then
     FhlKnl1.Ds_OpenDataSet(dlAdoDataSet1,fParams);
end;

procedure TanalyserFrm.WarePropAction1Execute(Sender: TObject);
begin
if self.DBGrid1.DataSource.DataSet.Active  then
begin
  FhlUser.CheckRight(fDict.WarePropRitId);
  FhlUser.ShowWarePropFrm(dlAdoDataSet1.FieldByName('Id').asString,dlDataSource1);
end;  
end;

procedure TanalyserFrm.DeleteAction1Execute(Sender: TObject);
begin
if self.DBGrid1.DataSource.DataSet.Active  then
begin
  if Not Assigned(dlAdoDataSet1.BeforeDelete) and (MessageDlg(fsDbDelete,mtConfirmation,[mbYes,mbNo],0)<>mrYes) then
     Abort;
  dlAdoDataSet1.Delete;
end;
  
end;

function TanalyserFrm.GetTabEditorFrm:TTabEditorFrm;
begin
  if fTabEditorFrm=nil then
  begin
    fTabEditorFrm:=TTabEditorFrm.Create(Application);
    fTabEditorFrm.InitFrm('Analyser.'+fDict.Id,Null,dlAdoDataSet1);
  end;
  Result:=fTabEditorFrm;
end;

procedure TanalyserFrm.TabEditorAction1Execute(Sender: TObject);
begin
  GetTabEditorFrm.ShowModal;
end;

procedure TanalyserFrm.NewTabEditorAction1Execute(Sender: TObject);
begin
  GetTabEditorFrm.DataSource1.DataSet.Append;
  fTabEditorFrm.ShowModal;
end;

procedure TanalyserFrm.NewBillAction1Execute(Sender: TObject);
begin
  FhlUser.ShowBillFrm(fDict.Tag);
end;

procedure TanalyserFrm.EditBillAction1Execute(Sender: TObject);
begin
  FhlUser.ShowBillFrm(fDict.Tag,self.dlAdoDataSet1.FieldByName('Code').asString);
end;

procedure TanalyserFrm.ChkBillAction1Execute(Sender: TObject);
  var fBillDict:TBillDict;
begin
  FhlKnl1.Cf_GetDict_Bill(fDict.Tag,fBillDict);
  fbilldict.BillCode:=self.dlAdoDataSet1.FieldByName(fbilldict.mkeyfld).asString;
  dmFrm.ExecStoredProc(fbilldict.chkproc,varArrayof([fbilldict.billcode,LoginInfo.EmpId,LoginInfo.LoginId]));
  FhlKnl1.Ds_RefreshDataSet(self.dlAdoDataSet1);
  self.dlAdoDataSet1.Locate(fbilldict.mkeyfld,fbilldict.BillCode,[]);
end;

procedure TanalyserFrm.VldBillAction1Execute(Sender: TObject);
  var fBillDict:TBillDict;
begin
  FhlKnl1.Cf_GetDict_Bill(fDict.Tag,fBillDict);
  fbilldict.BillCode:=self.dlAdoDataSet1.FieldByName(fbilldict.mkeyfld).asString;
  dmFrm.ExecStoredProc(fbilldict.vldproc,varArrayof([fbilldict.billcode,LoginInfo.EmpId]));
  FhlKnl1.Ds_RefreshDataSet(self.dlAdoDataSet1);
  self.dlAdoDataSet1.Locate(fbilldict.mkeyfld,fbilldict.BillCode,[]);
end;

procedure TanalyserFrm.CloseBillAction1Execute(Sender: TObject);
  var fBillDict:TBillDict;
begin
  FhlKnl1.Cf_GetDict_Bill(fDict.Tag,fBillDict);
  fbilldict.BillCode:=self.dlAdoDataSet1.FieldByName(fbilldict.mkeyfld).asString;
  dmFrm.ExecStoredProc(fbilldict.clsproc,varArrayof([fbilldict.billcode,LoginInfo.EmpId]));
  FhlKnl1.Ds_RefreshDataSet(self.dlAdoDataSet1);
  self.dlAdoDataSet1.Locate(fbilldict.mkeyfld,fbilldict.BillCode,[]);
end;

procedure TanalyserFrm.EditorAction1Execute(Sender: TObject);
begin
  FhlUser.ShowEditorFrm('Analyser.'+fDict.Id,null,dlAdoDataSet1).ShowModal;
end;

procedure TanalyserFrm.DetailAction1Execute(Sender: TObject);
begin
  FhlUser.ShowTabGridFrm('Analyser.Detail.'+fDict.Id,self.dlAdoDataSet1.FieldByName('Code').asString);
end;

procedure TanalyserFrm.dlBillAction1Execute(Sender: TObject);
var
  fBillId:String;
begin
  fBillId:=dlAdoDataSet1.FieldByName('BillId').AsString;
  if fBillId='-1' then exit;
  FhlUser.ShowBillFrm(fBillId,dlAdoDataSet1.FieldByName('BillCode').asString);
//    FhlUser.ShowEditorFrm('Analyser.'+fDict.Id,null,dlAdoDataSet1).ShowModal;
end;

procedure TanalyserFrm.dlFilterAction1Execute(Sender: TObject);
begin
  FhlKnl1.Ds_Filter(dlAdoDataSet1);
end;

procedure TanalyserFrm.DBGrid1DrawColumnCellFntClr(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if DbGrid1.DataSource.DataSet.IsEmpty then exit;
  if dlAdoDataSet1.FieldByName('FntClr').AsString<>'' then
  begin
  DbGrid1.Canvas.Font.Color:=StringToColor(dlAdoDataSet1.FieldByName('FntClr').AsString);
  FhlKnl1.Dg_DrawLineFont(Sender,Rect,DataCol,Column,State,DbGrid1.Canvas.Font);
  end;
end;

procedure TanalyserFrm.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin

if NOT  ( dgMultiselect in dbgrid1.Options) then

  FhlKnl1.Dg_DrawZebraBackgroud(Sender,Rect,DataCol,Column,State,clWhite,clCream);

end;

procedure TanalyserFrm.OpnDlDsBtn1Click(Sender: TObject);
var fParams:variant;
//  var i:integer;
var  abortstr,WarningStr:string;
begin
  with mtAdoDataSet1 do
  begin
      if (State=dsInsert) or (State=dsEdit) then  //update parameter getvalue
      begin
        UpdateRecord;
        Post;
      end;
  end;

    fParams:=FhlKnl1.Ds_GetFieldsValue(mtAdoDataSet1,fDict.mtOpenParamFlds);


    if Not VarIsNull(fParams) then
    begin
         FhlKnl1.Ds_OpenDataSet(dlAdoDataSet1,fParams);
    end;



 if assigned(  dlAdoDataSet1.FindField('fntclr')) then
    DbGrid1.OnDrawColumnCell:=DBGrid1DrawColumnCellFntClr   ;

end;

procedure TanalyserFrm.Print2Action1Execute(Sender: TObject);
begin
  Screen.Cursor:=crSqlWait;
  RepBillFrm:=TRepBillFrm.Create(Application);
  dlAdoDataSet1.DisableControls;
  try
    RepBillFrm.SetBillRep(fdict.TopBoxId,fdict.BtmBoxId,mtAdoDataSet1,DbGrid1);
    RepBillFrm.PreviewModal;
  finally
    dlAdoDataSet1.EnableControls;
    Screen.Cursor:=crDefault;
    RepBillFrm.Free;
  end;
end;

procedure TanalyserFrm.ph1Action1Execute(Sender: TObject);
begin
  sDefaultVals:='ClientId='+dlAdoDataSet1.FieldByName('ClientId').asString+',BeginDate='+mtAdoDataSet1.FieldByName('BeginDate').AsString+',EndDate='+mtAdoDataSet1.FieldByName('EndDate').AsString;
  FhlUser.ShowAnalyserFrm('43',null);
end;

procedure TanalyserFrm.sl1Action1Execute(Sender: TObject);
begin
  sDefaultVals:='ClientId='+dlAdoDataSet1.FieldByName('Code').asString+',WhId='+mtAdoDataSet1.FieldByName('WhId').asString+',BeginDate='+mtAdoDataSet1.FieldByName('BeginDate').AsString+',EndDate='+mtAdoDataSet1.FieldByName('EndDate').AsString;
  FhlUser.ShowAnalyserFrm('8',null);
end;

procedure TanalyserFrm.SortAction3Execute(Sender: TObject);
begin

  FhlKnl1.Dg_Sort(DbGrid1);
end;

procedure TanalyserFrm.whInvAction1Execute(Sender: TObject);
var
 dispersion:double;
 WhId:string;
 cost:double;
begin
  if MessageDlg(#13#10'您确定要更新下列表格中的存货库存为指定库存量吗?',mtWarning,[mbOk,mbCancel],0)<>mrOk then exit;
  WhId:=mtAdoDataSet1.FieldByName('WhId').asString;
  with dlAdoDataSet1 do
  begin
    DisableControls;
    First;
    while not Eof do
    begin
      dispersion:=FieldByName('rQty').asFloat-FieldByName('cQty').asFloat;
      cost:=FieldByName('Cost').asFloat;
      if dispersion<>0 then
        dmFrm.ExecStoredProc('wh_inventroy_ok',varArrayof([WhId,FieldByName('Id').asString,FieldByName('PartNo').asString,FieldByName('Brand').asString,dispersion,LoginInfo.EmpId,cost]));
      next;
    end;
    Close;
    Open;
    EnableControls;
   end;
end;

procedure TanalyserFrm.WhInvbAction1Execute(Sender: TObject);
begin
  if MessageDlg(#13#10'您确定要删除以往的盘点数据并初始化新的盘点吗?',mtWarning,[mbOk,mbCancel],0)<>mrOk then exit;
  dmFrm.ExecStoredProc('wh_inventroy_clear','');
end;

procedure TanalyserFrm.phArriveXAction1Execute(Sender: TObject);
var
  dlId:string;
begin
  if Not (dlAdoDataSet1.Active) or dlAdoDataSet1.IsEmpty then Exit;
  dlId:=dlAdoDataSet1.FieldByName('dlId').asString;
  sDefaultVals:='OrderDlId='+dlId;
  with FhlUser.ShowEditorFrm('ph_arriveX',varArrayof([dlAdoDataSet1.FieldByName('dlId').asInteger]),nil) do
  begin
    ShowModal;
    Free;
  end;
  with dlAdoDataSet1 do
  begin
    Close;
    Open;
    Locate('dlId',dlId,[]);
  end;
end;

procedure TanalyserFrm.phOrdAriXAction1Execute(Sender: TObject);
begin
  if Not (dlAdoDataSet1.Active) or dlAdoDataSet1.IsEmpty then exit;
  sDefaultVals:='OrderId='+mtAdoDataSet1.FieldByName('Code').asString+',OrderDlId='+dlAdoDataSet1.FieldByName('dlId').asString+',PartNo='+dlAdoDataSet1.FieldByName('PartNo').AsString+',Brand='+dlAdoDataSet1.FieldByName('Brand').AsString;
  FhlUser.ShowAnalyserFrm('56',null);
end;

procedure TanalyserFrm.mtBillAction1Execute(Sender: TObject);
begin
  if mtAdoDataSet1.Active and (mtAdoDataSet1.RecordCount>0) then
  FhlUser.ShowBillFrm(mtAdoDataSet1.FieldByName('BillId').AsString,mtAdoDataSet1.FieldByName('Code').asString);
end;

procedure TanalyserFrm.mtFirstAction1Execute(Sender: TObject);
begin
  mtAdoDataSet1.First;
  OpnDlDsBtn1.Click;
end;

procedure TanalyserFrm.mtPriorAction1Execute(Sender: TObject);
begin
  mtAdoDataSet1.Prior;
  OpnDlDsBtn1.Click;
end;

procedure TanalyserFrm.mtNextAction1Execute(Sender: TObject);
begin
  mtAdoDataSet1.Next;
  OpnDlDsBtn1.Click;
end;

procedure TanalyserFrm.mtLastAction1Execute(Sender: TObject);
begin
  mtAdoDataSet1.Last;
  OpnDlDsBtn1.Click;
end;

procedure TanalyserFrm.dlLocateAction1Execute(Sender: TObject);
begin
  FhlKnl1.Ds_Locate(dlAdoDataSet1);
end;

procedure TanalyserFrm.mtFilterAction1Execute(Sender: TObject);
begin
  dlAdoDataSet1.Close;
  FhlKnl1.Ds_Filter(mtAdoDataSet1);
end;

procedure TanalyserFrm.mtLocateAction1Execute(Sender: TObject);
begin
  FhlKnl1.Ds_Locate(mtAdoDataSet1);
end;

procedure TanalyserFrm.phOrdCloseAction1Execute(Sender: TObject);
begin
  if (mtAdoDataSet1.IsEmpty) or (MessageDlg(#13#10'您确定要关闭本订单吗? 请注意: 关闭后的订单不能进行反向关闭操作.',mtWarning,[mbOk,mbCancel],0)<>mrOk) then exit;
  FhlKnl1.Ds_AssignValues(mtAdoDataSet1,varArrayof(['IsClose']),varArrayof([1]),False);
  mtAdoDataSet1.Close;
  mtAdoDataSet1.Open;
  OpnDlDsBtn1.Click;
  MessageDlg(#13#10'订单关闭成功,关闭后的订单不参与到货分析.',mtInformation,[mbOk],0);
end;

procedure TanalyserFrm.phOrdAriBilAction1Execute(Sender: TObject);
begin
  FhlUser.ShowAnalyserFrm('55',varArrayof([mtAdoDataSet1.FieldByName('ClientId').AsString]));
end;

procedure TanalyserFrm.fnCaAction1Execute(Sender: TObject);
begin
// sDefaultVals:=   sDefaultVals+  'WareId='+dlAdoDataSet1.FieldByName('WareId').asString+',';
  sDefaultVals:='';
  sDefaultVals:=sDefaultVals+'ClientId='+dlAdoDataSet1.FieldByName('code').asString;

  FhlUser.ShowAnalyserFrm('42',null);
end;

procedure TanalyserFrm.slWhOutAction1Execute(Sender: TObject);
begin
  FhlUser.CheckRight('0301030602');
  if dlAdoDataSet1.IsEmpty then exit;
  with dlAdoDataSet1 do
  begin
    First;
    while not eof do
    begin
      if (FieldByName('SndQty').AsFloat>FieldByName('RmnQty').AsFloat) or (FieldByName('SndQty').AsFloat<0) then
      begin
        MessageDlg(#13#10'提示: 补货的数量不能小于0或大于差量,操作中止.',mtWarning,[mbOk],0);
        Exit;
      end;
      Next;
    end;
  end;
  if MessageDlg(#13#10'提示: 您确定要生成本次补货数据吗?',mtInformation,[mbCancel,mbOk],0)=mrCancel then exit;
  dlAdoDataSet1.UpdateBatch();
  dmFrm.ExecStoredProc('sl_invoice_out',varArrayof([LoginInfo.WhId,mtAdoDataSet1.FieldByName('Code').AsString,LoginInfo.EmpId]));
  dlAdoDataSet1.Close;
  dlAdoDataSet1.Open;
  FhlUser.ShowAnalyserFrm('48',varArrayof([dmFrm.FreeStoredProc1.Parameters.Items[4].Value]));
end;

procedure TanalyserFrm.slHisAction1Execute(Sender: TObject);
begin
  if mtAdoDataSet1.IsEmpty then exit;
  FhlUser.ShowAnalyserFrm('48',varArrayof(['']));
end;

procedure TanalyserFrm.fnBankInoutAction1Execute(Sender: TObject);
begin
if self.DBGrid1.DataSource.DataSet.Active  then
begin
  sDefaultVals:='BankId='+dlAdoDataSet1.FieldByName('Code').asString;
  FhlUser.ShowAnalyserFrm('64',null);
end;  
end;

procedure TanalyserFrm.fncadlAction1Execute(Sender: TObject);
begin
if self.DBGrid1.DataSource.DataSet.Active  then
begin
  sDefaultVals:='ClientId='+dlAdoDataSet1.FieldByName('Code').asString;
  FhlUser.ShowAnalyserFrm('17',null);
end;  
end;

procedure TanalyserFrm.whWareInoutAction1Execute(Sender: TObject);
begin
if self.DBGrid1.DataSource.DataSet.Active  then
begin
  sDefaultVals:='WareId='+dlAdoDataSet1.FieldByName('Id').asString+',PartNo='+dlAdoDataSet1.FieldByName('PartNo').asString+',Brand='+dlAdoDataSet1.FieldByName('Brand').asString;
  FhlUser.ShowAnalyserFrm('61',null);
end;  
end;

procedure TanalyserFrm.OpenBillAction1Execute(Sender: TObject);
begin
  if fBillOpenDlgFrm=nil then
  begin
    Screen.Cursor:=crSqlwait;
    try
      fBillOpenDlgFrm:=TBillOpenDlgFrm.Create(Application);
      fBillOpenDlgFrm.InitFrm(fDict.Id);
    finally
      Screen.Cursor:=crDefault;
    end;
  end;
//  else
//     fBillOpenDlgFrm.refreshBtnClick(nil);
  fBillOpenDlgFrm.ADODataSet1.Locate('code',mtAdoDataSet1.FieldByName('Code').AsString,[]);
  if fBillOpenDlgFrm.ShowModal=mrOk then
  begin
    FhlKnl1.Ds_OpenDataSet(mtAdoDataSet1,varArrayof([fBillOpenDlgFrm.FileNameComboBox.Text]));
    OpnDlDsBtn1.Click;
  end;
end;

procedure TanalyserFrm.mtProcAction1Execute(Sender: TObject);
begin
  if MessageDlg(#13#10'提示: 您确定要删除该补货单吗?',mtWarning,[mbCancel,mbOk],0)=mrOk then
  begin
    FhlUser.DoExecProc(mtAdoDataSet1,null);
    mtAdoDataSet1.Close;
    mtAdoDataSet1.Open;
    OpnDlDsBtn1.Click;
  end;
end;

procedure TanalyserFrm.fnDyRprtDtlAction1Execute(Sender: TObject);
var
  s,d:string;
begin
  case DbGrid1.SelectedIndex of
    3:
    with dlAdoDataSet1 do
    begin
      if FieldByName('InDblId').AsInteger=-1 then exit;
//      s:=FieldByName('InBrief').asString;
//      if s='' then s:=FieldByName('InItem').asString;
      s:=FieldByName('InItmId').AsString;
      d:=FieldByName('InDblId').AsString;
    end;
    7:
    with dlAdoDataSet1 do
    begin
      if FieldByName('OutDblId').AsInteger=-1 then exit;
//      s:=FieldByName('OutBrief').asString;
//      if s='' then s:=FieldByName('OutItem').asString;
      s:=FieldByName('OutItmId').AsString;
      d:=FieldByName('OutDblId').AsString;
    end;
    1:begin
        ShowMessage(#13#10+dlAdoDataSet1.FieldByName('InExplain').AsString);
        exit;
      end;
    5:begin
        ShowMessage(#13#10+dlAdoDataSet1.FieldByName('OutExplain').AsString);
        exit;
      end
  else
    exit;
  end;
  sDefaultVals:='ItemId='+s+',WhId='+mtAdoDataSet1.FieldByName('WhId').AsString+',BeginDate='+mtAdoDataSet1.FieldByName('BeginDate').asString+',EndDate='+mtAdoDataSet1.FieldByName('EndDate').asString;
//  showmessage(DbGrid1.DataSource.DataSet.FieldByName('Id').AsString);
  FhlUser.ShowAnalyserFrm(d,null);

end;

procedure TanalyserFrm.fnAlrdyBlAction1Execute(Sender: TObject);
var
  fCode,fBillId,TableName:string;
var   EditorFrm:TEditorFrm;

begin
  Screen.Cursor:=crHourGlass;

  fCode:=dlAdoDataSet1.FieldByName('Code').AsString;
  fBillId:=dlAdoDataSet1.FieldByName('BillId').AsString;

  if   (fCode<>'' ) and (fBillId<>'') then
  begin
      case    dlAdoDataSet1.FieldByName('BillType').AsInteger of
      0:
      begin
            try
                EditorFrm:=TEditorFrm.Create(nil);
                EditorFrm.InitFrm(fBillId,null,nil);
                EditorFrm.AddBtn.Enabled  :=false;
                EditorFrm.CpyBtn.Enabled  :=false;
                EditorFrm.ChgBtn.Enabled  :=false;
                EditorFrm.DelBtn.Enabled  :=false;
                {     for i:=0 to EditorFrm.PageControl1.PageCount -1 do
                    if   EditorFrm.PageControl1.Controls[i] is TWinControl then
                    with TDbEdit( EditorFrm.PageControl1.Controls[i]) do
                    begin
                        Color:=clWhite;
                        Enabled:=true;
                    end;                      }

                EditorFrm.ADODataSet1.Close;

                TableName:=   fhlknl1.GetTableName(EditorFrm.ADODataSet1.tag);
                if    TableName      ='' then      exit;

                EditorFrm.ADODataSet1.Close;
                EditorFrm.ADODataSet1.CommandText :='select *From '+TableName +' where code =' +quotedstr( fCode);
                EditorFrm.ADODataSet1.Open ;
                EditorFrm.ShowModal ;

            finally
                EditorFrm.Free  ;

            end;
      end  ;
      1:
      begin
           FhlUser.ShowBillFrm(fBillId,fCode);
      end ;
      27:
      begin
           //FhlUser.ShowInvoiceFrm(fBillId,fCode);
            with TBillFrm.Create(Application) do
                begin
                  formstyle:=fsnormal;
                  hide;
                  windowState:=wsNormal;
                  position:=poMainFormCenter;
                  Label2.Visible :=false;
                  linkBtn.Visible :=false;
                  importBtn.Visible := false;
                  RemoveBtn.Visible := false;
                  NewBtn.Visible :=false;
                  SavBtn.Visible :=false;
                  CelBtn.Visible :=false;
                  AddBtn.Visible :=false;
                  DelBtn.Visible :=false;
                  ScrollBox1.Enabled :=false;
                  ScrollBox2.Enabled :=false;
                  ScrollBox1.Color :=   clwhite;
                  ScrollBox2.Color :=   clwhite;
                  InitFrm(fBillId);

                  Name:='BillFrm'+fBillId;
                  OpenBill(fCode);
                  DBGrid1.Options :=DBGrid1.Options -[dgediting];
                  Showmodal;
                end;
      end;
    end;
 end;
Screen.Cursor:=crDefault;
end;
procedure TanalyserFrm.fnChkAction1Execute(Sender: TObject);
var
  fbk:TBookmark;
begin
  FhlUser.DoExecProc(dlAdoDataSet1,null);
  fbk:=dlAdoDataSet1.GetBookmark;
  FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);
  dlAdoDataSet1.GotoBookmark(fbk);
end;

procedure TanalyserFrm.slOutStpAction1Execute(Sender: TObject);
begin
  if dlAdoDataSet1.IsEmpty then exit;
  if MessageDlg(#13#10'警告: 您确定要中止当前货物的补发程序吗? 系统将自动生成应付款!',mtWarning,[mbCancel,mbOk],0)=mrOk then
  begin
    dlAdoDataSet1.UpdateBatch();
    FhlUser.DoExecProc(dlAdoDataSet1,null);
//    dmFrm.ExecStoredProc('sl_invoicedl_cls',varArrayof([LoginInfo.LogindlAdoDataSet1.FieldByName('dlId').AsInteger]));
    dlAdoDataSet1.Close;
    dlAdoDataSet1.Open;
  end;
end;

procedure TanalyserFrm.fnDyRprtDtl2Action1Execute(Sender: TObject);
begin
  sDefaultVals:='ClientId='+dlAdoDataSet1.FieldByName('ClientId').AsString+',BeginDate='+mtAdoDataSet1.FieldByName('BeginDate').asString+',EndDate='+mtAdoDataSet1.FieldByName('EndDate').asString;
  FhlUser.ShowAnalyserFrm('66',null);
end;

procedure TanalyserFrm.fnItmInoutAction61Execute(Sender: TObject);
begin
  sDefaultVals:='ItemId='+dlAdoDataSet1.Fields[0].AsString+',BeginDate='+mtAdoDataSet1.FieldByName('BeginDate').asString+',EndDate='+mtAdoDataSet1.FieldByName('EndDate').asString;
  FhlUser.ShowAnalyserFrm('70',null);
end;

procedure TanalyserFrm.fnShldOutIOAction62Execute(Sender: TObject);
begin
  sDefaultVals:='ClientId='+dlAdoDataSet1.FieldByName('ClientId').AsString+',BeginDate='+mtAdoDataSet1.FieldByName('BeginDate').asString+',EndDate='+mtAdoDataSet1.FieldByName('EndDate').asString;
  FhlUser.ShowAnalyserFrm('72',null);
end;

procedure TanalyserFrm.wrprice63Execute(Sender: TObject);
var
  fbk:TBookmark;

//  editRitId:string;


begin
if self.DBGrid1.DataSource.DataSet.Active  then
begin

  FhlUser.ShowTabEditorFrm('wr_ware.price',varArrayof([dlAdoDataSet1.FieldByName('Id').AsInteger]));
  fbk:=dlAdoDataSet1.GetBookmark;
  FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);
  dlAdoDataSet1.GotoBookmark(fbk);
end;
end;

procedure TanalyserFrm.IsOutBillAction64Execute(Sender: TObject);
var
  fbk:TBookmark;
begin
  FhlUser.DoExecProc(dlAdoDataSet1,null,'-1');
  fbk:=dlAdoDataSet1.GetBookmark;
  FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);
  dlAdoDataSet1.GotoBookmark(fbk);
end;

procedure TanalyserFrm.slInvoiceRecHintAction65Execute(Sender: TObject);
var
  fbk:TBookmark;
  s:string;
begin
  if InputQuery('','请输入提醒天数:',s) then
  with DbGrid1.DataSource do
   begin
  FhlUser.DoExecProc(DataSet,s,'-2');
  fbk:=DataSet.GetBookmark;
  DataSet.Close;
  DataSet.Open;
  if not Dataset.IsEmpty then
DataSet.GotoBookmark(fbk);

  end;
end;

procedure TanalyserFrm.slInvoiceRecedAction1Execute(Sender: TObject);
var
  fbk:TBookmark;
begin
  FhlUser.DoExecProc(dlAdoDataSet1,null,'-3');
  fbk:=dlAdoDataSet1.GetBookmark;
  FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);
  dlAdoDataSet1.GotoBookmark(fbk);
end;

procedure TanalyserFrm.slEmpSaleDlAction67Execute(Sender: TObject);
begin
  sDefaultVals:='EmpId='+dlAdoDataSet1.FieldByName('Code').asString+',BeginDate='+mtAdoDataSet1.FieldByName('BeginDate').AsString+',EndDate='+mtAdoDataSet1.FieldByName('EndDate').AsString;
  FhlUser.ShowAnalyserFrm('77',null);
end;

procedure TanalyserFrm.slClientKp2Action68Execute(Sender: TObject);
begin
//  sDefaultVals:='ClientId='+dlAdoDataSet1.FieldByName('Code').asString;
  sDefaultVals:='ClientId='+mtAdoDataSet1.FieldByName('ClientId').asString+',BeginDate='+mtAdoDataSet1.FieldByName('BeginDate').AsString+',EndDate='+mtAdoDataSet1.FieldByName('EndDate').AsString;
  FhlUser.ShowAnalyserFrm('80',null);
end;

procedure TanalyserFrm.slClientProfitAction69Execute(Sender: TObject);
begin
  sDefaultVals:='ClientId='+dlAdoDataSet1.FieldByName('Code').asString+',BeginDate='+mtAdoDataSet1.FieldByName('BeginDate').AsString+',EndDate='+mtAdoDataSet1.FieldByName('EndDate').AsString;
  FhlUser.ShowAnalyserFrm('81',null);
end;

procedure TanalyserFrm.ywyDetailNewAction70Execute(Sender: TObject);
begin
  sDefaultVals:='ClientId='+mtAdoDataSet1.FieldByName('ClientId').AsString;
  GetTabEditorFrm.DataSource1.DataSet.Append;
  GetTabEditorFrm.ShowModal;
end;

procedure TanalyserFrm.ywyDetailEdtAction71Execute(Sender: TObject);
begin
  sDefaultVals:='ClientId='+mtAdoDataSet1.FieldByName('ClientId').AsString;
  fTabEditorFrm.ShowModal;
end;

procedure TanalyserFrm.ywyLinkmansAction72Execute(Sender: TObject);
begin
  sDefaultVals:='ClientId='+dlAdoDataSet1.FieldByName('Id').AsString;
  FhlUser.ShowAnalyserFrm('82',null);
end;

procedure TanalyserFrm.ywyActivitysAction73Execute(Sender: TObject);
begin
  sDefaultVals:='ClientId='+dlAdoDataSet1.FieldByName('Id').AsString;
  FhlUser.ShowAnalyserFrm('83',null);
end;

procedure TanalyserFrm.kcYdstockAction76Execute(Sender: TObject);
begin

  FhlUser.CheckRight(fDict.ydWarepropRitID );
with mtAdoDataSet1 do
begin
  if State=dsEdit then
    UpdateRecord;
  FhlUser.ShowYdWarePropFrm(cDgId03,FieldByName('Model').AsString);
end;
end;

procedure TanalyserFrm.phQuotePriceAction77Execute(Sender: TObject);
begin
  FhlUser.CheckRight(fDict.phQuoteRitID);

with mtAdoDataSet1 do
begin
  if State=dsEdit then
    UpdateRecord;
  FhlUser.ShowYdWarePropFrm('423',FieldByName('Model').AsString);
end;
end;

procedure TanalyserFrm.phOrderReferAction78Execute(Sender: TObject);
begin
  FhlUser.CheckRight(fDict.phOrderdlRitID);
with mtAdoDataSet1 do
begin
  if State=dsEdit then
    UpdateRecord;
  FhlUser.ShowYdWarePropFrm('445',FieldByName('Model').AsString);
end;
end;

procedure TanalyserFrm.phArriveReferAction79Execute(Sender: TObject);
begin
  if dlAdoDataSet1.Active then
  begin
      FhlUser.CheckRight(fDict.slPriceInRfsRitID);
      FhlUser.ShowTabGridFrm('pick.slPriceInRfs',varArrayof([dlAdoDataSet1.FieldByName('PartNo').AsString]));
  end;
end;

procedure TanalyserFrm.ywyDemandAction80Execute(Sender: TObject);
begin
  sDefaultVals:='ClientId='+dlAdoDataSet1.FieldByName('Id').AsString;
  FhlUser.ShowAnalyserFrm('85',null);
end;

procedure TanalyserFrm.IsInvoiceAction60Execute(Sender: TObject);
var
  fbk:TBookmark;
begin
  FhlUser.CheckRight('0301051302');
  FhlUser.DoExecProc(dlAdoDataSet1,null,'712');
  fbk:=dlAdoDataSet1.GetBookmark;
  FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);
  dlAdoDataSet1.GotoBookmark(fbk);
end;

procedure TanalyserFrm.IsInvEditAction81Execute(Sender: TObject);
var
  fbk:TBookmark;
begin
  FhlUser.CheckRight('0301051302');
  with TInvFrm.Create(Self) do
  try
    if dlAdoDataSet1.fieldbyname('invfund').ascurrency<>0 then
    begin
    Edit1.Text:=dlAdoDataSet1.fieldbyname('invcode').asstring;
    edit2.text:=dladodataset1.fieldbyname('invdate').asstring;
    edit3.text:=dladodataset1.fieldbyname('invfund').asstring;
    edit4.Text:=dladodataset1.fieldbyname('invname').asstring;
    end
    else
    edit4.text:=mtadodataset1.fieldbyname('client').asstring;
    if ShowModal=mrOk then
    begin
  FhlUser.DoExecProc(dlAdoDataSet1,varArrayof([Edit1.Text,Edit2.Text,Edit3.Text,Edit4.Text]));
  fbk:=dlAdoDataSet1.GetBookmark;
  FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);
  dlAdoDataSet1.GotoBookmark(fbk);
  end;
  finally
    Release;
  end;
end;

procedure TanalyserFrm.TopPanel1DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin
// modeltpe:=Bill;
  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;
//    CrtCom.fAnalyserDict:=  fdict;
    CrtCom.mtDataSource1:=mtDataSource1;
    CrtCom.mtDataSet1:= mtADODataSet1;
    CrtCom.mtDataSetId :=inttostr(self.mtADODataSet1.Tag );
    CrtCom.TopOrBtm :=true;
    CrtCom.TOPBoxId :=  fdict.TopBoxId ;
    CrtCom.DlGridId  :=inttostr(self.DBGrid1.tag );
    CrtCom.DLGrid :=self.DBGrid1 ;
    //CrtCom.FormId := FormId;
   
  end;

try
    CrtCom.Show;
finally

end;


end;

procedure TanalyserFrm.ActionStkinAndStkout82Execute(Sender: TObject);
begin
 // sDefaultVals:='WareId='+dlAdoDataSet1.FieldByName('Id').asString+',PartNo='+dlAdoDataSet1.FieldByName('PartNo').asString+',Brand='+dlAdoDataSet1.FieldByName('Brand').asString;
 // FhlUser.ShowAnalyserFrm('61',null);

if   (not dlAdoDataSet1.IsEmpty)  and (not mtADODataSet1.IsEmpty ) then
begin

  sDefaultVals:='';
 { sDefaultVals:=   sDefaultVals+  'Model='+dlAdoDataSet1.FieldByName('Model').asString+',';

  }

 sDefaultVals:=   sDefaultVals+  'WareId='+dlAdoDataSet1.FieldByName('WareId').asString+',';
 sDefaultVals:=   sDefaultVals+  'WhId='+mtADODataSet1.FieldByName('StorageID').AsString+',';
 sDefaultVals:=   sDefaultVals+  'StorageName='+mtADODataSet1.FieldByName('StorageName').AsString+',';
 sDefaultVals:=   sDefaultVals+  'Brand='+dlAdoDataSet1.FieldByName('Brand').AsString+',';
 sDefaultVals:=   sDefaultVals+  'PartNo='+dlAdoDataSet1.FieldByName('specification').AsString+',';
 sDefaultVals:=   sDefaultVals+  'Encapsulation='+dlAdoDataSet1.FieldByName('Encapsulation').AsString+',';
 sDefaultVals:=   sDefaultVals+  'Unit='+dlAdoDataSet1.FieldByName('Unit').AsString+',';
 sDefaultVals:=   sDefaultVals+  'BeginDate='+mtADODataSet1.FieldByName('BeginDate').AsString+',';
 sDefaultVals:=   sDefaultVals+  'EndDate='+mtADODataSet1.FieldByName('EndDate').AsString+',';
 sDefaultVals:=   sDefaultVals+  'Filters='+mtADODataSet1.FieldByName('UseWhichDate').AsString;

 {
 sDefaultVals:='WareId='+dlAdoDataSet1.FieldByName('WareId').asString
             +',PartNo='+dlAdoDataSet1.FieldByName('PartNo').asString
             +',Brand= '+dlAdoDataSet1.FieldByName('Brand').asString;
}
 FhlUser.ShowAnalyserFrm('85',null);
end;


{if   (not dlAdoDataSet1.IsEmpty)  and (not mtADODataSet1.IsEmpty ) then
begin

  sDefaultVals:='';
  sDefaultVals:=   sDefaultVals+  'Model='+dlAdoDataSet1.FieldByName('Model').asString+',';
  sDefaultVals:=   sDefaultVals+  'WareId='+dlAdoDataSet1.FieldByName('WareId').asString+',';
  sDefaultVals:=   sDefaultVals+  'specification='+dlAdoDataSet1.FieldByName('specification').AsString+',';
  sDefaultVals:=   sDefaultVals+  'Brand='+dlAdoDataSet1.FieldByName('Brand').AsString+',';
  sDefaultVals:=   sDefaultVals+  'Encapsulation='+dlAdoDataSet1.FieldByName('Encapsulation').AsString+',';
  sDefaultVals:=   sDefaultVals+  'Unit='+dlAdoDataSet1.FieldByName('Unit').AsString+',';
  sDefaultVals:=   sDefaultVals+  'BeginDate='+mtADODataSet1.FieldByName('BeginDate').AsString+',';
  sDefaultVals:=   sDefaultVals+  'EndDate='+mtADODataSet1.FieldByName('EndDate').AsString+',';
  sDefaultVals:=   sDefaultVals+  'StorageID='+mtADODataSet1.FieldByName('StorageID').AsString+',';
  sDefaultVals:=   sDefaultVals+  'UseWhichDate='+mtADODataSet1.FieldByName('UseWhichDate').AsString;

  FhlUser.ShowAnalyserFrm('83',null);
end;    }

end;

procedure TanalyserFrm.DBGrid1CellClick(Column: TColumn);
  var
  i: integer;
  TempBookmark: TBookMark;
  Amt:real;
begin
Amt:=0;
if   dgMultiselect in dbgrid1.Options then      //2006-7-26加入多先功能
begin

      DBGrid1.SelectedRows.CurrentRowSelected:=true;
      if self.dlAdoDataSet1.Active then
      with DBGrid1.SelectedRows do
          if Count <> 0 then
          begin
              TempBookmark:= DBGrid1.Datasource.Dataset.GetBookmark;
              for i:= 0 to Count - 1 do
              begin
                if IndexOf(Items[i]) > -1 then
                begin
                  DBGrid1.Datasource.Dataset.Bookmark:= Items[i];
                  //showmessage(dbgrd1.Datasource.Dataset.Fields[2].AsString);
                  Amt:=Amt+self.dlAdoDataSet1.fieldbyname('Amt').AsCurrency;// *self.dlAdoDataSet1.fieldbyname('Price').AsCurrency ;
                end;
              end;
          end;
      DBGrid1.Datasource.Dataset.GotoBookmark(TempBookmark);
      DBGrid1.Datasource.Dataset.FreeBookmark(TempBookmark);
      self.DBGrid1.Hint :=MulSelMessage+'     所选明细总金额 : '+floattostr(Amt);
      end;
end;

procedure TanalyserFrm.actInputInvoice83Execute(Sender: TObject);
var FrmInputInvoice:TEditorFrm;
begin
  FrmInputInvoice:=TEditorFrm.Create(nil);
  TEditorFrm(FrmInputInvoice).InitFrm('30',null,nil);          //
//  FrmInputInvoice.InvoiceItems :=Tstringlist;
  FrmInputInvoice.ShowModal ;
  freeandnil(FrmInputInvoice);
end;

procedure TanalyserFrm.actPackPic84Execute(Sender: TObject);
begin
      //封装图片
  if not dlAdoDataSet1.IsEmpty then
  FhlUser.ShowTabEditorFrm('10003',varArrayof([dlAdoDataSet1.FieldByName('pack').asstring]),nil,false,-11,true,true,false);
end;

procedure TanalyserFrm.actBrandPic85Execute(Sender: TObject);
begin
      //品牌图片
  if not dlAdoDataSet1.IsEmpty then      
  FhlUser.ShowTabEditorFrm('10004',varArrayof([dlAdoDataSet1.FieldByName('Brand').asstring]),nil,false,-11,true,true,false);

end;

procedure TanalyserFrm.actPriceOutRfs86Execute(Sender: TObject);
begin
FhlUser.CheckRight(fDict.slPriceOutRfsRitID );
FhlUser.ShowTabGridFrm('pick.slPriceOutRfs',varArrayof([self.mtADODataSet1.FieldByName('ClientId').asString,self.mtADODataSet1.FieldByName('Model').asString]));
// FhlUser.ShowTabGridFrm('pick.slPriceOutRfs','');


end;

procedure TanalyserFrm.actNeedInvoiceDLExecute(Sender: TObject);
begin

      if   (not dlAdoDataSet1.IsEmpty)  and (not mtADODataSet1.IsEmpty ) then
      begin

           sDefaultVals:='';
           if dlAdoDataSet1.FieldByName('ClientID').asString<>'' then
               sDefaultVals:=   sDefaultVals+  'ClientID='+dlAdoDataSet1.FieldByName('ClientID').asString+','
           else
               sDefaultVals:=   sDefaultVals+  'ClientID='+mtADODataSet1.FieldByName('ClientID').asString+','  ;

           if  dlAdoDataSet1.FindField('ClientName')<>nil then
               sDefaultVals:=   sDefaultVals+  'ClientName='+dlAdoDataSet1.FieldByName('ClientName').asString+','
           else
               sDefaultVals:=   sDefaultVals+  'ClientName='+mtADODataSet1.FieldByName('ClientName').asString+',' ;


           sDefaultVals:=   sDefaultVals+  'filters='+'制单时间';

           FhlUser.ShowAnalyserFrm('91',null);
      end;
end;
procedure TanalyserFrm.actHaveInvoiceDLExecute(Sender: TObject);
begin
        if   (not dlAdoDataSet1.IsEmpty)  and (not mtADODataSet1.IsEmpty ) then
      begin

           sDefaultVals:='';
           sDefaultVals:=   sDefaultVals+  'ClientID='+dlAdoDataSet1.FieldByName('ClientID').asString+',';
           sDefaultVals:=   sDefaultVals+  'ClientName='+dlAdoDataSet1.FieldByName('ClientName').asString+',';

           FhlUser.ShowAnalyserFrm('92',null);
      end;
end;

procedure TanalyserFrm.actInvoiceExecute(Sender: TObject);
begin
 FhlUser.ShowBillFrm('52');
end;

procedure TanalyserFrm.actShowPInvoiceExecute(Sender: TObject);
begin
if not self.dlAdoDataSet1.IsEmpty then
  FhlUser.ShowBillFrm('52',self.dlAdoDataSet1.fieldbyname('Pcode').AsString );
  
end;

procedure TanalyserFrm.actChkORUnChkExecute(Sender: TObject);
begin
      if not self.dlAdoDataSet1.IsEmpty then
      begin
          dmFrm.ExecStoredProc('Sp_ChkOrUnChkNInvoice ',varArrayof([self.dlAdoDataSet1.fieldbyname('code').AsString]));
          refreshAction2.Execute ;
      end;
end;

procedure TanalyserFrm.actShowNInvoiceExecute(Sender: TObject);
begin
if not self.dlAdoDataSet1.IsEmpty then
 // FhlUser.ShowBillFrm('52',self.dlAdoDataSet1.fieldbyname('Pcode').AsString );
  FhlUser.ShowEditorFrm('31',self.dlAdoDataSet1.fieldbyname('code').AsString ).ShowModal ;


end;

procedure TanalyserFrm.actEditPriceChangeExecute(Sender: TObject);
begin

  if not self.dlAdoDataSet1.IsEmpty then
  FhlUser.ShowEditorFrm('32',self.dlAdoDataSet1.fieldbyname('code').AsString ).ShowModal
  else
  FhlUser.ShowEditorFrm('32',null).ShowModal ;

end;

procedure TanalyserFrm.actShowPriceChangeExecute(Sender: TObject);
begin

  if (not dlAdoDataSet1.IsEmpty ) and (dlAdoDataSet1.FieldByName('PriceChange').asstring<>'' )then
  FhlUser.ShowTabEditorFrm('10006',varArrayof([dlAdoDataSet1.FieldByName('id').asstring]),nil,false,-11,true,true,false);

end;

procedure TanalyserFrm.Button1Click(Sender: TObject);
begin
    self.DBGrid1.Columns[0].Alignment:=taCenter;
end;

procedure TanalyserFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   case Key of
     vk_Return:self.OpnDlDsBtn1.Click ;
   end;
end;

procedure TanalyserFrm.InvoiceItemExecute(Sender: TObject);
begin
      if self.DBGrid1.DataSource.DataSet.Active  then
      begin
        sDefaultVals:='ClientId='+self.mtADODataSet1.FieldByName('ClientId').asString+',';
        sDefaultVals:=sDefaultVals+'Clientname='+self.mtADODataSet1.FieldByName('Client').asString;

        FhlUser.ShowAnalyserFrm('91',null);
      end;
end;

procedure TanalyserFrm.ActUpdateSalePriceExecute(Sender: TObject);
var
  fbk:TBookmark;

//  editRitId:string;


begin
if self.DBGrid1.DataSource.DataSet.Active  then
begin

  FhlUser.ShowTabEditorFrm('10007',varArrayof([dlAdoDataSet1.FieldByName('Id').AsInteger]));
  fbk:=dlAdoDataSet1.GetBookmark;
  FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);
  dlAdoDataSet1.GotoBookmark(fbk);
end;
end;

procedure TanalyserFrm.ActInvoiceBillItemExecute(Sender: TObject);
begin
      if self.DBGrid1.DataSource.DataSet.Active  then
      begin
        sDefaultVals:='ClientId='+self.mtADODataSet1.FieldByName('ClientId').asString+',';
        sDefaultVals:=sDefaultVals+'Clientname='+self.mtADODataSet1.FieldByName('Clientname').asString;

        FhlUser.ShowAnalyserFrm('95',null);
      end;

end;

procedure TanalyserFrm.ActCreatePhPlanExecute(Sender: TObject);
var
  PhPlanName: string;
var BillMan,BillDate:string;
var i:integer;
begin
  BillMan:=fhluser.GetSysParamVal('sEmpID');
  BillDate := Datetimetostr(now) ;
  PhPlanName:=  Datetostr(Today);


  if messagedlg('确定要生成采购计划吗?',mtConfirmation,[mbYes, mbNo],0)=mRno then exit;

  dmfrm.GetQuery1('select  * From T_PhPlan where PHPlanName='+quotedstr(PhPlanName))  ;
  if  not dmfrm.FreeQuery1.IsEmpty then
  begin
      if messagedlg('今天已经产生了采购计划。 要删除之前的记录吗？',mtConfirmation,[mbYes, mbNo],0)=mRYes then
       dmfrm.GetQuery1('delete T_PhPlan where  PHPlanName='+quotedstr(PhPlanName), false );
  end;

  dmfrm.GetQuery1('select top 0 *From T_PhPlan',true,true);

  dlAdoDataSet1.DisableControls ;
  dlAdoDataSet1.first;
  for i:=0 to dlAdoDataSet1.RecordCount -1 do
  begin
   
     if   dlAdoDataSet1.FieldByName('PhQty').AsInteger  <>0 then
      begin
           dmfrm.FreeQuery1.Append ;

           dmfrm.FreeQuery1.FieldByName('id').Value       :=dlAdoDataSet1.FieldByName('id').Value ;
           dmfrm.FreeQuery1.FieldByName('model').Value    :=dlAdoDataSet1.FieldByName('model').Value ;
           dmfrm.FreeQuery1.FieldByName('partno').Value   :=dlAdoDataSet1.FieldByName('partno').Value ;
           dmfrm.FreeQuery1.FieldByName('Brand').Value    :=dlAdoDataSet1.FieldByName('Brand').Value ;
           dmfrm.FreeQuery1.FieldByName('pack').Value     :=dlAdoDataSet1.FieldByName('pack').Value ;
           dmfrm.FreeQuery1.FieldByName('origin').Value   :=dlAdoDataSet1.FieldByName('origin').Value ;
           dmfrm.FreeQuery1.FieldByName('safePos').Value  :=dlAdoDataSet1.FieldByName('safePos').Value ;
           dmfrm.FreeQuery1.FieldByName('maxPos').Value   :=dlAdoDataSet1.FieldByName('maxPos').Value ;
           dmfrm.FreeQuery1.FieldByName('MinPos').Value   :=dlAdoDataSet1.FieldByName('MinPos').Value ;
           dmfrm.FreeQuery1.FieldByName('Cost').Value     :=dlAdoDataSet1.FieldByName('Cost').Value ;
           dmfrm.FreeQuery1.FieldByName('Price').Value    :=dlAdoDataSet1.FieldByName('Price').Value ;
           dmfrm.FreeQuery1.FieldByName('RealQty').Value  :=dlAdoDataSet1.FieldByName('RealQty').Value ;
           dmfrm.FreeQuery1.FieldByName('SysQty').Value   :=dlAdoDataSet1.FieldByName('SysQty').Value ;
             if dlAdoDataSet1.FindField('YDRealQty')<>nil then
           dmfrm.FreeQuery1.FieldByName('YDRealQty').Value:=dlAdoDataSet1.FieldByName('YDRealQty').Value ;
             if dlAdoDataSet1.FindField('YDSysQty')<>nil then
           dmfrm.FreeQuery1.FieldByName('YDSysQty').Value :=dlAdoDataSet1.FieldByName('YDSysQty').Value ;
           dmfrm.FreeQuery1.FieldByName('PhQty').Value    :=dlAdoDataSet1.FieldByName('PhQty').Value ;
           dmfrm.FreeQuery1.FieldByName('BillMan').Value  :=BillMan ;
           dmfrm.FreeQuery1.FieldByName('BillTime').Value :=BillDate;
           dmfrm.FreeQuery1.FieldByName('PHPlanName').Value:=PhPlanName ;

           dmfrm.FreeQuery1.Post ; {}
         // showmessage(dlAdoDataSet1.FieldByName('PhQty').Value );
      end;
      dlAdoDataSet1.Next ;
  end;
  dlAdoDataSet1.EnableControls ;
end;

procedure TanalyserFrm.TopPanel1Click(Sender: TObject);
begin


end;

end.
