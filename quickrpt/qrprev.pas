{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 4.0 for Delphi and C++Builder               ::                                               
  ::                                                         ::
  :: QRPREV.PAS - QUICKREPORT STANDARD PREVIEW FORM          ::
  ::                                                         ::
  :: Copyright (c) 2004 A Lochert / QBS Software             ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: http://www.qusoft.com                                   ::
  :: 5/12/2003  new preview for 4                            ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }

{$I QRDEFS.INC}

unit QRPrev;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, QRPrntr, QR4const, QRExtra, ComCtrls, ToolWin,
  Menus , ImgList, Grids, printers;

type
  TQRStandardPreview = class(TForm)
    StatusBar: TStatusBar;
    ToolBar1: TToolBar;
    ZoomFit: TToolButton;
    Zoom100: TToolButton;
    ZoomToWidth: TToolButton;
    FirstPage: TToolButton;
    PreviousPage: TToolButton;
    ToolButton2: TToolButton;
    LastPage: TToolButton;
    PrintSetup: TToolButton;
    Print: TToolButton;
    SaveReport: TToolButton;
    LoadReport: TToolButton;
    Images: TImageList;
    ToolButton1: TToolButton;
    ExitButton: TSpeedButton;
    QRPreview: TQRPreview;
    Splitter1: TSplitter;
    Spacer2: TToolButton;
    Tabs: TPageControl;
    TabThumbs: TTabSheet;
    TabSearchResult: TTabSheet;
    Splitter2: TSplitter;
    GroupBox1: TGroupBox;
    SearchResultBox: TListBox;
    SearchTextLabel: TLabel;
    ThumbGrid: TDrawGrid;
    Spacer3: TToolButton;
    Spacer4: TToolButton;
    FindButton: TToolButton;
    Spacer1: TToolButton;
    GotoPageButton: TToolButton;
    Spacer5: TToolButton;
    PrintDialog1: TPrintDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ZoomToFitClick(Sender: TObject);
    procedure ZoomTo100Click(Sender: TObject);
    procedure ZoomToWidthClick(Sender: TObject);
    procedure FirstPageClick(Sender: TObject);
    procedure PrevPageClick(Sender: TObject);
    procedure NextPageClick(Sender: TObject);
    procedure LastPageClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SaveClick(Sender: TObject);
    procedure PrintSetupClick(Sender: TObject);
    procedure LoadClick(Sender: TObject);
    procedure QRPreviewPageAvailable(Sender: TObject; PageNum: Integer);
    procedure QRPreviewProgressUpdate(Sender: TObject; Progress: Integer);
    procedure FormCreate(Sender: TObject);
    procedure QRPreviewHyperlink(Sender: TObject; EventType: TQRHyperlinkEventType; Link: String; var Handled: Boolean);
    procedure OutlineViewChange(Sender: TObject; Node: TTreeNode);
    procedure ThumbGridDrawCell(Sender: TObject; ACol, ARow: Integer; ARect: TRect; State: TGridDrawState);
    procedure ThumbGridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure FindButtonClick(Sender: TObject);
    procedure GotoPageButtonClick(Sender: TObject);
  private
    FQRPrinter : TQRPrinter;
    FReportOrientation : TPrinterOrientation;
    Gauge : TProgressBar;
    LastProgress : integer;
    ThumbFontHeight,
    ThumbDrawHeight,
    ThumbDrawWidth,
    ThumbTopMargin,
    ThumbLeftMargin : integer;
    ShowThumbs, ShowSearch : boolean;
    InitZoom : TQRZoomstate;
  public
    constructor CreatePreview(AOwner : TComponent; aQRPrinter : TQRPrinter); virtual;
    procedure Show;
    procedure UpdateInfo;
    procedure SelectPage(aPageNumber : integer);
    procedure ResizeThumb(Sender : TObject);
    function GetTextSearch(var MatchCase : boolean; var AText : string) : boolean;
    property QRPrinter : TQRPrinter read FQRPrinter write FQRPrinter;
  end;

  TResizeGrid = class(TDrawGrid)
  public
    property OnResize;
  end;

implementation

uses
   qrsearchdlg, quickrpt;
   var
      ThumbUpdating : boolean;
      ReportTitle : string;
//  QRSearch;
{$R *.DFM}

