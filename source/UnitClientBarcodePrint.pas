unit UnitClientBarcodePrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls,fhlknl,Db,DbGrids, adodb;

type
  TQrClientBarCodePrint = class(TQuickRep)
    DetailBand1: TQRBand;
    pgcount: TQRSysData;
    lblslash: TQRLabel;
    pgnumber: TQRSysData;
  private
     BarCodePrintConfig: TBarCodePrintConfig;
     printPagePaperConfig:TPrintPagePaperConfig ;
     RowMargin:integer;
     pFontSize:integer;
     pFontBlod:integer;
     ColumnCount:integer;
     ColumnWidth:integer;
     PageContentHeight:integer;
     CacheBarCodeImage:boolean;
  public
     procedure SetBillRep( fdataset:TCustomADODataSet );
     procedure InitialImageLoader( fdataset:TCustomADODataSet );
     function ExportReport( fdataset:TCustomADODataSet ):TImage;

     procedure GetPageCfg;
     function  CreateQrLabel(caption:string; left, top, fontsize:integer; parent:TWinControl): TQRLabel;
     function   CreateQrDbText(left, top:integer;   fieldName:string; fDataSet :TDataSet; parent:TWinControl ;i:integer):TQRDBText;
     function  CreateTextOnImage(left, top:integer;   fieldName:string; fDataSet :TDataSet; parent:TImage ;i:integer):Tpoint;
  end;

var
  QrClientBarCodePrint: TQrClientBarCodePrint;

implementation
    uses datamodule, WinTypes, WinProcs,Printers, barcode,barcode2 ,unitBarCodeTest,RepBarCode, upublicCtrl;
{$R *.DFM}

{ TQuickReport1 }

function TQrClientBarCodePrint.CreateQrDbText(left, top: integer;
  fieldName: string; fDataSet: TDataSet; parent: TWinControl;
  i: integer): TQRDBText;
var dbText:  TQRDBText ;
begin
     dbText:= TQRDBText.Create(parent);
     dbText.Font.Size:=pfontsize ;
     if (self.pFontBlod  =1) then
        dbText.Font.Style := [fsBold];

     dbText.AutoSize:=true;
     dbText.Parent:=parent;
     dbText.DataSet :=fdataset;
     dbText.DataField:= fieldName + inttostr(i) ;
     dbText.Top:= top;
     dbText.Left := left;
     dbText.Font.Name :=  printPagePaperConfig.FontName ;

     result:= dbText;
end;
function TQrClientBarCodePrint.CreateQrLabel(caption: string; left, top,
  fontsize: integer; parent: TWinControl): TQRLabel;
var qrLabel: TQRLabel ;
begin
    qrLabel :=TQrlabel.create(parent);
    if (self.pFontBlod  =1) then
        qrLabel.Font.Style := [fsBold];
    {
    qrLabel.Caption :=caption;
    qrLabel.Font.Size := FontSize -2 ;
    qrLabel.AutoSize  := true;
    qrLabel.Parent:= parent;    }
    qrLabel.Top := top ;
    qrLabel.Left := left  ;
    result := qrLabel;
end;


procedure TQrClientBarCodePrint.GetPageCfg;
var sql,sqlformat:string;
var parentParamCode:string;
begin
    parentParamCode:=  quotedstr( '020302%' ) ;
    
    sqlformat := 'select  isnull(FParamValue,1) from TParamsAndValues where  FParamCode like %s and FParamDescription =%s';

    BarCodePrintConfig :=fhlknl1.Cf_GetPagePaperConfig( parentParamCode) ;
    printPagePaperConfig := BarCodePrintConfig.BarCodePaperConfig;

    RowMargin:=printPagePaperConfig.RowMargin;
    pFontSize:= printPagePaperConfig.pFontSize ;
    ColumnCount:= printPagePaperConfig.ColumnCount ;

    ColumnWidth:= printPagePaperConfig.ColumnWidth ;

    pFontBlod:=printPagePaperConfig.pFontBlod ;


    self.Page.Width        :=  printPagePaperConfig.paperWidth ;
    self.Page.Length       :=  printPagePaperConfig.paperHeight ;
    self.Page.TopMargin    :=  printPagePaperConfig.topMargin ;
    self.Page.LeftMargin   :=  printPagePaperConfig.leftMargin ;
    self.Page.RightMargin  :=  printPagePaperConfig.rightMargin  ;
    self.Page.BottomMargin :=  printPagePaperConfig.bottomMargin ;

    self.DetailBand1.Size.Length :=   self.Page.Length -printPagePaperConfig.topMargin    ;
    self.DetailBand1.Size.Width :=    self.Page.Width  ;

    self.Font.Size := self.pFontSize;
    self.DetailBand1.Font.Size := self.pFontSize ;



    self.pgnumber.Top := Round( self.DetailBand1.Height   -  self.pgcount.Height -2 );
    self.lblslash.Top := self.pgnumber.Top ;
    self.pgcount.Top := self.pgnumber.Top ;
    self.pgnumber.Left :=  Round(self.DetailBand1.Width /2-  pgnumber.Width - self.pgnumber.Width -1 );
    lblslash.Left := pgnumber.Left +pgnumber.Width ;
    pgcount.Left := lblslash.Left +lblslash.Width;
    


    
    sql := format(sqlformat ,[parentParamCode , quotedstr('ColumnWidth') ])  ; // 'ColumnWidth'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    printPagePaperConfig.ColumnWidth:=fhlknl1.User_Query.fields[0].AsInteger;

