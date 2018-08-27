unit UnitDesignMainMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus,FhlKnl, ToolWin, ComCtrls,DB, ActnList, StdCtrls, Mask,
  DBCtrls, ADODB,StrUtils,UnitManageFrm;

type
  TfrmDesignMainMenu = class(TForm)
    ToolBar1: TToolBar;
    pmDesignMainMenu: TPopupMenu;
    N2: TMenuItem;
    ToolButton1: TToolButton;
    NCreateMenuItem: TMenuItem;
    grp1: TGroupBox;
    btnsave: TButton;
    btncancel: TButton;
    btndelete: TButton;
    btnadd: TButton;
    mmMain: TMainMenu;
    Label1: TLabel;
    DBCheckBox1: TDBCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBCheckBox2: TDBCheckBox;
    Label9: TLabel;
    Label11: TLabel;
    actlst1: TActionList;
    actSelectMenuItem: TAction;
    lbl1: TLabel;
    edtMenuName: TEdit;
    cbb1: TComboBoxEx;
    dsOPerateMenu: TADODataSet;
    cbb2: TComboBox;
    dbedt1: TDBEdit;
    ds2: TDataSource;
    dbedt2: TDBEdit;
    dbedt3: TDBEdit;
    dbedt4: TDBEdit;
    dbedt5: TDBEdit;
    dbedt6: TDBEdit;
    dbedt7: TDBEdit;
    dbedt8: TDBEdit;
    dbedt9: TDBEdit;
    dbedt11: TDBEdit;
    dblkcbbSysDb: TDBLookupComboBox;
    dbchkIsTool: TDBCheckBox;
    procedure N2Click(Sender: TObject);
    procedure actSelectMenuItemExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dsDateSourceMenuStateChange(Sender: TObject);
    procedure btnaddClick(Sender: TObject);
    procedure btncancelClick(Sender: TObject);
    procedure btndeleteClick(Sender: TObject);
    procedure btnsaveClick(Sender: TObject);
    procedure cbb1Click(Sender: TObject);
    procedure cbb2Click(Sender: TObject);
    procedure dsDateSourceMenuDataChange(Sender: TObject; Field: TField);
    procedure dbedt4Change(Sender: TObject);
    procedure ds2DataChange(Sender: TObject; Field: TField);

  private
    { Private declarations }
  public
    { Public declarations }
    
  end;

var
  frmDesignMainMenu: TfrmDesignMainMenu;

implementation
    uses desktop, datamodule, main,Upublic;
{$R *.dfm}

procedure TfrmDesignMainMenu.N2Click(Sender: TObject);
 var
  myItem,fItem:TMenuItem;
  i:integer;
  MenuId:string;
    dt:TDataSet;
begin
// InitMenu
//  FhlUser.SetDataSet(dmFrm.FreeDataSet1,'526',LoginInfo.LoginId);      //Sys_GetMainMenu ȡ��Ӧ����ʾ�Ĳ˵�
 // FhlKnl1.Cf_SetMainMenu('1',mmMain,ToolBar1,DesktopFrm.ActionList1,dmFrm.FreeDataSet1);       //���ɲ˵�

  MenuId:='1'   ;

  fItem:=nil;
  mmmain.Items.Clear;
  FhlKnl1.Tb_ClearTlBtn(ToolBar1);

    FhlKnl1.Kl_GetQuery2('select * from '+logininfo.SysDBPubName +'.dbo.T511'+ '  where  f01 not like '+quotedstr('%-%')+'  and F03='+quotedstr(MenuId)+'  order by F01 ');        //ϵͳ�˵�
    dt:=FhlKnl1.FreeQuery;


  with dt do
  begin
   while not eof do
   begin
    //Self
    myItem:=TMenuItem.Create(mmMain);

    myItem.Name:=FieldByName('F01').asString;
    if       FieldByName('F04').asString='-' then
    myItem.Caption:='============'
    else
    myItem.Caption:=FieldByName('F04').asString;
    myItem.Tag:=FieldByName('F06').asInteger;    //fromId
   // myItem.ShortCut:=TextToShortCut(FieldByName('F07').asString);
    myItem.ImageIndex:=FieldByName('F08').asInteger;
    myItem.Hint:=FieldByName('F09').asString;
    myItem.GroupIndex:=FieldByName('F13').asInteger;


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
    i:=FieldByName('F05').asInteger;
    if  (i<DesktopFrm.ActionList1.ActionCount) then
    begin


      myItem.OnClick:=actlst1[0].OnExecute;

      // myItem.Caption:=myItem.Caption  +',tag'+inttostr(myItem.tag )+',Alstix ' +inttostr(i); //test
    end;
    //
    if FieldByName('F10').asBoolean then
    begin
      with TToolButton.Create(ToolBar1) do  //��ݼ�
      begin
        Parent:=ToolBar1;
        Caption:=FieldByName('F11').asString;
        ImageIndex:=myItem.ImageIndex;
        Tag:=myItem.Tag;
       // OnClick:=myItem.OnClick;
      end;
    end;
    next;
   end;
   close;
  end;
end;


procedure TfrmDesignMainMenu.actSelectMenuItemExecute(Sender: TObject);
var name:string;
begin
name:=  trim( Tmenuitem(sender).name);


    if name<>'' then
    begin

    FhlKnl1.Ds_OpenDataSet(dsOPerateMenu,name);
//    dsOPerateMenu.Locate('f01',name,[]);
    end

    else
    showmessage('�ؼ���Ϊ��!');
end;

procedure TfrmDesignMainMenu.FormCreate(Sender: TObject);
 

