unit TreeEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, StdCtrls, ExtCtrls, Db, dbctrls, Mask, ImgList, ADODB,StrUtils,
  Grids, DBGrids, Variants, FhlKnl,UnitModelFrm,UnitCreateComponent, UPublicFunction;

type
  TTreeEditorFrm = class(TFrmModel)
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    SetBtn: TToolButton;
    PrtBtn: TToolButton;
    PreBtn: TToolButton;
    ToolButton5: TToolButton;
    Addbtn: TToolButton;
    ChgBtn: TToolButton;
    DelBtn: TToolButton;
    ToolButton9: TToolButton;
    CleBtn: TToolButton;
    SavBtn: TToolButton;
    ToolButton12: TToolButton;
    rfsBtn: TToolButton;
    hlpBtn: TToolButton;
    ExtBtn: TToolButton;
    TreeView1: TTreeView;
    Splitter1: TSplitter;
    DataSource1: TDataSource;
    ScrollBox1: TScrollBox;
    DBGrid1: TDBGrid;
    Splitter2: TSplitter;
    ADODataSet1: TADODataSet;
    expBtn: TToolButton;
    btnSubAdd: TToolButton;
//    procedure InitFrm(FrmId:String);
    procedure InitFrm(FrmId:String;AParams:Variant;Model:boolean=false);
    procedure SavBtnClick(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure rfsBtnClick(Sender: TObject);
    procedure AddbtnClick(Sender: TObject);
    procedure ExtBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CleBtnClick(Sender: TObject);
    procedure ChgBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    function  CheckIsSaved:Boolean;
    procedure TreeView1Changing(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure PreBtnClick(Sender: TObject);
    procedure SetCtrlCanEdit(CanEdit:Boolean;bkColor:TColor);
    procedure expBtnClick(Sender: TObject);
    procedure ExpNodesAndHideCode;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PrtBtnClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure ToolBar1DblClick(Sender: TObject);
    procedure btnSubAddClick(Sender: TObject);
  private
    fDict:TTreeEditorDict;
  public

  end;

var
  TreeEditorFrm: TTreeEditorFrm;

implementation

uses datamodule,RepGrid;

{$R *.DFM}

procedure TTreeEditorFrm.InitFrm(FrmId:String;AParams:Variant;Model:boolean=false);
begin
  if Not FhlKnl1.Cf_GetDict_TreeEditor(FrmId,fdict) then Close;
  self.Caption:=fDict.FrmCaption;
  FhlUser.SetDbGridAndDataSet(dbGrid1,fDict.DbGridId,Null,true);
  FhlKnl1.Cf_SetBox(fDict.BoxId,DataSource1,ScrollBox1,dmFrm.DbCtrlActionList1);
  FhlKnl1.Tv_NewDataNode(Treeview1,nil,'',fDict.RootCaption,12,12);

  if  not Model then      //model  then  hide the code
       expBtnClick(expBtn)
  else
      ExpNodesAndHideCode;


  SetCtrlCanEdit(False,clCream);
  TreeView1.Items.GetFirstNode.Selected:=True;
end;

procedure TTreeEditorFrm.SavBtnClick(Sender: TObject);
 var c,s:String;
begin
  with AdoDataSet1 do
  begin
    Post;
    c:=fieldbyname(fDict.CodeFld).asString;
    s:=TStrPointer(TreeView1.Selected.Parent.Data)^;
  end;
  if (c<>s) and (copy(c,1,length(s))=s) then
  begin
    AdoDataSet1.UpdateBatch;
    TreeView1.Selected.Text:=AdoDataSet1.FieldByName(fDict.NameFld).asString+'['+AdoDataSet1.FieldByName(fDict.CodeFld).asString+']';
    TStrPointer(TreeView1.Selected.Data)^:=AdoDataSet1.FieldByName(fDict.CodeFld).asString;
    SetCtrlCanEdit(False,clCream);
  end else
  begin
    AdoDataSet1.Edit;
    MessageDlg(#13#10+'该编码与其父项编码在规则编排上不一致,请重试!',mtWarning,[MbOK],0)
  end;
end;


procedure TTreeEditorFrm.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
// AdoDataset1.Locate(fDict.CodeFld,TStrPointer(Node.Data)^,[]);
// ChgBtn.Enabled:=Node.Level<>0;
// DelBtn.Enabled:=ChgBtn.Enabled and Not Node.HasChildren;

     if  AdoDataset1.FindField(fDict.CodeFld)     <>nil then
    begin
     if TStrPointer(Node.Data)^<>'' then
     AdoDataset1.Locate(fDict.CodeFld,TStrPointer(Node.Data)^,[]);
     ChgBtn.Enabled:=Node.Level<>0;
     DelBtn.Enabled:=ChgBtn.Enabled and Not Node.HasChildren;
     Addbtn.Enabled := Node.Level<>0;
    end;

end;

procedure TTreeEditorFrm.rfsBtnClick(Sender: TObject);
begin
  AdoDataSet1.Close;
  AdoDataSet1.Open;
  ExpBtnClick(ExpBtn);
end;

procedure TTreeEditorFrm.AddbtnClick(Sender: TObject);
var s,n:String;
    i:integer;
begin
      if not ( ADODataSet1.State  in [ dsEdit, dsInsert]) then
      begin

           n:='新建名称';
           s:=TStrPointer(TreeView1.Selected.Parent.GetLastChild.Data  )^   ;
           i:=pos('Sys',s);

           if I>0 then
           s:=rightstr(s,length(s)- 3);

           if length(s)>1 then
             if  isinteger( rightstr(s,2)) then
               if length(inttostr(strtoint(rightstr(s,2))+1))=1   then
                  s:= leftstr(s,length(s)-2) + format('0%s',[inttostr(strtoint(rightstr(s,2))+1)])
               else
                  s:= leftstr(s,length(s)-2) + inttostr(strtoint(rightstr(s,2))+1);


           FhlKnl1.Tv_NewDataNode(TreeView1,TreeView1.Selected.Parent    ,'',n,35,34).Selected:=True;
           SetCtrlCanEdit(True,clWhite);
           FhlKnl1.Ds_AssignValues(AdoDataSet1,varArrayof([fDict.CodeFld,fDict.NameFld]),varArrayof([s,n]),True,False);
           FhlKnl1.Vl_FocueACtrl(ScrollBox1);
     end;



   //      FhlKnl1.Tv_NewDataNode(TreeView1,TreeView1.Selected  ,'',n,35,34).Selected:=True;

end;

procedure TTreeEditorFrm.ExtBtnClick(Sender: TObject);
begin
 Close;
end;

procedure TTreeEditorFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if CheckIsSaved then
    Action:=caFree
 else
    Action:=caNone;
end;

function  TTreeEditorFrm.CheckIsSaved:Boolean;
  var i:integer;
begin
 Result:=true;
 if SavBtn.Enabled then
 begin
    i:=MessageDlg(fsDbChanged,mtConfirmation,mbYesNoCancel,0);
    if i=mrYes then
       SavBtnClick(SavBtn)
    else if i=mrNo then
       CleBtnClick(CleBtn)
    else
       Result:=false;
 end;
end;

procedure TTreeEditorFrm.CleBtnClick(Sender: TObject);
begin
 SetCtrlCanEdit(False,clCream);
 AdoDataSet1.CancelUpdates;
 if Not AdoDataSet1.Locate(fDict.CodeFld,TStrPointer(TreeView1.Selected.Data)^,[]) then
    TreeView1.Items.Delete(TreeView1.Selected);
end;

procedure TTreeEditorFrm.ChgBtnClick(Sender: TObject);
begin
 SetCtrlCanEdit(True,clWhite);
 DataSource1.DataSet.Edit;
 FhlKnl1.Vl_FocueACtrl(ScrollBox1);
end;

procedure TTreeEditorFrm.DelBtnClick(Sender: TObject);
begin
 if TreeView1.Selected.HasChildren or (TreeView1.Selected.Level=0) then
 begin
    MessageDlg(#13#10+'  非未级编码记录不能删除!          '+#13#10,mtWarning,[mbyes],0);
    Exit;
 end;
    try
     AdoDataSet1.Delete;
     AdoDataSet1.UpdateBatch;
     Treeview1.Selected.Delete;
    except
     AdoDataSet1.Close;
     AdoDataSet1.Open;
     expBtnClick(expBtn);
    end;
end;

procedure TTreeEditorFrm.TreeView1Changing(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin
 AllowChange:=CheckIsSaved;
end;

procedure TTreeEditorFrm.PreBtnClick(Sender: TObject);
begin
 DbGrid1.Visible:=Not DbGrid1.Visible;
 Splitter2.Visible:=Not Splitter2.Visible;
end;

procedure TTreeEditorFrm.SetCtrlCanEdit(CanEdit:Boolean;bkColor:TColor);
begin
  SavBtn.Enabled:=CanEdit;
  CleBtn.Enabled:=CanEdit;
  AddBtn.Enabled:=Not CanEdit;
  ChgBtn.Enabled:=Not CanEdit;
  DelBtn.Enabled:=Not CanEdit;
  FhlKnl1.Vl_SetCtrlStyle(bkColor,ScrollBox1,CanEdit);
end;

procedure TTreeEditorFrm.expBtnClick(Sender: TObject);
begin
 Treeview1.Items.GetFirstNode.DeleteChildren;
 FhlKnl1.Cf_ListAllNode(AdoDataSet1,TreeView1,35,34,fDict.CodeFld,fDict.NameFld);
 with TreeView1.Items.GetFirstNode do begin
      Expand(False);
      if GetFirstChild<>nil then GetFirstChild.Expand(False);
 end;
end;

procedure TTreeEditorFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case Key of
   vk_Return:begin
               if ssCtrl in Shift then
                  SavBtn.Click
               else
                  Perform(WM_NEXTDLGCTL, 0, 0);
             end;
   vk_Insert:begin
               if ssCtrl in Shift then
                  ChgBtn.Click
               else
                  AddBtn.Click;
             end;
   vk_Delete:begin
               if Not ((DataSource1.State=dsEdit) or (DataSource1.State=dsInsert)) then
                  DelBtn.Click;
             end;
 end;
end;

procedure TTreeEditorFrm.PrtBtnClick(Sender: TObject);
begin
 FhlUser.CheckRight(fdict.PrintRitId);
 FhlKnl1.Rp_DbGrid(intTostr(DbGrid1.Tag),DbGrid1);
end;

procedure TTreeEditorFrm.DBGrid1CellClick(Column: TColumn);
begin
 FhlKnl1.Tv_FindNode(TreeView1,AdoDataSet1.FieldByName(fDict.CodeFld).asString).Selected:=True;
end;

procedure TTreeEditorFrm.ToolBar1DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin
// modeltpe:=Bill;
 if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
  begin
      CrtCom:=TfrmCreateComponent.Create(self);
      CrtCom.mtDataSet1 :=self.ADODataSet1 ;
      CrtCom.fTreeEditorDict :=self.fDict ;
      CrtCom.ModelType :=ModelFrmTreeEditor;
      CrtCom.TopOrBtm :=true;

      try
          CrtCom.Show;
      finally

      end;

  end;


 { }

end;

procedure TTreeEditorFrm.btnSubAddClick(Sender: TObject);
 var s,n:String;
begin

      if not (ADODataSet1.State in  [dsinsert,dsedit]) then
      begin
         n:='新建名称';

         if  TreeView1.Selected.Level <>0 then
         begin
           if not TreeView1.Selected.HasChildren then
             begin
                 s:=TStrPointer(TreeView1.Selected.Data)^ ;
                 s:=s+'01';
             end
             else     {  }
             begin
                 s:=TStrPointer(TreeView1.Selected.GetLastChild.Data)^;
                 if length(s)>1 then
                   if  isinteger( rightstr(s,2)) then
                      if length(inttostr(strtoint(rightstr(s,2))+1))=1   then
                          s:= leftstr(s,length(s)-2) + format('0%s',[inttostr(strtoint(rightstr(s,2))+1)])
                       else
                          s:= leftstr(s,length(s)-2) + inttostr(strtoint(rightstr(s,2))+1);

              end;        
         end
         else
         begin
              s:=s+'01';

             if TreeView1.Selected.GetLastChild <>nil then
             begin
             s:=TStrPointer(TreeView1.Selected.GetLastChild.Data  )^   ;
             if length(s)>1 then
               if  isinteger( rightstr(s,2)) then
                 if length(inttostr(strtoint(rightstr(s,2))+1))=1   then
                    s:= leftstr(s,length(s)-2) + format('0%s',[inttostr(strtoint(rightstr(s,2))+1)])
                 else
                    s:= leftstr(s,length(s)-2) + inttostr(strtoint(rightstr(s,2))+1);

             end;
         end;

         FhlKnl1.Tv_NewDataNode(TreeView1,TreeView1.Selected  ,'',n,35,34).Selected:=True;
         SetCtrlCanEdit(True,clWhite);
         FhlKnl1.Ds_AssignValues(AdoDataSet1,varArrayof([fDict.CodeFld,fDict.NameFld]),varArrayof([s,n]),True,False);
         FhlKnl1.Vl_FocueACtrl(ScrollBox1);
      end;

end;
procedure TTreeEditorFrm.ExpNodesAndHideCode;
begin
 Treeview1.Items.GetFirstNode.DeleteChildren;
FhlKnl1.Cf_ListAllNode(AdoDataSet1,TreeView1,20,0,fDict.CodeFld,fDict.NameFld,false);
 with TreeView1.Items.GetFirstNode do begin
      Expand(False);
      if GetFirstChild<>nil then GetFirstChild.Expand(False);
 end;
end;

end.
