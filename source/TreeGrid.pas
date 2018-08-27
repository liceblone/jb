unit TreeGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, ComCtrls, ToolWin, Db, DBTables, stdctrls, ADODB, ImgList, 
  Menus, ActnList, ExtCtrls, UnitModelFrm,  UnitGrid,

  variants,Editor,tabgrid,   FhlKnl,UnitCreateComponent, DBCtrls;


type
  TTreeGridFrm = class(TFrmModel)
    DataSource1: TDataSource;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Panel2: TPanel;
    ADODataSet1: TADODataSet;
    ControlBar1: TControlBar;
    myBar1: TToolBar;
    ToolBar2: TToolBar;
    prtBtn: TToolButton;
    refreshBtn: TToolButton;
    upBtn: TToolButton;
    TreeBtn: TToolButton;
    setBtn: TToolButton;
    expbtn: TToolButton;
    ActionList1: TActionList;
    WarePropAction1: TAction;
    ExtBtn: TToolButton;
    EditorAction1: TAction;
    DeleteAction1: TAction;
    fnCaAction1: TAction;
    fnCaDlAction1: TAction;
    SortAction1: TAction;
    ClientPropAction1: TAction;
    ClientEmpAction1: TAction;
    GroupBox1: TGroupBox;
    TreeView1: TTreeView;
    MainMenu1: TMainMenu;
    LocateAction1: TAction;
    fnOriginalAction1: TAction;
    FilterAction1: TAction;
    ClntOwnerAction1: TAction;
    ClntPubAction1: TAction;
    actUpdateImage: TAction;
    ActMergeStock: TAction;
    ActBachUpdate: TAction;
    ActUpLoad: TAction;
    ActUpdateStok: TAction;
    ActClientRgt: TAction;
    statLabel1: TLabel;
//    procedure InitFrm(FrmId:String);
    procedure InitFrm(FrmId:String;AParam:variant;Modal:boolean=false);
    procedure rfsBtnClick(Sender: TObject);
    procedure ExtBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AdoDataSet1PostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure TreeBtnClick(Sender: TObject);
    procedure upBtnClick(Sender: TObject);
    procedure refreshBtnClick(Sender: TObject);
    procedure expbtnClick(Sender: TObject);
    procedure WarePropAction1Execute(Sender: TObject);
    procedure DeleteAction1Execute(Sender: TObject);
    procedure EditorAction1Execute(Sender: TObject);
    procedure SortAction1Execute(Sender: TObject);
    procedure ClientPropAction1Execute(Sender: TObject);
    procedure prtBtnClick(Sender: TObject);
    procedure ClientEmpAction1Execute(Sender: TObject);
    procedure LocateAction1Execute(Sender: TObject);
    procedure fnOriginalAction1Execute(Sender: TObject);
    procedure FilterAction1Execute(Sender: TObject);
    procedure ClntOwnerAction1Execute(Sender: TObject);
    procedure ClntPubAction1Execute(Sender: TObject);
    procedure myBar1DblClick(Sender: TObject);
    procedure ControlBar1DblClick(Sender: TObject);
    procedure actUpdateImageExecute(Sender: TObject);
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ActMergeStockExecute(Sender: TObject);
    procedure ActBachUpdateExecute(Sender: TObject);
    procedure ActUpdateStokExecute(Sender: TObject);
    procedure ActUpLoadExecute(Sender: TObject);
    procedure ActClientRgtExecute(Sender: TObject);
    procedure ADODataSet1AfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    DBGrid1:TModelDbGrid;

    blSelect: Boolean;  //mul select mouse up
    BookMark: TBookMark;
    CurrNo, OldNo: integer;
    //==============================================
    fDict:TTreeGridDict;
    fEditorFrm:TEditorFrm;
    fSortFrm,fFilterFrm,fLocateFrm:TForm;
  public

  end;

var
  TreeGridFrm: TTreeGridFrm;

implementation
uses datamodule,RepGrid,analyser, desktop,TabEditor,UPublic;
{$R *.DFM}

procedure TTreeGridFrm.InitFrm(FrmId:String;AParam:variant;Modal:boolean=false);
begin
  if Modal then
  begin
    self.FormStyle :=fsnormal;
  end;

  fDict.Id:=FrmId;
  if Not FhlKnl1.Cf_GetDict_TreeGrid(FrmId,fdict) then Close;
   Caption:=fDict.Caption;
