unit RepSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, ImgList, DB, ADODB;

type
  TRepSetFrm = class(TForm)
    PageControl1: TPageControl;
    Button1: TButton;
    Button2: TButton;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    TitleEdit1: TEdit;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    lEdit1: TEdit;
    rEdit1: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    tEdit1: TEdit;
    Label9: TLabel;
    bEdit1: TEdit;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Label11: TLabel;
    PaperComboBox1: TComboBox;
    Label2: TLabel;
    lengthEdit1: TEdit;
    Label3: TLabel;
    widthEdit1: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Bevel1: TBevel;
    Label10: TLabel;
    Bevel2: TBevel;
    Label4: TLabel;
    colEdit1: TEdit;
    Label12: TLabel;
    colSpaceEdit1: TEdit;
    Label5: TLabel;
    rowHeightEdit1: TEdit;
    Image1: TImage;
    himg: TImage;
    pimg: TImage;
    ADODataSet1: TADODataSet;
    Label13: TLabel;
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure InitFrm(PrinterId:String);
    procedure PaperComboBox1Select(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  Title='F02';
  pgSize='F07';
  pgLength='F08';
  pgWidth='F09';
  columns='F10';
  colSpace='F16';
  RowHeight='F17';
  LfMargin='F11';
  Rtmargin='F12';
  TpMargin='F13';
  BtMargin='F14';
  Orientation='F15';

implementation

{$R *.dfm}

procedure TRepSetFrm.InitFrm(PrinterId:String);
begin
  AdoDataSet1.CommandText:='select * from T609 where F01='+PrinterId;
  with AdoDataSet1 do
  begin
       Active:=True;
       if RecordCount<>1 then exit;
       titleEdit1.Text:=FieldByName(Title).asString;
       paperComboBox1.ItemIndex:=FieldByName(pgSize).asInteger;
       lengthEdit1.Text:=FieldByName(pgLength).asString;
       widthEdit1.Text:=FieldByName(pgWidth).asString;
       colEdit1.Text:=FieldByName(columns).asString;
       colSpaceEdit1.Text:=FieldByName(colSpace).asString;
       rowHeightEdit1.Text:=FieldByName(RowHeight).asString;
       lEdit1.Text:=FieldByName(LfMargin).asString;
       rEdit1.Text:=FieldByName(RtMargin).asString;
       tEdit1.Text:=FieldByName(TpMargin).asString;
       bEdit1.Text:=FieldByName(BtMargin).asString;
       RadioButton1.Checked:=FieldByName(Orientation).asBoolean;
       RadioButton2.Checked:=not RadioButton1.Checked;
  end;
end;

procedure TRepSetFrm.RadioButton1Click(Sender: TObject);
begin
himg.Visible:=true;
pimg.Visible:=false;
end;

procedure TRepSetFrm.RadioButton2Click(Sender: TObject);
begin
pimg.Visible:=true;
himg.Visible:=false;
end;

procedure TRepSetFrm.PaperComboBox1Select(Sender: TObject);
 var x,y:integer;
begin
  case PaperComboBox1.ItemIndex of
       0:begin
          x:=297; y:=420;
         end;
       1:begin
          x:=210; y:=297;
         end;
       2:begin
          x:=148; y:=210;
         end;
       3:begin
          x:=250; y:=354;
         end;
       4:begin
          x:=182; y:=257;
         end;
       else begin
          x:=0; y:=0;
         end;
  end;
  lengthEdit1.Text:=intTostr(y);
  widthEdit1.Text:=intTostr(x);
end;

end.
