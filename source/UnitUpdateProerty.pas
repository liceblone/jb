unit UnitUpdateProerty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,datamodule, ComCtrls,StrUtils, Menus, ExtCtrls;
type TcontrolEx=class(Tcontrol)  ;
type
  TFrmUpdateProperty = class(TForm)
    lbl1: TLabel;
    btnUpdate: TButton;
    edtCaption: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Editclick: TEdit;
    Editdbclick: TEdit;
    Editexit: TEdit;
    cmbclick: TComboBox;
    cmbdbclick: TComboBox;
    cmbexit: TComboBox;
    FontDialog1: TFontDialog;
    edtUpdateAction: TButton;
    BtnClearhint: TButton;
    pm1: TPopupMenu;
    F1: TMenuItem;
    B1: TMenuItem;
    dlgColor1: TColorDialog;
    P1: TMenuItem;
    btnRemove: TButton;
    btnRemoveCtrl: TButton;
    rg1: TRadioGroup;
    a1: TMenuItem;
    chkreadonly: TCheckBox;
    GrpLabel: TGroupBox;
    GrpCTRL: TGroupBox;
    procedure btnUpdateClick(Sender: TObject);
    procedure edtCaptionChange(Sender: TObject);
    procedure edtUpdateActionClick(Sender: TObject);
    procedure cmbclickClick(Sender: TObject);
    procedure cmbdbclickClick(Sender: TObject);
    procedure cmbexitClick(Sender: TObject);
    procedure BtnClearhintClick(Sender: TObject);
    procedure F1Click(Sender: TObject);
    procedure B1Click(Sender: TObject);
    procedure P1Click(Sender: TObject);
    procedure lbl1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnRemoveCtrlClick(Sender: TObject);
    procedure rg1Click(Sender: TObject);
    procedure a1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkreadonlyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Acontrol:    Tcontrol;
  end;

var
  FrmUpdateProperty: TFrmUpdateProperty;

implementation
         uses upublic ,upublicCtrl;
{$R *.dfm}

procedure TFrmUpdateProperty.btnUpdateClick(Sender: TObject);
begin
    if  Acontrol is Tlabel then
    begin
        Tlabel( Acontrol ).Caption := lbl1.Caption ;//  edtCaption.Text ;
        Tlabel( Acontrol ).Font :=lbl1.Font ;
        Tlabel( Acontrol ).Color :=  lbl1.Color ;
    end;
    
   if Acontrol is TEdit_mtn then
   begin 
        TEdit_mtn( Acontrol ).Font.Assign (lbl1.Font );
   end;
end;

procedure TFrmUpdateProperty.edtCaptionChange(Sender: TObject);
begin
if  Acontrol is Tlabel then
 lbl1.Caption :=  edtCaption.Text ;
   
end;

procedure TFrmUpdateProperty.edtUpdateActionClick(Sender: TObject);
begin
       if  Acontrol is Tedit_Mtn then
    begin
          if length( Tedit( Acontrol).Hint)<=4 then
              Tedit_Mtn( Acontrol).Hint := Tedit( Acontrol).Hint+ ','+ Editclick.Text   +','+Editdbclick.Text + ','+Editexit.Text
          else
              Tedit_Mtn( Acontrol).Hint :=leftstr( trim(Tedit( Acontrol).Hint),4)+ ','+ Editclick.Text   +','+Editdbclick.Text + ','+Editexit.Text;
    end;
end;

procedure TFrmUpdateProperty.cmbclickClick(Sender: TObject);
begin
       Editclick.Text :=inttostr(Tcombobox(Sender).ItemIndex );
end;

procedure TFrmUpdateProperty.cmbdbclickClick(Sender: TObject);
begin
  Editdbclick.Text :=inttostr(Tcombobox(Sender).ItemIndex );
edtUpdateAction.Click ;
end;

procedure TFrmUpdateProperty.cmbexitClick(Sender: TObject);
begin
 Editexit.Text :=inttostr(Tcombobox(Sender).ItemIndex );
end;

procedure TFrmUpdateProperty.BtnClearhintClick(Sender: TObject);
begin
       if  Acontrol is Tedit then
    begin
        Tedit( Acontrol).Hint := '';//Tedit( Acontrol).Hint+ ','+ Editclick.Text   +','+Editdbclick.Text + ','+Editexit.Text  ;
    end;
end;

procedure TFrmUpdateProperty.F1Click(Sender: TObject);
begin
   if FontDialog1.Execute then
      lbl1.Font := FontDialog1.Font ;

      btnUpdate.Click ;
end;

procedure TFrmUpdateProperty.B1Click(Sender: TObject);
begin
if  dlgColor1.Execute then
    lbl1.Color :=dlgColor1.Color ;

    btnUpdate.Click ;
end;

procedure TFrmUpdateProperty.P1Click(Sender: TObject);
begin
     lbl1.Color :=self.Color ;
     btnUpdate.Click ;
end;

procedure TFrmUpdateProperty.lbl1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var pp:Tpoint;
begin
GetCursorPos(pp);
pm1.Popup(pp.x,pp.y);
end;

procedure TFrmUpdateProperty.btnRemoveClick(Sender: TObject);
begin
Acontrol.Free ;
end;

procedure TFrmUpdateProperty.btnRemoveCtrlClick(Sender: TObject);
begin
Acontrol.Free ;
end;

procedure TFrmUpdateProperty.rg1Click(Sender: TObject);
begin
Acontrol.Tag :=  rg1.itemindex;
edtUpdateAction.Click ;
end;

procedure TFrmUpdateProperty.a1Click(Sender: TObject);
begin
lbl1.Color :=stringtocolor('clCream');
btnUpdate.Click ;
end;

procedure TFrmUpdateProperty.FormCreate(Sender: TObject);
var i:integer;
begin


if self.Acontrol is tlabel then
 GrpLabel.Visible :=true
else
   GrpCTRL.Visible  :=true;



for i:= 0 to    dmfrm.dbCtrlActionList1.ActionCount-1 do
begin
    cmbclick.Items.Add(dmfrm.dbCtrlActionList1.Actions [i].Name ) ;
    cmbdbclick.Items.Add(dmfrm.dbCtrlActionList1.Actions [i].Name ) ;
    cmbexit.Items.Add(dmfrm.dbCtrlActionList1.Actions [i].Name ) ;
end;
//dbCtrlActionList1

    if  Acontrol is Tlabel then
    begin
       lbl1.Color :=  Tlabel( Acontrol ).Color ;
    end;

   if  Acontrol is Tedit_Mtn then
    begin
       self.chkreadonly.Checked:=  Tedit_Mtn( Acontrol ).ReadOnly  ;
    end;

end;

procedure TFrmUpdateProperty.chkreadonlyClick(Sender: TObject);
begin
 if  Acontrol is Tedit_Mtn then
    ( Acontrol as Tedit_Mtn  ).ReadOnly :=chkreadonly.Checked;
end;

end.



