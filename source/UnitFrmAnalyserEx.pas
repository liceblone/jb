unit UnitFrmAnalyserEx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ActnList, ADODB, Buttons, StdCtrls, ExtCtrls, Grids , Excel2000,ComObj,ActiveX, ComCtrls,
  DBGrids, FhlKnl,ToolWin, jpeg,UnitGrid,UnitModelFrm, XPMenu,UPublicFunction, unitFrmWrArchive ,
  DBCtrls,UnitBarCodePanel;

type
  TAnalyseEx = class(TFrmModel)
    BtmPanel1: TPanel;
    TopPanel1: TPanel;
    statLabel1: TLabel;
    OpnDlDsBtn1: TSpeedButton;
    mtADODataSet1: TADODataSet;
    mtADODataSet1IntegerField111: TIntegerField;
    mtDataSource1: TDataSource;
    ControlBar1: TControlBar;
    ToolBar2: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    TLBtnShowQry: TToolButton;
    ToolBar1: TToolBar;
    ActionList1: TActionList;
    PrintAction1: TAction;
    RefreshAction1: TAction;
    CloseAction1: TAction;
    HelpAction1: TAction;
    Splitter1: TSplitter;
    PgGrids: TPageControl;
    ActOriBill: TAction;
    LblTitle: TLabel;
    ToolButton3: TToolButton;
    ActFilter: TAction;
    Actchk: TAction;
    ActSum: TAction;
    BtnSum: TToolButton;
    ActExport: TAction;
    actRestoreData: TAction;
    btnCtrl: TToolButton;
    pbIteration: TProgressBar;
    actLockCol: TAction;
    actOriBill2: TAction;
    ActRsExport: TAction;
    ActBatCodeList: TAction;
    ActExImport: TAction;
    ActExportCSV: TAction;
    ActNextDataset: TAction;
    ActOldVersionPrint: TAction;
    ActDelete: TAction;
    ActWrArchive: TAction;

    procedure OpnDlDsBtn1Click(Sender: TObject);
    procedure printAction0Execute(Sender: TObject);
    procedure refreshAction1Execute(Sender: TObject);
    procedure TopPanel1DblClick(Sender: TObject);
    procedure TLBtnShowQryClick(Sender: TObject);

    procedure ToolButton5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Action1Execute(Sender: TObject);
    procedure CloseAction1Execute(Sender: TObject);
    procedure HelpAction1Execute(Sender: TObject);
    procedure PgGridsChange(Sender: TObject);
    procedure ActOriBillExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ActFilterExecute(Sender: TObject);
    procedure ActchkExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure PrintAction1Execute(Sender: TObject);
    procedure ActSumExecute(Sender: TObject);
    procedure ActExportExecute(Sender: TObject);
    procedure actRestoreDataExecute(Sender: TObject);
    procedure btnCtrlClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actLockColExecute(Sender: TObject);
    procedure actOriBill2Execute(Sender: TObject);
    procedure ActRsExportExecute(Sender: TObject);
    procedure ActBatCodeListExecute(Sender: TObject);
    procedure ActExImportExecute(Sender: TObject);
    function VerifyBarCodeExcelFormat(Excel: OleVariant):boolean;
    procedure ActExportCSVExecute(Sender: TObject);
    procedure ActNextDatasetExecute(Sender: TObject);
    procedure ActOldVersionPrintExecute(Sender: TObject);
    procedure ActDeleteExecute(Sender: TObject);
    procedure ActWrArchiveExecute(Sender: TObject);
  private
    fDict:TAnalyserDictEX;
    FrmWrArchive : TFrmWrArchive ;
    fInputBarCode:boolean;

    { Private declarations }
  public
    DBGdCurrent: TModelDbGrid;
    PAuthoriseTmpTable:string ;
    FrmPanelBarCodeList:TFrmPanelBarCodeList;
    { Public declarations }
    procedure InitFrm(AFrmId:String;AmtParams:Variant);
    procedure DBGrid1DrawColumnCellFntClr(Sender: TObject;const Rect: TRect; DataCol: Integer;
              Column: TColumn; State: TGridDrawState);
    procedure IniCurrentGrid(PGrid:TDBGrid;GridID:string);
    procedure DsAfterScroll(Sender: TDataSet);
  end;

var
  AnalyseEx: TAnalyseEx;

implementation

uses datamodule,UnitCreateComponent,UnitBillEx,Editor,bill   ;

{$R *.dfm}
procedure TAnalyseEx.InitFrm(AFrmId:String;AmtParams:Variant);
var i:integer;
var GdRep:TModelDbGrid;
var DsSource:TDataSource;
var DsSet :TadodataSet;
var GridLst:TstringList;
begin

