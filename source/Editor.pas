unit Editor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ToolWin, ADODB, Db, DbCtrls, CheckLst, ImgList,UnitCreateComponent, variants,
  Mask, ActnList, FhlKnl,UnitModelFrm, ExtCtrls, Grids, DBGrids;


type
  TEditorFrm = class(TFrmModel)
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    SavBtn: TToolButton;
    DataSource1: TDataSource;
    CelBtn: TToolButton;
    ToolButton3: TToolButton;
    AddBtn: TToolButton;
    CpyBtn: TToolButton;
    DelBtn: TToolButton;
    ToolButton7: TToolButton;
    FirstBtn: TToolButton;
    NextBtn: TToolButton;
    PriorBtn: TToolButton;
    LastBtn: TToolButton;
    ToolButton12: TToolButton;
    ExtBtn: TToolButton;
    PageControl1: TPageControl;
    PrintBtn: TToolButton;
    ToolButton2: TToolButton;
    ChgBtn: TToolButton;
    ADODataSet1: TADODataSet;
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
    PrintAction: TAction;
    SetCaptionAction: TAction;
    actInputTaxAmt: TAction;
    Splitter1: TSplitter;
    PnlItem: TPanel;
    ActDeliveryCfg: TAction;
    ActPrintDeliveryBill: TAction;
    //procedure InitFrm(EditorId:String;fOpenParams:Variant;fDataSet:TDataSet;ParamGrid:Tdbgrid=nil);
    procedure InitFrm(EditorId:String;fOpenParams:Variant;fDataSet:TDataSet;PparentGrid:Tdbgrid=nil;POpenFlds:String='');overload;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SetEditState(CanEdit:Boolean);
    procedure AddActionExecute(Sender: TObject);
    procedure CopyActionExecute(Sender: TObject);
    procedure EditActionExecute(Sender: TObject);
    procedure DeleteActionExecute(Sender: TObject);
    function  GetPraValues():string;
    procedure FirstActionExecute(Sender: TObject);
    procedure PriorActionExecute(Sender: TObject);
    procedure NextActionExecute(Sender: TObject);
    procedure LastActionExecute(Sender: TObject);
    procedure CloseActionExecute(Sender: TObject);
    procedure SaveActionExecute(Sender: TObject);
    procedure CancelActionExecute(Sender: TObject);
    procedure SetCaptionActionExecute(Sender: TObject);
    procedure PrintActionExecute(Sender: TObject);
    procedure ToolBar1DblClick(Sender: TObject);
    procedure actInputTaxAmtExecute(Sender: TObject);
    procedure ADODataSet1BeforePost(DataSet: TDataSet);
    procedure ActDeliveryCfgExecute(Sender: TObject);
    procedure ActPrintDeliveryBillExecute(Sender: TObject);
    procedure UpdateSysFields;
     
  public
       F_ParamGrid:TDBGrid;
       F_ParamFlds :string;
       fDict:TEditorDict;
  end;

var
  EditorFrm: TEditorFrm;

implementation

{$R *.DFM}
uses datamodule, RepCard, UnitDeliveryReport;

//procedure TEditorFrm.InitFrm(EditorId:string;fOpenParams:Variant;fDataSet:TDataSet;ParamGrid:Tdbgrid=nil);
procedure TEditorFrm.InitFrm(EditorId:String;fOpenParams:Variant;fDataSet:TDataSet;PparentGrid:Tdbgrid=nil;POpenFlds:String='') ;
var
  ftabs:TStringList;
  i:integer;