constructor TQRStandardPreview.CreatePreview(AOwner : TComponent; aQRPrinter : TQRPrinter);
begin
  inherited Create(AOwner);
  QRPrinter := aQRPrinter;
  if qrprinter.parentreport is TCustomquickrep then
  begin
     FormStyle := TCustomquickrep(qrprinter.ParentReport).PrevFormstyle;
     width := TCustomquickrep(qrprinter.ParentReport).PreviewWidth;
     height := TCustomquickrep(qrprinter.ParentReport).Previewheight;
     WindowState := TCustomquickrep(qrprinter.ParentReport).PreviewInitialState;
     ShowThumbs := TCustomquickrep(qrprinter.ParentReport).PrevShowThumbs;
     ShowSearch := TCustomquickrep(qrprinter.ParentReport).PrevShowSearch;
     InitZoom := TCustomquickrep(qrprinter.ParentReport).PrevInitialZoom;
     reportTitle := TCustomquickrep(qrprinter.ParentReport).ReportTitle;
     QRPrinter.Title := reportTitle;
     FReportOrientation := TCustomquickrep(qrprinter.ParentReport).Page.Orientation;
  end
  else
  begin // this should never happen
     WindowState := wsMaximized;
     ShowThumbs := true;
     ShowSearch := true;
  end;
  QRPreview.QRPrinter := aQRPrinter;
  if (QRPrinter <> nil) and (QRPrinter.Title <> '') then Caption := QRPrinter.Title;
  Gauge := TProgressBar.Create(Self);
  Gauge.Top := 2;
  Gauge.Left := 2;
  Gauge.Height := 10;
  Gauge.Width := 100;
  LastProgress := 0;
  // qrprinter.load -> qrprinter.preview grid bug fix
  Tabs.Visible := ShowThumbs or ShowSearch;
  try
     if Tabs.Visible and (QRPrinter.PageCount > 0) then
         ThumbGrid.RowCount := QRPrinter.PageCount;

     if Tabs.Visible then TabThumbs.TabVisible := ShowThumbs;
     if not ShowSearch and Tabs.Visible then
     begin
        TabSearchResult.TabVisible := false;
        findButton.Visible := false;
     end;
  except

  end;
  if InitZoom = QRZoomtofit then
  begin
      QRPreview.ZoomToFit ;
      ZoomFit.Down := true;
  end
  else if InitZoom = QRZoomtowidth then
  begin
      QRPreview.ZoomToWidth;
      ZoomToWidth.Down := true;
  end
  else
  begin
      QRPreview.Zoom := 100;
      QRPreview.UpdateZoom;
      Zoom100.Down := true;
  end;
  if qrprinter.status = mpFinished then
    Print.Enabled := true;
end;

procedure TQRStandardPreview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  QRPrinter.ClosePreview(Self);
  Action := caFree;
end;

procedure TQRStandardPreview.UpdateInfo;
begin
  StatusBar.Panels[1].Text := SqrPage + ' ' + IntToStr(QRPreview.PageNumber) + ' ' +
    SqrOf + ' ' + IntToStr(QRPreview.QRPrinter.PageCount);

  StatusBar.Panels[2].Text := ReportTitle;

end;

procedure TQRStandardPreview.ZoomToFitClick(Sender: TObject);
begin
  Application.ProcessMessages;
  QRPreview.ZoomToFit;
end;

procedure TQRStandardPreview.ZoomTo100Click(Sender: TObject);
begin
  Application.ProcessMessages;
  QRPreview.Zoom := 100;
  QRPreview.UpdateZoom;
end;

procedure TQRStandardPreview.ZoomToWidthClick(Sender: TObject);
begin
  Application.ProcessMessages;
  QRPreview.ZoomToWidth;
end;

procedure TQRStandardPreview.SelectPage(aPageNumber : integer);
begin
  QRPreview.PageNumber := APageNumber;
  UpdateInfo;
  // set thumb row
  if (aPagenumber > 0) and ( aPagenumber <= QRPrinter.PageCount) then
  begin
     ThumbUpdating := true;
     ThumbGrid.Row := APageNumber-1;
     ThumbUpdating := false;
  end;
end;

procedure TQRStandardPreview.FirstPageClick(Sender: TObject);
begin
  SelectPage(1)
end;

procedure TQRStandardPreview.PrevPageClick(Sender: TObject);
begin
  SelectPage(QRPreview.PageNumber - 1);