try
  GridLst:=TstringList.Create ;
  if Not FhlKnl1.Cf_GetDict_AnalyserEx(AFrmId,fdict) then Close;

  
  GridLst.CommaText :=  fdict.DbGridId;
  Caption:=fDict.Caption;
  LblTitle.Caption :=self.Caption;
  FhlUser.SetDataSet(mtAdoDataSet1,fDict.mtDataSetId,AmtParams);
  if mtAdoDataSet1.Active then
  begin
      FhlUser.AssignDefault(mtAdoDataSet1);
      if mtAdoDataSet1.IsEmpty then
      begin
          mtAdoDataSet1.Append;
      end;
  end;
      
   if  fDict.Actions <>'' then
      FhlKnl1.Tb_CreateActionBtns_Ex(self.ToolBar1,self.ActionList1,fDict.Actions, logininfo.EmpId,FWindowsFID  )
   else
      ToolBar1.Visible :=false;


  if (fDict.TopBoxId<>'-1') and (fDict.TopBoxId<>'' ) then      //top or buttom      create label and dbcontrol
    FhlKnl1.Cf_SetBox(fDict.TopBoxId,mtDataSource1,TopPanel1,dmFrm.UserDbCtrlActLst);
  if (fDict.BtmBoxId<>'-1') and (fDict.BtmBoxId<> '') then
    FhlKnl1.Cf_SetBox(fDict.BtmBoxId,mtDataSource1,BtmPanel1,dmFrm.UserDbCtrlActLst);

           
  for i:=0 to  GridLst.Count -1 do
  begin
     DsSet :=TadodataSet.Create (self);
     DsSet.connection:=dmFrm.ADOConnection1;
     DsSet.AfterScroll :=  DsAfterScroll  ;
     DsSource:=TDataSource.Create (self);
     DsSource.DataSet := DsSet;

     GdRep:=TModelDbGrid.Create(self);

     GdRep.PopupMenu :=dmFrm.DbGridPopupMenu1 ;
     GdRep.DataSource :=  DsSource;
     //GdRep.NeedSumRow :=true;
     if GridLst.Count =1 then
        GdRep.Parent :=self.PgGrids
    else
     begin
        GdRep.Parent := fhlknl1.Pc_CreateTabSheet (PgGrids) ;
     end;
     GdRep.Align :=alclient;
     IniCurrentGrid(GdRep, GridLst[i]);
     if i=0 then
        DBGdCurrent:=  GdRep ;

  end;
      
  if fDict.DblActIdx>-1 then
    if (ActionList1.ActionCount > fDict.DblActIdx) and (DBGdCurrent<>nil) then
       DBGdCurrent.OnDblClick:=ActionList1.Actions[fDict.DblActIdx].OnExecute  ;
      { }

  if fDict.IsOpen then
  begin
    if mtAdoDataSet1.Active then
      OpnDlDsBtn1.Click         //查询
    else
      DBGdCurrent.DataSource.DataSet.Open;
  end;
        
finally
    if (GridLst<>nil ) then
        freeandnil(GridLst);
end;

end;

procedure TAnalyseEx.DBGrid1DrawColumnCellFntClr(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;  State: TGridDrawState);
var GridDraw:Tdbgrid;
begin
  GridDraw:=     (Sender as Tdbgrid);

  if GridDraw.DataSource.DataSet.IsEmpty then exit;

  if  GridDraw.DataSource.DataSet.FindField ('FntClr') <>nil then
  begin
      GridDraw.Canvas.Font.Color:=StringToColor(GridDraw.DataSource.DataSet.FieldByName('FntClr').AsString);
      FhlKnl1.Dg_DrawLineFont(Sender,Rect,DataCol,Column,State,GridDraw.Canvas.Font);
  end;
end;

procedure TAnalyseEx.IniCurrentGrid(PGrid:TDBGrid;GridID:string);
var i:integer;
begin
  FhlUser.SetDbGridAndDataSet(PGrid,GridID,null,false);
  //fhlknl1.Cf_DeleteDbGridUnAuthorizeCol(GridID,PGrid,logininfo.EmpId ,self.FWindowsFID,logininfo.SysDBPubName) ;
  if PGrid.DataSource.DataSet.FindField('FntClr')<>nil then
     PGrid.OnDrawColumnCell:=DBGrid1DrawColumnCellFntClr
  else
  begin
      for i:=0 to PGrid.Columns.Count -1 do
      begin
          if uppercase(PGrid.Columns[i].FieldName) = uppercase( 'FntClr' )then
          begin
               PGrid.OnDrawColumnCell:=DBGrid1DrawColumnCellFntClr   ;
               break;
          end;
      end;

  end;

end;
procedure TAnalyseEx.OpnDlDsBtn1Click(Sender: TObject);
var fParams:variant;
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

    fParams:=FhlKnl1.Ds_GetFieldsValue(mtAdoDataSet1,fDict.mtOpenParamFlds,true);

    if Not VarIsNull(fParams) then
    begin
         FhlKnl1.Ds_OpenDataSet(DBGdCurrent.DataSource.DataSet  ,fParams);
         FhlKnl1.SetColFormat(DBGdCurrent );
    end;
  
    if assigned(  DBGdCurrent.DataSource.DataSet.FindField('fntclr')) then
       DBGdCurrent.OnDrawColumnCell:=DBGrid1DrawColumnCellFntClr   ;

    if self.BtnSum.Down then
    self.DBGdCurrent.ReflashSumValues;