begin
  if Not FhlKnl1.Cf_GetDict_Editor(EditorId,fdict) then Close;


      //2006-7-26加toolbutton
  if (trim(fDict.Actions)<>''  ) and  (trim(fDict.Actions)<>'-1' )then
    // FhlKnl1.Tb_CreateActionBtns(ToolBar1,self.ActionList1 ,fDict.Actions,false);
      FhlKnl1.Tb_CreateActionBtns_Ex(ToolBar1,self.ActionList1 ,fDict.Actions,logininfo.EmpId,self.FWindowsFID )   ;

     
  width:=fDict.Width;
  height:=fDict.Height;
  Caption:=fDict.Caption;

  if CpyBtn<>nil then
    CpyBtn.Visible:=Not (fDict.CpyFlds='');
  if (fDataSet<>nil) and ((fDict.DataSetId ='-1' )or (trim(fDict.DataSetId) ='')) then
    DataSource1.DataSet:=fDataSet
  else
  begin
    FhlUser.SetDataSet(AdoDataSet1,fDict.DataSetId,fOpenParams);
    F_ParamGrid:= PparentGrid;
    F_ParamFlds:= POpenFlds;
  end;

  ftabs:=TStringList.Create;
  ftabs.CommaText:=fDict.BoxIds;
  for i:=0 to ftabs.Count-1 do
      FhlKnl1.Cf_SetBox(ftabs.Strings[i],DataSource1,FhlKnl1.Pc_CreateTabSheet(PageControl1),dmFrm.DbCtrlActionList1);
  ftabs.Free;
  SetEditState(false);


end;

procedure TEditorFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if (DataSource1.State=dsEdit) or (DataSource1.State=dsInsert) then
    case MessageDlg(fsDbChanged,mtConfirmation,[mbYes,mbNo,mbCancel],0) of
         mrYes:begin
                 SaveActionExecute(SavBtn);
                 Action:=caHide;
               end;
         mrNo:begin
                 CancelActionExecute(celBtn);
                 Action:=caHide;
              end;
         else begin
                 Action:=caNone;
              end;
    end;
end;

procedure TEditorFrm.SetEditState(CanEdit:Boolean);
  var i:integer;bkColor:TColor;
begin
     CancelAction.Enabled:=CanEdit;
     SaveAction.Enabled:=CancelAction.Enabled;
     FirstAction.Enabled:=Not CanEdit;
     PriorAction.Enabled:=FirstAction.Enabled;
     NextAction.Enabled:=FirstAction.Enabled;
     LastAction.Enabled:=FirstAction.Enabled;
     CloseAction.Enabled:=FirstAction.Enabled;
        AddAction.Enabled:=FirstAction.Enabled;
        CopyAction.Enabled:=FirstAction.Enabled;
        EditAction.Enabled:=FirstAction.Enabled;
        DeleteAction.Enabled:=FirstAction.Enabled;
        PrintAction.Enabled:=FirstAction.Enabled;

     if CanEdit then
        bkColor:=clWhite
    else
        bkColor:=clcream;//$00F6F6F6;
        {;}
     For i:=0 to PageControl1.PageCount-1 do
     begin
         FhlKnl1.Vl_SetCtrlStyle(bkColor,PageControl1.Pages[i],CanEdit);
         
     end;
     //dmFrm.SetDataSetStyle(DataSource1.DataSet,Not CanEdit);
end;

procedure TEditorFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if SaveAction.Enabled then
 begin
   case Key of
     vk_Return:begin
               if ssCtrl in Shift then
                  SavBtn.Click
               else if Not (ActiveControl is TDbMemo) then
                  FhlKnl1.Vl_DoBoxEnter(ActiveControl)
               end;
     vk_Escape:begin
              CelBtn.Click;
             end;
   end;
 end else
 begin
   case Key of
     vk_Escape:begin
             ExtBtn.Click;
             end;
     vk_Insert:begin
              if ssCtrl in Shift then
                 ChgBtn.Click
              else
                 AddBtn.Click;
             end;
     vk_Delete:begin
                 DelBtn.Click;
             end;
     vk_Home:firstBtn.Click;
     vk_End:lastBtn.Click;
     vk_Prior:priorBtn.Click;
     vk_Next:nextBtn.Click;
     vk_Print:printBtn.Click;
   end;
 end;

end;

procedure TEditorFrm.AddActionExecute(Sender: TObject);
begin


SetEditState(True);
  FhlUser.AssignDefault(DataSource1.DataSet,false);
if not (DataSource1.DataSet.State in [dsinsert] ) then
 DataSource1.DataSet.Append;




 FhlKnl1.Vl_FocueACtrl(PageControl1.ActivePage);
end;

