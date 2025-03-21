{*******************************************}
{                                           }
{            FastReport v2.5                }
{         Barcode Add-in object             }
{                                           }
{Copyright(c) 1998-2004 by FastReports Inc.}
{                                           }

//  Barcode Component
//  Version 1.3
//  Copyright 1998-99 Andreas Schmidt and friends

//  Freeware

//  for use with Delphi 2/3/4


//  this component is for private use only!
//  i am not responsible for wrong barcodes
//  Code128C not implemented

//  bug-reports, enhancements:
//  mailto:shmia@bizerba.de or
//  a_j_schmidt@rocketmail.com

{  Fr_BarC:     Guilbaud Olivier            }
{               golivier@worldnet.fr        }
{  Ported to FR2.3: Alexander Tzyganenko    }
{                                           }
{*******************************************}

unit FR_BarC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, frBarcod, FR_Class, ExtCtrls, FR_Ctrls;

type
  TfrBarCodeObject = class(TComponent)  // fake component
  end;

  TfrBarCodeRec = packed record
    cCheckSum : Boolean;
    cShowText : Boolean;
    cCadr     : Boolean;
    cBarType  : TfrBarcodeType;
    cModul    : Integer;
    cRatio    : Double;
    cAngle    : Double;
  end;

  TfrBarCodeView = class(TfrView)
  private
    BarC: TfrBarCode;
    procedure BarcodeEditor(Sender: TObject);
  public
    Param: TfrBarCodeRec;
    constructor Create; override;
    destructor Destroy; override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToStream(Stream: TStream); override;
    procedure SaveToFR3Stream(Stream: TStream); override;
    procedure Draw(Canvas: TCanvas); override;
    procedure StreamOut(Stream: TStream); override;
    procedure DefinePopupMenu(Popup: TPopupMenu); override;
    procedure DefineProperties; override;
    procedure ShowEditor; override;
  end;

  TfrBarCodeForm = class(TForm)
    bCancel: TButton;
    bOk: TButton;
    M1: TfrComboEdit;
    Label1: TLabel;
    cbType: TComboBox;
    Label2: TLabel;
    Image1: TImage;
    GroupBox1: TGroupBox;
    ckCheckSum: TCheckBox;
    ckViewText: TCheckBox;
    GroupBox2: TGroupBox;
    RB1: TRadioButton;
    RB2: TRadioButton;
    RB3: TRadioButton;
    RB4: TRadioButton;
    Label3: TLabel;
    eZoom: TEdit;
    Panel1: TPanel;
    frSpeedButton1: TfrSpeedButton;
    frSpeedButton2: TfrSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure bOkClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ExprBtnClick(Sender: TObject);
    procedure frSpeedButton1Click(Sender: TObject);
    procedure frSpeedButton2Click(Sender: TObject);
  private
    procedure Localize;
  public
  end;


implementation

uses FR_Const, FR_Utils, FR_DBRel;

{$R *.DFM}
{$R *.RES}

const
  cbDefaultText = '12345678';


{$HINTS OFF}
function isNumeric(St: String): Boolean;
var
  R: Double;
  E: Integer;
begin
  Val(St, R, E);
  Result := (E = 0);
end;
{$HINTS ON}

constructor TfrBarCodeView.Create;
begin
  inherited Create;

  BarC := TfrBarCode.Create(nil);
  Param.cCheckSum := True;
  Param.cShowText := True;
  Param.cCadr     := False;
  Param.cBarType  := bcCode39;
  Param.cModul    := 2;
  Param.cRatio    := 1;
  Param.cAngle    := 0;
  Memo.Add(cbDefaultText);
  BaseName := 'Bar';
end;

destructor TfrBarCodeView.Destroy;
begin
  BarC.Free;
  inherited Destroy;
end;

procedure TfrBarCodeView.DefineProperties;
begin
  inherited DefineProperties;
  AddProperty('Barcode', [frdtHasEditor, frdtOneObject], BarcodeEditor);
  AddProperty('DataField', [frdtOneObject, frdtHasEditor, frdtString], frFieldEditor);
end;

procedure TfrBarCodeView.LoadFromStream(Stream:TStream);
begin
  inherited LoadFromStream(Stream);
  Stream.Read(Param, SizeOf(Param));
  if Param.cModul = 1 then
  begin
      Param.cRatio := Param.cRatio / 2;
      Param.cModul := 2;
  end;
end;

procedure TfrBarCodeView.SaveToStream(Stream:TStream);
begin
  inherited SaveToStream(Stream);
  Stream.Write(Param, SizeOf(Param));
end;

procedure TfrBarCodeView.Draw(Canvas: TCanvas);
var
  Txt: String;
  newdx, newdy, hg: Integer;
  EMF: TMetafile;
  EMFCanvas: TMetafileCanvas;
  h, oldh: HFont;

  function CreateRotatedFont(Font: TFont; Angle: Integer): HFont;
  var
    F: TLogFont;
  begin
    GetObject(Font.Handle, SizeOf(TLogFont), @F);
    F.lfEscapement := Angle * 10;
    F.lfOrientation := Angle * 10;
    Result := CreateFontIndirect(F);
  end;

