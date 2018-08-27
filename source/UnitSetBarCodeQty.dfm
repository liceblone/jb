object frmBarCodeQty: TfrmBarCodeQty
  Left = 445
  Top = 218
  Width = 333
  Height = 343
  ActiveControl = mmFQtyItems
  Caption = #26465#30721#25968#37327#26126#32454':'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    325
    316)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 217
    Top = 64
    Width = 60
    Height = 13
    Anchors = [akTop, akRight]
    Caption = #27719#24635#25968#37327#65306
  end
  object lblQty: TLabel
    Left = 222
    Top = 104
    Width = 6
    Height = 13
    Anchors = [akTop, akRight]
    Caption = '0'
  end
  object Label2: TLabel
    Left = 84
    Top = 32
    Width = 7
    Height = 24
    Caption = '*'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 16
    Width = 30
    Height = 13
    Caption = #31665#25968'  '
  end
  object Label4: TLabel
    Left = 112
    Top = 16
    Width = 54
    Height = 13
    Caption = #27599#31665#25968#37327'  '
  end
  object mmFQtyItems: TMemo
    Left = 16
    Top = 64
    Width = 172
    Height = 231
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    OnKeyPress = mmFQtyItemsKeyPress
    OnKeyUp = mmFQtyItemsKeyUp
  end
  object btnOK: TButton
    Left = 213
    Top = 258
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object edtPackageCnt: TEdit
    Left = 16
    Top = 32
    Width = 49
    Height = 21
    TabOrder = 2
    Text = '1'
    OnChange = edtPackageCntChange
    OnExit = edtPackageCntExit
  end
  object edtPackageQty: TEdit
    Left = 96
    Top = 32
    Width = 81
    Height = 21
    TabOrder = 3
    Text = '5000'
    OnChange = edtPackageQtyChange
    OnExit = edtPackageQtyExit
  end
  object UpDown1: TUpDown
    Left = 65
    Top = 32
    Width = 15
    Height = 21
    Associate = edtPackageCnt
    Min = 1
    Position = 1
    TabOrder = 4
    OnClick = UpDown1Click
  end
  object UpDown2: TUpDown
    Left = 177
    Top = 32
    Width = 16
    Height = 21
    Associate = edtPackageQty
    Min = 1
    Max = 10000
    Position = 5000
    TabOrder = 5
    Thousands = False
    OnClick = UpDown2Click
  end
end
