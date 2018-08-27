object frmBarCodeList: TfrmBarCodeList
  Left = 394
  Top = 198
  Width = 357
  Height = 382
  Caption = #26465#30721#21015#34920
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 232
    Top = 200
    Width = 57
    Height = 13
    Caption = #26465#30721#20010#25968':  '
  end
  object lblBarCodeCount: TLabel
    Left = 232
    Top = 224
    Width = 6
    Height = 13
    Caption = '0'
  end
  object btnOK: TButton
    Left = 232
    Top = 272
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object mmBarCodeList: TMemo
    Left = 16
    Top = 56
    Width = 201
    Height = 249
    ReadOnly = True
    TabOrder = 1
  end
end
