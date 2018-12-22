unit UnitDeliveryLabel;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls,adodb;

type
  TDeliveryLabelPrint = class(TQuickRep)
    DetailBand1: TQRBand;
  private

  public
     procedure SetBillRep( fdataset:TCustomADODataSet);

  end;

var
  DeliveryLabelPrint: TDeliveryLabelPrint;

implementation

{$R *.DFM}
  
procedure TDeliveryLabelPrint.SetBillRep( fdataset:TCustomADODataSet);
var
   i, BarcodeColumnCnt, topMargin, VGap,VLeft , FontSize :integer;
   ImageBarCode:TQRImage;
   dbText:TQRDBText;
   flabel:TQRLabel;
   sql:string;
begin


   fdataset.First;
   i:=0    ;
   topMargin:=20;
   VGap:=25 ;
   VLeft:=20;
   FontSize :=20;

   self.DataSet:=fdataset;
   if not fdataset.IsEmpty  then
   begin
        try
               dbText:= TQRDBText.Create(self.DetailBand1);
               dbText.Font.Size:= FontSize;
               dbText.AutoSize:=true;
               dbText.Parent:=self.DetailBand1;
               dbText.DataSet :=fdataset;
               dbText.DataField:='NickName';//+inttostr(i+1);
               dbText.Top:=topMargin;
               dbText.Left:=VLeft+ 1;

               dbText:= TQRDBText.Create(self.DetailBand1);
               dbText.Font.Size:= FontSize ;
               dbText.AutoSize:=true;
               dbText.Parent:=self.DetailBand1;
               dbText.DataSet :=fdataset;
               dbText.DataField:='PcsCount';//+inttostr(i+1);
               dbText.Top:=topMargin + dbText.Height +50 ;
               dbText.Left:=VLeft+ 1;

                flabel:= TQrLabel.Create(self.DetailBand1);
               flabel.Font.Size:= FontSize ;
               flabel.AutoSize:=true;
               flabel.Parent:=self.DetailBand1;
               flabel.Top:=topMargin + dbText.Height +50 ;
               flabel.Left:=VLeft+ 60   ;
               flabel.Caption :='--';

                dbText:= TQRDBText.Create(self.DetailBand1);
               dbText.Font.Size:= FontSize ;
               dbText.AutoSize:=true;
               dbText.Parent:=self.DetailBand1;
               dbText.DataSet :=fdataset;
               dbText.DataField:='PcsIndex';//+inttostr(i+1);
               dbText.Top:=topMargin + dbText.Height +50 ;
               dbText.Left:=VLeft+ 100;

                {
               dbImage:=TQRDBBarCodeImage.Create(self.DetailBand1);
               dbImage.ResetWidthHeight (BarCodePrintConfig.BarCodeConfig.width,BarCodePrintConfig.BarCodeConfig.height);
               dbimage.Parent:=self.DetailBand1;
               dbimage.DataSet :=fdataset;
               dbimage.DataField:='FBarCode' ;//+inttostr(i+1);
               dbimage.Top:=topMargin +70;
               dbimage.Height :=80;
               dbimage.Left:= VLeft   ;
               dbimage.Ratio :=BarCodePrintConfig.BarCodeConfig.Ratio;
               dbimage.BarCodeType:=BarCodePrintConfig.BarCodeConfig.BarCodeType;
               dbimage.LineWidth :=  BarCodePrintConfig.BarCodeConfig.LineWidth;
               dbimage.FormatSerialText :=  BarCodePrintConfig.BarCodeConfig.bFormatSerialText;
               dbimage.CacheBarcodeImage := BarCodePrintConfig.BarCodeConfig.bCacheBarcodeImage;
                 }

        finally
        end;
     end;

     //prepare;
     //pgcount.Caption:= intTostr(QRPrinter.PageCount);;
end;

end.
