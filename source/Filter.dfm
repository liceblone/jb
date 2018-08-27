object FilterFrm: TFilterFrm
  Left = 180
  Top = 239
  Anchors = [akRight, akBottom]
  BorderStyle = bsDialog
  Caption = #36807#28388'/'#31579#36873
  ClientHeight = 265
  ClientWidth = 673
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 169
    Height = 51
    Caption = #23545#35937
    TabOrder = 0
    object FldComboBox: TComboBox
      Left = 8
      Top = 19
      Width = 153
      Height = 19
      Style = csOwnerDrawFixed
      Ctl3D = True
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 0
      OnChange = FldComboBoxChange
    end
  end
  object ValGroupBox: TGroupBox
    Left = 352
    Top = 8
    Width = 201
    Height = 51
    Caption = #20540
    TabOrder = 1
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 63
    Width = 337
    Height = 99
    Caption = #25351#20196#21015#34920
    TabOrder = 2
    object ListBox1: TListBox
      Left = 2
      Top = 15
      Width = 333
      Height = 82
      Align = alClient
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      ItemHeight = 13
      TabOrder = 0
      OnClick = ListBox1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 185
    Top = 10
    Width = 161
    Height = 49
    Caption = #36816#31639#31526
    TabOrder = 3
    object oprtComboBox: TComboBox
      Left = 7
      Top = 17
      Width = 145
      Height = 19
      Style = csOwnerDrawFixed
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object Button1: TButton
    Left = 565
    Top = 17
    Width = 75
    Height = 21
    Caption = #29983#25104
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 565
    Top = 46
    Width = 75
    Height = 21
    Caption = #28165#38500
    TabOrder = 5
    OnClick = Button2Click
  end
  object fOkBtn: TButton
    Left = 565
    Top = 114
    Width = 75
    Height = 21
    Caption = #30830#23450
    Default = True
    ModalResult = 1
    TabOrder = 6
  end
  object fCancelBtn: TButton
    Left = 565
    Top = 140
    Width = 75
    Height = 21
    Cancel = True
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 7
  end
  object RadioGroup1: TRadioGroup
    Left = 352
    Top = 63
    Width = 201
    Height = 45
    Caption = #25324#21495
    Columns = 3
    Items.Strings = (
      #24038#25324#21495
      #21491#25324#21495
      #26080#25324#21495)
    TabOrder = 8
    OnClick = RadioGroup1Click
  end
  object RadioGroup2: TRadioGroup
    Left = 352
    Top = 116
    Width = 201
    Height = 45
    Caption = #19982#19979#19968#26465#25351#20196#30340#20851#31995
    Columns = 3
    Items.Strings = (
      #24182#19988
      #25110#32773
      #26080#20851#31995)
    TabOrder = 9
    OnClick = RadioGroup2Click
  end
  object RadioGroup3: TRadioGroup
    Left = 8
    Top = 206
    Width = 337
    Height = 37
    Caption = #26597#25214#26041#21521
    Columns = 4
    ItemIndex = 0
    Items.Strings = (
      #21521#21069
      #21521#21518
      #39318#26465
      #23614#26465)
    TabOrder = 11
  end
  object FindNextBtn: TButton
    Left = 352
    Top = 215
    Width = 120
    Height = 21
    Caption = #26597#25214#19979#19968#20010'(&F)'
    Enabled = False
    TabOrder = 12
  end
  object BeginFindBtn: TButton
    Left = 480
    Top = 215
    Width = 75
    Height = 21
    Caption = #24320#22987#26597#25214
    Default = True
    TabOrder = 13
  end
  object Button5: TButton
    Left = 565
    Top = 215
    Width = 75
    Height = 21
    Cancel = True
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 14
    OnClick = Button5Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 243
    Width = 673
    Height = 22
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvLowered
    TabOrder = 10
  end
  object FilterName: TEdit
    Left = 456
    Top = 168
    Width = 97
    Height = 21
    Hint = #35831#22635#20889#36807#28388#26465#20214#21517
    TabOrder = 15
    Visible = False
  end
  object ChkSqlCon: TCheckBox
    Left = 357
    Top = 168
    Width = 100
    Height = 17
    Caption = #20445#23384#36807#28388#26465#20214
    TabOrder = 16
    Visible = False
  end
end