end;

procedure TQRStandardPreview.NextPageClick(Sender: TObject);
begin
  SelectPage(QRPreview.PageNumber + 1);
end;

procedure TQRStandardPreview.LastPageClick(Sender: TObject);
begin
  SelectPage(QRPrinter.PageCount);
end;

procedure TQRStandardPreview.PrintClick(Sender: TObject);
begin
      if PrintMetafileFromPreview or ( not (qrprinter.ParentReport is TQuickRep)) then
           QRPrinter.Print
      else
           TQuickRep( qrprinter.ParentReport).print;
end;

procedure TQRStandardPreview.ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TQRStandardPreview.FormResize(Sender: TObject);
begin
  QRPreview.UpdateZoom;
end;

procedure TQRStandardPreview.Show;
begin
  inherited Show;
  UpdateInfo;
end;

procedure TQRStandardPreview.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_Next : if Shift = [ssCtrl] then
                LastPageClick(Self)
              else
                NextPageClick(Self);
    VK_Prior : if Shift = [ssCtrl] then
                 FirstPageClick(Self)
               else
                 PrevPageClick(Self);
    VK_Home : FirstPageClick(Self);
    VK_End : LastPageClick(Self);
    VK_Escape : ExitClick(self)
  end;
end;

procedure TQRStandardPreview.SaveClick(Sender: TObject);
var
  aExportFilter : TQRExportFilter;
  FileExt : string;
  I : integer;
begin
  aExportFilter := nil;
  with TSaveDialog.Create(Application) do
  try
    Title := SqrSaveReport;
    Filter := QRExportFilterLibrary.SaveDialogFilterString;
    DefaultExt := cQRPDefaultExt;
    if Execute then
    begin
      if FilterIndex = 1 then
        QRPrinter.Save(Filename)
      else
      begin
        try
          aExportFilter := TQRExportFilterLibraryEntry(
            QRExportFilterLibrary.Filters[FilterIndex - 2]).ExportFilterClass.Create(Filename);
          QRPrinter.ExportToFilter(aExportFilter);
        finally
          aExportFilter.Free
        end
      end
    end;
  finally
    Free;
  end;
end;

procedure StandardSetup;
begin
end;

procedure TQRStandardPreview.PrintSetupClick(Sender: TObject);
var
   prep : TCustomquickrep;
begin
  if TCustomquickrep( qrprinter.ParentReport).ParentComposite <> nil then
  begin
       prep := TCustomquickrep( qrprinter.ParentReport);
       TCustomQuickrep(QRPrinter.ParentReport).PrinterSetup;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.FirstPage :=
                                                    prep.UserPrinterSettings.FirstPage;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.LastPage :=
                                                    prep.UserPrinterSettings.LastPage;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.OutputBin := TQRBin(prep.UserPrinterSettings.CustomBinCode);
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.Collate := prep.UserPrinterSettings.Collate;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.ColorOption := prep.UserPrinterSettings.ColorOption;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.PrintQuality := prep.UserPrinterSettings.PrintQuality;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.Copies := prep.UserPrinterSettings.Copies;
       TQRCompositeReport( prep.ParentComposite).printerSettings.Duplex := prep.UserPrinterSettings.ExtendedDuplex = 1;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.CustomBinCode := prep.UserPrinterSettings.CustomBinCode;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.UseCustomBinCode := prep.PrinterSettings.UseCustomBinCode;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.Duplex := prep.UserPrinterSettings.Duplex;
       qrprinter.PrinterIndex := prep.PrinterSettings.printerindex;
       QRPrinter.aPrinterSettings.OutputBin := TQRBin(prep.UserPrinterSettings.CustomBinCode);
       QRPrinter.aPrinterSettings.Collate := prep.UserPrinterSettings.Collate;
       QRPrinter.aPrinterSettings.ColorOption := prep.UserPrinterSettings.ColorOption;
       QRPrinter.aPrinterSettings.PrintQuality := prep.UserPrinterSettings.PrintQuality;
       QRPrinter.aPrinterSettings.Copies := prep.UserPrinterSettings.Copies;
       QRPrinter.aPrinterSettings.Duplex := prep.UserPrinterSettings.ExtendedDuplex = 1;
       QRPrinter.aPrinterSettings.CustomBinCode := prep.UserPrinterSettings.CustomBinCode;
       QRPrinter.aPrinterSettings.UseCustomBinCode := prep.PrinterSettings.UseCustomBinCode;
       QRPrinter.LastPage := prep.UserPrinterSettings.LastPage;
       QRPrinter.FirstPage := prep.UserPrinterSettings.FirstPage;
       QRPrinter.aPrinterSettings.Duplex := prep.UserPrinterSettings.Duplex;
       exit;
  end;
  if qrprinter.ParentReport is TCustomquickrep then
  Begin
       TCustomQuickrep(QRPrinter.ParentReport).PrinterSetup;
       prep := TCustomquickrep( qrprinter.ParentReport);
       qrprinter.PrinterIndex := prep.PrinterSettings.printerindex;
       QRPrinter.aPrinterSettings.OutputBin := TQRBin(prep.UserPrinterSettings.CustomBinCode);
       QRPrinter.aPrinterSettings.Collate := prep.UserPrinterSettings.Collate;
       QRPrinter.aPrinterSettings.ColorOption := prep.UserPrinterSettings.ColorOption;
       QRPrinter.aPrinterSettings.PrintQuality := prep.UserPrinterSettings.PrintQuality;
       QRPrinter.aPrinterSettings.Copies := prep.UserPrinterSettings.Copies;
       QRPrinter.aPrinterSettings.Duplex := prep.UserPrinterSettings.ExtendedDuplex = 1;
       QRPrinter.aPrinterSettings.CustomBinCode := prep.UserPrinterSettings.CustomBinCode;
       QRPrinter.aPrinterSettings.UseCustomBinCode := prep.PrinterSettings.UseCustomBinCode;
       QRPrinter.LastPage := prep.UserPrinterSettings.LastPage;
       QRPrinter.FirstPage := prep.UserPrinterSettings.FirstPage;
       QRPrinter.aPrinterSettings.Duplex := prep.UserPrinterSettings.Duplex;
  end;
