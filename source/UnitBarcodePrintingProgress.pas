unit UnitBarcodePrintingProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, FR_Class, FR_View, UPublic ,UnitPublicFunction ;

type
  TfrmBarcodePrintingProgress = class(TForm)
    btnPrint: TButton;
    prgPrinting: TProgressBar;
    lblBarcode: TLabel;
    btnPreview: TButton;
    frReport1: TfrReport;
    Label1: TLabel;
    Label4: TLabel;
    CBPrinters: TComboBox;
    GroupBox2: TGroupBox;
    RBALLPage: TRadioButton;
    RBPageNums: TRadioButton;
    Label2: TLabel;
    edtBeginPageNum: TEdit;
    UpDownBegin: TUpDown;
    edtEndPageNum: TEdit;
    UpDownEnd: TUpDown;
    Label5: TLabel;
    procedure btnPreviewClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBPrintersClick(Sender: TObject);
    procedure edtBeginPageNumChange(Sender: TObject);
    procedure edtEndPageNumKeyPress(Sender: TObject; var Key: Char);
    procedure edtBeginPageNumKeyPress(Sender: TObject; var Key: Char);
    procedure edtEndPageNumChange(Sender: TObject);
    procedure ResetEditorEnable(value: boolean);
    procedure RBALLPageClick(Sender: TObject);
    procedure RBPageNumsClick(Sender: TObject);
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
  uses Printers,FR_Prntr ;
  
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
var i, MaxPage :integer;
begin
 // print
      frReport1.LoadFromFile('barcode.frf');

      MaxPage:= strtoint( self.edtEndPageNum.Text )-1  ;

      if MaxPage> strtoint( self.edtBeginPageNum.Text )-1 +255 then
         MaxPage := strtoint( self.edtBeginPageNum.Text )-1 +255;

      for i:= strtoint( self.edtBeginPageNum.Text )-1  to MaxPage  do
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
var sql, barcodeFileName,  pageStr :string;
var i,j, PageNum, MaxPageNo, MinPageNo:integer;
begin
 // print

    self.prgPrinting.Max := filelist.Count      ;

    for j:= 0 to  trunc(filelist.Count /100)+1  do
    begin
      frReport1.LoadFromFile('barcode.frf');

      for i:= 0 to 99  do
      begin
          PageNum :=   j*100 + i ;
          if ( PageNum  < filelist.Count ) then
          begin
            if RBALLPage.Checked then
               AddPage( self.frReport1,self.ImageDir + filelist [ PageNum ] )
            else
              if not RBALLPage.Checked and (strtoint(edtEndPageNum.Text)>=PageNum+1)  and     ( strtoint(edtBeginPageNum.Text) <=PageNum+1) then
              begin
                AddPage( self.frReport1,self.ImageDir + filelist [ PageNum ] );
              end;
              self.prgPrinting.Position := PageNum ;
          end;
      end;
      frReport1.Pages.Delete(0);
      frReport1.PrepareReport;

      if RBALLPage.Checked then
          pageStr:=''
      else
      begin

      end;

          if frReport1.Pages.Count >0 then
           frReport1.PrintPreparedReport('', 1, true, TfrPrintPages(0));
 
    end;
end;


procedure TfrmBarcodePrintingProgress.SetImageDir(const Value: string);
begin
  FImageDir := Value;
  filelist := getFileTree( self.ImageDir,'*.jpg');
  self.lblBarcode.Caption := '总共条码数：  '+inttostr( filelist.Count  )+'     ';
  self.lblBarcode.Visible :=true;
end;

procedure TfrmBarcodePrintingProgress.FormCreate(Sender: TObject);
begin
  CBPrinters.Items.Assign(Printer.Printers);
  CBPrinters.ItemIndex := Printer.PrinterIndex;
  // OldIndex := Printer.PrinterIndex;
end;

procedure TfrmBarcodePrintingProgress.CBPrintersClick(Sender: TObject);
begin
  Prn.PrinterIndex := self.CBPrinters.ItemIndex;
end;

procedure TfrmBarcodePrintingProgress.edtBeginPageNumChange(
  Sender: TObject);
begin
   edtEndPageNum.Text := edtBeginPageNum.Text ;
   
   if   (strtoint( edtBeginPageNum.Text )> filelist.Count ) then
     edtBeginPageNum.Text := inttostr( filelist.Count ) ;
end;

procedure TfrmBarcodePrintingProgress.edtEndPageNumKeyPress(
  Sender: TObject; var Key: Char);
begin
  if ( key in ['0','1','2','3','4','5','6','7','8','9',#8] )
      and (strtoint( edtendPageNum.Text )<= filelist.Count ) then
     Key := Key
  else
     Key:= #0;
end;

procedure TfrmBarcodePrintingProgress.edtBeginPageNumKeyPress(
  Sender: TObject; var Key: Char);
begin
  if ( key in ['0','1','2','3','4','5','6','7','8','9',#8] )
      and (strtoint( edtBeginPageNum.Text )<= filelist.Count ) then
     Key := Key
  else
     Key:= #0;
end;

procedure TfrmBarcodePrintingProgress.edtEndPageNumChange(Sender: TObject);
begin
   if  (strtoint( edtEndPageNum.Text )> filelist.Count ) then
     edtEndPageNum.Text := inttostr( filelist.Count );
end;

procedure TfrmBarcodePrintingProgress.ResetEditorEnable(value: boolean);
begin
  self.edtBeginPageNum.Enabled := value;
  self.edtEndPageNum.Enabled := value;
  self.UpDownBegin.Enabled := value;
  self.UpDownEnd.Enabled := value;

end;

procedure TfrmBarcodePrintingProgress.RBALLPageClick(Sender: TObject);
begin
  ResetEditorEnable(self.RBPageNums.Checked  );
end;

procedure TfrmBarcodePrintingProgress.RBPageNumsClick(Sender: TObject);
begin
  ResetEditorEnable(self.RBPageNums.Checked  );
end;

end.