end;

function TQrClientBarCodePrint.ExportReport(fdataset: TCustomADODataSet):TImage;
var
   Barcode1 : TAsBarcode;
   i, BarcodeColumnCnt  ,vGap, kvGap, colGap, preTop , ileft, ibottomEdge :integer;
   dbImage,dbImagebhNote:TQRDBBarCodeImage;
   prePos:Tpoint;
   sql:string;
begin
   result:=TImage.Create(nil);
   result.Width  :=  DetailBand1.Width ;
   result.Height :=  DetailBand1.Height - round(printPagePaperConfig.topMargin*4) -round(printPagePaperConfig.bottomMargin*4) - 10;

   kvGap :=0;
   vGap:=  self.RowMargin ;
   colGap:= self.ColumnWidth ;
   //fdataset.First;
   i:=0    ;
   if fdataset.Active then
   begin
        try
           //for i:=0 to ColumnCount-1 do
           for i:=0 to 0 do
           begin
              preTop:=0;

              prePos := CreateTextOnImage( colGap*(i) , preTop, 'CompanyName', fdataset, result, i) ;
              preTop:= preTop + prePos.Y  + vGap  ;

              prePos :=  CreateTextOnImage(colGap*(i) , preTop, 'PartNo', fdataset, result, i) ;
              preTop:= preTop + prePos.Y +  vGap  ;

              dbImagebhNote:=TQRDBBarCodeImage.Create(nil);
              dbImagebhNote.DataSet :=fdataset;
              dbImagebhNote.DataField:='bhNote0' ;//+inttostr(i+1);
              dbImagebhNote.Top:=preTop  ;
              dbImagebhNote.Left:= colGap*(i)   ;
              dbImagebhNote.ResetWidthHeight(210,35);// (BarCodePrintConfig.BarCodeConfig.width,BarCodePrintConfig.BarCodeConfig.height);
              dbImagebhNote.Ratio := BarCodePrintConfig.BarCodeConfig.Ratio;
              dbImagebhNote.BarCodeType:= 5;//BarCodePrintConfig.BarCodeConfig.BarCodeType;
              dbImagebhNote.LineWidth :=  1;//BarCodePrintConfig.BarCodeConfig.LineWidth;
              dbImagebhNote.FormatSerialText := False;// BarCodePrintConfig.BarCodeConfig.bFormatSerialText;
              //dbImagebhNote.SetShowTextFont (dbText.Font);
              dbImagebhNote.CacheBarcodeImage := self.BarCodePrintConfig.BarCodeConfig.bCacheBarcodeImage;
              dbImagebhNote.BarCodeShowText  := self.BarCodePrintConfig.BarCodeConfig.IsShowText;
              preTop:= preTop +dbImagebhNote.Height  +  vGap +5 ;
              dbImagebhNote.LoadPicture;
              result.Canvas.Draw( dbImagebhNote.Left, dbImagebhNote.Top, dbImagebhNote.FImage.Picture.Graphic  );

              
              dbImage:=TQRDBBarCodeImage.Create(nil);
              dbimage.DataSet :=fdataset;
              dbimage.DataField:='FBarCode0' ;//+inttostr(i+1);
              dbimage.Top:=  preTop  ;
              dbimage.Left:= colGap*(i)   ;
              dbImage.ResetWidthHeight(210,35);// (BarCodePrintConfig.BarCodeConfig.width,BarCodePrintConfig.BarCodeConfig.height);
              dbimage.Ratio := BarCodePrintConfig.BarCodeConfig.Ratio;
              dbimage.BarCodeType:= 5;//BarCodePrintConfig.BarCodeConfig.BarCodeType;
              dbimage.LineWidth :=  1;//BarCodePrintConfig.BarCodeConfig.LineWidth;
              dbimage.FormatSerialText := False;// BarCodePrintConfig.BarCodeConfig.bFormatSerialText;
              //dbimage.SetShowTextFont (dbText.Font);
              dbimage.CacheBarcodeImage := self.BarCodePrintConfig.BarCodeConfig.bCacheBarcodeImage;
              dbimage.BarCodeShowText  := self.BarCodePrintConfig.BarCodeConfig.IsShowText;
              dbimage.LoadPicture;
              result.Canvas.Draw( dbimage.Left, dbimage.Top, dbimage.FImage.Picture.Graphic  );


              preTop:= preTop +dbImage.Height  + vGap   ;
              prePos := CreateTextOnImage(colGap*(i) , preTop, 'FMinPackageQty', fdataset, result, i) ;

              ibottomEdge :=  preTop + prePos.Y;

              ileft   :=colGap*(i) + prePos.X   -50;
              prePos := CreateTextOnImage( ileft , preTop, 'ClientOrderNo', fdataset, result, i) ;

           end;
        finally
          dbImagebhNote.Free;
          dbImage.Free ;
        end;
     end;
     
     self.DataSet:=fdataset;
     //pgcount.Caption:= intTostr(QRPrinter.PageCount);;
