object TreeDlgFrm: TTreeDlgFrm
  Left = 255
  Top = 132
  Width = 359
  Height = 375
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #26641
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  DesignSize = (
    351
    345)
  PixelsPerInch = 96
  TextHeight = 13
  object TreeView1: TTreeView
    Left = 16
    Top = 24
    Width = 241
    Height = 289
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    HideSelection = False
    Images = dmFrm.ImageList1
    Indent = 19
    ParentCtl3D = False
    ReadOnly = True
    ShowRoot = False
    TabOrder = 0
    OnChange = TreeView1Change
    OnDblClick = TreeView1DblClick
  end
  object okBtn: TButton
    Left = 270
    Top = 31
    Width = 75
    Height = 21
    Anchors = [akTop, akRight]
    Caption = #30830#23450'(&S)'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 1
  end
  object Button2: TButton
    Left = 270
    Top = 64
    Width = 75
    Height = 21
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = #21462#28040'(&C)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 2
  end
  object CheckBox1: TCheckBox
    Left = 15
    Top = 321
    Width = 70
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = #20540#20026#31354
    TabOrder = 3
    OnClick = CheckBox1Click
  end
  object ADODataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    Parameters = <>
    Left = 264
    Top = 160
  end
end
