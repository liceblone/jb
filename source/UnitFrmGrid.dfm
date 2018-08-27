object FrmGrid: TFrmGrid
  Left = 221
  Top = 136
  Width = 493
  Height = 230
  ActiveControl = btnCancel
  Caption = 'FrmGrid'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnDblClick = FormDblClick
  DesignSize = (
    485
    203)
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 485
    Height = 144
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object TabSheet1: TTabSheet
      BorderWidth = 6
      object LblMsg: TLabel
        Left = 0
        Top = 0
        Width = 66
        Height = 19
        Caption = 'LblMsg'
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -19
        Font.Name = #26999#20307'_GB2312'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object DBGrid1: TDBGrid
        Left = 0
        Top = 24
        Width = 465
        Height = 80
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        Color = clWhite
        Ctl3D = False
        DataSource = DataSource1
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        PopupMenu = dmFrm.DbGridPopupMenu1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
  end
  object btnCancel: TButton
    Left = 396
    Top = 170
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #21462#28040
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 1
  end
  object btnOk: TButton
    Left = 312
    Top = 170
    Width = 73
    Height = 25
    Caption = #32487#32493#20351#29992
    ModalResult = 1
    TabOrder = 2
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 56
    Top = 312
  end
  object ADODataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    Parameters = <>
    Left = 104
    Top = 312
  end
end
