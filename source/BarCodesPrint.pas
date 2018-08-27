unit BarCodesPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls;

type
  TFrmBarCodePrint = class(Tform)
    QuickRepBarcode: TQuickRep;
    QRImageBarcode: TQRImage;
    DetailBandBarCode: TQRBand;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBarCodePrint: TFrmBarCodePrint;

implementation
       uses WinTypes, WinProcs,Printers, barcode,barcode2;
{$R *.dfm}

procedure TFrmBarCodePrint.FormCreate(Sender: TObject);
var
   Barcode1 : TAsBarcode;
begin

  try
     Barcode1 := TAsBarcode.Create(self);
     Barcode1.Top := 50;
     Barcode1.Left := 30;
     Barcode1.Typ := bcCodePostNet;
     Barcode1.Modul := 2;
     Barcode1.Ratio := 2.0;
     Barcode1.Height := 50;
     Barcode1.DrawText(self.QRImageBarcode.Canvas);
  finally
     freeandnil(Barcode1);
  end;

end;

end.