end;

procedure TQRStandardPreview.LoadClick(Sender: TObject);
begin
  with TOpenDialog.Create(Application) do
  try
    Title := SqrLoadReport;
    Filter := SqrQRFile + ' (*.' +cQRPDefaultExt + ')|*.' + cqrpDefaultExt;
    if Execute then
      if FileExists(FileName) then
      begin
        QRPrinter.Load(Filename);
        reportTitle := filename;
        QRPreview.PageNumber := 1;
        QRPreview.PreviewImage.PageNumber := 1;
        // have to reset the thumbs with this call
        QRPreviewPageAvailable( self, 1);
        thumbGrid.Row := 0;
        //PrintSetup.Enabled := False;
        PrintMetafileFromPreview := true;
        Print.Enabled := true;
      end
      else
        ShowMessage(SqrFileNotExist);
  finally
    free;
  end;
end;

procedure TQRStandardPreview.QRPreviewPageAvailable(Sender: TObject; PageNum: Integer);
begin
  UpdateInfo;
  ThumbGrid.RowCount := QRPrinter.PageCount;
  ThumbGrid.Invalidate;
  if qrprinter.status = mpFinished then
  begin
    PrintSetup.Enabled := true;
    Print.Enabled := true;
  end;
end;

procedure TQRStandardPreview.QRPreviewProgressUpdate(Sender: TObject; Progress: Integer);
var
  AProgress : integer;
begin
  if Progress >= LastProgress + 5 then
  begin
    StatusBar.Panels[0].Text := IntToStr(Progress)+'%';
    LastProgress := Progress;
  end;
  if (Progress = 0) or (Progress = 100) then StatusBar.Panels[0].Text := '';
end;

procedure TQRStandardPreview.FormCreate(Sender: TObject);
begin
   HorzScrollbar.Tracking := true;
   VertScrollbar.Tracking := true;
   TResizeGrid(ThumbGrid).OnResize := ResizeThumb;
end;

procedure TQRStandardPreview.QRPreviewHyperlink(Sender: TObject;
  EventType: TQRHyperlinkEventType; Link: String; var Handled: Boolean);
begin
  Statusbar.Panels[2].Text := Link;
end;

procedure TQRStandardPreview.OutlineViewChange(Sender: TObject; Node: TTreeNode);
var
  NewPage : integer;
  ARect : TRect;
