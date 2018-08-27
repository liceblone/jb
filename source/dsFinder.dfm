object dsFinderFrm: TdsFinderFrm
  Left = 199
  Top = 190
  BorderStyle = bsDialog
  Caption = #26597#25214
  ClientHeight = 213
  ClientWidth = 486
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  DesignSize = (
    486
    213)
  PixelsPerInch = 96
  TextHeight = 12
  object Button1: TButton
    Left = 402
    Top = 30
    Width = 75
    Height = 21
    Anchors = [akTop, akRight]
    Caption = #26597#25214'(&F)'
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 402
    Top = 64
    Width = 75
    Height = 21
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 1
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 385
    Height = 193
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 88
    Top = 72
  end
  object ADODataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    Parameters = <>
    Left = 176
    Top = 72
  end
end
