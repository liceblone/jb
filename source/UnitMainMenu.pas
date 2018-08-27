unit UnitMainMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, DB, ADODB, ActnList, ComCtrls, ToolWin, FhlKnl;

type
  TFrmMainMenu = class(TForm)
    ToolBar: TToolBar;
    SavBtn: TToolButton;
    CelBtn: TToolButton;
    btn2: TToolButton;
    AddBtn: TToolButton;
    CpyBtn: TToolButton;
    editBtn: TToolButton;
    DelBtn: TToolButton;
    btn3: TToolButton;
    FirstBtn: TToolButton;
    PriorBtn: TToolButton;
    NextBtn: TToolButton;
    LastBtn: TToolButton;
    btn4: TToolButton;
    ExtBtn: TToolButton;
    ADODataSet1: TADODataSet;
    DataSource1: TDataSource;
    mmmain: TMainMenu;
    pnlMain: TPanel;
    s1: TMenuItem;
    ToolBarMain: TToolBar;
    ActionList1: TActionList;
    actAddAction: TAction;
    actCopyAction: TAction;
    actEditAction: TAction;
    actDeleteAction: TAction;
    actSaveAction: TAction;
    actCancelAction: TAction;
    actFirstAction: TAction;
    actPriorAction: TAction;
    actNextAction: TAction;
    actLastAction: TAction;
    actCloseAction: TAction;
    actPrintAction: TAction;
    actSetCaptionAction: TAction;
    actInputTaxAmt: TAction;
    PrintBtn: TToolButton;
    SelectMenu: TAction;
    ToolButton1: TToolButton;
    TbtnReflash: TToolButton;
    Frm: TToolButton;
    procedure CpyBtnClick(Sender: TObject);
    procedure actFirstActionExecute(Sender: TObject);
    procedure actPriorActionExecute(Sender: TObject);
    procedure actNextActionExecute(Sender: TObject);
    procedure actLastActionExecute(Sender: TObject);
    procedure actCloseActionExecute(Sender: TObject);
    procedure actSaveActionExecute(Sender: TObject);
    procedure actCancelActionExecute(Sender: TObject);
    procedure actCopyActionExecute(Sender: TObject);
    procedure actEditActionExecute(Sender: TObject);
    procedure actDeleteActionExecute(Sender: TObject);
    procedure SetEditState(CanEdit:Boolean);
    procedure InitFrm(EditorId:string;fOpenParams:Variant;fDataSet:TDataSet);
    procedure CreateMenu(Sender: TObject);
    procedure SelectMenuExecute(Sender: TObject);
    procedure ToolBarDblClick(Sender: TObject);
    procedure actAddActionExecute(Sender: TObject);
    procedure TbtnReflashClick(Sender: TObject);
    procedure FrmClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     fDict:TEditorDict;
  end;

var
  FrmMainMenu: TFrmMainMenu;

implementation
            uses datamodule,UnitCreateComponent,TreeGrid;
{$R *.dfm}
procedure TFrmMainMenu.InitFrm(EditorId:string;fOpenParams:Variant;fDataSet:TDataSet);
var
  ftabs:TStringList;
  i:integer;
begin
  if Not FhlKnl1.Cf_GetDict_Editor(EditorId,fdict) then Close;
    //2006-7-26加toolbutton

if (trim(fDict.Actions)<>''  ) and   (trim(fDict.Actions)<>'-1' )then
  FhlKnl1.Tb_CreateActionBtns(ToolBar,self.ActionList1  ,fDict.Actions,false);


  self.Width :=  fDict.Width;
  height:=fDict.Height;

  Caption:=fDict.Caption;
  CpyBtn.Visible:=Not (fDict.CpyFlds='');
  if fDataSet<>nil then
    DataSource1.DataSet:=fDataSet
  else
    FhlUser.SetDataSet(AdoDataSet1,fDict.DataSetId,fOpenParams);

  ftabs:=TStringList.Create;
  ftabs.CommaText:=fDict.BoxIds;
  for i:=0 to ftabs.Count-1 do
      FhlKnl1.Cf_SetBox(ftabs.Strings[i],DataSource1,pnlMain,dmFrm.DbCtrlActionList1);

  SetEditState(false);

  ftabs.Free;

  self.CreateMenu(self);