//   FhlKnl1.Cf_SetTreeView(fDict.TreeId,TreeView1,dmFrm.FreeDataSet1);
   FhlKnl1.Cf_SetTreeView(fDict.TreeId,TreeView1,dmFrm.FreeDataSet1,AParam);
   FhlUser.SetDbGridAndDataSet(dbGrid1,fDict.DbGridId,Null,False);    //Fcfg_dbgrid  Fcfg_dbgridcol


   if fDict.Actions<>'' then
   begin
   FhlKnl1.Tb_CreateActionBtns(myBar1,ActionList1,fDict.Actions);
   DbGrid1.OnDblClick:=myBar1.Buttons[0].OnClick;
   end;
   
   TreeView1.Items.GetFirstNode.Selected:=fDict.IsOpen;

end;

procedure TTreeGridFrm.rfsBtnClick(Sender: TObject);
begin
  DataSource1.DataSet.Close;
  DataSource1.DataSet.Open;
end;

procedure TTreeGridFrm.ExtBtnClick(Sender: TObject);
begin
 Close;
end;

procedure TTreeGridFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if fEditorFrm<>nil then
       fEditorFrm.Free;
    if fLocateFrm<>nil then
       fLocateFrm.Free;
    if fFilterFrm<>nil then
       fFilterFrm.Free;
    if fSortFrm<>nil then
       fSortFrm.Free;
    Action:=caFree;
end;

procedure TTreeGridFrm.AdoDataSet1PostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  Beep;
 Action:=daAbort;
end;

procedure TTreeGridFrm.TreeView1Change(Sender: TObject; Node: TTreeNode);
  var p:string;
begin
  Screen.Cursor:=crSqlWait;
  try
    p:=TStrPointer(Node.Data)^;
    if AdoDataSet1.FindField(fDict.ClassFld)<>Nil then
    begin
      sDefaultVals:=fDict.ClassFld+'='+p;
      FhlUser.AssignDefault(AdoDataSet1);
    end;  
    p:=p+'%';
    FhlKnl1.Ds_OpenDataSet(AdoDataSet1,varArrayof([p,LoginInfo.LoginId]));
    Panel2.Caption:=FhlKnl1.Tv_GetTreePath(Node)+inttostr(AdoDataSet1.recordCount)+' 个项目';
    expBtn.Enabled:=Node.HasChildren;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TTreeGridFrm.TreeBtnClick(Sender: TObject);
begin
 GroupBox1.Visible:=TreeBtn.Down;
end;

procedure TTreeGridFrm.upBtnClick(Sender: TObject);
begin
 if TreeView1.Selected<>nil then
   with TreeView1.Selected do
        if Level>0 then
           Parent.Selected:=true;
end;

procedure TTreeGridFrm.refreshBtnClick(Sender: TObject);
begin
 TreeView1Change(TreeView1,TreeView1.Selected);
end;

procedure TTreeGridFrm.expbtnClick(Sender: TObject);
 var Node:TTreeNode;
begin
 Node:=TreeView1.Selected;
 if Node=nil then 
    Node:=FhlKnl1.Tv_FindNode(Treeview1,'');
 with Node do
    if Expanded then
       Collapse(True)
    else 
       Expand(True);
end;

procedure TTreeGridFrm.WarePropAction1Execute(Sender: TObject);
begin
if (AdoDataSet1.Active ) and (not AdoDataSet1.IsEmpty ) then
  FhlUser.ShowWarePropFrm(self.AdoDataSet1.FieldByName('Id').asString,self.DataSource1);
end;

procedure TTreeGridFrm.DeleteAction1Execute(Sender: TObject);
var
  i,F_MID: integer;

var
  fDict:TBeforeDeleteDict;
begin

 if Not FhlKnl1.Cf_GetDict_BeforeDelete(intTostr(ADODataSet1.Tag),fdict) then exit;
 if (not AdoDataSet1.IsEmpty)  then
 begin
   if (not assigned(ADODataSet1.BeforeDelete ) ) or  (fdict.Hint ='' )then
   begin
      if    messagedlg('确定'+self.DeleteAction1.Caption+'?'  ,mtinformation,[mbOk, mbCancel],0)=mrOK then
          DBGrid1.SelectedRows.Delete     ;
   end
   else
          DBGrid1.SelectedRows.Delete;
  end
  else
     showmessage('请先选择记录!');

end;

