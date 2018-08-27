object colShowerFrm: TcolShowerFrm
  Left = 192
  Top = 140
  BorderStyle = bsDialog
  Caption = #35774#23450' - '#21487#35270#21015
  ClientHeight = 324
  ClientWidth = 377
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 15
    Top = 8
    Width = 85
    Height = 13
    Caption = #24403#21069#21487#35270#24773#20917':'
  end
  object StringGrid1: TStringGrid
    Left = 9
    Top = 32
    Width = 269
    Height = 281
    Hint = #21452#20987#21487#25913#21464#24403#21069#20540
    ColCount = 2
    Ctl3D = True
    DefaultColWidth = 120
    DefaultRowHeight = 22
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing]
    ParentCtl3D = False
    TabOrder = 0
    OnClick = StringGrid1Click
    RowHeights = (
      23)
  end
  object Button1: TButton
    Left = 288
    Top = 32
    Width = 75
    Height = 22
    Caption = #30830#23450'(&Y)'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 288
    Top = 57
    Width = 75
    Height = 22
    Cancel = True
    Caption = #21462#28040'(&C)'
    ModalResult = 2
    TabOrder = 2
  end
  object Button3: TButton
    Left = 288
    Top = 289
    Width = 75
    Height = 22
    Cancel = True
    Caption = #21453#36873'(&V)'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 288
    Top = 262
    Width = 75
    Height = 22
    Cancel = True
    Caption = #20840#36873'(&A)'
    TabOrder = 4
    OnClick = Button4Click
  end
end
