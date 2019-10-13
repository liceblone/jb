object FrmSearchBarCode: TFrmSearchBarCode
  Left = 411
  Top = 294
  Width = 316
  Height = 297
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
    Width = 308
    Height = 65
    Align = alTop
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    OnDblClick = PnlLeftDblClick
    object Label1: TLabel
      Left = 1
      Top = 34
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
    object Label2: TLabel
      Left = 1
      Top = 6
      Width = 27
      Height = 13
      Alignment = taCenter
      Caption = ' '#39564#35777
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object EdtHsBarCode: TEdit
      Left = 32
      Top = 32
      Width = 170
      Height = 30
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '1234567890123456'
      OnChange = EdtHsBarCodeChange
      OnEnter = EdtHsBarCodeEnter
      OnKeyDown = EdtHsBarCodeKeyDown
    end
    object BtnSearch: TButton
      Left = 204
      Top = 33
      Width = 41
      Height = 25
      Caption = #25628#32034
      TabOrder = 1
      OnClick = BtnSearchClick
    end
    object BtnImport: TButton
      Left = 204
      Top = 1
      Width = 41
      Height = 25
      Caption = #23548#20837
      TabOrder = 2
      OnClick = BtnImportClick
    end
    object EdtJbLabelBarCode: TEdit
      Left = 32
      Top = 1
      Width = 170
      Height = 30
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = '1234567890123456'
      OnChange = EdtHsBarCodeChange
      OnKeyDown = EdtJbLabelBarCodeKeyDown
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
