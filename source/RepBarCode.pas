unit RepBarCode;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,adodb,  QRPrntr,
  QRCtrls, QuickRpt, ExtCtrls,    fhlknl,    barcode,barcode2 ,unitBarCodeTest ,
  StdCtrls, Forms,Db,DbGrids, jpeg;


type
  TRepBarCodeFrm = class(TQuickRep)
    DetailBand1: TQRBand;
    pgnumber: TQRSysData;
    lblslash: TQRLabel;
    pgcount: TQRSysData;
    QRDBImage1: TQRDBImage;
    constructor CreateNew(AOwner : TComponent; Dummy: Integer = 1); override;
       destructor Destroy; override;
    procedure SetBillRep( fdataset:TCustomADODataSet);
    procedure GetPageCfg();
  private
    pFontSize:integer;
    BarCodePrintConfig:TBarCodePrintConfig;
    printPagePaperConfig:TPrintPagePaperConfig ;
  public
    procedure SettingPage;
  end;

type TBarcodePageExporter= class(Tobject)
     DetailBand1: TCustomPanel;
     printPagePaperConfig:TPrintPagePaperConfig  ;
     barCodePrintConfig :TBarCodePrintConfig;
     procedure GetPageCfg( parentParamCode:string ; pDetailBand1:TCustomPanel );
     function  CreateQrLabel(caption:string; left, top, fontsize:integer; parent:TWinControl): TQRLabel;
     function  CreateQrDbText(left, top:integer;   fieldName:string; fDataSet :TDataSource; parent:TWinControl ;i:integer):TFhlDbEdit;

     procedure q_CreateBarcodeReport( fdatasource :TDataSource    );

end;

var
  RepBarCodeFrm: TRepBarCodeFrm;

implementation
uses datamodule, WinTypes, WinProcs,Printers , UpublicCtrl;
{$R *.DFM}

destructor TRepBarCodeFrm.Destroy;
begin
BarCodePrintConfig.Free;
  inherited;
end;

procedure TRepBarCodeFrm.SetBillRep( fdataset:TCustomADODataSet);
var
   Barcode1 : TAsBarcode;
   qrCode: TQRDBQRCodeImage;
   i, BarcodeColumnCnt, topMargin, VGap,VLeft :integer;
   ImageBarCode:TQRImage;
   dbText:TQRDBText;
   dbImage:TQRDBBarCodeImage;
   sql:string;

