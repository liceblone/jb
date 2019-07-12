unit analyser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ComCtrls, ToolWin, DB, ADODB, ExtCtrls, StdCtrls,  DBCtrls, DateUtils,
  Menus, ActnList, TabEditor, jpeg, Buttons, FhlKnl,billOpenDlg,UnitModelFrm,UnitCreateComponent,Editor;

type
  TanalyserFrm = class(TFrmModel)
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
    ActAdjustStock100: TAction;
    ActSP_sl_daysaleDL: TAction;
    ActInvoiceWare: TAction;
    ActOriginalBill: TAction;
    ActIsDuplicateClt: TAction;
    ActNotDuplicateClt: TAction;
    ActSlInvoiceRecDl: TAction;
    ActOldSlRecDL: TAction;
    ActTranBill: TAction;
    ActOutBillLog: TAction;
    ActGatheringChk110: TAction;
    ActMonthEndClose: TAction;
    ActMonthEndHis: TAction;
    ActCustArrivalDL: TAction;
    ActPuOrd: TAction;
    ActCustBill: TAction;
    ActPOrdExeProgress: TAction;
    ActPayBill: TAction;
    ActXlkInvoice: TAction;
    ActSortAnalyser: TAction;
    ActExport120: TAction;
    ActReloadGridFormat: TAction;
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
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1DrawColumnCellFntClr(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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
    procedure ActAdjustStock100Execute(Sender: TObject);
    procedure ActSP_sl_daysaleDLExecute(Sender: TObject);
    procedure OpnDlDsBtn1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ActInvoiceWareExecute(Sender: TObject);
    procedure ActOriginalBillExecute(Sender: TObject);
    procedure ActIsDuplicateCltExecute(Sender: TObject);
    procedure ActNotDuplicateCltExecute(Sender: TObject);
    procedure ActSlInvoiceRecDlExecute(Sender: TObject);
    procedure ActOldSlRecDLExecute(Sender: TObject);
    procedure ActTranBillExecute(Sender: TObject);
    procedure ActOutBillLogExecute(Sender: TObject);
    procedure ActGatheringChk110Execute(Sender: TObject);
    procedure ActMonthEndCloseExecute(Sender: TObject);
    procedure ActMonthEndHisExecute(Sender: TObject);
    procedure ActCustArrivalDLExecute(Sender: TObject);
    procedure ActPuOrdExecute(Sender: TObject);
    procedure ActCustBillExecute(Sender: TObject);
    procedure ActPOrdExeProgressExecute(Sender: TObject);
    procedure ActPayBillExecute(Sender: TObject);
    procedure ActXlkInvoiceExecute(Sender: TObject);
    procedure ActSortAnalyserExecute(Sender: TObject);
    procedure ActExport120Execute(Sender: TObject);
    procedure ActReloadGridFormatExecute(Sender: TObject);

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
uses datamodule,repgrid,colProp,repset,bill, RepBill, Inv,TabGrid,UnitFrmGrid ,Sort ,UPublicFunction ;
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
   FhlUser.SetDbGridAndDataSet(DbGrid1,fDict.DbGridId,null,false);
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
  dmFrm.ExecStoredProc(fbilldict.vldproc,varArrayof([fbilldict.billcode,LoginInfo.EmpId]),true);
  FhlKnl1.Ds_RefreshDataSet(self.dlAdoDataSet1);
  self.dlAdoDataSet1.Locate(fbilldict.mkeyfld,fbilldict.BillCode,[]);
end;

procedure TanalyserFrm.CloseBillAction1Execute(Sender: TObject);
  var fBillDict:TBillDict;
begin
//FhlKnl1.Cf_GetDict_ExcPrc
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
  fBillType:Integer;
  TableName :string;
  fCode:string;
begin
  fBillId:=dlAdoDataSet1.FieldByName('BillId').AsString;
  if  dlAdoDataSet1.FindField('BillType')<>nil then
      fBillType:=dlAdoDataSet1.FieldByName('BillType').AsInteger
  else
      fBillType:=1;

  if fBillId='-1' then exit;
  if dlAdoDataSet1.FieldByName('BillCode').asString<>'' then
  fCode:=dlAdoDataSet1.FieldByName('BillCode').asString;

  if dlAdoDataSet1.findField('Code')<>nil then
  fCode:=dlAdoDataSet1.FieldByName('Code').asString;


  if   (fCode<>'' ) and (fBillId<>'') then
      case    fBillType of
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
                Screen.Cursor:=crDefault;

            end;
      end  ;
      1:
      begin//             -- FhlUser.ShowBillFrm(fBillId,dlAdoDataSet1.FieldByName('BillCode').asString);
              Screen.Cursor:=crAppStart;
             try
              if FhlKnl1.Vl_FindChildFrm('BillFrm'+fBillId)=nil then   // if find then form then show the form
              begin
                with TBillFrm.Create(Application) do
                begin
                  InitFrm(fBillId);
                  Name:='BillFrm'+fBillId;
                  Show;

                  if fCode<>'' then
                    OpenBill(dlAdoDataSet1.FieldByName('BillCode').asString);
                  NewBtn.Enabled :=false;
                  chkBtn.Enabled :=false;
                  RemoveBtn.Enabled :=false;
                  OpenBtn.Enabled :=false;
                  linkBtn.Enabled :=false;
                  AddBtn.Enabled :=false;
                  DelBtn.Enabled :=false;
                  importBtn.Enabled :=false;
                end;
              end;
             finally
              Screen.Cursor:=crDefault;
             end;
      end;
      end;

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
     FhlKnl1.SetColFormat(DbGrid1) ;


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
 origin:string;
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
      origin:=FieldByName('origin').AsString ;
      if dispersion<>0 then
        dmFrm.ExecStoredProc('wh_inventroy_ok',varArrayof([WhId,FieldByName('Id').asString,FieldByName('PartNo').asString,FieldByName('Brand').asString,dispersion,LoginInfo.EmpId,cost,origin]));
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
  sDefaultVals:='';
  sDefaultVals:=sDefaultVals+'ClientId='+dlAdoDataSet1.FieldByName('code').asString;

  FhlUser.ShowAnalyserFrm('55',varArrayof([mtAdoDataSet1.FieldByName('ClientId').AsString]));
end;

procedure TanalyserFrm.fnCaAction1Execute(Sender: TObject);
begin
// sDefaultVals:=   sDefaultVals+  'WareId='+dlAdoDataSet1.FieldByName('WareId').asString+',';
  sDefaultVals:='';
  if dlAdoDataSet1.FIndField('ClientId')<>nil then
  sDefaultVals:=sDefaultVals+'ClientId='+dlAdoDataSet1.FieldByName('ClientId').asString;

  if dlAdoDataSet1.FIndField('code')<>nil then
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
var BillFrm:TBillFrm;

begin
  Screen.Cursor:=crHourGlass;

  if dlAdoDataSet1.FindField('Code')<>nil then
     fCode:=dlAdoDataSet1.FieldByName('Code').AsString
  else
     fCode:=dlAdoDataSet1.FieldByName('BillCode').AsString;

  if    dlAdoDataSet1.FieldByName('BillId')<>nil then 
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
                Screen.Cursor:=crDefault;

            end;
      end  ;
      1:
      begin
          // FhlUser.ShowBillFrm(fBillId,fCode);
            Screen.Cursor:=crAppStart;
           try
              if FhlKnl1.Vl_FindChildFrm('BillFrm'+fBillId)=nil then   // if find then form then show the form
               FhlKnl1.Vl_FindChildFrm('BillFrm'+fBillId).Free ;
                
                BillFrm:=TBillFrm.Create(Application);
                BillFrm.FormStyle :=fsnormal;
                BillFrm.Hide ;
                      BillFrm.InitFrm(fBillId);
                    //  Name:='BillFrm'+fBillId;
                      if fCode<>'' then
                        BillFrm.OpenBill(fCode);

                       with BillFrm do
                       begin
                          ScrollBox1.Enabled :=false;
                          ScrollBox2.Enabled :=false;
                          DBGrid1.ReadOnly :=true;
                          NewBtn.Enabled :=false;
                          chkBtn.Enabled :=false;
                          RemoveBtn.Enabled :=false;
                          OpenBtn.Enabled :=false;
                          linkBtn.Enabled :=false;
                          AddBtn.Enabled :=false;
                          DelBtn.Enabled :=false;
                          importBtn.Enabled :=false;
                       end   ;
                      BillFrm.Showmodal;
                      BillFrm.Free ;

              //  end;
           finally
            Screen.Cursor:=crDefault;
           end;
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
                  Toolbar1.Enabled :=false;
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
  if trim( self.dlAdoDataSet1.FieldByName('isoutbill').AsString) <>trim('') then
  begin
    if MessageDlg(#13#10+'确定要取消出单吗?',mtInformation,[mbOk,mbCancel],0)=mrOk then
    begin
      FhlUser.DoExecProc(dlAdoDataSet1,null,'-1');
    end
    else
    exit;
  end
  else
  begin
      FhlUser.DoExecProc(dlAdoDataSet1,null,'-1');
  end;

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
 try
  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;
    //CrtCom.fAnalyserDict:=  fdict;
    CrtCom.TopOrBtm :=true;

    CrtCom.mtDataSet1:= mtADODataSet1;
    CrtCom.mtDataSetId :=inttostr(self.mtADODataSet1.Tag );
 
    CrtCom.TOPBoxId  := fdict.TopBoxId ;
    CrtCom.DlGridId  := inttostr(self.DBGrid1.tag );
    CrtCom.DLGrid    := self.DBGrid1 ;
    //CrtCom.FormId := FormId;
     CrtCom.Show;
  end;


   
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
 sDefaultVals:=   sDefaultVals+  'filters='+mtADODataSet1.FieldByName('UseWhichDate').AsString;

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
        if   self.mtADODataSet1.FieldByName('ClientId').asString<>'' then
        sDefaultVals:='ClientId='+self.mtADODataSet1.FieldByName('ClientId').asString+','
        else
        sDefaultVals:='ClientId='+self.dlAdoDataSet1.FieldByName('ClientId').asString+',';

        if   self.mtADODataSet1.FieldByName('Clientname').asString<>'' then
             sDefaultVals:=sDefaultVals+'Clientname='+self.mtADODataSet1.FieldByName('Clientname').asString
        else
             sDefaultVals:=sDefaultVals+'Clientname='+self.dlAdoDataSet1.FieldByName('Clientname').asString ;

        FhlUser.ShowAnalyserFrm('95',null);
      end;

end;

procedure TanalyserFrm.ActCreatePhPlanExecute(Sender: TObject);
var
  PhPlanName: string;
var BillMan,BillDate:string;
var i:integer;
begin
if dlAdoDataSet1.IsEmpty then exit;

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

procedure TanalyserFrm.ActAdjustStock100Execute(Sender: TObject);
var Model,Partno,Brand,pack,origin,ErrWareid,RightWareid:string;
var Errstr,RightStr:string;
var TabGridFrm:TTabGridFrm;
var abortstr  :string;
var warningstr:string;

var Dbedit:TDbedit;
var i:integer;
begin
if  dlAdoDataSet1.Active then
   
   if not dlAdoDataSet1.IsEmpty then
   begin

      if    dlAdoDataSet1.RecordCount <2 then
      begin
          showmessage('请先选择正确的资料。');
          exit;
      end;
      ErrWareid  :=mtADODataSet1.FieldByName('wareid').AsString;

      if mtADODataSet1.FieldByName('Note').AsString ='' then
      BEGIN

            
      END;

     { Errstr:= mtADODataSet1.FieldByName('strb').AsString +' '
              +mtADODataSet1.FieldByName('strC').AsString +' '
              +mtADODataSet1.FieldByName('strD').AsString +' '
              +mtADODataSet1.FieldByName('strE').AsString +' '
              +mtADODataSet1.FieldByName('strF').AsString +' '   ;  }

     Errstr:= trim(mtADODataSet1.fieldbyname('strb').AsString)+  format('%'+inttostr(15- length(mtADODataSet1.fieldbyname('strb').AsString)) +'s',[' '])+' '
             +mtADODataSet1.fieldbyname('strC').AsString+  format('%'+inttostr(30- length(mtADODataSet1.fieldbyname('strC').AsString)) +'s',[' '])+' '
             +mtADODataSet1.fieldbyname('strD').AsString+  format('%'+inttostr(15- length(mtADODataSet1.fieldbyname('strD').AsString)) +'s',[' '])+' '
             +mtADODataSet1.fieldbyname('strE').AsString+  format('%'+inttostr(15- length(mtADODataSet1.fieldbyname('strE').AsString)) +'s',[' '])+' '
             +mtADODataSet1.fieldbyname('strF').AsString+  format('%'+inttostr(15- length(mtADODataSet1.fieldbyname('strF').AsString)) +'s',[' '])+' ' ;


      dlAdoDataSet1.Last ;

      RightStr:=
                 trim(mtADODataSet1.fieldbyname('Model').AsString )+ format('%'+inttostr(15- length(mtADODataSet1.fieldbyname('Model').AsString )) +'s',[' '])+' '
               + mtADODataSet1.fieldbyname('Partno').AsString+ format('%'+inttostr(30- length(mtADODataSet1.fieldbyname('Partno').AsString)) +'s',[' '])+' '
               + mtADODataSet1.fieldbyname('Brand').AsString + format('%'+inttostr(15- length(mtADODataSet1.fieldbyname('Brand').AsString )) +'s',[' '])+' '
               + mtADODataSet1.fieldbyname('pack').AsString  + format('%'+inttostr(15- length(mtADODataSet1.fieldbyname('pack').AsString  )) +'s',[' '])+' '
               + mtADODataSet1.fieldbyname('Brief').AsString + format('%'+inttostr(15- length(mtADODataSet1.fieldbyname('Brief').AsString )) +'s',[' '])+' ';

     // Brand:=dlAdoDataSet1.fieldbyname ('Brand').AsString ;
     // pack := dlAdoDataSet1.fieldbyname ('pack').AsString ;
     // origin:=dlAdoDataSet1.fieldbyname('origin').AsString ;

      RightWareid:=dlAdoDataSet1.FieldByName('id').AsString;



      if  (ErrWareid='') or (RightWareid='') then
      begin
          showmessage('如果其中有一个器件从未做出入库，那么请直接修改规格，品牌，产地') ;
          exit;
      end;
      if messagedlg(  '确定要将    '+Errstr+char(10)+char(13)
                     +'更改为:      '+RightStr +'      '       ,mtConfirmation,[mbYes,mbno],0)=mryes then
      if messagedlg(  '确定要将    '+Errstr+char(10)+char(13)
                     +'更改为:      '+RightStr +'      '       ,mtConfirmation,[mbYes,mbno],0)=mryes then
         begin
              {
              TabGridFrm:=TTabGridFrm.Create (nil);
              TabGridFrm.Label2.caption:='按确定将以下器全部改成 ';
              TabGridFrm.Label1.Caption :=RightStr ;
              TabGridFrm.Label1.Font.Color :=clred;

              TabGridFrm.Hide ;
              TabGridFrm.Caption :='需要更改的明细';
              fhluser.SetDbGridAndDataSet(TabGridFrm.DBGrid1,'680',ErrWareid,true);
             }

              try
               {  if TabGridFrm.ShowModal =mrok then
                        begin
                       if TabGridFrm.ADODataSet1.IsEmpty then
                       begin
                          showmessage(Errstr+' 没有做任何出入库，建议直接删除！');
                          exit;
                       end;   }
                       if ErrWareid  =RightWareid then
                       begin
                           showmessage('选择了错误的资料，请重新选择。');
                           exit;
                       end;
                       if Not dmFrm.ExecStoredProc('sp_update_items',trim(ErrWareid)+','+trim(RightWareid)+','+trim(logininfo.EmpId)+','+dmfrm.ADOConnection1.DefaultDatabase) then
                       begin
                              with dmFrm.FreeStoredProc1 do
                              begin
                                  AbortStr:=Parameters.Items[1].Value;
                                  warningstr:=Parameters.Items[2].Value;
                              end;
                              if AbortStr<>'' then
                              begin
                                MessageDlg(#13#10+ AbortStr,mtError,[mbOk],0);
                                Abort;
                              end
                              else if MessageDlg(#13#10+WarningStr,mtWarning,[mbOk,mbCancel],0)<>mrOk then
                                Abort;
                        end;
              //   end;
               finally
                    //TabGridFrm.Free ;
               end;

         end;



   end;
end;

procedure TanalyserFrm.ActSP_sl_daysaleDLExecute(Sender: TObject);
begin

sDefaultVals:='';
sDefaultVals:=   sDefaultVals+  'xDate='+dlAdoDataSet1.FieldByName('xDate').AsString +',';
FhlUser.ShowAnalyserFrm('99',null);
 //  99
end;

procedure TanalyserFrm.OpnDlDsBtn1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 self.SetFocus ;

end;

procedure TanalyserFrm.ActInvoiceWareExecute(Sender: TObject);
var   fEditorFrm:TEditorFrm ;
begin
    if self.dlAdoDataSet1.Active  then
    begin
        fEditorFrm:=TEditorFrm(FhlUser.ShowEditorFrm('38',null,self.dlAdoDataSet1));
      fEditorFrm.ShowModal;
      fEditorFrm.Free ;
    end;

end;

procedure TanalyserFrm.ActOriginalBillExecute(Sender: TObject);
var
  fCode,fBillId,TableName:string;
var   EditorFrm:TEditorFrm;
var BillFrm:TBillFrm;

begin
  Screen.Cursor:=crHourGlass;

  if dlAdoDataSet1.FindField('Code')<>nil then
     fCode:=dlAdoDataSet1.FieldByName('Code').AsString
  else
     fCode:=dlAdoDataSet1.FieldByName('BillCode').AsString;

  fBillId:=dlAdoDataSet1.FieldByName('BillId').AsString;


  FhlUser.CheckRight('0301061101');
  if   (fCode<>'' ) and (fBillId<>'') then
  begin
             try
              if FhlKnl1.Vl_FindChildFrm('BillFrm'+fBillId)=nil then   // if find then form then show the form
              begin
                with TBillFrm.Create(Application) do
                begin
                  InitFrm(fBillId);
                  Name:='BillFrm'+fBillId;
                  Show;

                  if fCode<>'' then
                    OpenBill(dlAdoDataSet1.FieldByName('BillCode').asString);
                  NewBtn.Enabled :=false;
                  chkBtn.Enabled :=false;
                  RemoveBtn.Enabled :=false;
                  OpenBtn.Enabled :=false;
                  linkBtn.Enabled :=false;
                  AddBtn.Enabled :=false;
                  DelBtn.Enabled :=false;
                  importBtn.Enabled :=false;
                end;
              end;
             finally
              Screen.Cursor:=crDefault;
             end;
    end;         

end;

procedure TanalyserFrm.ActIsDuplicateCltExecute(Sender: TObject);
begin

    if  dlAdoDataSet1.Active  then
     if  not dlAdoDataSet1.IsEmpty then
       if dlAdoDataSet1.FindField('SuspectNote')<>nil then
       begin
           dlAdoDataSet1.Edit ;
           dlAdoDataSet1.FieldByName('SuspectNote').AsString :='重复客户建议删除';
           dlAdoDataSet1.FieldByName('IsSuspect').AsBoolean :=true;
           dlAdoDataSet1.Post ;
       end;
end;

procedure TanalyserFrm.ActNotDuplicateCltExecute(Sender: TObject);
begin

    if  dlAdoDataSet1.Active  then
     if  not dlAdoDataSet1.IsEmpty then
       if dlAdoDataSet1.FindField('SuspectNote')<>nil then
       begin
           dlAdoDataSet1.Edit ;
           dlAdoDataSet1.FieldByName('SuspectNote').AsString :='正常客户可以继续联系';
           dlAdoDataSet1.FieldByName('IsSuspect').AsBoolean :=false;
           dlAdoDataSet1.Post ;
       end;

end;

procedure TanalyserFrm.ActSlInvoiceRecDlExecute(Sender: TObject);
begin
sDefaultVals:='';
sDefaultVals:=   sDefaultVals+  'Stra='+self.mtADODataSet1.FieldByName('Stra').AsString +',';
sDefaultVals:=   sDefaultVals+  'ClientID='+self.DLADODataSet1.FieldByName('code').AsString +',';
sDefaultVals:=   sDefaultVals+  'ClientName='+self.DLADODataSet1.FieldByName('name').AsString ;

    FhlUser.ShowAnalyserFrm('102',null);

end;

procedure TanalyserFrm.ActOldSlRecDLExecute(Sender: TObject);
begin

sDefaultVals:='';
sDefaultVals:=   sDefaultVals+  'Stra='+self.mtADODataSet1.FieldByName('Stra').AsString +',';
sDefaultVals:=   sDefaultVals+  'ClientID='+self.DLADODataSet1.FieldByName('code').AsString ;
//sDefaultVals:=   sDefaultVals+  'ClientName='+self.DLADODataSet1.FieldByName('name').AsString ;

FhlUser.ShowAnalyserFrm('104',null);
//
end;

procedure TanalyserFrm.ActTranBillExecute(Sender: TObject);
var fCode,fBillId,TableName,BillType:string;
var EditorFrm:TEditorFrm;
var BillFrm:TBillFrm;
begin

      inherited;
      Screen.Cursor:=crHourGlass;
      
      if dlAdoDataSet1.FieldByName('BillId')  =nil then exit;
      if dlAdoDataSet1.FieldByName('BillType')=nil then exit;

      if dlAdoDataSet1.FindField('Code')<>nil then
         fCode:=dlAdoDataSet1.FieldByName('Code').AsString
      else
         fCode:=dlAdoDataSet1.FieldByName('BillCode').AsString;


       fBillId:=dlAdoDataSet1.FieldByName('BillId').AsString;
      BillType:=dlAdoDataSet1.FieldByName('BillType').AsString;

   //   if uppercase( BillType)=uppercase( 'editor') then


  try


      begin
          EditorFrm:=TEditorFrm.Create (nil);
          EditorFrm.F_ParamFlds :='Code';
          EditorFrm.Visible :=false;
          EditorFrm.InitFrm('42',fCode,nil,self.DBGrid1  );

          EditorFrm.ShowModal  ;

          EditorFrm.Free ;
      end;
  finally
       Screen.Cursor:=crDefault;
  end;

end;

procedure TanalyserFrm.ActOutBillLogExecute(Sender: TObject);
var FrmGrid1:TFrmGrid;
var BillCode:string;
begin
      inherited;

      if self.dlAdoDataSet1.IsEmpty then exit;

      BillCode:= self.dlAdoDataSet1.FieldByName ('Order_Code').AsString   ;

      FrmGrid1:=TFrmGrid.Create (nil);
      FrmGrid1.InitFrm('704',BillCode);
      FrmGrid1.LblMsg.Caption :='出单日志：';
      FrmGrid1.ShowModal ;
      FrmGrid1.Free ;

end;



procedure TanalyserFrm.ActGatheringChk110Execute(Sender: TObject);


var
  fbk:TBookmark;
begin
  Screen.Cursor:=crHourGlass;
  try
      fbk:=dlAdoDataSet1.GetBookmark;
      FhlUser.DoExecProc(dlAdoDataSet1,null);
      
      FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);
      dlAdoDataSet1.GotoBookmark(fbk);

    finally
       Screen.Cursor:=crDefault;
  end;
end;

procedure TanalyserFrm.ActMonthEndCloseExecute(Sender: TObject);
var
  fbk:TBookmark;
begin
  try
      Screen.Cursor:=crHourGlass;
      fbk:=dlAdoDataSet1.GetBookmark;
      FhlUser.DoExecProc(dlAdoDataSet1,null);
     
      FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);
      dlAdoDataSet1.GotoBookmark(fbk);

    finally
       Screen.Cursor:=crDefault;
  end;
end;

procedure TanalyserFrm.ActMonthEndHisExecute(Sender: TObject);
begin
  inherited;
       
   FhlUser.ShowAnalyserFrm('111',null);
end;

procedure TanalyserFrm.ActCustArrivalDLExecute(Sender: TObject);
begin
  inherited;

  sDefaultVals:='';
  sDefaultVals:=   sDefaultVals+  'BeginDate='  + self.mtADODataSet1.FieldByName('BeginDate').AsString +',';
  sDefaultVals:=   sDefaultVals+  'EndDate='    + self.mtADODataSet1.FieldByName('EndDate').AsString +',';

  if DLADODataSet1.Active then
  begin
    sDefaultVals:=   sDefaultVals+  'FBookingNO=' + self.DLADODataSet1.FieldByName('FBookingNO').AsString +',';
    sDefaultVals:=   sDefaultVals+  'PartNo='     + self.DLADODataSet1.FieldByName('PartNo').AsString +',';
    //sDefaultVals:=   sDefaultVals+  'Model='      + self.DLADODataSet1.FieldByName('Model').AsString +',';
    sDefaultVals:=   sDefaultVals+  'Brand='      + self.DLADODataSet1.FieldByName('Brand').AsString +',';
    sDefaultVals:=   sDefaultVals+  'Pack='       + self.DLADODataSet1.FieldByName('Pack').AsString +',';
    sDefaultVals:=   sDefaultVals+  'Origin='     + self.DLADODataSet1.FieldByName('Origin').AsString ;
  end;

  FhlUser.ShowAnalyserFrm('117',null);
  sDefaultVals:='';
end;

procedure TanalyserFrm.ActPuOrdExecute(Sender: TObject);
begin
  inherited;
  if not self.dlAdoDataSet1.IsEmpty then
    FhlUser.ShowBillFrm('7',self.dlAdoDataSet1.fieldbyname('Code').AsString )
  else
    FhlUser.ShowBillFrm('7','');

end;

procedure TanalyserFrm.ActCustBillExecute(Sender: TObject);
begin
  inherited;
  if not self.dlAdoDataSet1.IsEmpty then
    FhlUser.ShowBillFrm('56',self.dlAdoDataSet1.fieldbyname('Code').AsString )
  else
    FhlUser.ShowBillFrm('56','' );

end;

procedure TanalyserFrm.ActPOrdExeProgressExecute(Sender: TObject);
begin
  inherited;
  sDefaultVals:='';
 // sDefaultVals:=   sDefaultVals+  'Fyear='  + self.mtADODataSet1.FieldByName('BeginDate').AsString +','; 
  if DLADODataSet1.Active then
  begin
    sDefaultVals:=   sDefaultVals+  'PartNo='     + self.DLADODataSet1.FieldByName('PartNo').AsString +',';
    sDefaultVals:=   sDefaultVals+  'Brand='      + self.DLADODataSet1.FieldByName('Brand').AsString +',';
    sDefaultVals:=   sDefaultVals+  'Pack='       + self.DLADODataSet1.FieldByName('Pack').AsString +',';
    sDefaultVals:=   sDefaultVals+  'Origin='     + self.DLADODataSet1.FieldByName('Origin').AsString ;
  end;

  FhlUser.ShowAnalyserFrm('114',null);
  sDefaultVals:='';
end;

procedure TanalyserFrm.ActPayBillExecute(Sender: TObject);
var EditorFrm:TEditorFrm;
var TableName,fCode:string;
begin
    inherited;
  if not DLADODataSet1.Active then Exit;
try
    sDefaultVals:='';
    sDefaultVals:=   sDefaultVals+  'ClientID='  + self.dlAdoDataSet1.FieldByName('ClientID').AsString +',';
    sDefaultVals:=   sDefaultVals+  'ClientName='  + self.dlAdoDataSet1.FieldByName('ClientName').AsString +',';
    sDefaultVals:=   sDefaultVals+  'PayFund='  + self.dlAdoDataSet1.FieldByName('RmbAmt').AsString +',';
    sDefaultVals:=   sDefaultVals+  'CustArriveid='  + self.dlAdoDataSet1.FieldByName('Code').AsString +',';

    sDefaultVals:=   sDefaultVals+  'IsSys=1' ;

    EditorFrm:=TEditorFrm.Create(nil);
    EditorFrm.InitFrm('21',null,nil);
    {
    EditorFrm.AddBtn.Enabled  :=false;
    EditorFrm.CpyBtn.Enabled  :=false;
    EditorFrm.ChgBtn.Enabled  :=false;
    EditorFrm.DelBtn.Enabled  :=false;
    }

    EditorFrm.ADODataSet1.Close;

    TableName:=   fhlknl1.GetTableName(EditorFrm.ADODataSet1.tag);
    if    TableName      ='' then      exit;

    fCode:=self.DBGrid1.DataSource.DataSet.fieldbyname('FPayBillCode').AsString ;
    EditorFrm.ADODataSet1.Close;
    EditorFrm.ADODataSet1.CommandText :='select *From '+TableName +' where code =' +quotedstr( fCode);
    EditorFrm.ADODataSet1.Open ;
    EditorFrm.ShowModal ;

    refreshAction2.Execute ;
    
finally
    EditorFrm.Free ;

end;
end;

procedure TanalyserFrm.ActXlkInvoiceExecute(Sender: TObject);
var FXlkInvoiceCode,fFrmId,FbookingNo:string;
var i:Integer;
var SourceDs:TDataSet;
begin
    inherited;
    if  self.dlAdoDataSet1.IsEmpty then Exit;
    if dlAdoDataSet1.findfield ('FXlkInvoiceCode')<>nil then
    FXlkInvoiceCode:=  dlAdoDataSet1.fieldbyname('FXlkInvoiceCode').AsString;
    FbookingNo:=   dlAdoDataSet1.fieldbyname('FbookingNo').AsString;

    SourceDs:=dlAdoDataSet1;
    fFrmId:='57';
    if FXlkInvoiceCode<>'' then
      FhlUser.ShowBillFrm(fFrmId,FXlkInvoiceCode)
    else
    begin
      with TBillFrm.Create(Application) do
      begin
        InitFrm(fFrmId);
        Name:='BillFrm'+fFrmId;
        NewAction1Execute(Self);


        SourceDs.Filter :='FbookingNo='+quotedstr(FbookingNo);
        SourceDs.Filtered :=True;

        for i:=0 to SourceDs.RecordCount-1 do
        begin
          dlDataSet1.Insert;
          dlDataSet1.FieldByName('wareid').value:=SourceDs.FieldByName('wareid').value ;
          dlDataSet1.FieldByName('FbookingNo').value:=SourceDs.FieldByName('FbookingNo').value ;
          //dlDataSet1.FieldByName('FbookingNo').value=SourceDs.FieldByName('FbookingNo').value ;
          dlDataSet1.Post;
        end;
        SourceDs.filter:='';

        Show;
      end;


    end;
end;

procedure TanalyserFrm.ActSortAnalyserExecute(Sender: TObject);
var str:string;
begin
  if Not DbGrid1.DataSource.DataSet.Active then Exit;
  with TSortFrm.Create(Application) do
  begin
    try
    // TCustomAdoDataSet(DbGrid1.DataSource.DataSet).Sort :='';
      InitFrm(DbGrid1);
      if ShowModal=mrOk then
      begin
        if RightVals<>'' then
          str := 'xorder,'+RightVals+',Order_Code ,IsCalc DESC ,classid, dlId';
        TCustomAdoDataSet(DbGrid1.DataSource.DataSet).Sort:=str;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TanalyserFrm.ActExport120Execute(Sender: TObject);
 var
  PopDbgrid:Tdbgrid;
  RepeatCnt:string;
  ClickedOK: Boolean;
  NewString: string;

begin
//  RepeatCnt:=   InputBox('设置列重复次数', '请输入列重复次数', '3')  ;
  RepeatCnt := '1';
  ClickedOK := InputQuery('设置列重复次数', '请输入列重复次数', RepeatCnt);
  if ClickedOK then
  begin
    PopDbgrid:=self.DBGrid1   ;
    QExportExcel(PopDbgrid,TForm(PopDbgrid.Parent).Caption+formatdatetime('yyyymmdd',now), true,strtoint(RepeatCnt));
  end;
end;

procedure TanalyserFrm.ActReloadGridFormatExecute(Sender: TObject);
begin
  fhlknl1.RenewColumnsFormatCache( fdict.DbGridId, true );
end;

end.