end;

procedure TFrmMainMenu.CreateMenu(Sender: TObject);
 var
  myItem,fItem:TMenuItem;
  i:integer;
  MenuId:string;
    dt:TDataSet;
begin

  MenuId:='1'   ;
  fItem:=nil;
  mmmain.Items.Clear;
  FhlKnl1.Tb_ClearTlBtn(ToolBarMain);
 
  FhlKnl1.Kl_GetQuery2('select * from '+ LoginInfo.SysDBPubName +'.dbo.T511'+ '  where    f01 not like '+quotedstr('%-%')+'  and F03='+quotedstr(MenuId)+'  order by F01 ');        //系统菜单
  dt:=FhlKnl1.FreeQuery;


  with dt do
  begin
   while not eof do
   begin
    //Self
    myItem:=TMenuItem.Create(mmMain);

    myItem.Name:=FieldByName('F01').asString;
    if FieldByName('F04').asString<>'-' then
       myItem.Caption:=FieldByName('F04').asString
    else
       myItem.Caption:='-------';

    myItem.Tag:=FieldByName('F06').asInteger;    //fromId
    myItem.ShortCut:=TextToShortCut(FieldByName('F07').asString);
    myItem.ImageIndex:=FieldByName('F08').asInteger;
    myItem.Hint:=FieldByName('F09').asString;
    myItem.GroupIndex:=FieldByName('F13').asInteger;
    myItem.Checked :=FieldByName('F02').AsBoolean ;

     //Parent
    i:=length(myItem.Name);
    while i>1 do
    begin
          i:=i-1;
          fItem:=FhlKnl1.Mn_FindMainMenuItem(mmMain,copy(myItem.Name,1,i));
          if fItem<>nil then
          begin
              fItem.Add(myItem);
              Break;
          end;
    end;
 
    if fItem=nil then
       mmMain.Items.Add(myItem);
    //Event
//    i:=FieldByName('F05').asInteger;



      myItem.OnClick:=self.ActionList1[14].OnExecute;

      // myItem.Caption:=myItem.Caption  +',tag'+inttostr(myItem.tag )+',Alstix ' +inttostr(i); //test

    //
    if FieldByName('F10').asBoolean then
    begin
      with TToolButton.Create(ToolBarMain) do  //快捷键
      begin
        Parent:=ToolBarMain;
        if FieldByName('F11').asString<>'-' then
           Caption:=FieldByName('F11').asString
        else
           Caption:='-------';

        name:=myItem.Name ;
        onclick:=myItem.onClick ;
        ImageIndex:=myItem.ImageIndex;
        Tag:=myItem.Tag;

      end;
    end;
    next;
   end;
   close;
  end;    { }
end;

procedure TFrmMainMenu.SetEditState(CanEdit:Boolean);
  var 
  bkColor:TColor;
begin
     CelBtn.Enabled:=CanEdit;
     SavBtn.Enabled:=CelBtn.Enabled;
     FirstBtn.Enabled:=Not CanEdit;
     PriorBtn.Enabled:=FirstBtn.Enabled;
     NextBtn.Enabled:=FirstBtn.Enabled;
     LastBtn.Enabled:=FirstBtn.Enabled;
     ExtBtn.Enabled:=FirstBtn.Enabled;
        AddBtn.Enabled:=FirstBtn.Enabled;
        CpyBtn.Enabled:=FirstBtn.Enabled;
        editBtn.Enabled:=FirstBtn.Enabled;
        DelBtn.Enabled:=FirstBtn.Enabled;
        PrintBtn.Enabled:=FirstBtn.Enabled;
     if CanEdit then
        bkColor:=clWhite
     else
        bkColor:=clCream;


         FhlKnl1.Vl_SetCtrlStyle(bkColor,self.pnlMain ,CanEdit);