begin
 //  DetailBand1.Size.Height:=BarCodePrintConfig.BarCodePaperConfig.paperHeight;//BarCodePrintConfig.BarCodeConfig.height+5;// floattoint(self.Page.Length);// BarCodePrintConfig.BarCodePaperConfig.paperHeight;
 //  self.Height:=self.DetailBand1.Height;

   BarcodeColumnCnt:=BarCodePrintConfig.BarCntPerPackage      ;
   fdataset.First;
   i:=0    ;
   topMargin:=10;
   VGap:=25 ;
   VLeft:=0;
   self.DataSet:=fdataset;
   if not fdataset.IsEmpty  then
   begin
        try

               dbText:= TQRDBText.Create(self.DetailBand1);
               dbText.Font.Size:=self.BarCodePrintConfig.BarCodeConfig.FontSize;
               dbText.AutoSize:=true;
               dbText.Parent:=self.DetailBand1;
               dbText.DataSet :=fdataset;
               dbText.DataField:='PartNo';//+inttostr(i+1);
               dbText.Top:=topMargin;
               dbText.Left:=VLeft+ 1;//round(dbimage.Height/2)- round(dbText.Width/2);

               qrCode:= TQRDBQRCodeImage.Create(self.DetailBand1);
               qrCode.ResetWidthHeight (100,100);
               qrCode.Parent:=self.DetailBand1;
               qrCode.DataSet :=fdataset;
               qrCode.DataField:='FBarCode';//+inttostr(i+1);
               qrCode.Top:=topMargin;
               qrCode.Left:=VLeft+ 170;//round(dbimage.Height/2)- round(dbText.Width/2);
               qrCode.CacheQrcodeImage := BarCodePrintConfig.BarCodeConfig.bCacheBarcodeImage;

               dbText:= TQRDBText.Create(self.DetailBand1);
               dbText.Font.Size:=self.BarCodePrintConfig.BarCodeConfig.FontSize;
               dbText.AutoSize:=true;
               dbText.Parent:=self.DetailBand1;
               dbText.DataSet :=fdataset;
               dbText.DataField:='Brand';
               dbText.Top:=topMargin ;;
               dbText.Left:=VLeft + 120;

               dbText:= TQRDBText.Create(self.DetailBand1);
               dbText.Font.Size:=self.BarCodePrintConfig.BarCodeConfig.FontSize;
               dbText.AutoSize:=true;
               dbText.Parent:=self.DetailBand1;
               dbText.DataSet :=fdataset;
               dbText.DataField:='Origin';//+inttostr(i+1);
               dbText.Top:=topMargin;
               dbText.Left:=VLeft+ 100;//round(dbimage.Height/2)- round(dbText.Width/2);

               dbText:= TQRDBText.Create(self.DetailBand1);
               dbText.Font.Size:=self.BarCodePrintConfig.BarCodeConfig.FontSize;
               dbText.AutoSize:=true;
               dbText.Parent:=self.DetailBand1;
               dbText.DataSet :=fdataset;
               dbText.DataField:='FDateCode';//+inttostr(i+1);
               dbText.Top:=topMargin;
               dbText.Left:=VLeft+ 160;//round(dbimage.Height/2)- round(dbText.Width/2);


               dbText:= TQRDBText.Create(self.DetailBand1);
               dbText.Font.Size:=self.BarCodePrintConfig.BarCodeConfig.FontSize;
               dbText.AutoSize:=true;
               dbText.Parent:=self.DetailBand1;
               dbText.DataSet :=fdataset;
               dbText.DataField:='Pack';
               dbText.Top:=topMargin +VGap;;
               dbText.Left:=VLeft;



               dbText:= TQRDBText.Create(self.DetailBand1);
               dbText.Font.Size:=self.BarCodePrintConfig.BarCodeConfig.FontSize;
               dbText.AutoSize:=true;
               dbText.Parent:=self.DetailBand1;
               dbText.DataSet :=fdataset;
               dbText.DataField:='RsSurfix';
               dbText.Top:=topMargin +VGap;
               dbText.Left:=VLeft+ 100;


                 dbText:= TQRDBText.Create(self.DetailBand1);
               dbText.Font.Size:=self.BarCodePrintConfig.BarCodeConfig.FontSize;
               dbText.AutoSize:=true;
               dbText.Parent:=self.DetailBand1;
               dbText.DataSet :=fdataset;
               dbText.DataField:='FBarCodeQty';
               dbText.Top:=topMargin +VGap*2;
               dbText.Left:=VLeft+ 1;

               dbText:= TQRDBText.Create(self.DetailBand1);
               dbText.Font.Size:=self.BarCodePrintConfig.BarCodeConfig.FontSize;
               dbText.AutoSize:=true;
               dbText.Parent:=self.DetailBand1;
               dbText.DataSet :=fdataset;
               dbText.DataField:='CreateTime';
               dbText.Top:=topMargin +VGap*2;
               dbText.Left:=VLeft+ 100;

               
               dbImage:=TQRDBBarCodeImage.Create(self.DetailBand1);
               dbImage.ResetWidthHeight (BarCodePrintConfig.BarCodeConfig.width,BarCodePrintConfig.BarCodeConfig.height);
               dbimage.Parent:=self.DetailBand1;
               dbimage.DataSet :=fdataset;
               dbimage.DataField:='FBarCode' ;//+inttostr(i+1);
               //dbimage.DataField:='Fwareid';
               dbimage.Top:=topMargin +70;
               dbimage.Height :=80;
               dbimage.Left:= VLeft   ;
               dbimage.Ratio :=BarCodePrintConfig.BarCodeConfig.Ratio;
               dbimage.BarCodeType:=BarCodePrintConfig.BarCodeConfig.BarCodeType;
               dbimage.LineWidth :=  BarCodePrintConfig.BarCodeConfig.LineWidth;
               dbimage.FormatSerialText :=  BarCodePrintConfig.BarCodeConfig.bFormatSerialText;
               dbimage.CacheBarcodeImage := BarCodePrintConfig.BarCodeConfig.bCacheBarcodeImage;


        finally
        end;
     end;

     //prepare;
     //pgcount.Caption:= intTostr(QRPrinter.PageCount);;
end;


{ TBarcodePageExporter }

function TBarcodePageExporter.CreateQrDbText(left, top: integer;
  fieldName: string; fDataSet: TDataSource; parent: TWinControl;
  i: integer): TFhlDbEdit;
var dbText:  TFhlDbEdit ;
begin
     dbText:= TFhlDbEdit.Create(parent);
     dbText.Font.Size:=PrintPagePaperConfig.pFontSize ;
     if (printPagePaperConfig.pFontBlod  =1) then
        dbText.Font.Style := [fsBold];

     dbText.AutoSize:=true;
     dbText.Parent:=parent;
     dbText.DataSource :=fdataset;
     dbText.DataField:= fieldName + inttostr(i) ;
     dbText.Top:= top;
     dbText.Left := left;


     result:= dbText;
end;
function TBarcodePageExporter.CreateQrLabel(caption: string; left, top,
  fontsize: integer; parent: TWinControl): TQRLabel;