end;
procedure TQrClientBarCodePrint.SetBillRep(fdataset: TCustomADODataSet  );
var
   Barcode1 : TAsBarcode;
   i, BarcodeColumnCnt  ,vGap, kvGap, colGap, preTop , ileft:integer;
   dbImage,dbImagebhNote:TQRDBBarCodeImage;
   dbText:TQRDBText;
   qrLabel:TQrlabel;
   sql:string;
begin
   kvGap :=0;
   vGap:=  self.RowMargin ;
   colGap:= self.ColumnWidth ;
   fdataset.First;
   i:=0    ;
   if fdataset.Active then
   begin
        try
           //for i:=0 to ColumnCount-1 do
           for i:=0 to 0 do
           begin
               preTop:=0;

               dbText:=CreateQrDbText (  colGap*(i)  , preTop  ,   'CompanyName', fdataset , DetailBand1, i);
               dbText.Font.Name :=  printPagePaperConfig.FontName ;
               preTop:= preTop +dbText.Height  + vGap  ;

               dbText:=CreateQrDbText (  colGap*(i)  , preTop  ,   'PartNo', fdataset , DetailBand1, i);
               dbText.Font.Name :=  printPagePaperConfig.FontName ;
               preTop:= preTop +dbText.Height  +  vGap  ;

               
               dbImagebhNote:=TQRDBBarCodeImage.Create(self.DetailBand1);
               dbImagebhNote.Parent:=self.DetailBand1;
               dbImagebhNote.DataSet :=fdataset;
               dbImagebhNote.DataField:='bhNote0' ;//+inttostr(i+1);
               dbImagebhNote.Top:=preTop  ;
               dbImagebhNote.Left:= dbText.Left    ;
               dbImagebhNote.ResetWidthHeight(210,35);// (BarCodePrintConfig.BarCodeConfig.width,BarCodePrintConfig.BarCodeConfig.height);
               dbImagebhNote.Ratio := BarCodePrintConfig.BarCodeConfig.Ratio;
               dbImagebhNote.BarCodeType:= 5;//BarCodePrintConfig.BarCodeConfig.BarCodeType;
               dbImagebhNote.LineWidth :=  1;//BarCodePrintConfig.BarCodeConfig.LineWidth;
               dbImagebhNote.FormatSerialText := False;// BarCodePrintConfig.BarCodeConfig.bFormatSerialText;
               dbImagebhNote.SetShowTextFont (dbText.Font);
               dbImagebhNote.CacheBarcodeImage := self.BarCodePrintConfig.BarCodeConfig.bCacheBarcodeImage;
                dbImagebhNote.BarCodeShowText  := self.BarCodePrintConfig.BarCodeConfig.IsShowText;

                 preTop:= preTop +dbImagebhNote.Height  +  vGap +5 ;


                 dbImage:=TQRDBBarCodeImage.Create(self.DetailBand1);
                 dbimage.Parent:=self.DetailBand1;
                 dbimage.DataSet :=fdataset;
                 dbimage.DataField:='FBarCode0' ;//+inttostr(i+1);
                 dbimage.Top:=  preTop  ;
                 dbimage.Left:= dbText.Left    ;
                 dbImage.ResetWidthHeight(210,35);// (BarCodePrintConfig.BarCodeConfig.width,BarCodePrintConfig.BarCodeConfig.height);
                 dbimage.Ratio := BarCodePrintConfig.BarCodeConfig.Ratio;
                 dbimage.BarCodeType:= 5;//BarCodePrintConfig.BarCodeConfig.BarCodeType;
                 dbimage.LineWidth :=  1;//BarCodePrintConfig.BarCodeConfig.LineWidth;
                 dbimage.FormatSerialText := False;// BarCodePrintConfig.BarCodeConfig.bFormatSerialText;
                 dbimage.SetShowTextFont (dbText.Font);
                 dbimage.CacheBarcodeImage := self.BarCodePrintConfig.BarCodeConfig.bCacheBarcodeImage;
                  dbimage.BarCodeShowText  := self.BarCodePrintConfig.BarCodeConfig.IsShowText;
                 preTop:= preTop +dbImage.Height  + vGap   ;
             

               dbText:=CreateQrDbText (  colGap*(i)  , preTop  ,   'FMinPackageQty', fdataset , DetailBand1, i);
               dbText.Font.Name :=  printPagePaperConfig.FontName ;
               //dbText.Frame.DrawRight :=true;

               //preTop:= preTop +dbImage.Height  + vGap  ;

               ileft   :=colGap*(i) +  dbText.Width  -50;
               dbText:=CreateQrDbText ( ileft  , preTop  ,   'ClientOrderNo', fdataset , DetailBand1, i);
               dbText.Font.Name :=  printPagePaperConfig.FontName ;
           end;
        finally
        end;
     end;
     self.DataSet:=fdataset;
     prepare;
     //pgcount.Caption:= intTostr(QRPrinter.PageCount);;