procedure TEditorFrm.CopyActionExecute(Sender: TObject);
begin
//  if fDict.CpyFlds='' then exit;
  SetEditState(true);
  FhlKnl1.Ds_AssignValues(DataSource1.DataSet,FhlKnl1.Vr_CommaStrToVarArray(fDict.CpyFlds),FhlKnl1.Ds_GetFieldsValue(DataSource1.DataSet,fDict.CpyFlds),True,False);
  FhlKnl1.Vl_FocueACtrl(PageControl1.ActivePage);
end;

procedure TEditorFrm.EditActionExecute(Sender: TObject);
begin
  if DataSource1.DataSet.IsEmpty then Exit;
  SetEditState(true);
  DataSource1.DataSet.Edit;
  FhlKnl1.Vl_FocueACtrl(PageControl1.ActivePage);
end;

procedure TEditorFrm.DeleteActionExecute(Sender: TObject);
begin
    FhlUser.CheckRight(self.fDict.deleteRit );
    if DataSource1.DataSet.IsEmpty then Exit;
   try
       if not  assigned( DataSource1.DataSet.BeforeDelete) then
       begin
         if MessageDlg('真的要删除?',mtConfirmation, [mbYes, mbNo], 0 ) = mrYes then
         begin
           DataSource1.DataSet.Delete;
         end
         else
           Abort ;
       end
       else
       begin
           DataSource1.DataSet.Delete;
       end;
   except
       on err: exception     do
       begin
            showmessage('失败！'+err.Message  );
       end;
   end;
end;

function  TEditorFrm.GetPraValues():string;
var fldNames:TStrings;
var fldValues:string;
var i:integer;
begin
      fldNames:=TStringlist.Create ;
      fldNames.CommaText :=F_ParamFlds;

      for i:=0 to  fldNames.Count -1 do
      begin
      if i=0 then
         fldValues:= F_ParamGrid.DataSource.DataSet.fieldbyname(fldNames[i]).asstring
      else
         fldValues:=fldValues+','+  F_ParamGrid.DataSource.DataSet.fieldbyname(fldNames[i]).asstring;
      end;
      result:= fldValues;
end;

procedure TEditorFrm.FirstActionExecute(Sender: TObject);
begin
      if F_ParamGrid=nil    then
         DataSource1.DataSet.First
      else
      begin
         F_ParamGrid.DataSource.DataSet.First;

         FhlKnl1.Ds_OpenDataSet( DataSource1.DataSet,GetPraValues());
      end;
end;

procedure TEditorFrm.PriorActionExecute(Sender: TObject);
begin

      if F_ParamGrid=nil    then
         DataSource1.DataSet.Prior
      else
      begin
         F_ParamGrid.DataSource.DataSet.Prior;

         FhlKnl1.Ds_OpenDataSet( DataSource1.DataSet,GetPraValues());
      end;
end;


procedure TEditorFrm.NextActionExecute(Sender: TObject);
begin

      if F_ParamGrid=nil    then
         DataSource1.DataSet.Next
      else
      begin
         F_ParamGrid.DataSource.DataSet.Next;

//                  self.FParams:=  FhlKnl1.Vr_MergeVarArray (self.FParams,GetParamterValues);
         if DataSource1.DataSet.Active then DataSource1.DataSet.Close;
         FhlKnl1.Ds_OpenDataSet( DataSource1.DataSet,GetPraValues());
      end;
end;

procedure TEditorFrm.LastActionExecute(Sender: TObject);
begin

      if F_ParamGrid=nil    then
         DataSource1.DataSet.Last
      else
      begin
         F_ParamGrid.DataSource.DataSet.Last;
         GetPraValues();
         FhlKnl1.Ds_OpenDataSet( DataSource1.DataSet,GetPraValues());
      end;
end;

procedure TEditorFrm.CloseActionExecute(Sender: TObject);
begin
Close;
end;

procedure TEditorFrm.SaveActionExecute(Sender: TObject);
begin
    Screen.Cursor:=crSqlwait;
    try
      FhlUser.CheckRight(self.fDict.editRitID );
      UpdateSysFields();
      DataSource1.DataSet.Post;

      SetEditState(DataSource1.DataSet.State<>dsBrowse);
    finally
      Screen.Cursor:=crDefault;
    end;
