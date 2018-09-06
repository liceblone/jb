unit UnitBarcodePrintingProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, FR_Class, FR_View, UPublic ,UnitPublicFunction;

type
  TfrmBarcodePrintingProgress = class(TForm)
    btnPrint: TButton;
    prgPrinting: TProgressBar;
    lblBarcode: TLabel;
    btnPreview: TButton;
    edtBeginPageNum: TEdit;
    Label2: TLabel;
    UpDown1: TUpDown;
    frReport1: TfrReport;
    Label1: TLabel;
    procedure btnPreviewClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);

  private
    FImageDir: string;
    filelist:Tstringlist ;
    procedure SetImageDir(const Value: string);
     { Private declarations }
  public
    procedure AddPage(report: TfrReport; fileName: string);

  published
    property ImageDir: string read FImageDir write SetImageDir;
    { Public declarations }
  end;

var
  frmBarcodePrintingProgress: TfrmBarcodePrintingProgress;

implementation

{$R *.dfm}


procedure TfrmBarcodePrintingProgress.AddPage(report: TfrReport; fileName: string);
var picview,t1,t0:TfrPictureView;
var newpage:TfrPage;
begin
  t0:=TfrPictureView(report.Pages[0].FindObject('Picture1'));
  
  report.Pages.Add;

  newpage:= report.Pages[report.Pages.Count -1]  ;
  newpage.pgWidth:=report.Pages[0].pgWidth;
  newpage.pgHeight:=report.Pages[0].pgHeight;
  newpage.pgSize := report.Pages[0].pgSize;

  picview:= TfrPictureView.Create;
  picview.Assign(t0);
  picview.ParentPage :=newpage;

  newpage.Objects.Add( picview );

  t1:=TfrPictureView(newpage.FindObject('Picture1'));
  if t1<>nil then
  t1.Picture.loadfromfile(fileName);
end;

procedure TfrmBarcodePrintingProgress.btnPreviewClick(Sender: TObject);
var sql, barcodeFileName:string; 
var i:integer; 
begin
 // print
      frReport1.LoadFromFile('barcode.frf');

      for i:= strtoint( self.edtBeginPageNum.Text )-1  to strtoint( self.edtBeginPageNum.Text )-1 +255  do
      begin
          if i< self.filelist.Count then
            AddPage( self.frReport1, self.ImageDir + filelist [i] );
      end;
      frReport1.Pages.Delete(0);
      frReport1.PreviewButtons := [pbZoom, pbLoad, pbSave, pbFind, pbHelp, pbExit] ;
      frReport1.PrepareReport;
      frReport1.ShowReport;
end;

procedure TfrmBarcodePrintingProgress.btnPrintClick(Sender: TObject);
var sql, barcodeFileName:string;
var i,j:integer;
begin
 // print

    self.prgPrinting.Max := filelist.Count      ;

    for j:= 0 to  trunc(filelist.Count /100)  do
    begin
      frReport1.LoadFromFile('barcode.frf');

      for i:= 0 to 99  do
      begin
          if ( j*100 + i < filelist.Count ) then
          begin
            AddPage( self.frReport1,self.ImageDir + filelist [j*100 + i] );
            self.prgPrinting.Position := j*100 + i;
          end;
      end;
      frReport1.Pages.Delete(0);
      frReport1.PrepareReport;
      frReport1.PrintPreparedReport('', 1, true, TfrPrintPages(0));
        //  frReport1.PrintPreparedReportDlg;
    end;
end;


procedure TfrmBarcodePrintingProgress.SetImageDir(const Value: string);
begin
  FImageDir := Value;
  filelist := getFileTree( self.ImageDir,'*.jpg');
  self.lblBarcode.Caption := '总共条码数：  '+inttostr( filelist.Count  )+'     ';
  self.lblBarcode.Visible :=true;
end;

end.
