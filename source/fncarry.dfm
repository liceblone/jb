object fncarryFrm: TfncarryFrm
  Left = 311
  Top = 352
  BorderStyle = bsDialog
  ClientHeight = 122
  ClientWidth = 340
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
    Left = 0
    Top = 110
    Width = 340
    Height = 12
    Align = alBottom
    Caption = #27491#22312#21548#20505#25351#20196'...'
  end
  object RadioGroup1: TRadioGroup
    Left = 24
    Top = 16
    Width = 177
    Height = 73
    Caption = #25130#27490#26085#26399
    TabOrder = 0
  end
  object Button1: TButton
    Left = 240
    Top = 16
    Width = 75
    Height = 25
    Caption = #32467#36716
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 240
    Top = 56
    Width = 75
    Height = 25
    Caption = #21453#32467#36716
    TabOrder = 2
    OnClick = Button2Click
  end
  object DateTimePicker1: TDateTimePicker
    Left = 40
    Top = 40
    Width = 97
    Height = 20
    Date = 37931.418613865740000000
    Time = 37931.418613865740000000
    TabOrder = 3
  end
end