end;

procedure TEditorFrm.CancelActionExecute(Sender: TObject);
begin
DataSource1.DataSet.Cancel;
SetEditState(false);
end;

procedure TEditorFrm.SetCaptionActionExecute(Sender: TObject);
begin


Caption:=fDict.Caption+' '+intTostr(DataSource1.DataSet.RecNo)+'/'+intTostr(DataSource1.DataSet.RecordCount);
end;

procedure TEditorFrm.PrintActionExecute(Sender: TObject);
begin
  FhlUser.CheckRight(fDict.PrintRitId);
  FhlKnl1.Rp_Card(intTostr(PageControl1.Pages[0].Tag),DataSource1.DataSet);
end;

procedure TEditorFrm.ToolBar1DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin
// modeltpe:=Bill;
  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
  begin
    CrtCom:=TfrmCreateComponent.Create(self);

    CrtCom.TopOrBtm :=true;
    CrtCom.TOPBoxId :=inttostr(self.PageControl1.ActivePage.tag);

    CrtCom.FEditorDict  :=  fdict;
    CrtCom.ModelType :=Modeleditor;
    CrtCom.mtDataSet1:=Tadodataset(DataSource1.DataSet);
    try
    CrtCom.Show;
    finally

    end;
  end;


end;

procedure TEditorFrm.actInputTaxAmtExecute(Sender: TObject);
var frmtax:   TEditorFrm;
begin
//23          24


  Screen.Cursor:=crHourGlass;
  try
    frmtax:=TEditorFrm.Create(nil);
    sDefaultVals:='';
    sDefaultVals:=sDefaultVals+'AutoPK='+self.ADODataSet1.fieldbyname('pk').AsString +',';
   sDefaultVals:=sDefaultVals+'payfund='+self.ADODataSet1.fieldbyname('Diffamt').AsString ;




    if self.ADODataSet1.FieldByName('Diffamt').AsCurrency >0 then
    begin
        TEditorFrm(frmtax).InitFrm('31',self.ADODataSet1.fieldbyname('pk').AsString,nil);
    end
    else
    begin
        TEditorFrm(frmtax).InitFrm('24',null,nil);
    end;
       // frmtax.Hide;
       // frmtax.AddBtn.Click;
        frmtax.ShowModal ;
        freeandnil(frmtax)   ;

  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TEditorFrm.ADODataSet1BeforePost(DataSet: TDataSet);
begin
showmessage('');
end;

procedure TEditorFrm.ActDeliveryCfgExecute(Sender: TObject);
var frm:TFrmDeliveryReport;
var F_firmCode:String;
begin
  FhlUser.CheckRight(fDict.PrintRitId);
  try
    F_firmCode :=  DataSource1.DataSet.fieldbyName('F_firmCode').AsString  ;
    frm:= TFrmDeliveryReport.Create(nil);
    frm.InitFrm(self.DataSource1);
    if frm.DatasetReport.Active then
      frm.DatasetReport.Locate('F_firmCode',F_firmCode,[]) ;
    frm.ShowModal ;
  finally
    freeandnil(frm);
  end;

end;

procedure TEditorFrm.ActPrintDeliveryBillExecute(Sender: TObject);
var reportGUID:String;
begin
  if (DataSource1.DataSet.fieldbyName('F_firmCode').AsString <>'' ) then
  begin
      FhlUser.CheckRight(fDict.PrintRitId);
      reportGUID := FhlUser.GetReportGUID( DataSource1.DataSet.fieldbyName('F_firmCode').AsString );
      FhlKnl1.Rp_ExpressPrint( reportGUID ,DataSource1.DataSet);
  end;
end;

procedure TEditorFrm.UpdateSysFields;
begin
  if  DataSource1.DataSet.FindField  ('FLstEditEmp') <>nil then
       DataSource1.DataSet.FieldByName ('FLstEditEmp').AsString  :=  trim(logininfo.EmpId) ;
   if  DataSource1.DataSet.FindField  ('FlstEditTime') <>nil then
       DataSource1.DataSet.FieldByName ('FlstEditTime').Value :=now;

end;

end.
