object FrmSearchBarCode: TFrmSearchBarCode
  Left = 467
  Top = 458
  Width = 313
  Height = 248
  Align = alClient
  Caption = 'FrmSearchBarCode'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 305
    Height = 41
    Align = alTop
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    OnDblClick = PnlLeftDblClick
    object Label1: TLabel
      Left = 6
      Top = 10
      Width = 27
      Height = 13
      Alignment = taCenter
      Caption = ' '#26465#30721
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object EdtBarCode: TEdit
      Left = 38
      Top = 5
      Width = 169
      Height = 30
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '1234567890123456'
      OnChange = EdtBarCodeChange
      OnEnter = EdtBarCodeEnter
      OnKeyDown = EdtBarCodeKeyDown
    end
    object BtnSearch: TButton
      Left = 208
      Top = 8
      Width = 41
      Height = 25
      Caption = #25628#32034
      TabOrder = 1
      OnClick = BtnSearchClick
    end
    object BtnImport: TButton
      Left = 256
      Top = 8
      Width = 41
      Height = 25
      Caption = #23548#20837
      TabOrder = 2
      OnClick = BtnImportClick
    end
  end
  object BarCodeDataSet: TADODataSet
    Connection = dmFrm.ADOConnection1
    Parameters = <>
    Left = 128
    Top = 104
  end
  object DataSource1: TDataSource
    DataSet = BarCodeDataSet
    Left = 64
    Top = 96
  end
end