var qrLabel: TQRLabel ;
begin
    qrLabel :=TQrlabel.create(parent);
    if (self.printPagePaperConfig.pFontBlod  =1) then
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

procedure TBarcodePageExporter.GetPageCfg( parentParamCode:string ; pDetailBand1:TCustomPanel );

 var sql,sqlformat:string;
begin
    //parentParamCode:=  quotedstr( '020302%' ) ;

    DetailBand1 := pDetailBand1 ;
 parentParamCode:=  quotedstr( '020302%' ) ;
    
    sqlformat := 'select  isnull(FParamValue,1) from TParamsAndValues where  FParamCode like %s and FParamDescription =%s';

    BarCodePrintConfig :=fhlknl1.Cf_GetPagePaperConfig( parentParamCode) ;
    printPagePaperConfig := BarCodePrintConfig.BarCodePaperConfig;


    if (DetailBand1 is TQRBand) then
    begin
      TQRBand(self.DetailBand1).Size.Length := printPagePaperConfig.paperHeight  -printPagePaperConfig.topMargin    ;
      TQRBand(self.DetailBand1).Size.Width  := printPagePaperConfig.paperWidth   ;
      TQRBand(self.DetailBand1).Font.Size   := printPagePaperConfig.pFontSize ;
    end;
    //self.Font.Size := printPagePaperConfig.pFontSize;


         {
    self.pgnumber.Top := Round( self.DetailBand1.Height   -  self.pgcount.Height -2 );
    self.lblslash.Top := self.pgnumber.Top ;
    self.pgcount.Top := self.pgnumber.Top ;
    self.pgnumber.Left :=  Round(self.DetailBand1.Width /2-  pgnumber.Width - self.pgnumber.Width -1 );
    lblslash.Left := pgnumber.Left +pgnumber.Width ;
    pgcount.Left := lblslash.Left +lblslash.Width;
           }


    
    sql := format(sqlformat ,[parentParamCode , quotedstr('ColumnWidth') ])  ; // 'ColumnWidth'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    printPagePaperConfig.ColumnWidth:=fhlknl1.User_Query.fields[0].AsInteger;
end;

procedure TBarcodePageExporter.q_CreateBarcodeReport(  fdatasource: TDataSource );
var
   i, BarcodeColumnCnt  ,vGap, kvGap, colGap, preTop , ileft:integer;
   dbImage,dbImagebhNote:TQRDBBarCodeImage;
   dbText:TFhlDbEdit;
   qrLabel:Tlabel;
   sql:string;
begin

   kvGap :=0;
   vGap:=  printPagePaperConfig.RowMargin ;
   colGap:= printPagePaperConfig.ColumnWidth ;
   fdatasource.DataSet.First;
   i:=0    ;
   if fdatasource.DataSet.Active then
   begin
        try
           //for i:=0 to ColumnCount-1 do
           for i:=0 to 0 do
           begin
               preTop:=0;

               dbText:=CreateQrDbText (  colGap*(i)  , preTop  ,   'CompanyName', fdatasource , DetailBand1, i);
               dbText.Font.Name :=  printPagePaperConfig.FontName ;
               preTop:= preTop +dbText.Height  + vGap  ;

               dbText:=CreateQrDbText (  colGap*(i)  , preTop  ,   'PartNo', fdatasource , DetailBand1, i);
               dbText.Font.Name :=  printPagePaperConfig.FontName ;
               preTop:= preTop +dbText.Height  +  vGap  ;

               
               dbImagebhNote:=TQRDBBarCodeImage.Create( DetailBand1);
               dbImagebhNote.Parent:= DetailBand1;
               dbImagebhNote.DataSet :=fdatasource.DataSet ;
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


                 dbImage:=TQRDBBarCodeImage.Create(DetailBand1);
                 dbimage.Parent:=DetailBand1;
                 dbimage.DataSet :=fdatasource.DataSet ;
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
             

               dbText:=CreateQrDbText (  colGap*(i)  , preTop  ,   'FMinPackageQty', fdatasource , DetailBand1, i);
               dbText.Font.Name :=  printPagePaperConfig.FontName ;
               //dbText.Frame.DrawRight :=true;

               //preTop:= preTop +dbImage.Height  + vGap  ;

               ileft   :=colGap*(i) +  dbText.Width  -50;
               dbText:=CreateQrDbText ( ileft  , preTop  ,   'ClientOrderNo', fdatasource , DetailBand1, i);
               dbText.Font.Name :=  printPagePaperConfig.FontName ;
           end;
        finally
        end;
     end;
     //self.DataSet:=fdataset;
     //prepare;
      
end;

constructor TRepBarCodeFrm.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited;
     BarCodePrintConfig:=TBarCodePrintConfig.Create;
     SettingPage;
end;