end;

procedure TAnalyseEx.printAction0Execute(Sender: TObject);
begin
showmessage('');
end;

procedure TAnalyseEx.refreshAction1Execute(Sender: TObject);
begin
  //showmessage('relash');
   DBGdCurrent.DataSource.DataSet.Close;
   DBGdCurrent.DataSource.DataSet.Open  ;

end;

procedure TAnalyseEx.TopPanel1DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ; 
begin
    if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
    begin
        CrtCom:=TfrmCreateComponent.Create(self);
        CrtCom.TOPBoxId :=self.fDict.TopBoxId ;
        CrtCom.TopOrBtm:=true;
        CrtCom.mtDataSet1:=self.mtADODataSet1 ;
        CrtCom.mtDataSetId :=inttostr(mtADODataSet1.tag);
        if DBGdCurrent<>nil then
        begin
        CrtCom.DlGridId :=inttostr(self.DBGdCurrent.Tag ) ;
        CrtCom.DLGrid :=self.DBGdCurrent ;
        end;
        CrtCom.ShowModal ;
        CrtCom.Free ;
    end;
end;

procedure TAnalyseEx.TLBtnShowQryClick(Sender: TObject);
begin
self.TopPanel1.Visible :=self.TLBtnShowQry.Down ;
end;



procedure TAnalyseEx.ToolButton5Click(Sender: TObject);
begin
     self.Close;
end;

procedure TAnalyseEx.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if PAuthoriseTmpTable<>'' then
  fhlknl1.Kl_GetQuery2('drop table '+ PAuthoriseTmpTable  ,false );
  Action:=caFree;
end;

procedure TAnalyseEx.Action1Execute(Sender: TObject);
begin
showmessage('');
end;

procedure TAnalyseEx.CloseAction1Execute(Sender: TObject);
begin
    self.Close;
end;

procedure TAnalyseEx.HelpAction1Execute(Sender: TObject);
begin
showMessage('help');
end;

procedure TAnalyseEx.PgGridsChange(Sender: TObject);
var i:integer;
begin

if  self.PgGrids.ActivePage.controlcount >0 then
   for i:=0 to  self.PgGrids.ActivePage.controlcount-1 do
   begin
       if  self.PgGrids.ActivePage.controls[i] is Tdbgrid then
       DBGdCurrent:=TModelDbGrid(self.PgGrids.ActivePage.controls[i])
   end;

end;

procedure TAnalyseEx.ActOriBillExecute(Sender: TObject);
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
      FhlUser.CheckToolButtonRight( self.fDict.Actions , (sender as Taction).Name );

      try
        LstParameterFLDs:=Tstringlist.Create ;

        sql:='select  A.F19,A.F17,A.F20 ,B.F_ID From T525 A  join '+ logininfo.SysDBPubName +'.dbo.T511 B  on A.F17=B.F06 where A.F02='+fDict.Actions+' and A.f16=' +inttostr(Taction(Sender).Index )
            +' and A.f17=' +inttostr(Taction(Sender).ActionComponent.Tag  )+' and A.f04='+quotedstr( Ttoolbutton( Taction(Sender).ActionComponent).Caption   );
        fhlknl1.Kl_GetQuery2 (sql  );
        fBillType:=fhlknl1.FreeQuery.FieldByName('F19').AsString  ;
        frmid:=fhlknl1.FreeQuery.FieldByName('F17').AsString      ;
        tmpWindowsFID:=fhlknl1.FreeQuery.FieldByName('F_ID').AsString      ;
        if uppercase(fBillType)=uppercase('Analyser') then
        begin
            if DBGdCurrent.DataSource.DataSet .FindField('sDefaultVals')<>nil then
            sDefaultVals:=self.DBGdCurrent.DataSource.DataSet .fieldbyname('sDefaultVals').AsString;

            LstParameterFLDs.CommaText :=fhlknl1.FreeQuery.FieldByName('F20').AsString      ;//  fDict.QryParamsFLDs ;
            for i:=0 to  LstParameterFLDs.Count -1 do
            begin
                if (DBGdCurrent.DataSource.DataSet.FindField (LstParameterFLDs[i])<>nil ) then
                LstParameterFLDs[i]:=LstParameterFLDs[i]+'='+DBGdCurrent.DataSource.DataSet .fieldbyname(LstParameterFLDs[i]).AsString;
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

        if uppercase(fBillType)=uppercase('Editor') then
        begin
            if DBGdCurrent.DataSource.DataSet.FindField('sDefaultVals')<>nil then
              sDefaultVals:=DBGdCurrent.DataSource.DataSet.fieldbyname('sDefaultVals').AsString;
            EditorFrm:=TEditorFrm.Create(self);
            if DBGdCurrent.DataSource.DataSet.Active then
              keyValue:=DBGdCurrent.DataSource.DataSet.fieldbyname(fhlknl1.FreeQuery.FieldByName('F20').AsString).AsString;
            EditorFrm.InitFrm(FrmId,keyValue ,DBGdCurrent.DataSource.DataSet ,DBGdCurrent ,fhlknl1.FreeQuery.FieldByName('F20').AsString  ) ;
            EditorFrm.ShowModal ;
            EditorFrm.Free ;
        end;

        if uppercase(fBillType)=uppercase('CRM') then
        begin

            if DBGdCurrent.DataSource.DataSet.FindField('sDefaultVals')<>nil then
            sDefaultVals:=self.DBGdCurrent.DataSource.DataSet .fieldbyname('sDefaultVals').AsString;
            FhlUser.ShowCRMFrm(frmid);
        end;
        if uppercase(fBillType)=uppercase('BillEx') then
        begin
          if not self.DBGdCurrent.DataSource.DataSet.IsEmpty then
          begin
            LstParameterFLDs.CommaText :=fhlknl1.FreeQuery.FieldByName('F20').AsString      ;//  fDict.QryParamsFLDs ;
            for i:=0 to  LstParameterFLDs.Count -1 do
            begin
              if   self.DBGdCurrent.DataSource.DataSet.FindField (LstParameterFLDs[i])<>nil then
              begin
                 if self.DBGdCurrent.DataSource.DataSet.FieldByName (LstParameterFLDs[i]).AsString <>'' then
                 begin
                     Code:=self.DBGdCurrent.DataSource.DataSet.FieldByName (LstParameterFLDs[i]).AsString  ;
                     break;
                 end;
              end;
            end;
          end;

          FrmBillEx:=TFrmBillEx.Create(nil);
          FrmBillEx.SetParamDataset(self.DBGdCurrent.DataSource.DataSet  );
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
        LstParameterFLDs.Free;
      end;
  except
    on err:exception do
    showmessage(err.Message );
  end;
