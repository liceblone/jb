unit UnitSetBarCodeQty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TfrmBarCodeQty = class(TForm)
    mmFQtyItems: TMemo;
    btnOK: TButton;
    Label1: TLabel;
    lblQty: TLabel;
    edtPackageCnt: TEdit;
    edtPackageQty: TEdit;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure mmFQtyItemsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mmFQtyItemsKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPackageQtyChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtPackageCntExit(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure edtPackageQtyExit(Sender: TObject);
    procedure UpDown2Click(Sender: TObject; Button: TUDBtnType);
    procedure edtPackageCntChange(Sender: TObject);
  private
    FQtyItems:string;
    FSumQty:double;
    FPackageQty:integer;

    procedure UpdateLabel;
    { Private declarations }
  public
    procedure initialData( value:string; packageQty:integer);
    procedure fillList;
    property QtyItems :string read FQtyItems;
    property SumQty  :double read FSumQty;
    property PackageQty  :integer read FPackageQty;
    { Public declarations }
  end;

var
  frmBarCodeQty: TfrmBarCodeQty;

implementation

{$R *.dfm}

procedure TfrmBarCodeQty.mmFQtyItemsKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
  UpdateLabel;
end;

procedure TfrmBarCodeQty.mmFQtyItemsKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (key in ['0'..'9',#13,#8]) then
     key:=#0;
end;

procedure  TfrmBarCodeQty.InitialData(value:string; packageQty:integer);
begin
  self.mmFQtyItems.Lines.CommaText :=  stringreplace( value , '+', ',', [rfReplaceAll]);
  self.edtPackageCnt.Text := inttostr(packageQty);
  UpdateLabel;
end;

procedure TfrmBarCodeQty.UpdateLabel;
var i:integer;
var value:double;
begin
  value:=0;
  for i:=self.mmFQtyItems.Lines.Count-1 downto  0 do
  begin
     if (trim(mmFQtyItems.Lines[i])='' ) then
         mmFQtyItems.Lines.Delete(i);
  end;
  for i:=0 to self.mmFQtyItems.Lines.Count-1 do
  begin
       value :=value+ strtofloat( mmFQtyItems.Lines[i]);
  end;
  self.FQtyItems:= stringreplace( mmFQtyItems.Lines.CommaText  ,',','+',[rfReplaceAll]);
  FSumQty := value;
  FPackageQty := mmFQtyItems.Lines.Count;
  self.lblQty.Caption :=floattostr(FsumQty);
end;

procedure TfrmBarCodeQty.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case Key of
     vk_Return:
     begin
         if ssCtrl in Shift then
            self.btnOK.Click;
     end;
   end;
end;
procedure TfrmBarCodeQty.edtPackageQtyChange(Sender: TObject);
begin
//    fillList;
end;

procedure TfrmBarCodeQty.FormCreate(Sender: TObject);
begin
     //fillList;
end;

procedure TfrmBarCodeQty.fillList;
var i:integer;
begin
     self.mmFQtyItems.Clear;
     for i:=0 to strtoint(edtpackagecnt.Text ) -1 do
     begin
         mmFQtyItems.Text:=mmFQtyItems.Text+edtpackageqty.Text +chr( 13)+chr( 10);
     end;
     UpdateLabel;
end;

procedure TfrmBarCodeQty.edtPackageCntExit(Sender: TObject);
begin
    fillList;
end;

procedure TfrmBarCodeQty.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
    fillList;
end;

procedure TfrmBarCodeQty.edtPackageQtyExit(Sender: TObject);
begin
    fillList;
end;

procedure TfrmBarCodeQty.UpDown2Click(Sender: TObject; Button: TUDBtnType);
begin
    fillList;
end;

procedure TfrmBarCodeQty.edtPackageCntChange(Sender: TObject);
var s:string;
begin
             s:='';
end;

end.
