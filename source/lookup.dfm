object LookupFrm: TLookupFrm
  Left = 277
  Top = 190
  Width = 726
  Height = 346
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #25628#23547
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnDblClick = FormDblClick
  DesignSize = (
    718
    319)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 12
    Width = 26
    Height = 13
    Caption = #25628#23547
  end
  object Label2: TLabel
    Left = 191
    Top = 12
    Width = 26
    Height = 13
    Caption = #20540#20026
  end
  object Label3: TLabel
    Left = 497
    Top = 12
    Width = 26
    Height = 13
    Anchors = [akTop, akRight]
    Caption = #27604#36739
  end
  object statLabel1: TLabel
    Left = 641
    Top = 25
    Width = 71
    Height = 13
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = '0/0'
    Transparent = True
  end
  object Edit1: TEdit
    Left = 221
    Top = 8
    Width = 268
    Height = 19
    Anchors = [akLeft, akTop, akRight]
    Ctl3D = False
    ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
    ParentCtl3D = False
    TabOrder = 0
    OnChange = Edit1Change
    OnKeyUp = Edit1KeyUp
  end
  object Button2: TButton
    Left = 641
    Top = 40
    Width = 75
    Height = 22
    Anchors = [akTop, akRight]
    Caption = #30830#23450
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button3: TButton
    Left = 641
    Top = 72
    Width = 75
    Height = 22
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 2
  end
  object ComboBox1: TComboBox
    Left = 38
    Top = 8
    Width = 145
    Height = 21
    BevelKind = bkSoft
    Style = csDropDownList
    Ctl3D = False
    ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
    ItemHeight = 13
    ParentCtl3D = False
    TabOrder = 3
    OnChange = ComboBox1Change
  end
  object ComboBox2: TComboBox
    Left = 527
    Top = 8
    Width = 104
    Height = 21
    BevelKind = bkSoft
    Style = csDropDownList
    Anchors = [akTop, akRight]
    Ctl3D = False
    ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
    ItemHeight = 13
    ParentCtl3D = False
    TabOrder = 4
    OnChange = Edit1Change
  end
  object CheckBox1: TCheckBox
    Left = 7
    Top = 296
    Width = 70
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = #20540#20026#31354
    TabOrder = 5
  end
  object Button1: TButton
    Left = 641
    Top = 264
    Width = 75
    Height = 22
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #32534#36753'(&E)'
    TabOrder = 6
    Visible = False
    OnClick = Button1Click
  end
  object grp1: TGroupBox
    Left = 8
    Top = 40
    Width = 624
    Height = 238
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 7
    object dbGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 620
      Height = 221
      Align = alClient
      Ctl3D = False
      DataSource = DataSource1
      ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      ParentShowHint = False
      PopupMenu = dmFrm.DbGridPopupMenu1
      ShowHint = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
      OnDrawColumnCell = dbGrid1DrawColumnCell
      OnDblClick = dbGrid1DblClick
    end
  end
  object ChkPhoneticize: TCheckBox
    Left = 88
    Top = 296
    Width = 81
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = #25340#38899#36807#28388
    TabOrder = 8
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 240
    Top = 264
  end
  object ADODataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    AfterScroll = ADODataSet1AfterScroll
    Parameters = <>
    Left = 280
    Top = 264
  end
end
