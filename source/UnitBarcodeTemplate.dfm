object FrmBarCodeTemplate: TFrmBarCodeTemplate
  Left = 192
  Top = 107
  Width = 870
  Height = 500
  Caption = 'FrmBarCodeTemplate'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 272
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object edtPrintID: TEdit
    Left = 256
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'edtPrintID'
  end
  object frReport1: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    Left = 128
    Top = 136
    ReportForm = {19000000}
  end
  object RptDataSet: TADODataSet
    Connection = dmFrm.ADOConnection1
    Parameters = <>
    Left = 136
    Top = 176
  end
end