end;

procedure TAnalyseEx.DsAfterScroll(Sender: TDataSet);
begin
     statLabel1.Caption:=intTostr(Tadodataset(Sender).RecNo)+'/'+intTostr(Tadodataset(Sender).RecordCount);
end;

procedure TAnalyseEx.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if  Key=13 then
  begin
    self.OpnDlDsBtn1.Click;
  end;

end;

procedure TAnalyseEx.ActFilterExecute(Sender: TObject);
begin
 FhlKnl1.Ds_Filter(nil,self.DBGdCurrent  );
//  GrpBox.IniGrpBox(self.DBGdCurrent );
end;

procedure TAnalyseEx.ActchkExecute(Sender: TObject);
var
  fbk:TBookmark;
  i:integer;
begin

  FhlUser.CheckToolButtonRight(self.fDict.Actions, (sender as Taction).Name );
  try
    Screen.Cursor:=crHourGlass;
    fbk:=DBGdCurrent.DataSource.DataSet .GetBookmark;

    if dgMultiSelect in DBGdCurrent.Options then
    begin
      pbIteration.Visible :=true;
      if DBGdCurrent.SelectedRows.Count>=1 then
      pbIteration.Max :=DBGdCurrent.SelectedRows.Count-1 ;
      for i:=0 to DBGdCurrent.SelectedRows.Count-1 do
      begin
        pbIteration.Position :=i;
        DBGdCurrent.DataSource.DataSet.GotoBookMark(Pointer(DBGdCurrent.SelectedRows.Items[i]));
        FhlUser.DoExecProc(DBGdCurrent.DataSource.DataSet ,null);
      end;
    end
    else
    begin
      FhlUser.DoExecProc(DBGdCurrent.DataSource.DataSet ,null);
    end;
    FhlKnl1.Ds_RefreshDataSet(DBGdCurrent.DataSource.DataSet );
    pbIteration.Visible :=false;
    DBGdCurrent.DataSource.DataSet .GotoBookmark(fbk);
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TAnalyseEx.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
 case Key of
     vk_Return:begin
                 if Not (ActiveControl is TDbGrid) and not fInputBarCode then
                   FhlKnl1.Vl_DoBoxEnter(ActiveControl)
                 else
                 self.OpnDlDsBtn1.Click;
               end;
       end;
end;

procedure TAnalyseEx.PrintAction1Execute(Sender: TObject);
var printID:string;
//    FrmMulModulePrint: TFrmMulModulePrint;
begin
  {if not DBGdCurrent.DataSource.DataSet.Active then exit;
  try
    printID:=self.fDict.Id ;
    FrmMulModulePrint:= TFrmMulModulePrint.Create (nil);
    FrmMulModulePrint.FrmIni(printID  ,self.mtADODataSet1   ,inttostr(mtADODataSet1.Tag ), self.fDict.TopBoxId ,     fDict.BtmBoxID , self.DBGdCurrent   );
    FrmMulModulePrint.MaxPrintModule :=1;
    FrmMulModulePrint.ShowModal ;
  finally
    if assigned(FrmMulModulePrint) then
    FrmMulModulePrint.Free ;
  end;
  }
end;

