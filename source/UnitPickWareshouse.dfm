object frmPickWarehouse: TfrmPickWarehouse
  Left = 216
  Top = 207
  Width = 411
  Height = 191
  Caption = #36873#25321#35843#25320#20179#24211#65306
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 96
    Height = 13
    Caption = #35843#25320#30446#26631#20179#24211#65306'    '
  end
  object Label2: TLabel
    Left = 64
    Top = 64
    Width = 42
    Height = 13
    Caption = #22791#27880#65306'  '
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 120
    Top = 24
    Width = 161
    Height = 21
    ListSource = DataSource1
    TabOrder = 0
  end
  object edtNote: TEdit
    Left = 120
    Top = 56
    Width = 161
    Height = 21
    TabOrder = 1
  end
  object Button1: TButton
    Left = 144
    Top = 112
    Width = 75
    Height = 25
    Caption = #21462#28040
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 232
    Top = 112
    Width = 75
    Height = 25
    Caption = #30830#23450
    ModalResult = 2
    TabOrder = 3
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 296
    Top = 8
  end
  object ADODataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    CommandText = 
      'select * from  wh_warehouse where ISNULL(fdel,0)=0 and Code<>'#39'00' +
      '9'#39
    Parameters = <>
    Left = 336
    Top = 8
  end
end
