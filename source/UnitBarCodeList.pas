unit UnitBarCodeList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TfrmBarCodeList = class(TForm)
    btnOK: TButton;
    mmBarCodeList: TMemo;
    Label1: TLabel;
    lblBarCodeCount: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InitialData(barcodeList:String);
  end;

var
  frmBarCodeList: TfrmBarCodeList;

implementation

{$R *.dfm}

{ TfrmBarCodeList }

procedure TfrmBarCodeList.InitialData(barcodeList: String);
var i,cnt:integer;
begin
  mmBarCodeList.Lines.CommaText:= barcodeList;
  cnt:=0;
  
  for i:=0 to  mmBarCodeList.Lines.Count -1 do
     if ( mmBarCodeList.Lines[i]<>'') then
     inc(cnt);
  self.lblBarCodeCount.Caption:=inttostr(cnt);
end;

procedure TfrmBarCodeList.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case Key of
     vk_Return:
     begin
            self.btnOK.Click;
     end;
   end;
end;

end.