procedure TAnalyseEx.ActSumExecute(Sender: TObject);
var i,j:Integer;
var SumValue:Double;
var MaxValue:Double;
var pdbgrid:Tdbgrid;
begin
{ftUnknown, ftString, ftSmallint, ftInteger, ftWord,
    ftBoolean, ftFloat, ftCurrency, ftBCD, ftDate, ftTime, ftDateTime,
    ftBytes, ftVarBytes, ftAutoInc, ftBlob, ftMemo, ftGraphic, ftFmtMemo,
    ftParadoxOle, ftDBaseOle, ftTypedBinary, ftCursor, ftFixedChar, ftWideString,
    ftLargeint, ftADT, ftArray, ftReference, ftDataSet, ftOraBlob, ftOraClob,
    ftVariant, ftInterface, ftIDispatch, ftGuid, ftTimeStamp, ftFMTBcd}
     {
     pdbgrid:= self.DBGdCurrent ;
     progress.Visible :=true;
     progress.Max :=pdbgrid.Columns.Count -1;
     pdbgrid.DataSource.DataSet.Last;

     pdbgrid.DataSource.DataSet.Append;

     pdbgrid.DataSource.DataSet.Post;


    // TADODataSet (pdbgrid.DataSource.DataSet).DisableControls ;
     for i:=0 to pdbgrid.Columns.Count -1 do
     begin
         progress.Position :=i;
         SumValue:=0;
         MaxValue:=0;
         pdbgrid.DataSource.DataSet.First ;
                                               //  ftBCD,   , ftTime, ftDateTime
         if pdbgrid.Columns[i].Field<>nil then
         if pdbgrid.Columns[i].Field.DataType in [ftBCD,ftSmallint,ftInteger,ftFloat,ftCurrency,ftLargeint,ftDate] then
         begin

           for j:=0 to pdbgrid.DataSource.DataSet.RecordCount -1 do
           begin
             progress.Position :=j;
             if pdbgrid.Columns[i].Field.value<>null then
             begin
                 if not ( pdbgrid.Columns[i].Field.DataType in [ftDate, ftTime, ftDateTime] )then
                   if pdbgrid.Columns[i].Field.Value<>null then
                    SumValue:=SumValue+pdbgrid.Columns[i].Field.Value;
                 if pdbgrid.Columns[i].Field.Value>MaxValue then
                    MaxValue := pdbgrid.Columns[i].Field.Value;
             end;
             pdbgrid.DataSource.DataSet.Next ;
           end;


             if   pdbgrid.Columns[i].Field.ReadOnly then
             pdbgrid.Columns[i].Field.ReadOnly :=false;

            begin
              pdbgrid.DataSource.DataSet.First ;
              pdbgrid.DataSource.DataSet.Edit ;

              if pdbgrid.Columns[i].Field.DataType in [ftDate, ftTime, ftDateTime] then
                pdbgrid.DataSource.DataSet.FieldByName ( pdbgrid.Columns[i].Field.FieldName ).Value :=MaxValue
              else
                pdbgrid.DataSource.DataSet.FieldByName ( pdbgrid.Columns[i].Field.FieldName ).Value :=SumValue;

                   //       pdbgrid.DataSource.DataSet.FieldByName  ('FmainQty').value :=0;
              pdbgrid.DataSource.DataSet.Post;
            end;
         end;
     end;

       TADODataSet (pdbgrid.DataSource.DataSet).EnableControls ;
      }

      DBGdCurrent.NeedSumRow:=  BtnSum.Down ;
      if    BtnSum.Down then
      begin
         DBGdCurrent.ReflashSumValues ;
      end;
end;


procedure TAnalyseEx.ActExportExecute(Sender: TObject);
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
    PopDbgrid:=self.DBGdCurrent  ;
    QExportExcel(PopDbgrid,TForm(PopDbgrid.Parent).Caption+formatdatetime('yyyymmdd',now), true,strtoint(RepeatCnt));
  end;
end;

procedure TAnalyseEx.actRestoreDataExecute(Sender: TObject);
var TableName,FieldName:string;
var AdoDataSet:TAdoDataSet ;
var i:Integer;
var F_ID :string;
begin
  try
    F_ID:=DBGdCurrent.DataSource.DataSet.FieldByName('F_ID' ).AsString ;
    TableName:=mtADODataSet1.FieldByName('fuserTableEname').AsString ;
    AdoDataSet:=TAdoDataSet.Create (nil) ;
    AdoDataSet.Connection :=FhlKnl1.UserConnection;
    AdoDataSet.CommandText :='select   * from  '+TableName+' where F_ID='+quotedstr(F_ID);
    AdoDataSet.LockType:=ltOptimistic;

    AdoDataSet.Open;
    if not AdoDataSet.IsEmpty then
    begin
      ShowMessage(' 该记录已被恢复！不能做多次恢复!');
      Exit;
    end
    else
    begin
      AdoDataSet.Append;
      for i:=0 to AdoDataSet.FieldCount-1 do
      begin
          FieldName:= AdoDataSet.Fields[i].FieldName ;
          if DBGdCurrent.DataSource.DataSet.FindField (FieldName )<>nil then
          if DBGdCurrent.DataSource.DataSet.FieldByName(FieldName ).Value<>null then
         AdoDataSet.Fields[i].Value :=DBGdCurrent.DataSource.DataSet.FieldByName(FieldName ).Value   ;
      end;
      AdoDataSet.Post;
      ShowMessage('恢复成功！');
    end;

  finally
    AdoDataSet.Free ;

  end;

