object DownerFrm: TDownerFrm
  Left = 275
  Top = 208
  BorderStyle = bsDialog
  Caption = #19979#36733
  ClientHeight = 97
  ClientWidth = 288
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object HintLabel1: TLabel
    Left = 16
    Top = 24
    Width = 162
    Height = 12
    Caption = #24744#30830#23450#35201#19979#36733'%s'#21495'%s'#30340#25968#25454#21527'?'
  end
  object Button1: TButton
    Left = 67
    Top = 64
    Width = 75
    Height = 25
    Caption = #30830#23450
    ModalResult = 1
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 155
    Top = 64
    Width = 75
    Height = 25
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 1
  end
  object mtDataSet2: TADODataSet
    Connection = dmFrm.ADOConnection2
    LockType = ltBatchOptimistic
    CommandText = 'select * from sl_retail where code=:code'
    Parameters = <
      item
        Name = 'code'
        Size = -1
        Value = Null
      end>
    Left = 248
    Top = 8
  end
  object dlDataSet2: TADODataSet
    Connection = dmFrm.ADOConnection2
    LockType = ltBatchOptimistic
    Parameters = <>
    Left = 240
    Top = 56
  end
end