end;
procedure TFrmMainMenu.CpyBtnClick(Sender: TObject);
begin

  SetEditState(true);
  FhlKnl1.Ds_AssignValues(DataSource1.DataSet,FhlKnl1.Vr_CommaStrToVarArray(fDict.CpyFlds),FhlKnl1.Ds_GetFieldsValue(DataSource1.DataSet,fDict.CpyFlds),True,False);

 // FhlKnl1.Vl_FocueACtrl(self.pnlMain);
end;

procedure TFrmMainMenu.actFirstActionExecute(Sender: TObject);
begin
 DataSource1.DataSet.First;
end;

procedure TFrmMainMenu.actPriorActionExecute(Sender: TObject);
begin
 DataSource1.DataSet.Prior;
end;

procedure TFrmMainMenu.actNextActionExecute(Sender: TObject);
begin
 DataSource1.DataSet.Next;
end;

procedure TFrmMainMenu.actLastActionExecute(Sender: TObject);
begin
 DataSource1.DataSet.Last;
end;

procedure TFrmMainMenu.actCloseActionExecute(Sender: TObject);
begin
 Close;
end;

procedure TFrmMainMenu.actSaveActionExecute(Sender: TObject);
begin

if not ADODataSet1.FieldByName('F15').AsBoolean then
ADODataSet1.FieldByName('F16').Value :=null;


 DataSource1.DataSet.Post;

 SetEditState(DataSource1.DataSet.State<>dsBrowse);
end;

procedure TFrmMainMenu.actCancelActionExecute(Sender: TObject);
begin
DataSource1.DataSet.Cancel;
SetEditState(false);
end;

procedure TFrmMainMenu.actCopyActionExecute(Sender: TObject);
begin
 if fDict.CpyFlds='' then exit;
  SetEditState(true);
  FhlKnl1.Ds_AssignValues(DataSource1.DataSet,FhlKnl1.Vr_CommaStrToVarArray(fDict.CpyFlds),FhlKnl1.Ds_GetFieldsValue(DataSource1.DataSet,fDict.CpyFlds),true,False);
//  FhlKnl1.Vl_FocueACtrl(self.pnlMain );

end;

procedure TFrmMainMenu.actEditActionExecute(Sender: TObject);
begin

  if DataSource1.DataSet.IsEmpty then Exit;
  SetEditState(true);
  DataSource1.DataSet.Edit;
//  FhlKnl1.Vl_FocueACtrl(PageControl1.ActivePage);
end;

procedure TFrmMainMenu.actDeleteActionExecute(Sender: TObject);
begin
  if DataSource1.DataSet.IsEmpty then Exit;


  if not assigned(  Tadodataset(DataSource1.DataSet).BeforeDelete ) then
  begin
      if MessageBox(0, '确定删除？', '', MB_YESNO + MB_ICONQUESTION) = IDYES 
        then
      begin
          DataSource1.DataSet.Delete;
      end;
  end
  else
     DataSource1.DataSet.Delete;
end;

procedure TFrmMainMenu.SelectMenuExecute(Sender: TObject);
var name:string;
begin
name:=  trim( Tcomponent(sender).name);
self.Caption :=name;
    if name<>'' then
    begin
       self.DataSource1.DataSet.Locate('F01',name,[]);

       {if  (dsedit<> self.DataSource1.DataSet.State) then
       begin
         self.DataSource1.DataSet.Edit ;
         self.SetEditState(true);
       end;}
    end
    else
    showmessage('控键名为空!');

end;

procedure TFrmMainMenu.ToolBarDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin

  if LoginInfo.LoginId ='chy' then

  begin
    CrtCom:=TfrmCreateComponent.Create(self);

    CrtCom.FEditorDict  :=  fdict;
    CrtCom.ModelType :=Modeleditor;
    CrtCom.mtDataSet1:=ADODataSet1;
    CrtCom.mtDataSetId :=inttostr(Tadodataset(DataSource1.DataSet).tag);
    try
    CrtCom.Show;
    finally

    end;
  end;


end;