//
end;

procedure TAnalyseEx.btnCtrlClick(Sender: TObject);
//var  FrmCtrlConfig:TFrmCtrlConfig ;
begin
  {try
    FrmCtrlConfig:=TFrmCtrlConfig.Create(nil) ;

    if  ( self.BtmPanel1.ControlCount =0 )
     or ( messagedlg('设置表头控键?',  mtWarning,[mbyes,mbno],0)=mryes ) then
      FrmCtrlConfig.boxid :=self.fDict.TopBoxId
    else
      FrmCtrlConfig.boxid :=self.fDict.BtmBoxId ;

    FrmCtrlConfig.ShowModal ;
  finally
    FrmCtrlConfig.Free;
  end;
  }
end;

procedure TAnalyseEx.FormCreate(Sender: TObject);
begin
  inherited;
  btnCtrl.Visible     :=logininfo.Sys ;
end;

procedure TAnalyseEx.actLockColExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TAnalyseEx.actOriBill2Execute(Sender: TObject);
var sql:string;
var
  frmid:string;
  fBillType:string;
  BillFrm:TFrmBillEx;
  EditorFrm:TEditorFrm ;
  LegacyBillfrm:TBillFrm;
  Code ,tmpWindowsFID:string;
  FrmBillEx:TFrmBillEx ;
  LstParameterFLDs:Tstrings;
  i:integer;
  form:TAnalyseEx;
begin

  if  DBGdCurrent.DataSource.DataSet.IsEmpty then Exit;
  fBillType:=DBGdCurrent.DataSource.DataSet.FieldByName('BillType').AsString  ;
  frmid:=DBGdCurrent.DataSource.DataSet.FieldByName('FormID').AsString      ;
  tmpWindowsFID:=DBGdCurrent.DataSource.DataSet.FieldByName('FWindowsFID').AsString      ;
  if Trim( frmid )='' then Exit;

  try
      try
        LstParameterFLDs:=Tstringlist.Create ;
 
        if uppercase(fBillType)=uppercase('Analyser') then
        begin
            if DBGdCurrent.DataSource.DataSet .FindField('sDefaultVals')<>nil then
            sDefaultVals:=self.DBGdCurrent.DataSource.DataSet .fieldbyname('sDefaultVals').AsString;

            LstParameterFLDs.CommaText :=fhlknl1.FreeQuery.FieldByName('F20').AsString      ;//  fDict.QryParamsFLDs ;
            for i:=0 to  LstParameterFLDs.Count -1 do
            begin
                if (DBGdCurrent.DataSource.DataSet.FindField (LstParameterFLDs[i])<>nil ) then
                LstParameterFLDs[i]:=LstParameterFLDs[i]+'='+DBGdCurrent.DataSource.DataSet .fieldbyname(LstParameterFLDs[i]).AsString;
            end;
            if LstParameterFLDs.Count>0 then
            sDefaultVals:=LstParameterFLDs.CommaText ;

            form:=TAnalyseEx.Create(Application)  ;
            form.hide;
            form.FWindowsFID :=tmpWindowsFID;
            form.InitFrm(frmid,null);
            form.Showmodal;
        end;
           {
        if uppercase(fBillType)=uppercase('Editor') then
        begin
            if DBGdCurrent.DataSource.DataSet.FindField('sDefaultVals')<>nil then
              sDefaultVals:=DBGdCurrent.DataSource.DataSet.fieldbyname('sDefaultVals').AsString;
            EditorFrm:=TEditorFrm.Create(self);
            EditorFrm.InitFrm(FrmId,DBGdCurrent.DataSource.DataSet.fieldbyname(fhlknl1.FreeQuery.FieldByName('F20').AsString).AsString,DBGdCurrent.DataSource.DataSet ,DBGdCurrent ,fhlknl1.FreeQuery.FieldByName('F20').AsString  ) ;
            EditorFrm.ShowModal ;
            EditorFrm.Free ;
        end;
        if uppercase(fBillType)=uppercase('CRM') then
        begin

            if DBGdCurrent.DataSource.DataSet.FindField('sDefaultVals')<>nil then
            sDefaultVals:=self.DBGdCurrent.DataSource.DataSet .fieldbyname('sDefaultVals').AsString;
            FhlUser.ShowCRMFrm(frmid);
        end;
        }
        if (uppercase(fBillType)=uppercase('BillEx') ) or ( uppercase(fBillType)=uppercase('bill') ) then
            if not self.DBGdCurrent.DataSource.DataSet.IsEmpty then
                begin
                  LstParameterFLDs.CommaText :=self.DBGdCurrent.DataSource.DataSet.FieldByName('ParameterFLDs').AsString      ;//  fDict.QryParamsFLDs ;
                  for i:=0 to  LstParameterFLDs.Count -1 do
                  begin
                    if   self.DBGdCurrent.DataSource.DataSet.FindField (LstParameterFLDs[i])<>nil then
                    begin
                       if self.DBGdCurrent.DataSource.DataSet.FieldByName (LstParameterFLDs[i]).AsString <>'' then
                       begin
                           Code:=self.DBGdCurrent.DataSource.DataSet.FieldByName (LstParameterFLDs[i]).AsString  ;
                           break;
                       end;
                    end;
                  end;
                end;

        if uppercase(fBillType)=uppercase('Bill') then
        begin
              LegacyBillfrm:=TBillFrm.Create(Application) ;
              with LegacyBillfrm  do
              begin
                FormStyle :=fsnormal;
                hide;
                InitFrm(FrmId);
                Name:='BillFrm'+frmid;
                if code<>'' then
                  OpenBill(code);
                ShowModal;
              end;
        end;

        if uppercase(fBillType)=uppercase('BillEx') then
        begin
          FrmBillEx:=TFrmBillEx.Create(nil);
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
          FrmBillEx.SetParamDataset(self.DBGdCurrent.DataSource.DataSet  );
          FrmBillEx.ShowModal ;
        end;
      finally
        LstParameterFLDs.Free;
      end;
  except
    on err:exception do
    showmessage(err.Message );
  end;