begin
  QRPrinter.PageList.QROutline.FindPosition(Node, ARect, NewPage);
  if NewPage > 0 then
  begin
    QRPreview.PageNumber := NewPage;
    UpdateInfo;
  end;
end;

procedure TQRStandardPreview.ResizeThumb(Sender: TObject);
begin
  ThumbFontHeight := ThumbGrid.Canvas.TextHeight('P');
  ThumbGrid.DefaultColWidth := ThumbGrid.Width - 4;
  if FReportOrientation = poPortrait then
  begin
      ThumbDrawWidth := Round((ThumbGrid.DefaultColWidth - 20));
      ThumbDrawHeight := Round((ThumbDrawWidth / QRPrinter.PaperWidth) * QRPrinter.PaperLength - ThumbFontHeight);
  end
  else
  begin
      ThumbDrawWidth := Round((ThumbGrid.DefaultColWidth - 20));
      ThumbDrawHeight := Round((ThumbDrawWidth / QRPrinter.PaperLength) * QRPrinter.PaperWidth - ThumbFontHeight);
  end;

  ThumbGrid.DefaultRowHeight := ThumbDrawHeight;
  ThumbLeftMargin := Round((ThumbGrid.DefaultColWidth - ThumbDrawWidth) / 2);
  ThumbTopMargin := Round((ThumbGrid.DefaultRowHeight - ThumbDrawHeight) / 2);
end;

procedure TQRStandardPreview.ThumbGridDrawCell(Sender: TObject; ACol, ARow: Integer; ARect: TRect; State: TGridDrawState);
var
  APage : TMetafile;
begin
  APage := QRPrinter.GetPage(ARow+1);
  if APage <> nil then
    PaintPageToCanvas(APage, ThumbGrid.Canvas, Rect(ARect.Left + ThumbLeftMargin, ARect.Top + 10,
                                 ARect.Right - 30, ARect.Bottom - 10), true);
  ThumbGrid.Canvas.Brush.Color := clBtnFace;
  ThumbGrid.Canvas.Textout(ARect.Left, ARect.Top, IntToStr(ARow + 1));
  APage.Free;
end;

procedure TQRStandardPreview.ThumbGridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
     if ThumbUpdating then exit;
     QRPreview.PageNumber := ARow + 1;
     UpdateInfo;
end;

function TQRStandardPreview.GetTextSearch(var MatchCase : boolean; var AText : string) :  boolean;
var
    SrchDlg : TSearchDlg;
begin
  AText := '';
  Result := false;
  SrchDlg := TSearchDlg.Create( self);
  srchDlg.ShowModal;
  if srchDlg.cancel then
  begin
       SrchDlg.Free;
       exit;
  end;
  Result := true;
  srchDlg.GetText( AText );
  MatchCase := srchDlg.GetCase;
  SrchDlg.Free;
end;

procedure TQRStandardPreview.FindButtonClick(Sender: TObject);
var
  FindStr : string;
  MatchCase : boolean;
  I : integer;
  APage : TMetafile;
  Dummy : TList;
begin
  if GetTextSearch(MatchCase, FindStr) then
  begin
    SearchResultBox.Enabled := true;
    SearchTextLabel.Caption := FindStr;
    SearchResultBox.Items.Clear;
    for I := 1 to QRPrinter.PageCount do
    begin
       APage := QRPrinter.GetPage(I);
       try
         if StrInMetafile(FindStr, APage, MatchCase) then
            SearchResultBox.Items.Add('Page ' + IntToStr(I));
       finally
         APage.Free;
       end;
    end;
    if SearchResultBox.Items.Count = 0 then
    begin
      SearchResultBox.Items.Add('No matching text');
      SearchResultBox.Enabled := false;
    end;
  end;
end;

procedure TQRStandardPreview.GotoPageButtonClick(Sender: TObject);
var
  Pnum, K : integer;
  PNStr : string;
  CaptionStr : string;
begin
  CaptionStr := format(SqrGotoPage, [QRPrinter.PageCount]);
  PNStr := format( '%d', [QRPreview.PageNumber]);
  InputQuery(CaptionStr, 'Go to page >>', PNStr );
  val(PNStr, Pnum, K );
  if (Pnum < 1) or (Pnum > QRPrinter.PageCount) then
     Pnum := 1;
  SelectPage(Pnum );
end;

end.