procedure TTreeGridFrm.EditorAction1Execute(Sender: TObject);
begin
if self.ADODataSet1.Active  then
begin
  if fEditorFrm=nil then
    fEditorFrm:=TEditorFrm(FhlUser.ShowEditorFrm(fDict.EditorId,null,self.AdoDataSet1));
  fEditorFrm.ShowModal;
end;  
end;

procedure TTreeGridFrm.SortAction1Execute(Sender: TObject);
begin
  FhlKnl1.Dg_Sort(DbGrid1);
end;

procedure TTreeGridFrm.ClientPropAction1Execute(Sender: TObject);
begin
  FhlUser.ShowClientPropFrm;
end;

procedure TTreeGridFrm.prtBtnClick(Sender: TObject);
begin
 FhlUser.CheckRight(fdict.PrintRitId);
 FhlKnl1.Rp_DbGrid(intTostr(DbGrid1.Tag),DbGrid1);
end;

procedure TTreeGridFrm.ClientEmpAction1Execute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm('3',varArrayof([AdoDataSet1.FieldByName('Code').asString]));
end;

procedure TTreeGridFrm.LocateAction1Execute(Sender: TObject);
begin
  FhlKnl1.Ds_Filter(DbGrid1.DataSource.DataSet);
end;

procedure TTreeGridFrm.fnOriginalAction1Execute(Sender: TObject);
begin

  FhlUser.ShowTabEditorFrm('TreeGrid.'+fDict.Id+'.'+TComponent(Sender).Name,AdoDataSet1.FieldByName('Code').AsString);
end;

procedure TTreeGridFrm.FilterAction1Execute(Sender: TObject);
begin
  FhlKnl1.Ds_Filter(DbGrid1.DataSource.DataSet);
end;

procedure TTreeGridFrm.ClntOwnerAction1Execute(Sender: TObject);
var
  fCode:string;
begin
  with DbGrid1.DataSource.DataSet do
  begin
    fCode:=FieldByName('Code').AsString;
    FhlUser.ShowTabEditorFrm('crm_client_owner',fCode);
    Close;
    Open;
    Locate('Code',fCode,[]);
  end;
end;

procedure TTreeGridFrm.ClntPubAction1Execute(Sender: TObject);
var
  fCode:string;
begin
  with DbGrid1.DataSource.DataSet do
  begin
    fCode:=FieldByName('Code').AsString;
    FhlUser.ShowTabEditorFrm('crm_client_pub',fCode);
    Close;
    Open;
    Locate('Code',fCode,[]);
  end;
end;

procedure TTreeGridFrm.myBar1DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin
 try
// modeltpe:=Bill;
  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    //CrtCom.FTreeGridDict :=  fdict;
    //CrtCom.ModelType :=ModelFrmTreeGrid;
    CrtCom.mtDataSet1 :=self.ADODataSet1 ;
    CrtCom.mtDataSetId :=inttostr(ADODataSet1.Tag );
    CrtCom.DlGridId :=inttostr(DBGrid1.Tag );
    CrtCom.DLGrid :=DBGrid1;
    CrtCom.Show;
  end;


   
finally

end;

end;

procedure TTreeGridFrm.ControlBar1DblClick(Sender: TObject);
begin
mybar1.OnDblClick   (sender);
end;

procedure TTreeGridFrm.actUpdateImageExecute(Sender: TObject);
begin
   //  FhlUser.ShowEditorFrm(intTostr(28),null ,self.ADODataSet1  ).ShowModal;

       if fEditorFrm=nil then
    fEditorFrm:=TEditorFrm(FhlUser.ShowEditorFrm('28',null,self.AdoDataSet1));
  fEditorFrm.ShowModal;
end;

procedure TTreeGridFrm.DBGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ( Button = mbLeft ) and (self.ADODataSet1.Active )then
  begin

    if not blSelect then
    begin
      BookMark := self.ADODataSet1.GetBookMark;
      OldNo := self.ADODataSet1.RecNo;
      blSelect := True;
      Exit;
    end
    else
    begin
      if ssShift in Shift then
      begin
        CurrNo := self.ADODataSet1.RecNo;
        self.ADODataSet1.DisableControls;
        self.ADODataSet1.GotoBookmark(BookMark);
        self.DBGrid1.SelectedRows.CurrentRowSelected := True;
        if CurrNo > OldNo then
        begin
          while CurrNo > self.ADODataSet1.RecNo do
          begin
            self.DBGrid1.SelectedRows.CurrentRowSelected := True;
            self.ADODataSet1.Next;
          end;
        end
        else
        begin
          while CurrNo < self.ADODataSet1.RecNo do
          begin
            self.DBGrid1.SelectedRows.CurrentRowSelected := True;
            self.ADODataSet1.Prior;
          end;
        end;
        self.ADODataSet1.EnableControls;
        self.ADODataSet1.FreeBookmark(BookMark);
        blSelect := False;
        CurrNo := 0;
        OldNo := 0;
      end
      else
      begin
        BookMark := self.ADODataSet1.GetBookMark;
        OldNo := self.ADODataSet1.RecNo;
        blSelect := True;
        Exit;
      end;
    end;
  end;