end;

procedure TAnalyseEx.ActRsExportExecute(Sender: TObject);
var
  fbk:TBookmark;
begin
  FhlUser.DoExecProc( DBGdCurrent.DataSource.DataSet,null );
  fbk:=DBGdCurrent.DataSource.DataSet.GetBookmark;
  FhlKnl1.Ds_RefreshDataSet( DBGdCurrent.DataSource.DataSet );
  DBGdCurrent.DataSource.DataSet.GotoBookmark(fbk);
end;

procedure TAnalyseEx.ActBatCodeListExecute(Sender: TObject);
begin
  if (FrmPanelBarCodeList=nil)   then
  begin
      FrmPanelBarCodeList:=TFrmPanelBarCodeList.Create(self);
      FrmPanelBarCodeList.SetDataSet(self.DBGdCurrent.DataSource.DataSet);
      FrmPanelBarCodeList.Parent  :=PgGrids;
      FrmPanelBarCodeList.Align:=alleft;
      FrmPanelBarCodeList.Width:=200;
  end
  else
  begin
      if FrmPanelBarCodeList.Visible then
          FrmPanelBarCodeList.Visible :=Not FrmPanelBarCodeList.Visible
      else
        FrmPanelBarCodeList.Show;
  end;
  fInputBarCode:= Ttoolbutton( ActBatCodeList.ActionComponent).Down;
//GdRep.Parent :=self.PgGrids
end;

function TAnalyseEx.VerifyBarCodeExcelFormat(Excel: OleVariant): boolean;
var fields:Tstringlist;
var i:integer;
begin
   try
    fields:= Tstringlist.Create;
    fields.Add('客戶代碼');
    fields.Add('LOTNO');
    fields.Add('料號');
    fields.Add('實發數量');
    fields.Add('流水號');
    fields.Add('排箱單號');
    fields.Add('箱號');
    fields.Add('pono');

    result:=true;
    for i:=1 to fields.Count do
    begin
        if ( Excel.WorkSheets[1].Cells[1,i].value  <> fields[i-1]) then
        begin
          result:= false;
         
        end;
    end;
   finally
       freeandnil(fields);
   end;
end;

procedure TAnalyseEx.ActExImportExecute(Sender: TObject);
const
  BeginRow = 2; BeginCol = 1;
var
  Excel: OleVariant;
  iRow,iCol ,j : integer;
  xlsFilename,cellValue,msg,ShortFileName,sql: string;
  dlg:Topendialog;
  ADOQuery1: TADOQuery; 
