unit UnitBarcodeTemplate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FR_Class, DB, ADODB, StdCtrls;

type
  TFrmBarCodeTemplate = class(TForm)
    frReport1: TfrReport;
    RptDataSet: TADODataSet;
    Button1: TButton;
    edtPrintID: TEdit;
    procedure Button1Click(Sender: TObject);
    function CreatefrPage(report: TfrReport ;width,height:integer): TfrPage;
    procedure CreateFrReport( RptDataSet: TADODataSet );
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBarCodeTemplate: TFrmBarCodeTemplate;

implementation
         uses datamodule ,UPublic ;
{$R *.dfm}

function TFrmBarCodeTemplate.CreatefrPage(report: TfrReport ;width,height:integer): TfrPage;
var newPage:TfrPage ;
begin
  report.Pages.Add;
  newPage := report.Pages[report.Pages.Count -1] ;
  newpage.pgWidth := width ;
  newpage.pgHeight:= height;
  newpage.pgSize  := 0;//report.Pages[ 0 ].pgSize ;
  result:=  newPage;
end;


procedure TFrmBarCodeTemplate.Button1Click(Sender: TObject); 
begin
  CreateFrReport( self.RptDataSet );
  self.frReport1.PrepareReport;
  self.frReport1.ShowReport;
end;


procedure TFrmBarCodeTemplate.CreateFrReport(RptDataSet: TADODataSet);
 var l,t,w:Integer;Fnt:TFont;
 var sql:string;
 var fDictDataSet: Tadoquery;
 var newPage:TfrPage;
 var mmLabel,mmDbText:TfrMemoView ;
begin
  t:=0;
  Fnt:=TFont.Create;
  Fnt.Assign(self.Font); 
  fDictDataSet:= fhlknl1.GetReportLayoutDBSet( edtPrintID.Text );

  newPage := CreatefrPage ( self.frReport1, 100 , 100 );

  While not fDictDataSet.Eof do
  begin
   l:=fDictDataSet.FieldByName('F12').asInteger;
   t:=fDictDataSet.FieldByName('F13').asInteger;
   Fnt.Size:=fDictDataSet.FieldByName('F07').asInteger;
   Fnt.Name:=fDictDataSet.FieldByName('F08').asString;
   w:=fDictDataSet.FieldByName('F14').asInteger;
   if fDictDataSet.FieldByName('F10').asBoolean then
     Fnt.Style:=Fnt.Style+[fsUnderLine]
   else
     Fnt.Style:=Fnt.Style-[fsUnderLine];
   if fDictDataSet.FieldByName('F09').asBoolean then
     Fnt.Style:=Fnt.Style+[fsBold]
   else
     Fnt.Style:=Fnt.Style-[fsBold];

   case fDictDataSet.FieldByName('F17').asInteger of
      0:begin
        mmLabel := TfrMemoView.Create;
        mmLabel.ParentPage := newpage; // y= 36  top   x= 132 left      dx=84  width   dy=20  height
        mmLabel.x := l ;
        mmLabel.y := t ;
        mmLabel.Memo.Text := fDictDataSet.FieldByName('F04').asString;
        mmLabel.Font.Assign(Fnt);
        newpage.Objects.Add( mmLabel );

       {
       with Tlabel_mtn.Create( self ) do
        begin
          Parent:= self;
          Left:=l;
          Top:=t;
          Caption:=fDictDataSet.FieldByName('F04').asString;
          Font.Assign(Fnt);
          KeyValue := fDictDataSet.FieldByName('F01').AsInteger ;
        end;
         }
        end;
      1:begin
            mmDbText := TfrMemoView.Create;
            mmDbText.ParentPage := newpage; // y= 36  top   x= 132 left      dx=84  width   dy=20  height
            mmDbText.x := l ;
            mmDbText.y := t ;
            mmDbText.Memo.Text := 'RptDataSet.'+fDictDataSet.FieldByName('F04').asString;
            mmDbText.Font.Assign(Fnt);
            newpage.Objects.Add( mmDbText );
        end;
        {with TEdit_mtn.Create( self ) do
        begin
          Parent:=self;
          Left:=l;
          top:=t;
          AutoSize:=False;
          width:=w; 
          Font.Assign(Fnt);
          KeyValue := fDictDataSet.FieldByName('F01').AsInteger ;
          FieldID   := fDictDataSet.FieldByName('f16').Value ;
          text:=fDictDataSet.FieldByName('f99').asString;
        end;
        }

   end;
   fDictDataSet.Next;
  end;
  //TabEditorReport.Height:=t+30;
  fDictDataSet.Close;
  Fnt.Free;
end;


end.