begin
  if (dx < 0) or (dy < 0) or (Memo.Text = #13#10) then Exit;
  BeginDraw(Canvas);
  Memo1.Assign(Memo);

  if (Memo1.Count > 0) and (Memo1[0][1] <> '[') then
    Txt := Memo1[0] else
    Txt := cbDefaultText;
  BarC.Angle := Param.cAngle;
  BarC.Ratio := 2;
  BarC.Modul := 1;
  BarC.Checksum := Param.cCheckSum;
  if FillColor = clNone then
    BarC.Color := clWhite else
    BarC.Color := FillColor;
  BarC.Typ := Param.cBarType;
  if bcData[Param.cBarType].Num = False then
    BarC.Text := Txt
  else if IsNumeric(Txt) then
    BarC.Text := Txt else
    BarC.Text := cbDefaultText;
  newdx := dx;
  newdy := dy;
  if (Param.cAngle = 90) or (Param.cAngle = 270) then
  begin
    dy := BarC.Width;
    newdy := Round(dy * Param.cRatio);
  end
  else
  begin
    dx := BarC.Width;
    newdx := Round(dx * Param.cRatio);
  end;

  if Trim(BarC.Text) = '0' then Exit;

  if (Param.cAngle = 90) or (Param.cAngle = 270) then
    if Param.cShowText then
      hg := dx - 14 else
      hg := dx
  else if Param.cShowText then
      hg := dy - 14 else
      hg := dy;
  BarC.Left := 0;
  BarC.Top := 0;
  BarC.Height := hg;
  if (BarC.Typ = bcCodePostNet) and (Param.cAngle = 0) then
  begin
    BarC.Top := hg;
    BarC.Height := -hg;
  end;

  if Param.cAngle = 180 then
    BarC.Top := dy - hg
  else if Param.cAngle = 270 then
    BarC.Left := dx - hg;



  EMF := TMetafile.Create;
  EMF.Width := dx;
  EMF.Height := dy;
  EMFCanvas := TMetafileCanvas.Create(EMF, 0);
  BarC.DrawBarcode(EMFCanvas);
  Txt := BarC.Text;

  if Param.cShowText then
  with EMFCanvas do
  begin
    Font.Color := clBlack;
    Font.Name := 'Courier New';
    Font.Height := -12;
    Font.Style := [];
    h := CreateRotatedFont(Font, Round(Param.cAngle));
    oldh := SelectObject(Handle, h);
    if Param.cAngle = 0 then
      TextOut((dx - TextWidth(Txt)) div 2, dy - 12, Txt)
    else if Param.cAngle = 90 then
      TextOut(dx - 12, dy - (dy - TextWidth(Txt)) div 2, Txt)
    else if Param.cAngle = 180 then
      TextOut(dx - (dx - TextWidth(Txt)) div 2, 12, Txt)
    else
      TextOut(12, (dy - TextWidth(Txt)) div 2, Txt);
    SelectObject(Handle, oldh);
    DeleteObject(h);
  end;
  EMFCanvas.Free;

  dx := newdx;
  dy := newdy;
  CalcGaps;
  ShowBackground;
  Canvas.StretchDraw(DRect, EMF);
  EMF.Free;
  ShowFrame;
  RestoreCoord;
end;

procedure TfrBarCodeView.StreamOut(Stream: TStream);
var
  SaveTag: String;
begin
  BeginDraw(Canvas);
  Memo1.Assign(Memo);
  CurReport.InternalOnEnterRect(Memo1, Self);
  frInterpretator.DoScript(Script);
  if not Visible then Exit;

  SaveTag := Tag;
  if (Tag <> '') and (Pos('[', Tag) <> 0) then
    ExpandVariables(Tag);

  if Memo1.Count > 0 then
    if (Length(Memo1[0]) > 0) and (Memo1[0][1] = '[') then
    try
      Memo1[0] := frParser.Calc(Memo1[0]);
    except
      Memo1[0] := '0';
    end;

  Stream.Write(Typ, 1);
  frWriteString(Stream, ClassName);
  SaveToStream(Stream);

  Tag := SaveTag;
end;

procedure TfrBarCodeView.DefinePopupMenu(Popup: TPopupMenu);
begin
  // no specific items in popup menu
end;

procedure TfrBarCodeView.BarcodeEditor(Sender: TObject);
begin
  ShowEditor;
end;

procedure TfrBarCodeView.ShowEditor;
begin
  with TfrBarcodeForm.Create(nil) do
  begin
    if Memo.Count > 0 then
      M1.Text := Memo.Strings[0];
    cbType.ItemIndex   := ord(Param.cBarType);
    ckCheckSum.checked := Param.cCheckSum;
    ckViewText.Checked := Param.cShowText;
    eZoom.Text := FloatToStr(Param.cRatio);
    if Param.cAngle = 0 then
      RB1.Checked := True
    else if Param.cAngle = 90 then
      RB2.Checked := True
    else if Param.cAngle = 180 then
      RB3.Checked := True
    else
      RB4.Checked := True;
    if ShowModal = mrOk then
    begin
      frDesigner.BeforeChange;
      Memo.Clear;
      Memo.Add(M1.Text);
      Param.cRatio := StrToFloat(eZoom.Text);
      Param.cCheckSum  := ckCheckSum.Checked;
      Param.cShowText  := ckViewText.Checked;
      Param.cBarType := TfrBarcodeType(cbType.ItemIndex);
      if RB1.Checked then
        Param.cAngle := 0
      else if RB2.Checked then
        Param.cAngle := 90
      else if RB3.Checked then
        Param.cAngle := 180
      else
        Param.cAngle := 270;
    end;
    Free;
  end;
end;
procedure TfrBarCodeView.SaveToFR3Stream(Stream: TStream);
var
  ds: TfrTDataSet;
  fld: String;

  procedure WriteStr(const s: String);
  begin
    Stream.Write(s[1], Length(s));
  end;

begin
  inherited;

  if Memo.Count > 0 then
    WriteStr(' Text="' + StrToXML(Memo[0]) + '"');
  WriteStr(' BarType="' + IntToStr(Integer(Param.cBarType)) +
    '" CalcCheckSum="' + IntToStr(Integer(Param.cCheckSum)) +
    '" Rotation="' + FloatToStr(Param.cAngle) +
    '" ShowText="' + IntToStr(Integer(Param.cShowText)) +
    '" Zoom="' + FloatToStr(Param.cRatio) + '"');

  if Memo.Count <> 0 then
  begin
    frGetDataSetAndField(Memo[0], ds, fld);
    if (ds <> nil) and (fld <> '') then
      WriteStr(' DataSet="' + ds.Owner.Name + '.' + ds.Name +
        '" DataField="' + StrToXML(fld) + '"');
  end;
end;


//--------------------------------------------------------------------------
procedure TfrBarCodeForm.Localize;
begin
  Caption := frLoadStr(frRes + 650);
  Label1.Caption := frLoadStr(frRes + 651);
  Label2.Caption := frLoadStr(frRes + 652);
  Label3.Caption := frLoadStr(frRes + 659);
  GroupBox1.Caption := frLoadStr(frRes + 653);
  ckCheckSum.Caption := frLoadStr(frRes + 654);
  ckViewText.Caption := frLoadStr(frRes + 655);
  M1.ButtonHint := frLoadStr(frRes + 656);
  GroupBox2.Caption := frLoadStr(frRes + 658);
  bOk.Caption := frLoadStr(SOk);
  bCancel.Caption := frLoadStr(SCancel);
end;

procedure TfrBarCodeForm.FormCreate(Sender: TObject);
var
  i: TfrBarcodeType;
begin
  Localize;
  CbType.Items.Clear;
  for i := bcCode_2_5_interleaved to bcCodeEAN128C do
    cbType.Items.Add(bcData[i].Name);
  cbType.ItemIndex := 0;
end;

procedure TfrBarCodeForm.FormActivate(Sender: TObject);
begin
  M1.SetFocus;
end;

procedure TfrBarCodeForm.ExprBtnClick(Sender: TObject);
var
  s: String;
begin
  s := frDesigner.InsertExpression;
  if s <> '' then
    M1.Text := s;
end;

procedure TfrBarCodeForm.bOkClick(Sender: TObject);
var
  bc: TfrBarCode;
  Bmp: TBitmap;
begin
  bc := TfrBarCode.Create(nil);
  bc.Text := M1.Text;
  bc.CheckSum  := ckCheckSum.Checked;
  bc.Typ := TfrBarcodeType(cbType.ItemIndex);
  Bmp := TBitmap.Create;
  Bmp.Width := 16; Bmp.Height := 16;
  if (bc.Text = '') or (bc.Text[1] <> '[') then
    try
      bc.DrawBarcode(Bmp.Canvas);
    except
      MessageBox(0, PChar(frLoadStr(SBarcodeError)), PChar(frLoadStr(SError)),
        mb_Ok + mb_IconError);
      ModalResult := 0;
    end;
  Bmp.Free;
end;


var
  Bmp: TBitmap;

procedure TfrBarCodeForm.frSpeedButton1Click(Sender: TObject);
var
  i: Double;
begin
  i := StrToFloat(eZoom.Text) + 1;
  eZoom.Text := FloatToStr(i);
end;

procedure TfrBarCodeForm.frSpeedButton2Click(Sender: TObject);
var
  i: Double;
begin
  i := StrToFloat(eZoom.Text) - 1;
  if i <= 0 then i := 1;
  eZoom.Text := FloatToStr(i);
end;

initialization
  Bmp := TBitmap.Create;
  Bmp.LoadFromResourceName(hInstance, 'FR_BARCODEVIEW');
  frRegisterObject(TfrBarCodeView, Bmp, IntToStr(SInsBarcode));

finalization
  Bmp.Free;


end.