end;

procedure TTreeGridFrm.ActMergeStockExecute(Sender: TObject);
var pnote:string;
var AnalyserFrm:TAnalyserFrm;
begin
  FhlUser.CheckRight('0301010405');

  if not ADODataSet1.Active  then exit;
  if  ADODataSet1.IsEmpty then  exit;




  sDefaultVals:='';
  sDefaultVals:=sDefaultVals+'wareid='+ADODataSet1.FieldByName('id').asString+',';

  pnote:='strb='+ADODataSet1.FieldByName('model').asString+',strC='+ADODataSet1.FieldByName('PartNo').asString;
  if  ADODataSet1.FieldByName('Brand').asString  <>'' then
      pnote:=pnote+',strD='+ADODataSet1.FieldByName('Brand').asString;

  if  ADODataSet1.FieldByName('pack').asString  <>'' then
      pnote:=pnote+',strE='+ADODataSet1.FieldByName('pack').asString;
  if  ADODataSet1.FieldByName('Origin').asString  <>'' then
      pnote:=pnote+',strF='+ADODataSet1.FieldByName('Origin').asString+'';

  sDefaultVals:=sDefaultVals+pnote;

  Screen.Cursor:=crAppStart;
 try
      AnalyserFrm:=TAnalyserFrm.Create(nil);
      AnalyserFrm.Position :=   poMainFormCenter;
      AnalyserFrm.FormStyle :=fsnormal;
      AnalyserFrm.hide;
      
      AnalyserFrm.InitFrm('98',null);
      AnalyserFrm.ShowModal  ;

 finally
      AnalyserFrm.Free ;
      Screen.Cursor:=crDefault;
 end;

end;

procedure TTreeGridFrm.ActBachUpdateExecute(Sender: TObject);

 
var
  i: integer;
  TempBookmark: TBookMark;          //multiselect

var TabEditorFrm:TTabEditorFrm;
var GrpBatchUpdate:TGrpQueryRecord   ;
var labelV:TLabel;
begin
  inherited;
    if self.ADODataSet1.IsEmpty then
    begin
        showmessage('请先选择记录');
        exit;
    end;
    labelV:=TLabel.Create(self);
    labelV.Caption :='字段值:';
    TabEditorFrm:=TTabEditorFrm.Create (nil);
    FhlKnl1.Pc_CreateTabSheet(TabEditorFrm.PageControl1);
    TabEditorFrm.CheckBox1.Visible :=false;
    TabEditorFrm.Caption :='批量修改, 先由shift +左键 条选记录 再确定。';
    GrpBatchUpdate:=TGrpQueryRecord.create(self);
    labelV.Parent  := GrpBatchUpdate;
    GrpBatchUpdate.LabelName.Left :=30;

    GrpBatchUpdate.DragMode :=   dmManual;
    GrpBatchUpdate.Parent :=TabEditorFrm.PageControl1.ActivePage ;
    GrpBatchUpdate.Align :=alClient;
    GrpBatchUpdate.IniQuickQuery(self.DBGrid1 ,true) ;
    GrpBatchUpdate.LabelName.Caption  :='字段名:';
    GrpBatchUpdate.OptCombobox.Visible :=false;
    GrpBatchUpdate.ValGroupBox.Left :=GrpBatchUpdate.ComBoxFieldCname.Left ;

    GrpBatchUpdate.ValGroupBox.Top := GrpBatchUpdate.ComBoxFieldCname.Top +GrpBatchUpdate.ComBoxFieldCname.Height   +30;
    labelV.Left := GrpBatchUpdate.LabelName.Left ;
    labelV.Top :=  GrpBatchUpdate.ValGroupBox.Top+10;
    if  TabEditorFrm.ShowModal =mrok then
    begin
         GrpBatchUpdate.GetSqlCon ;

         self.DBGrid1.SelectedRows.CurrentRowSelected:=true;

          if self.DBGrid1.DataSource.DataSet.Active then
          with DBGrid1.SelectedRows do
              if Count <> 0 then
              begin
                  TempBookmark:= DBGrid1.Datasource.Dataset.GetBookmark;
                  if GrpBatchUpdate.fldName='' then
                  begin
                     showmessage('字段名不能为空！');
                      exit;

                  end;
                  for i:= 0 to Count - 1 do
                  begin
                    if IndexOf(Items[i]) > -1 then
                    begin
                       DBGrid1.Datasource.Dataset.Bookmark:= Items[i];



                       DBGrid1.DataSource.DataSet.Edit ;

                       if GrpBatchUpdate.fldval='' then
                          DBGrid1.DataSource.DataSet.FieldByName(GrpBatchUpdate.fldName ).Value :=null
                       else
                          DBGrid1.DataSource.DataSet.FieldByName(GrpBatchUpdate.fldName ).Value :=GrpBatchUpdate.fldval ;
                       DBGrid1.DataSource.DataSet.Post ;
                    end;
                  end;
             end;

          DBGrid1.Datasource.Dataset.GotoBookmark(TempBookmark);
          DBGrid1.Datasource.Dataset.FreeBookmark(TempBookmark);

    end;
    TabEditorFrm.Free;

