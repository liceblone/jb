unit UnitPrintLabel;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,adodb, QRPrntr,
     QRCtrls, QuickRpt, ExtCtrls, fhlknl, StdCtrls, Forms,Db,DbGrids;


type
  TQrLabelPrinting = class(TQuickRep)
    DetailBand1: TQRBand;
    pgnumber: TQRSysData;
    lblslash: TQRLabel;
    pgcount: TQRSysData;
  private
     printPagePaperConfig:TPrintPagePaperConfig ;
     RowMargin:integer;
     pFontSize:integer;
     pFontBlod:integer;
     ColumnCount:integer;
     ColumnWidth:integer;
     PageContentHeight:integer;
  public
     procedure SetBillRep( fdataset:TCustomADODataSet);
     procedure GetPageCfg;
     function  CreateQrLabel(caption:string; left, top, fontsize:integer; parent:TWinControl): TQRLabel;
     function  CreateQrDbText(left, top:integer;   fieldName:string; fDataSet :TDataSet; parent:TWinControl ;i:integer):TQRDBText;
  end;

var
  QrLabelPrinting: TQrLabelPrinting;

implementation
  uses datamodule, WinTypes, WinProcs,Printers, barcode,barcode2 ,unitBarCodeTest;

{$R *.DFM}
{ TQrLabel }

function TQrLabelPrinting.CreateQrDbText(left, top:integer;  fieldName:string; fDataSet :TDataSet; parent: TWinControl ; i:integer): TQRDBText;
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


     result:= dbText;
end;

function TQrLabelPrinting.CreateQrLabel(caption:string; left, top, fontsize:integer; parent:TWinControl): TQRLabel;
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

procedure TQrLabelPrinting.SetBillRep(fdataset: TCustomADODataSet);
var
   Barcode1 : TAsBarcode;
   i, BarcodeColumnCnt  ,vGap, kvGap, colGap, preTop :integer;
   ImageBarCode:TQRImage;
   dbText:TQRDBText;
   qrLabel:TQrlabel;
   sql:string;
begin
   kvGap :=0;
   vGap:= self.RowMargin ;
   colGap:= self.ColumnWidth ;
   fdataset.First;
   i:=0    ;
   if fdataset.Active then
   begin
        try
           for i:=0 to ColumnCount-1 do
           //for i:=0 to 2-1 do
           begin
               preTop:=0;

               //qrLabel:=  CreateQrLabel( '厂商代号:', colGap*(i) , preTop , fontsize, DetailBand1);
               dbText:=CreateQrDbText (   colGap*(i)  , preTop ,   'CompanyName', fdataset , DetailBand1, i);
               preTop:= preTop + dbText.Height + vGap ;

               //qrLabel:=  CreateQrLabel( '订单号:', colGap*(i) , preTop , fontsize, DetailBand1);
               dbText:=CreateQrDbText (  colGap*(i)  , preTop ,   'ClientOrderNo', fdataset , DetailBand1, i);
               preTop:= preTop + dbText.Height + vGap ;

               //qrLabel:=  CreateQrLabel( '料号:', colGap*(i) , preTop , fontsize, DetailBand1);
               dbText:=CreateQrDbText (  colGap*(i)  , preTop  ,   'bhNote', fdataset , DetailBand1, i);
               preTop:= preTop + dbText.Height + vGap ;

               //qrLabel:=  CreateQrLabel( '品名:', colGap*(i) , preTop , fontsize, DetailBand1);
               dbText:=CreateQrDbText (  colGap*(i)  , preTop  ,   'PartNo', fdataset , DetailBand1, i);
               preTop:= preTop + dbText.Height + vGap ;

               //qrLabel:=  CreateQrLabel( '数量:', colGap*(i) , preTop , fontsize, DetailBand1);
               dbText:=CreateQrDbText (  colGap*(i)  , preTop  ,   'FMinPackageQty', fdataset , DetailBand1, i);
               preTop:= preTop + dbText.Height + vGap ;

               //qrLabel:=  CreateQrLabel( '入库日期:', colGap*(i) , preTop , fontsize, DetailBand1);
               dbText:= CreateQrDbText ( colGap*(i)  , preTop , 'InvoiceDate', fdataset , DetailBand1, i);

           end;
        finally
        end;
     end;
     self.DataSet:=fdataset;
     prepare;
     //pgcount.Caption:= intTostr(QRPrinter.PageCount);;
end;


procedure TQrLabelPrinting.GetPageCfg;
var sql,sqlformat:string;
var parentParamCode:string;
begin
    parentParamCode:=  quotedstr( '020301%' ) ;
    sqlformat := 'select  isnull(FParamValue,1) from TParamsAndValues where  FParamCode like %s and FParamDescription =%s';

    sql := format(sqlformat ,[parentParamCode , quotedstr('paperWidth') ]);;
    fhlknl1.Kl_GetUserQuery(sql);
    printPagePaperConfig.paperWidth:=fhlknl1.User_Query.fields[0].AsInteger;

    sql := format(sqlformat ,[parentParamCode , quotedstr('paperHeight') ])  ;
    fhlknl1.Kl_GetUserQuery(sql);
    printPagePaperConfig.paperHeight:=fhlknl1.User_Query.fields[0].AsInteger;

    sql := format(sqlformat ,[parentParamCode , quotedstr('topMargin') ])  ;
    fhlknl1.Kl_GetUserQuery(sql);
    printPagePaperConfig.topMargin:=fhlknl1.User_Query.fields[0].AsInteger;

    sql := format(sqlformat ,[parentParamCode , quotedstr('leftMargin') ])  ; // leftMargin'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    printPagePaperConfig.leftMargin:=fhlknl1.User_Query.fields[0].AsInteger;

    sql := format(sqlformat ,[parentParamCode , quotedstr('rightMargin') ])  ; // 'rightMargin'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    printPagePaperConfig.rightMargin:=fhlknl1.User_Query.fields[0].AsInteger;

    sql := format(sqlformat ,[parentParamCode , quotedstr('bottomMargin') ])  ; // 'bottomMargin'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    printPagePaperConfig.bottomMargin:=fhlknl1.User_Query.fields[0].AsInteger;

    sql := format(sqlformat ,[parentParamCode , quotedstr('RowMargin') ])  ; // 'RowMargin'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    RowMargin:=fhlknl1.User_Query.fields[0].AsInteger;

    sql := format(sqlformat ,[parentParamCode , quotedstr('FontSize') ])  ; // 'FontSize'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    pFontSize:=fhlknl1.User_Query.fields[0].AsInteger;

    sql := format(sqlformat ,[parentParamCode , quotedstr('ColumnCount') ])  ; // 'ColumnCount'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    ColumnCount:=fhlknl1.User_Query.fields[0].AsInteger;

    sql := format(sqlformat ,[parentParamCode , quotedstr('ColumnWidth') ])  ; // 'ColumnWidth'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    ColumnWidth:=fhlknl1.User_Query.fields[0].AsInteger;
    
   // sql := format(sqlformat ,[parentParamCode , quotedstr('PageContentHeight') ])  ; // 'PageContentHeight'' ';
   // fhlknl1.Kl_GetUserQuery(sql);
   // PageContentHeight:=fhlknl1.User_Query.fields[0].AsInteger;

    sql := format(sqlformat ,[parentParamCode , quotedstr('FontBlod') ])  ; // 'FontBlod'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    pFontBlod:=fhlknl1.User_Query.fields[0].AsInteger  ;


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

end;

end.
