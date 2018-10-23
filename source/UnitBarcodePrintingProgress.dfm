object frmBarcodePrintingProgress: TfrmBarcodePrintingProgress
  Left = 395
  Top = 140
  Width = 472
  Height = 280
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
    Left = 88
    Top = 8
    Width = 50
    Height = 13
    Caption = 'lblBarcode'
    Visible = False
  end
  object Label1: TLabel
    Left = 216
    Top = 8
    Width = 117
    Height = 13
    Caption = #26368#22810#21482#33021#39044#35272'256'#39029'     '
  end
  object Label4: TLabel
    Left = 96
    Top = 132
    Width = 42
    Height = 13
    Caption = #25171#21360#26426'  '
    FocusControl = CBPrinters
  end
  object btnPrint: TButton
    Left = 280
    Top = 176
    Width = 75
    Height = 25
    Caption = #25171#21360
    TabOrder = 0
    OnClick = btnPrintClick
  end
  object prgPrinting: TProgressBar
    Left = 0
    Top = 233
    Width = 464
    Height = 20
    Align = alBottom
    TabOrder = 1
  end
  object btnPreview: TButton
    Left = 112
    Top = 176
    Width = 75
    Height = 25
    Caption = #39044#35272
    TabOrder = 2
    OnClick = btnPreviewClick
  end
  object CBPrinters: TComboBox
    Left = 144
    Top = 129
    Width = 233
    Height = 22
    HelpContext = 142
    Style = csOwnerDrawFixed
    ItemHeight = 16
    TabOrder = 3
    OnClick = CBPrintersClick
  end
  object GroupBox2: TGroupBox
    Left = 92
    Top = 36
    Width = 285
    Height = 77
    Caption = #25171#21360#39029#30721#65306
    TabOrder = 4
    object Label2: TLabel
      Left = 80
      Top = 48
      Width = 12
      Height = 13
      Caption = #20174
    end
    object Label5: TLabel
      Left = 168
      Top = 48
      Width = 12
      Height = 13
      Caption = #21040
    end
    object RBALLPage: TRadioButton
      Left = 8
      Top = 20
      Width = 77
      Height = 17
      HelpContext = 108
      Caption = #25152#26377#39029
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = RBALLPageClick
    end
    object RBPageNums: TRadioButton
      Left = 8
      Top = 44
      Width = 65
      Height = 17
      HelpContext = 124
      Caption = #39029#30721':  '
      TabOrder = 1
      OnClick = RBPageNumsClick
    end
    object edtBeginPageNum: TEdit
      Left = 96
      Top = 48
      Width = 41
      Height = 21
      Enabled = False
      TabOrder = 2
      Text = '1'
      OnChange = edtBeginPageNumChange
      OnKeyPress = edtBeginPageNumKeyPress
    end
    object UpDownBegin: TUpDown
      Left = 137
      Top = 48
      Width = 15
      Height = 21
      Associate = edtBeginPageNum
      Enabled = False
      Min = 1
      Max = 4000
      Position = 1
      TabOrder = 3
    end
    object edtEndPageNum: TEdit
      Left = 192
      Top = 48
      Width = 41
      Height = 21
      Enabled = False
      TabOrder = 4
      Text = '1'
      OnChange = edtEndPageNumChange
      OnKeyPress = edtEndPageNumKeyPress
    end
    object UpDownEnd: TUpDown
      Left = 233
      Top = 48
      Width = 15
      Height = 21
      Associate = edtEndPageNum
      Enabled = False
      Position = 1
      TabOrder = 5
    end
  end
  object frReport1: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    Left = 14
    Top = 9
    ReportForm = {19000000}
  end
end
