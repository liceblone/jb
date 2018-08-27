object FrmUpdateHint: TFrmUpdateHint
  Left = 309
  Top = 224
  Width = 595
  Height = 360
  Caption = #31995#32479#26356#26032#20449#24687
  Color = 16761220
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    587
    333)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 168
    Top = 298
    Width = 232
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #26377#20219#20309#38382#39064#35831#30041#35328#65292' QQ'#65306'616898706             '
  end
  object BtnClose: TButton
    Left = 476
    Top = 292
    Width = 64
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #20851#38381
    TabOrder = 0
    OnClick = BtnCloseClick
  end
  object chkDontHintAgain: TCheckBox
    Left = 24
    Top = 298
    Width = 121
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = #19979#27425#19981#20877#25552#31034'                    '
    TabOrder = 1
    OnClick = chkDontHintAgainClick
  end
  object MemUpdateInfo: TMemo
    Left = 0
    Top = 0
    Width = 587
    Height = 277
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 2
  end
end
