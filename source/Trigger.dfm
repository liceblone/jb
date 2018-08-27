object FrmTrigger: TFrmTrigger
  Left = 266
  Top = 188
  Width = 635
  Height = 343
  Caption = 'FrmTrigger'
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
  object pgc1: TPageControl
    Left = 0
    Top = 32
    Width = 627
    Height = 284
    ActivePage = TabSheet1
    Align = alBottom
    TabOrder = 0
    object ts1: TTabSheet
      Caption = 'after saveT207'
      object lbl1: TLabel
        Left = 16
        Top = 16
        Width = 22
        Height = 13
        Caption = 'frmid'
        FocusControl = dbedt1
      end
      object lbl2: TLabel
        Left = 16
        Top = 56
        Width = 48
        Height = 13
        Caption = 'Procname'
        FocusControl = dbedt2
      end
      object lbl3: TLabel
        Left = 16
        Top = 96
        Width = 45
        Height = 13
        Caption = 'sysPrama'
        FocusControl = dbedt3
      end
      object lbl4: TLabel
        Left = 16
        Top = 136
        Width = 52
        Height = 13
        Caption = 'UserPrama'
        FocusControl = dbedt4
      end
      object lbl5: TLabel
        Left = 16
        Top = 176
        Width = 31
        Height = 13
        Caption = 'errHint'
        FocusControl = dbedt5
      end
      object dbedt1: TDBEdit
        Left = 16
        Top = 32
        Width = 200
        Height = 21
        DataField = 'frmid'
        DataSource = dsdsT207
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 0
      end
      object dbedt2: TDBEdit
        Left = 16
        Top = 72
        Width = 200
        Height = 21
        DataField = 'Procname'
        DataSource = dsdsT207
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 1
      end
      object dbedt3: TDBEdit
        Left = 16
        Top = 112
        Width = 200
        Height = 21
        DataField = 'sysPrama'
        DataSource = dsdsT207
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 2
      end
      object dbedt4: TDBEdit
        Left = 16
        Top = 152
        Width = 200
        Height = 21
        DataField = 'UserPrama'
        DataSource = dsdsT207
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 3
      end
      object dbedt5: TDBEdit
        Left = 16
        Top = 192
        Width = 200
        Height = 21
        DataField = 'errHint'
        DataSource = dsdsT207
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 4
      end
      object dbnvgr1: TDBNavigator
        Left = 232
        Top = 120
        Width = 240
        Height = 25
        DataSource = dsdsT207
        TabOrder = 5
      end
      object btnOPenT207: TButton
        Left = 232
        Top = 160
        Width = 97
        Height = 25
        Caption = 'btnOPenT207'
        TabOrder = 6
        OnClick = btnOPenT207Click
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'T802 user act'
      ImageIndex = 1
      object Label1: TLabel
        Left = 120
        Top = 16
        Width = 15
        Height = 13
        Caption = 'f01'
        FocusControl = DBEdit1
      end
      object Label2: TLabel
        Left = 120
        Top = 56
        Width = 18
        Height = 13
        Caption = 'F02'
        FocusControl = DBEdit2
      end
      object Label3: TLabel
        Left = 120
        Top = 96
        Width = 18
        Height = 13
        Caption = 'F03'
        FocusControl = DBEdit3
      end
      object Label4: TLabel
        Left = 120
        Top = 136
        Width = 18
        Height = 13
        Caption = 'F04'
        FocusControl = DBEdit4
      end
      object DBEdit1: TDBEdit
        Left = 120
        Top = 32
        Width = 134
        Height = 21
        DataField = 'f01'
        DataSource = DataSource1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 0
      end
      object DBEdit2: TDBEdit
        Left = 120
        Top = 72
        Width = 134
        Height = 21
        DataField = 'F02'
        DataSource = DataSource1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 1
      end
      object DBEdit3: TDBEdit
        Left = 120
        Top = 112
        Width = 200
        Height = 21
        DataField = 'F03'
        DataSource = DataSource1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 2
      end
      object DBEdit4: TDBEdit
        Left = 120
        Top = 152
        Width = 264
        Height = 21
        DataField = 'F04'
        DataSource = DataSource1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 3
      end
      object DBNavigator1: TDBNavigator
        Left = 160
        Top = 200
        Width = 240
        Height = 25
        DataSource = DataSource1
        TabOrder = 4
      end
      object BtnOpenUserAct: TButton
        Left = 32
        Top = 200
        Width = 105
        Height = 25
        Caption = 'BtnOpenUserAct'
        TabOrder = 5
        OnClick = BtnOpenUserActClick
      end
    end
  end
  object edtFrmID: TEdit
    Left = 48
    Top = 0
    Width = 121
    Height = 21
    ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
    TabOrder = 1
    Text = 'edtFrmID'
  end
  object dsT207: TADODataSet
    AfterInsert = dsT207AfterInsert
    CommandText = 'select *From T207  where frmid=:frmid'#13#10
    Parameters = <
      item
        Name = 'f01'
        Size = -1
        Value = Null
      end>
    Left = 8
    Top = 24
    object dsT207frmid: TStringField
      FieldName = 'frmid'
    end
    object dsT207Procname: TStringField
      FieldName = 'Procname'
      Size = 200
    end
    object dsT207sysPrama: TStringField
      FieldName = 'sysPrama'
      Size = 200
    end
    object dsT207UserPrama: TStringField
      FieldName = 'UserPrama'
      Size = 200
    end
    object dsT207errHint: TStringField
      FieldName = 'errHint'
      Size = 200
    end
  end
  object dsdsT207: TDataSource
    DataSet = dsT207
    Left = 65528
    Top = 24
  end
  object ADODataSetT802: TADODataSet
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=jbdata;Persist Security Info=True;U' +
      'ser ID=sa;Initial Catalog=jingbeiNewsys;Data Source=220.184.114.' +
      '225'
    CursorType = ctStatic
    CommandText = 'select * from T820  where f02=:f02'
    Parameters = <>
    Left = 172
    Top = 24
    object ADODataSetT802f01: TIntegerField
      FieldName = 'f01'
    end
    object ADODataSetT802F02: TIntegerField
      FieldName = 'F02'
    end
    object ADODataSetT802F03: TStringField
      FieldName = 'F03'
      Size = 100
    end
    object ADODataSetT802F04: TStringField
      FieldName = 'F04'
    end
  end
  object DataSource1: TDataSource
    DataSet = ADODataSetT802
    Left = 200
    Top = 24
  end
end