procedure TRepBarCodeFrm.SettingPage;
begin
   Page.PaperSize:=custom;
   self.Units:=mm;
   self.Page.Width:= BarCodePrintConfig.BarCodePaperConfig.paperWidth;
   self.Page.Length:= BarCodePrintConfig.BarCodePaperConfig.paperHeight;

   self.Page.TopMargin:= BarCodePrintConfig.BarCodePaperConfig.topMargin;
   self.Page.LeftMargin:= BarCodePrintConfig.BarCodePaperConfig.leftMargin;
   self.Page.RightMargin:= BarCodePrintConfig.BarCodePaperConfig.rightMargin;
   self.Page.BottomMargin:= BarCodePrintConfig.BarCodePaperConfig.bottomMargin;


//  self.PreviewWidth :=  BarCodePrintConfig.BarCodePaperConfig.paperWidth;
 // self.PreviewHeight :=BarCodePrintConfig.BarCodePaperConfig.paperHeight;


end;

procedure TRepBarCodeFrm.GetPageCfg;
var sql,sqlformat:string;
var parentParamCode:string;
begin
    parentParamCode:=  quotedstr( '020203%' ) ;
    sqlformat := 'select  isnull(FParamValue,1) from TParamsAndValues where  FParamCode like %s and FParamDescription =%s';

    sql := format(sqlformat ,[parentParamCode , quotedstr('paperWidth') ]);;
    fhlknl1.Kl_GetUserQuery(sql);
    printPagePaperConfig.paperWidth:=fhlknl1.User_Query.fields[0].AsInteger;

    sql := format(sqlformat ,[parentParamCode , quotedstr('paperHeight') ])  ;
    fhlknl1.Kl_GetUserQuery(sql);
    printPagePaperConfig.paperHeight:=fhlknl1.User_Query.fields[0].AsInteger;

    sql := format(sqlformat ,[parentParamCode , quotedstr('topMargin') ])  ;
    fhlknl1.Kl_GetUserQuery(sql);
    printPagePaperConfig.topMargin:=fhlknl1.User_Query.fields[0].AsFloat;

    sql := format(sqlformat ,[parentParamCode , quotedstr('leftMargin') ])  ; // leftMargin'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    printPagePaperConfig.leftMargin:=fhlknl1.User_Query.fields[0].AsFloat ;

    sql := format(sqlformat ,[parentParamCode , quotedstr('rightMargin') ])  ; // 'rightMargin'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    printPagePaperConfig.rightMargin:=fhlknl1.User_Query.fields[0].AsFloat;

    sql := format(sqlformat ,[parentParamCode , quotedstr('bottomMargin') ])  ; // 'bottomMargin'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    printPagePaperConfig.bottomMargin:=fhlknl1.User_Query.fields[0].AsFloat;


    sql := format(sqlformat ,[parentParamCode , quotedstr('FontSize') ])  ; // 'FontSize'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    pFontSize:=fhlknl1.User_Query.fields[0].AsInteger;

    
    sql := format(sqlformat ,[parentParamCode , quotedstr('PageFrame') ])  ; // 'FontSize'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    printPagePaperConfig.PageFrame :=fhlknl1.User_Query.fields[0].AsInteger =1;


    self.Page.Width        :=  printPagePaperConfig.paperWidth ;
    self.Page.Length       :=  printPagePaperConfig.paperHeight ;
    self.Page.TopMargin    :=  printPagePaperConfig.topMargin ;
    self.Page.LeftMargin   :=  printPagePaperConfig.leftMargin ;
    self.Page.RightMargin  :=  printPagePaperConfig.rightMargin  ;
    self.Page.BottomMargin :=  printPagePaperConfig.bottomMargin ;

    self.Frame.DrawTop    := printPagePaperConfig.PageFrame;
    self.Frame.DrawLeft   := printPagePaperConfig.PageFrame;
    self.Frame.DrawRight  := printPagePaperConfig.PageFrame;
    self.Frame.DrawBottom := printPagePaperConfig.PageFrame;

    self.DetailBand1.Size.Length :=   self.Page.Length -printPagePaperConfig.topMargin  -   -printPagePaperConfig.bottomMargin  ;
    self.DetailBand1.Size.Width :=    self.Page.Width  ;

    self.pgnumber.Top := Round( self.DetailBand1.Height   -  self.pgcount.Height -2 );
    self.lblslash.Top := self.pgnumber.Top ;
    self.pgcount.Top := self.pgnumber.Top ;
    self.pgnumber.Left :=  Round(self.DetailBand1.Width -  pgnumber.Width - self.pgnumber.Width -1 );
    lblslash.Left := pgnumber.Left +pgnumber.Width ;
    pgcount.Left := lblslash.Left +lblslash.Width;



    self.Font.Size := self.pFontSize;
    self.DetailBand1.Font.Size := self.pFontSize ;
end;

end.