var i:integer;
var SysDbSource:Tdatasource;
    sysDbSet:Tadodataset;
begin

    SysDbSource:=Tdatasource.Create (self);
    sysDbSet:=Tadodataset.Create (self);
    SysDbSource.DataSet :=sysDbSet;
    sysDbSet.Connection :=fhlknl1.Connection ;
    sysDbSet.CommandText :='select *From T800 ' ;
    sysDbSet.Open ;
    dblkcbbSysDb.ListSource :=  SysDbSource;
    dblkcbbSysDb.KeyField  :='F01';
    dblkcbbSysDb.ListField :='F02';

dsOPerateMenu.Connection :=fhlknl1.Connection ;
N2Click(sender);


for i:=0 to dmFrm.ImageList1.Count -1 do
begin
    cbb1.ItemsEx.Add ;
    cbb1.ItemsEx.Items [i].ImageIndex :=i;
end;
for i:=0 to desktopfrm.ActionList1.ActionCount -1  do
begin

cbb2.Items.Add  (            desktopfrm.ActionList1[i].Name) ;
end;

self.Caption :=   fhlknl1.Connection.DefaultDatabase ;
end;

procedure TfrmDesignMainMenu.dsDateSourceMenuStateChange(Sender: TObject);
begin
   {dsInactive, dsBrowse,     dsEdit,     dsInsert,
    dsSetKey,   dsCalcFields, dsFilter,    dsNewValue,
    dsOldValue, dsCurValue,   dsBlockRead, dsInternalCalc,
    dsOpening}

end;

procedure TfrmDesignMainMenu.btnaddClick(Sender: TObject);
begin
     edtMenuName.Text :=  dbedt1.Text ;

      FhlKnl1.Ds_OpenDataSet(dsOPerateMenu,edtMenuName.Text );
      dsOPerateMenu.Append;

      if isinteger(rightstr(edtMenuName.Text,2)) then
      dbedt1.Text :=leftstr(edtMenuName.Text ,length(edtMenuName.Text )-2)+ format('%.2d',[ strtoint( rightstr(edtMenuName.Text,2))+1 ]) ;

      DBCheckBox1.Checked :=true;
      DBCheckBox2.Checked :=true;
      dbedt8.Text :='-1';
      dbedt2.Text :='1';
      dbedt4.Text :='1';

      dbedt11.Text :='1';


end;
procedure TfrmDesignMainMenu.btncancelClick(Sender: TObject);
begin
dsOPerateMenu.Cancel;
end;

procedure TfrmDesignMainMenu.btndeleteClick(Sender: TObject);
begin
if MessageBox(0, 'ȷ��Ҫɾ��?', '', MB_YESNO + MB_ICONQUESTION) = IDYES then
begin
    try
       dsOPerateMenu.Delete;
       showmessage('ok' );
    except
       on err:exception do
       showmessage(err.Message );
    end;
end;





end;

procedure TfrmDesignMainMenu.btnsaveClick(Sender: TObject);
begin
try
dsOPerateMenu.Post ;
showmessage('OK');
except
     on err:exception do
    showmessage(err.message);
end;
end;

procedure TfrmDesignMainMenu.cbb1Click(Sender: TObject);
begin
//if    dsOPerateMenu.State in[ dsEdit,     dsInsert] then
   dbedt7.Text :=inttostr(cbb1.ItemIndex );

end;

procedure TfrmDesignMainMenu.cbb2Click(Sender: TObject);
var FrmManageFrm:TFrmManageFrm;
var UserDb:string;
begin


if dsOPerateMenu.FieldByName('f14').asstring<>'' then
begin
      UserDb:=  fhlknl1.UserConnection.DefaultDatabase ;

      if  not dsOPerateMenu.FieldByName('F15').AsBoolean  then
      begin
           fhlknl1.Connection.DefaultDatabase :=dblkcbbSysDb.Text  ;
           fhlknl1.UserConnection.DefaultDatabase :=dblkcbbSysDb.Text ;
      end
      else
      begin
             fhlknl1.UserConnection.DefaultDatabase :=logininfo.SysDBToolName ;
           fhlknl1.Connection.DefaultDatabase :=logininfo.SysDBToolName ;

      end;


      dbedt4.Text :=  inttostr(cbb2.ItemIndex);

      FrmManageFrm:=TFrmManageFrm.Create (nil,cbb2.ItemIndex);
      FrmManageFrm.edtFromID.Text := dbedt5.Text ;
      FrmManageFrm.ShowModal;


      
      fhlknl1.UserConnection.DefaultDatabase:=UserDb ;
      self.Caption :=  fhlknl1.Connection.DefaultDatabase ;
end
else
showmessage('����ѡ����ϵͳ��');
end;




procedure TfrmDesignMainMenu.dsDateSourceMenuDataChange(Sender: TObject;
  Field: TField);
begin

   if DBEdt1.Text <>'' then
    edtMenuName.Text := DBEdt1.Text ;

if DBEdt4.Text<>'' then
cbb2.ItemIndex :=  strtoint(DBEdt4.Text);
if DBEdt7.Text<>'' then
cbb1.ItemIndex      :=  strtoint(DBEdt7.Text);
   { }
end;



procedure TfrmDesignMainMenu.dbedt4Change(Sender: TObject);
begin
if DBEdt4.Text<>'' then
cbb2.ItemIndex  :=  strtoint(DBEdt4.Text);
end;

procedure TfrmDesignMainMenu.ds2DataChange(Sender: TObject; Field: TField);

begin
self.Caption :=   self.Caption+'a';
end;

end.