end;
procedure TTreeGridFrm.ActUpdateStokExecute(Sender: TObject);

  var
  fbk:TBookmark;
begin
              inherited;
             Screen.Cursor:=crHourGlass;
  FhlUser.DoExecProc(ADODataSet1,null);
  fbk:=ADODataSet1.GetBookmark;
  FhlKnl1.Ds_RefreshDataSet(ADODataSet1);
  ADODataSet1.GotoBookmark(fbk);
    Screen.Cursor:=crDefault;
end;
//882
procedure TTreeGridFrm.ActUpLoadExecute(Sender: TObject);
var
  fbk:TBookmark;      //更新网站信息
var
  fDict:TExcPrcDict;
  var Aparams:Variant ;
begin
    
    inherited;

 try
      Screen.Cursor:=crHourGlass;



      FhlKnl1.Cf_GetDict_ExcPrc('882',fDict);
      if fDict.ProcName<>'' then
      begin
      FhlUser.CheckRight(fDict.RightId);
      Aparams:=FhlKnl1.Vr_MergeVarArray(FhlKnl1.Ds_GetFieldsValue(ADODataSet1,fDict.UsrParams),Aparams);
      fDict.ReturnBool:=dmFrm.ExecStoredProc(fDict.ProcName,FhlKnl1.Vr_MergeVarArray(FhlUser.GetSysParamsVal(fDict.SysParams),Aparams));
      with dmFrm.FreeStoredProc1 do
      begin
      if (Parameters.Count>1) and (Parameters.Items[1].Direction=pdOutPut) and (Not varIsnull(Parameters.Items[1].Value)) then
      fDict.ResultHint:=Parameters.Items[1].Value;
      end;
      if fDict.ResultHint<>'' then MessageDlg(#13#10+fDict.ResultHint,mtError,[mbOk],0);
      if Not fDict.ReturnBool
      then Abort;
      end;

      fbk:=ADODataSet1.GetBookmark;
      FhlKnl1.Ds_RefreshDataSet(ADODataSet1);
      ADODataSet1.GotoBookmark(fbk);
      Screen.Cursor:=crDefault;
       showmessage('传送成功');
except
   on err:exception do
   begin
         showmessage(err.Message );
   end;

   
end;

end;

procedure TTreeGridFrm.ActClientRgtExecute(Sender: TObject);
begin 
FhlUser.ShowMore2MoreFrm('9',AdoDataSet1.FieldByName('code').asString);
end;

procedure TTreeGridFrm.ADODataSet1AfterScroll(DataSet: TDataSet);
begin

 statLabel1.Caption:=intTostr(Tadodataset(DataSet).RecNo)+'/'+intTostr(Tadodataset(DataSet).RecordCount);
end;

procedure TTreeGridFrm.FormCreate(Sender: TObject);
begin
    dbgrid1:=TModelDbGrid.create (self);
    dbgrid1.DataSource :=self.DataSource1 ;
    dbgrid1.Align :=alclient;
    dbgrid1.Parent :=panel1;
   // dbgrid1.OnDblClick := DBLClick;
    dbgrid1.PopupMenu :=dmFrm.DbGridPopupMenu1 ;
end;

end.
