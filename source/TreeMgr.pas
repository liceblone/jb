unit TreeMgr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, ToolWin, Db, ADODB, ImgList, Grids, DBGrids,
  Menus, variants,ActnList, FhlKnl,UnitModelFrm,UnitCreateComponent, UnitGrid;


type
  TTreeMgrFrm = class(TFrmModel)
    DataSource1: TDataSource;
    Panel2: TPanel;
    Splitter1: TSplitter;
    GroupBox1: TGroupBox;
    TreeView1: TTreeView;
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    ADODataSet1: TADODataSet;
    ControlBar1: TControlBar;
    myBar1: TToolBar;
    ToolBar1: TToolBar;
    printBtn: TToolButton;
    refreshbtn: TToolButton;
    ToolButton2: TToolButton;
    TreeBtn: TToolButton;
    exitBtn: TToolButton;
    ActionList1: TActionList;
    NodeDataSet1: TADODataSet;
    AddAction1: TAction;
    EditAction1: TAction;
    SaveAction1: TAction;
    UserPropAction1: TAction;
    GroupPropAction1: TAction;
    UsersAction1: TAction;
    uGroupAction1: TAction;
    RightAction1: TAction;
    rGroupAction1: TAction;
    DeleteAction1: TAction;
    LoginAction1: TAction;
    PwAction1: TAction;
    uBankAction1: TAction;
    BakAction1: TAction;
    CarryAction1: TAction;
    EmpClientAction1: TAction;
    BosEmpAction16: TAction;
    MacPermit17: TAction;
    act1: TAction;
    ActiActorClientClass19: TAction;
    TreeViewCategory: TTreeView;
    DataSetRightTree: TADODataSet;
    procedure InitFrm(FrmId:String);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure exitBtnClick(Sender: TObject);
    procedure TreeBtnClick(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure SaveAction1Execute(Sender: TObject);
    procedure EditAction1Execute(Sender: TObject);
    procedure AddAction1Execute(Sender: TObject);
    function  GetParams(Params:String):Variant;
    procedure UsersAction1Execute(Sender: TObject);
    procedure uGroupAction1Execute(Sender: TObject);
    procedure RightAction1Execute(Sender: TObject);
    procedure rGroupAction1Execute(Sender: TObject);
    procedure DeleteAction1Execute(Sender: TObject);
    procedure LoginAction1Execute(Sender: TObject);
    procedure uBankAction1Execute(Sender: TObject);
    procedure CarryAction1Execute(Sender: TObject);
    procedure BakAction1Execute(Sender: TObject);
    procedure EmpClientAction1Execute(Sender: TObject);
    procedure BosEmpAction16Execute(Sender: TObject);
    procedure MacPermit17Execute(Sender: TObject);
    procedure myBar1DblClick(Sender: TObject);
    procedure ActiActorClientClass19Execute(Sender: TObject);
    procedure ControlBar1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TreeViewCategoryChange(Sender: TObject; Node: TTreeNode);
  private
    fDict:TTreeMgrDict;
    DBGrid1: TModelDbGrid;
  public
    { Public declarations }
  end;

const
  fCode='F01';
  fTreeId='F02';
  fName='F03';
  fHint='F04';
  fActions='F05';
  fDbGridId='F06';
  fBoxId='F07';
  fDataSetId='F08';
  fOpenParams='F11';
  fNodeFld='F12';

var
  TreeMgrFrm: TTreeMgrFrm;

implementation
uses datamodule,TabEditor,fncarry, MacPermit;
{$R *.DFM}

procedure TTreeMgrFrm.InitFrm(FrmId:String);
begin
  if Not FhlKnl1.Cf_GetDict_TreeMgr(FrmId,fdict) then Close;
  Self.Caption:=fDict.Caption;
  NodeDataSet1.Connection:=FhlKnl1.Connection;
  FhlKnl1.Cf_SetTreeView(fDict.TreeId,TreeView1,NodeDataSet1,null);
end;

procedure TTreeMgrFrm.Button1Click(Sender: TObject);
begin
 Close;
end;

procedure TTreeMgrFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TTreeMgrFrm.exitBtnClick(Sender: TObject);
begin
 close;
end;

procedure TTreeMgrFrm.TreeBtnClick(Sender: TObject);
begin
 GroupBox1.Visible:=TreeBtn.Down;
end;

procedure TTreeMgrFrm.ToolButton2Click(Sender: TObject);
begin
 if TreeView1.Selected.Level>0 then
    TreeView1.Selected.Parent.Selected:=true;
end;

function TTreeMgrFrm.GetParams(Params:String):Variant;
  var i:integer;
begin
  Result:=FhlKnl1.Vr_CommaStrToVarArray(Params);
  if Not VarIsNull(Result) then
     for i:=0 to VarArrayHighBound(Result,1) do
         if Result[i]='sParent' then
            Result[i]:=TStrPointer(TreeView1.Selected.Data)^+'_%'
         else
            Result[i]:=FhlUser.GetSysParamVal(Result[i]);

end;

procedure TTreeMgrFrm.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
 FhlKnl1.Vl_ClearChild(ScrollBox1);
  Screen.Cursor:=crSqlWait;
 try
  if NodeDataSet1.Locate(fCode,TStrPointer(Node.Data)^,[]) then     //locate the record
  begin
    FhlKnl1.Tb_CreateActionBtns(myBar1,ActionList1,NodeDataSet1.FieldByName(fActions).asString);     // create toolbutton
    mybar1.Visible:=mybar1.ButtonCount>0;
    FhlUser.SetDataSet(AdoDataSet1,NodeDataSet1.FieldByName(fDataSetId).asString,GetParams(NodeDataSet1.FieldByName(fOpenParams).asString));//set AdoDataSet1
    DbGrid1.Visible:=NodeDataSet1.FieldByName(fDbGridId).asString<>'-1';
    if DbGrid1.Visible then
    begin
        FhlUser.SetDbGrid(NodeDataSet1.FieldByName(fDbGridId).AsString,DbGrid1) ; // if have grid then initial the grid
        TreeViewCategory.Visible :=  ADODataSet1.FindField('Category')<> nil  ;
        if ADODataSet1.FindField('Category')<> nil then
        begin
              TreeViewCategory.Items.Clear;
              FhlKnl1.Cf_SetTreeView('22',TreeViewCategory,DataSetRightTree,null);
        end;
    end
    else
       FhlKnl1.Cf_SetBox(NodeDataSet1.FieldByName(fBoxId).asString,DataSource1,ScrollBox1,dmFrm.DbCtrlActionList1); //  if have not grid then initial the boxes
  end;
 finally
  Screen.Cursor:=crDefault;
 end;
 Panel1.Caption:=FhlKnl1.Tv_GetTreePath(Node);
end;

procedure TTreeMgrFrm.SaveAction1Execute(Sender: TObject);
begin
  AdoDataset1.Post;
  AdoDataSet1.UpdateBatch;
end;

procedure TTreeMgrFrm.EditAction1Execute(Sender: TObject);
begin
  FhlUser.ShowTabEditorFrm('TreeNode-'+self.NodeDataSet1.FieldByName(fCode).asString+'-'+TComponent(Sender).Name,null,Self.AdoDataSet1);
end;

procedure TTreeMgrFrm.AddAction1Execute(Sender: TObject);
  var f:String;
begin
  f:=trim(NodeDataSet1.FieldByName(fNodeFld).asString);
  if f<>'' then
    sDefaultVals:=f+'='+TStrPointer(TreeView1.Selected.Data)^;
  FhlUser.ShowTabEditorFrm('TreeNode-'+self.NodeDataSet1.FieldByName(fCode).asString+'-'+TComponent(Sender).Name,null,Self.AdoDataSet1,True);
end;

procedure TTreeMgrFrm.UsersAction1Execute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm('TreeMgr.'+self.NodeDataSet1.FieldByName(fCode).asString+'.'+TComponent(Sender).Name,AdoDataSet1.Fields[0].asString);
end;

procedure TTreeMgrFrm.uGroupAction1Execute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm('2',AdoDataSet1.FieldByName('LoginId').asString);
end;

procedure TTreeMgrFrm.RightAction1Execute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm('4',AdoDataSet1.FieldByName('Code').asString);
end;

procedure TTreeMgrFrm.rGroupAction1Execute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm('5',AdoDataSet1.FieldByName('Code').asString);
end;

procedure TTreeMgrFrm.LoginAction1Execute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm('6',AdoDataSet1.FieldByName('LoginId').asString);
end;

procedure TTreeMgrFrm.DeleteAction1Execute(Sender: TObject);
begin
  AdoDataSet1.Delete;
end;

procedure TTreeMgrFrm.uBankAction1Execute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm('8',AdoDataSet1.FieldByName('LoginId').asString);
end;

procedure TTreeMgrFrm.CarryAction1Execute(Sender: TObject);
begin
  with TfncarryFrm.Create(Application) do
  begin
    ShowModal;
    Free;
  end;
end;

procedure TTreeMgrFrm.BakAction1Execute(Sender: TObject);
var
  fto:widestring;
begin
  if dmFrm.SaveDialog1.Execute then
  begin
    fto:=dmFrm.SaveDialog1.FileName;
//  fto:='D:\Program Files\FhlSoft\JingBei\bak\%s.bak';
    Screen.Cursor:=crHourGlass;
    try
    dmFrm.GetQuery1(format('backup database %s to disk=''%s''',[dmFrm.ADOConnection1.DefaultDatabase,format(fto,[dmFrm.ADOConnection1.DefaultDatabase])]),False);
    FhlKnl1.Kl_GetQuery2(format('backup database %s to disk=''%s''',[FhlKnl1.Connection.DefaultDatabase,format(fto,[FhlKnl1.Connection.DefaultDatabase])]),False);
    finally
    Screen.Cursor:=crDefault;
    end;
    MessageDlg(#13#10'备份成功.',mtInformation,[mbOk],0);
  end;
end;

procedure TTreeMgrFrm.EmpClientAction1Execute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm('9',AdoDataSet1.FieldByName('LoginId').asString);
end;

procedure TTreeMgrFrm.BosEmpAction16Execute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm('10',AdoDataSet1.FieldByName('LoginId').asString);
end;

procedure TTreeMgrFrm.MacPermit17Execute(Sender: TObject);
begin
  with TMacPermitFrm.Create(Self) do
  try
    CheckBox1.Checked:=ADODataSet1.FieldByName('Permit').AsBoolean;
    Edit1.Text:=ADODataSet1.fieldbyname('note').asstring;
    ComboCategory.Text:=ADODataSet1.fieldbyname('Category').asstring;
    if ShowModal=mrOk then
    begin
    ADODataSet1.Edit;
    ADODataSet1.FieldByName('Permit').AsBoolean:=CheckBox1.Checked;
    ADODataSet1.fieldbyname('note').asstring:=Edit1.Text;
    ADODataSet1.fieldbyname('Category').asstring:= ComboCategory.Text;
    ADODataSet1.fieldbyname('CategoryCode').AsInteger := ComboCategory.ItemIndex ;
    ADODataSet1.Post;
    end;
  finally
    Release;
  end;
end;

procedure TTreeMgrFrm.myBar1DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin
// modeltpe:=Bill;
  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;

    CrtCom.mtDataSet1:= AdoDataSet1;
 //   CrtCom.ModelType :=ModelTreeMgrDict;
    CrtCom.TopOrBtm :=true;
    CrtCom.mtDataSetId  :=  NodeDataSet1.FieldByName(fDataSetId).asString;
    CrtCom.DlGridId :=  NodeDataSet1.FieldByName(fDbGridId).AsString;
    CrtCom.TOPBoxId :=  NodeDataSet1.FieldByName(fboxId).AsString;
    //CrtCom.FormId := FormId;
      try
          CrtCom.Show;
      finally

      end;
  end;


end;


procedure TTreeMgrFrm.ActiActorClientClass19Execute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm('10',AdoDataSet1.FieldByName('code').asString);
end;


procedure TTreeMgrFrm.ControlBar1Click(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin
// modeltpe:=Bill;
  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;

    CrtCom.mtDataSet1:= AdoDataSet1;
 //   CrtCom.ModelType :=ModelTreeMgrDict;
    CrtCom.TopOrBtm :=true;
    CrtCom.mtDataSetId  :=  NodeDataSet1.FieldByName(fDataSetId).asString;
    CrtCom.DlGridId :=  NodeDataSet1.FieldByName(fDbGridId).AsString;
    CrtCom.TOPBoxId :=  NodeDataSet1.FieldByName(fboxId).AsString;
    //CrtCom.FormId := FormId;
      try
          CrtCom.Show;
      finally

      end;
  end;


end;



procedure TTreeMgrFrm.FormCreate(Sender: TObject);
begin
  inherited;

  DBGrid1 :=   TModelDbGrid.Create(self);
  DBGrid1.PopupMenu := dmfrm.DbGridPopupMenu1;
  DBGrid1.Parent :=  self.ScrollBox1      ;
  DBGrid1.Align :=alclient;
  DBGrid1.DataSource := self.DataSource1 ;
  
end;

procedure TTreeMgrFrm.TreeViewCategoryChange(Sender: TObject;
  Node: TTreeNode);
var nodeStr, filterStr:string;
begin
  inherited;

  nodestr:= TStrPointer(Node.Data)^ ;
  filterStr :='Category = '+quotedstr(nodestr);
  self.ADODataSet1.Filter := '';
  if nodestr<>'' then
      self.ADODataSet1.Filter := filterStr;
  self.ADODataSet1.Filtered:=True;
//
end;

end.
