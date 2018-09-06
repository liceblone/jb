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
  PixelsPerInch = 96
  TextHeight = 13
  object lblBarcode: TLabel
    Left = 104
    Top = 16
    Width = 50
    Height = 13
    Caption = 'lblBarcode'
    Visible = False
  end
  object Label2: TLabel
    Left = 104
    Top = 56
    Width = 54
    Height = 13
    Caption = #36215#22987#39029#30721': '
  end
  object Label1: TLabel
    Left = 248
    Top = 56
    Width = 117
    Height = 13
    Caption = #26368#22810#21482#33021#39044#35272'256'#39029'     '
  end
  object btnPrint: TButton
    Left = 232
    Top = 144
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
    Left = 104
    Top = 144
    Width = 75
    Height = 25
    Caption = #39044#35272
    TabOrder = 2
    OnClick = btnPreviewClick
  end
  object edtBeginPageNum: TEdit
    Left = 160
    Top = 56
    Width = 65
    Height = 21
    TabOrder = 3
    Text = '0'
  end
  object UpDown1: TUpDown
    Left = 225
    Top = 56
    Width = 15
    Height = 21
    Associate = edtBeginPageNum
    Min = 1
    Max = 4000
    Position = 1
    TabOrder = 4
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
    Left = 40
    Top = 56
    ReportForm = {19000000}
  end
end
