unit UnitBarCodeTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfrmBarCodeTest = class(TForm)
    Image1: TImage;
    Button1: TButton;
    Image2: TImage;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBarCodeTest: TfrmBarCodeTest;

implementation
     uses  WinTypes, WinProcs, barcode,barcode2;
{$R *.dfm}

procedure TfrmBarCodeTest.Button1Click(Sender: TObject);
var
   Barcode1 : TAsBarcode;
begin
   
  try
   Image1.Picture := nil;
     Barcode1 := TAsBarcode.Create(self);
     Barcode1.Top := 10;
     Barcode1.ShowText :=TBarcodeOption(1);
     Barcode1.Left := 10;
     Barcode1.Typ := bcCode128C;
     Barcode1.Modul := 2;
     Barcode1.Ratio := 2.0;
     Barcode1.Height := 100;
     Barcode1.Text:='9313642184001';
     Barcode1.DrawBarcode(self.Image1.Canvas );
  finally
     freeandnil(Barcode1);
  end;
end;

procedure TfrmBarCodeTest.Button2Click(Sender: TObject);
var    Dest: TRect;
begin
//
   dest.Top:=0;
   dest.Left:=0;
   dest.Right:=image1.Width;
   dest.Bottom:=image1.Height;

  image2.Canvas.StretchDraw(Dest, image1.Picture.Graphic );
end;

end.