end;


function TQrClientBarCodePrint.CreateTextOnImage(left, top: integer;
  fieldName: string; fDataSet: TDataSet; parent: TImage; i: integer): Tpoint;
var point:Tpoint;
var font:TFont;
begin
  font:= TFont.Create;
  font.Size := pfontsize ;
  font.Name := printPagePaperConfig.FontName ;
  if (printPagePaperConfig.pFontBlod  =1) then
    font.Style := [fsBold];

  parent.Canvas.Font.Assign(font);
  
  parent.Canvas.TextOut(left, top, fDataSet.fieldbyname(fieldName + inttostr(i)).AsString );
  point.X := parent.Canvas.TextWidth( fDataSet.fieldbyname(fieldName + inttostr(i)).AsString);
  point.Y := parent.Canvas.TextHeight( fDataSet.fieldbyname(fieldName + inttostr(i)).AsString) ;
  result:= point;
end;

procedure TQrClientBarCodePrint.InitialImageLoader( fdataset: TCustomADODataSet );
var dbImage,imageLoader : TQRImageLoader;
var barcodeFileName : string;
begin
   if fdataset.Active then
   begin
     barcodeFileName := './barcodeImages/';//+ fdataset.fieldbyname('FBarCode0').AsString + '.jpg';
     imageLoader:= TQRImageLoader.Create(self.DetailBand1);
     imageLoader.Parent:=DetailBand1;
     imageLoader.Stretch := False;
     imageLoader.ImageDir :=barcodeFileName ;
     imageLoader.Top:=0;
     imageLoader.left:=0;
     imageLoader.Width := self.printPagePaperConfig.paperWidth;
     imageLoader.Height:= self.printPagePaperConfig.paperHeight ;
     imageLoader.DataSet := fdataset;
     imageLoader.DataField :='FBarCode0' ;
     self.DataSet:=fdataset;
   
   end;
   //pgcount.Caption:= intTostr(QRPrinter.PageCount);;
end;

end.
