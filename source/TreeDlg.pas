unit TreeDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, ADODB, FhlKnl;


type
  TTreeDlgFrm = class(TForm)
    TreeView1: TTreeView;
    okBtn: TButton;
    Button2: TButton;
    ADODataSet1: TADODataSet;
    CheckBox1: TCheckBox;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure TreeView1DblClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    fDict:TTreeDlgDict;
  public
    procedure InitFrm(Fld:TField);  overload;
    procedure InitFrm(DataSetID: string;aParam:variant;Isopen:boolean;CodeFldName,NameFldName:string;showCode:boolean);overload;

  end;

var
  TreeDlgFrm: TTreeDlgFrm;

implementation
uses datamodule;
{$R *.dfm}

procedure TTreeDlgFrm.InitFrm(Fld:TField);
begin
   fDict.LkpFld:=Fld;
  if Not FhlKnl1.Cf_GetDict_TreeDlg(intTostr(fDict.LkpFld.tag),fdict) then Close;
   Caption:=fDict.Caption;
   FhlKnl1.Tv_NewDataNode(TreeView1,nil,'',fDict.RootText,6,6);
   FhlKnl1.Cf_ListAllNode(Fld.LookupDataSet,TreeView1,20,0,fDict.CodeFldName,fDict.NameFldName);
   with TreeView1.Items.GetFirstNode do
   begin
     Expand(fDict.IsExpand);
     if GetFirstChild<>nil then
        GetFirstchild.Expand(False);
   end;
   //定位原有值
      if fDict.LkpFld.AsString<>'' then
         FhlKnl1.Tv_FindNode(TreeView1,fDict.LkpFld.DataSet.FieldByName(fDict.LkpFld.KeyFields).AsString).Selected:=True;
end;

procedure TTreeDlgFrm.FormClose(Sender: TObject; var Action: TCloseAction);
var fldlst:TStrings;
var i:integer;
begin
  if ModalResult=mrOk then
  begin
       if assigned(fDict.LkpFld) then
       begin
           if  not CheckBox1.Checked then
           begin
               fDict.LkpFld.LookupDataSet.Locate(fDict.LkpFld.LookupKeyFields,TStrPointer(TreeView1.Selected.Data)^,[]);
               FhlKnl1.Ds_CopyValues(fDict.LkpFld.LookupDataSet,fDict.LkpFld.DataSet,fDict.LkpChgFldNames,fDict.ChgFldNames,False,False);
           end
           else
           begin
                fldlst:=TStringlist.Create ;
                fldlst.CommaText :=fDict.ChgFldNames;

                if  not  (fDict.LkpFld.DataSet.State in [dsinsert,dsedit] )then
                fDict.LkpFld.DataSet.Edit ;

                for i:=0 to    fldlst.Count-1 do
                begin
                     fDict.LkpFld.DataSet.FieldByName(fldlst[i]).Value :=null;
                end;
                //fDict.LkpFld.DataSet
                //fDict.ChgFldNames
           end;
       end;
  end;
end;

procedure TTreeDlgFrm.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
 OkBtn.Enabled:=(fDict.ParentSelect) or (not Node.HasChildren);

   


 if self.ADODataSet1.Active then
    ADODataSet1.Locate(fdict.CodeFldName ,TStrPointer(Node.Data)^ ,[]);


end;

procedure TTreeDlgFrm.TreeView1DblClick(Sender: TObject);
begin
 if Not TreeView1.Selected.HasChildren then
    ModalResult:=mrOk;
end;

procedure TTreeDlgFrm.InitFrm(DataSetID: string; aParam: variant;
  Isopen: boolean; CodeFldName, NameFldName: string; showCode: boolean);
begin
   fhluser.SetDataSet(self.ADODataSet1 ,datasetID,aParam,Isopen) ;
   FhlKnl1.Tv_NewDataNode(TreeView1,nil,'','全部',6,6);
   fdict.CodeFldName := CodeFldName;
   fdict.NameFldName := NameFldName;
   FhlKnl1.Cf_ListAllNode(ADODataSet1,TreeView1,20,0,CodeFldName,NameFldName,showCode);
   TreeView1.Items.GetFirstNode.Expand(true);
end;

procedure TTreeDlgFrm.CheckBox1Click(Sender: TObject);
begin
okBtn.Click ;
end;

end.