begin
  try
      Screen.Cursor:=crSqlwait;
      try
        Excel := CreateOLEObject('Excel.Application');
      except
        Application.MessageBox('excel没有安装', '提示信息', MB_OK+MB_ICONASTERISK+MB_DEFBUTTON1+MB_APPLMODAL);
        Exit;
      end;

     ADOQuery1:= TADOQuery.Create(nil);
     ADOQuery1.Connection :=dmFrm.ADOConnection1;
     dlg:= Topendialog.Create(nil);
     dlg.Filter:='Excel文件(*.xls)|*.xls|Excel文件(*.xlsx)|*.xlsx'  ;
     if not  dlg.Execute then
        abort;

        xlsFilename := dlg.FileName;
        ShortFileName  := ExtractFileName(xlsFilename) ;

        sql := 'if exists(select *  from TPesistorImport where FFileName ='+quotedstr(ShortFileName)+') select 1  else select 0';
        fhlknl1.Kl_GetUserQuery( sql);
        if fhlknl1.User_Query.Fields[0].Value>0 then
        begin
            showmessage(  ShortFileName +' 已经存在!');
            abort;
        end;



        Excel.Visible := false;
        Excel.WorkBooks.Open(xlsFilename);
        try
          iRow := BeginRow;
          iCol := BeginCol;
          ADOQuery1.close;
          ADOQuery1.SQL.Clear;
          ADOQuery1.SQL.Add('delete    TPesistorImport where FFileName='+quotedstr(ShortFileName)) ;
          ADOQuery1.ExecSQL;

          ADOQuery1.close;
          ADOQuery1.SQL.Clear;
          ADOQuery1.SQL.Add('select FClientID,FOrdNo,FPesistorPartNo,FQty,FSmallPkgSeq,FBigPkgSeq,FPkgNo,FPono, RowNo,FFileName from TPesistorImport where 1<>1');
          ADOQuery1.Open;
          application.HandleMessage;
          VerifyBarCodeExcelFormat(Excel);
          cellValue:=  trim( Excel.WorkSheets[1].Cells[iRow,1].value );
          while  ( cellValue ) <> '' do begin
              ADOQuery1.Append;
              for j:=0 to  ADOQuery1.FieldCount-1 do begin
                with ADOQuery1 do begin
                  cellValue:= trim(Excel.WorkSheets[1].Cells[iRow,j+1].value);
                  Fields[j].AsString := cellValue ;
                end;
              end;
              if (IRow mod 50 =0)   then
                  application.HandleMessage;

              ADOQuery1.FieldByName('RowNo').Value := iRow;
              ADOQuery1.FieldByName('FFileName').Value := ShortFileName;
             
              iRow := iRow + 1;
              ADOQuery1.post; 
              cellValue:=  trim( Excel.WorkSheets[1].Cells[iRow,1].value );
          end;
          
          ADOQuery1.UpdateStatus ;
          msg :=   '数据导入成功,'+inttostr(iRow-BeginRow)+'行'   ;
          MessageBox(GetActiveWindow(),pchar( msg) , '提示信息', MB_OK + MB_ICONWARNING);
       except on E:Exception do
            begin
                msg := '导入数据出错'+E.Message ;
               MessageDlg(#13#10+E.Message,mtError,[mbOk],0);
            end;
        end;

  finally
      Excel.Quit;
      freeandnil(dlg);
      freeandnil(ADOQuery1);
      Screen.Cursor:=crDefault;
  end;

end;




procedure TAnalyseEx.ActExportCSVExecute(Sender: TObject);
var
  PopDbgrid:Tdbgrid;
  RepeatCnt:string;
  ClickedOK: Boolean;
  NewString: string;

begin
    PopDbgrid:=self.DBGdCurrent  ;
    QExportCSV(PopDbgrid,TForm(PopDbgrid.Parent).Caption+formatdatetime('yyyymmddHHmmSS',now) );

end;


procedure TAnalyseEx.ActNextDatasetExecute(Sender: TObject);
var rowcnt :integer;
begin
rowcnt:= Tadodataset( self.DBGdCurrent.DataSource.DataSet).RecordCount ;

 if not self.DBGdCurrent.DataSource.DataSet.IsEmpty then
     Tadodataset( self.DBGdCurrent.DataSource.DataSet).NextRecordset(rowcnt);
end;

procedure TAnalyseEx.ActOldVersionPrintExecute(Sender: TObject);
begin 
if self.DBGdCurrent.DataSource.DataSet.Active  then
 FhlKnl1.Rp_DbGrid(intTostr(DBGdCurrent.Tag),DBGdCurrent,self.fDict.Caption );

end;

procedure TAnalyseEx.ActDeleteExecute(Sender: TObject);
begin
 if self.DBGdCurrent.DataSource.DataSet.Active  then
begin
  if Not Assigned(DBGdCurrent.DataSource.DataSet.BeforeDelete) and (MessageDlg(fsDbDelete,mtConfirmation,[mbYes,mbNo],0)<>mrYes) then
     Abort;
  DBGdCurrent.DataSource.DataSet.Delete;
end;
end;

procedure TAnalyseEx.ActWrArchiveExecute(Sender: TObject);
begin
    if FrmWrArchive = nil then
    begin
        FrmWrArchive := TFrmWrArchive.Create(self);
        FrmWrArchive.InitFrm (null);
        FrmWrArchive.SetDataSet(self.DBGdCurrent.DataSource.DataSet);
        FrmWrArchive.Parent  :=PgGrids;
        FrmWrArchive.Align:=alleft;
        FrmWrArchive.Width:=300;
        DBGdCurrent.DataSource.DataSet.AfterScroll(DBGdCurrent.DataSource.DataSet) ;

    end
    else
    begin
        if FrmWrArchive.Visible then
          FrmWrArchive.Visible :=Not FrmWrArchive.Visible
        else
        begin
          FrmWrArchive.Show;

        end
    end;
 // fInputBarCode:= Ttoolbutton( ActBatCodeList.ActionComponent).Down;
    { }
end;

end.
