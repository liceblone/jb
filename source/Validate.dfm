object ValidateFrm: TValidateFrm
  Left = 17
  Top = 188
  Width = 769
  Height = 266
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #37319#36141#20837#24211#30830#35748
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
  DesignSize = (
    761
    239)
  PixelsPerInch = 96
  TextHeight = 13
  object HintLabel: TLabel
    Left = 16
    Top = 216
    Width = 59
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #24403#21069#36873#23450':'
  end
  object okBtn: TButton
    Left = 680
    Top = 28
    Width = 75
    Height = 21
    Anchors = [akTop, akRight]
    Caption = #30830#23450'(&Y)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = okBtnClick
  end
  object Button2: TButton
    Left = 680
    Top = 59
    Width = 75
    Height = 21
    Anchors = [akTop, akRight]
    Caption = #20851#38381
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 1
  end
  object dlBtn: TButton
    Left = 680
    Top = 187
    Width = 75
    Height = 20
    Anchors = [akRight, akBottom]
    Caption = #26126#32454'...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = dlBtnClick
  end
  object DBGrid1: TDBGrid
    Left = 13
    Top = 42
    Width = 652
    Height = 165
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 440
    Top = 96
  end
  object ADODataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    LockType = ltReadOnly
    AfterOpen = ADODataSet1AfterOpen
    AfterScroll = ADODataSet1AfterScroll
    Parameters = <>
    Left = 480
    Top = 104
  end
end
