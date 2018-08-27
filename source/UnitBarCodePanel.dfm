object FrmPanelBarCodeList: TFrmPanelBarCodeList
  Left = 0
  Top = 0
  Width = 240
  Height = 538
  TabOrder = 0
  DesignSize = (
    240
    538)
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 144
    Height = 13
    Caption = #35831#36755#20837#26465#30721#28982#21518#22238#36710#65306'        '
  end
  object mmBarCodeList: TMemo
    Left = 8
    Top = 40
    Width = 219
    Height = 489
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      '0123456789123456')
    ParentFont = False
    TabOrder = 0
    OnKeyPress = mmBarCodeListKeyPress
  end
end
