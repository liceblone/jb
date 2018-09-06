object frmBarcodePrintingProgress: TfrmBarcodePrintingProgress
  Left = 374
  Top = 204
  Width = 403
  Height = 258
  Caption = #26465#30721#25171#21360
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblBarcode: TLabel
    Left = 112
    Top = 8
    Width = 50
    Height = 13
    Caption = 'lblBarcode'
    Visible = False
  end
  object Label2: TLabel
    Left = 48
    Top = 48
    Width = 54
    Height = 13
    Caption = #36215#22987#39029#30721': '
  end
  object Label1: TLabel
    Left = 200
    Top = 48
    Width = 117
    Height = 13
    Caption = #26368#22810#21482#33021#39044#35272'256'#39029'     '
  end
  object Label4: TLabel
    Left = 72
    Top = 92
    Width = 36
    Height = 13
    Caption = #25171#21360#26426
    FocusControl = CBPrinters
  end
  object btnPrint: TButton
    Left = 248
    Top = 152
    Width = 75
    Height = 25
    Caption = #25171#21360
    TabOrder = 0
    OnClick = btnPrintClick
  end
  object prgPrinting: TProgressBar
    Left = 0
    Top = 211
    Width = 395
    Height = 20
    Align = alBottom
    TabOrder = 1
  end
  object btnPreview: TButton
    Left = 80
    Top = 152
    Width = 75
    Height = 25
    Caption = #39044#35272
    TabOrder = 2
    OnClick = btnPreviewClick
  end
  object edtBeginPageNum: TEdit
    Left = 112
    Top = 48
    Width = 65
    Height = 21
    TabOrder = 3
    Text = '1'
  end
  object UpDown1: TUpDown
    Left = 177
    Top = 48
    Width = 15
    Height = 21
    Associate = edtBeginPageNum
    Min = 1
    Max = 4000
    Position = 1
    TabOrder = 4
  end
  object CBPrinters: TComboBox
    Left = 112
    Top = 89
    Width = 217
    Height = 22
    HelpContext = 142
    Style = csOwnerDrawFixed
    ItemHeight = 16
    TabOrder = 5
    OnClick = CBPrintersClick
  end
  object frReport1: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    Left = 398
    Top = 273
    ReportForm = {19000000}
  end
  object frReport2: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    Left = 65528
    Top = 8
    ReportForm = {19000000}
  end
end
