object Form1: TForm1
  Left = 165
  Top = 100
  Width = 702
  Height = 486
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 32
    Top = 8
    Width = 18
    Height = 13
    Caption = 'F01'
    FocusControl = dbedt1
  end
  object lbl2: TLabel
    Left = 328
    Top = 8
    Width = 18
    Height = 13
    Caption = 'F03'
    FocusControl = dbedt2
  end
  object lbl3: TLabel
    Left = 472
    Top = 8
    Width = 18
    Height = 13
    Caption = 'F04'
    FocusControl = dbedt3
  end
  object lbl4: TLabel
    Left = 328
    Top = 56
    Width = 18
    Height = 13
    Caption = 'F07'
    FocusControl = dbedt4
  end
  object lbl5: TLabel
    Left = 32
    Top = 56
    Width = 18
    Height = 13
    Caption = 'F05'
    FocusControl = dbedt5
  end
  object lbl6: TLabel
    Left = 184
    Top = 56
    Width = 18
    Height = 13
    Caption = 'F06'
    FocusControl = dbedt6
  end
  object lbl7: TLabel
    Left = 32
    Top = 104
    Width = 18
    Height = 13
    Caption = 'F09'
    FocusControl = dbedt7
  end
  object lbl8: TLabel
    Left = 472
    Top = 56
    Width = 18
    Height = 13
    Caption = 'F08'
    FocusControl = dbedt8
  end
  object lbl9: TLabel
    Left = 328
    Top = 104
    Width = 18
    Height = 13
    Caption = 'F11'
    FocusControl = dbedt9
  end
  object lbl10: TLabel
    Left = 472
    Top = 104
    Width = 18
    Height = 13
    Caption = 'F12'
    FocusControl = dbedt10
  end
  object lbl11: TLabel
    Left = 32
    Top = 144
    Width = 18
    Height = 13
    Caption = 'F13'
    FocusControl = dbedt11
  end
  object dbgrd1: TDBGrid
    Left = 32
    Top = 200
    Width = 433
    Height = 152
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object dbedt1: TDBEdit
    Left = 32
    Top = 24
    Width = 134
    Height = 21
    DataField = 'F01'
    DataSource = ds2
    TabOrder = 1
  end
  object dbchk1: TDBCheckBox
    Left = 184
    Top = 24
    Width = 97
    Height = 17
    Caption = 'F02'
    DataField = 'F02'
    DataSource = ds2
    TabOrder = 2
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object dbedt2: TDBEdit
    Left = 328
    Top = 24
    Width = 134
    Height = 21
    DataField = 'F03'
    DataSource = ds2
    TabOrder = 3
  end
  object dbedt3: TDBEdit
    Left = 472
    Top = 24
    Width = 134
    Height = 21
    DataField = 'F04'
    DataSource = ds2
    TabOrder = 4
  end
  object dbedt4: TDBEdit
    Left = 328
    Top = 72
    Width = 134
    Height = 21
    DataField = 'F07'
    DataSource = ds2
    TabOrder = 5
  end
  object dbedt5: TDBEdit
    Left = 32
    Top = 72
    Width = 134
    Height = 21
    DataField = 'F05'
    DataSource = ds2
    TabOrder = 6
  end
  object dbedt6: TDBEdit
    Left = 184
    Top = 72
    Width = 134
    Height = 21
    DataField = 'F06'
    DataSource = ds2
    TabOrder = 7
  end
  object dbedt7: TDBEdit
    Left = 32
    Top = 120
    Width = 137
    Height = 21
    DataField = 'F09'
    DataSource = ds2
    TabOrder = 8
  end
  object dbedt8: TDBEdit
    Left = 472
    Top = 72
    Width = 134
    Height = 21
    DataField = 'F08'
    DataSource = ds2
    TabOrder = 9
  end
  object dbchk2: TDBCheckBox
    Left = 184
    Top = 120
    Width = 97
    Height = 17
    Caption = 'F10'
    DataField = 'F10'
    DataSource = ds2
    TabOrder = 10
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object dbedt9: TDBEdit
    Left = 328
    Top = 120
    Width = 137
    Height = 21
    DataField = 'F11'
    DataSource = ds2
    TabOrder = 11
  end
  object dbedt10: TDBEdit
    Left = 472
    Top = 120
    Width = 137
    Height = 21
    DataField = 'F12'
    DataSource = ds2
    TabOrder = 12
  end
  object dbedt11: TDBEdit
    Left = 32
    Top = 160
    Width = 134
    Height = 21
    DataField = 'F13'
    DataSource = ds2
    TabOrder = 13
  end
  object qry1: TADOQuery
    Connection = dmFrm.ADOConnection1
    Parameters = <>
    SQL.Strings = (
      'select * from T511 ')
    Left = 528
    Top = 224
    object qry1F01: TStringField
      FieldName = 'F01'
      Size = 50
    end
    object qry1F02: TBooleanField
      FieldName = 'F02'
    end
    object qry1F03: TStringField
      FieldName = 'F03'
      Size = 50
    end
    object qry1F04: TStringField
      FieldName = 'F04'
      Size = 50
    end
    object qry1F07: TStringField
      FieldName = 'F07'
      Size = 50
    end
    object ifdqry1F5: TIntegerField
      FieldName = 'F05'
    end
    object ifdqry1F6: TIntegerField
      FieldName = 'F06'
    end
    object qry1F09: TStringField
      FieldName = 'F09'
      Size = 100
    end
    object ifdqry1F8: TIntegerField
      FieldName = 'F08'
    end
    object qry1F10: TBooleanField
      FieldName = 'F10'
    end
    object qry1F11: TStringField
      FieldName = 'F11'
      Size = 8
    end
    object qry1F12: TStringField
      FieldName = 'F12'
      Size = 50
    end
    object ifdqry1F13: TIntegerField
      FieldName = 'F13'
    end
  end
  object ds2: TDataSource
    DataSet = qry1
    Left = 528
    Top = 192
  end
end