procedure TFrmMainMenu.actAddActionExecute(Sender: TObject);
begin
SetEditState(True);
  FhlUser.AssignDefault(DataSource1.DataSet,false);
if not (DataSource1.DataSet.State in [dsinsert] ) then
 DataSource1.DataSet.Append;




// FhlKnl1.Vl_FocueACtrl(self.pnlMain);
end;

procedure TFrmMainMenu.TbtnReflashClick(Sender: TObject);
begin
   self.CreateMenu(self);
end;

procedure TFrmMainMenu.FrmClick(Sender: TObject);
var id:integer;
var sysDb,FrmID:String;

Var TreeGridID:integer;
var UserdefaultDB:String;
var  TreeGridFrm:Tform;
     SysToolCnn,SysCnn,UserCnn:string;
begin
      id:= self.ADODataSet1.FieldByName('F05').AsInteger ;
      sysDb:= self.ADODataSet1.FieldByName('SysDataBaseLKP').AsString      ;
      FrmID:=self.ADODataSet1.FieldByName('F06').AsString      ;

      SysToolCnn:= 'Provider=SQLOLEDB.1;Password=Jbdata1;Persist Security Info=true;User ID=sa;Initial Catalog='+logininfo.SysDBToolName+';Data Source='+logininfo.IP;
      SysToolCnn:= SysToolCnn+';Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID=chypc;Use Encryption for Data=False;Tag with column collation when possible=False';
      SysCnn:= fhlknl1.Connection.ConnectionString ;
      UserCnn:= dmfrm.ADOConnection1.ConnectionString ;

  if (sysDb<>'') and (inttostr(id)<>'') then  begin
       logininfo.IsTool :=true;
       UserdefaultDB:=dmfrm.ADOConnection1.DefaultDatabase ;
       dmfrm.ADOConnection1.DefaultDatabase :=sysDb  ;

       fhlknl1.UserConnection.DefaultDatabase  :=sysDb ;


       fhlknl1.Connection.Close;
       fhlknl1.Connection.ConnectionString :=SysToolCnn ;
       fhlknl1.Connection.DefaultDatabase :=logininfo.SysDBToolName ;

       self.Caption :=  fhlknl1.Connection.DefaultDatabase ;

       case  id  of
       0:begin
            TreeGridID:= 38;
       end;
       1:begin
            TreeGridID:= 37;
       end;
       2:begin
             TreeGridID:= 36;
       end;
       3:begin
            TreeGridID:= 40;
       end;
       4:begin

       end;
       7:begin
            TreeGridID:= 39;
       end;
       8:begin

            TreeGridID:= 41;
       end;
       23:begin

            TreeGridID:=  52;
        end;
        27:begin
            TreeGridID:= 38;
           end;
        31:begin
             TreeGridID:= 58;
           end;
        32:begin
             TreeGridID:= 59;
           end;
       end;


    if TreeGridID<>0 then
    begin
        if FrmID='' then FrmID:='1';
        TreeGridFrm:=FhlUser.ShowModalTreeGridFrm(inttostr(TreeGridID) ,FrmID,true);
        TreeGridFrm.ShowModal ;

        if self.ADODataSet1.FieldByName('F06').AsString='' then
        begin
            editBtn.Click ;
            if (TTreeGridFrm(TreeGridFrm).ADODataSet1.fieldbyname('F01')<>nil ) then
                self.ADODataSet1.FieldByName('F06').AsString := TTreeGridFrm(TreeGridFrm).ADODataSet1.fieldbyname('F01').AsString ;
        end;

    end; 
         dmfrm.ADOConnection1.DefaultDatabase :=UserdefaultDB;
    fhlknl1.UserConnection.DefaultDatabase :=UserdefaultDB;//sysDb ;
       fhlknl1.Connection.DefaultDatabase :=sysDb;//logininfo.SysDBToolName ;

      
  end
  else
  showmessage('请先选择子系统名');
   {}
end;


procedure TFrmMainMenu.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure TFrmMainMenu.FormCreate(Sender: TObject);
begin
logininfo.IsTool:=true;
end;

end.
