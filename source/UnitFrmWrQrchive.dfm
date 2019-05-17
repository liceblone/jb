object FrmWrArchive: TFrmWrArchive
  Left = 0
  Top = 0
  Width = 218
  Height = 561
  TabOrder = 0
  object DBGrid1: TDBGrid
    Left = 0
    Top = 137
    Width = 218
    Height = 424
    Align = alClient
    Color = clHighlightText
    Ctl3D = False
    DataSource = dlDataSource1
    ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    ParentCtl3D = False
    ParentShowHint = False
    PopupMenu = dmFrm.DbGridPopupMenu1
    ShowHint = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object TopPanel1: TPanel
    Left = 0
    Top = 0
    Width = 218
    Height = 137
    Align = alTop
    BevelOuter = bvLowered
    Color = clCream
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    object OpnDlDsBtn1: TSpeedButton
      Left = 615
      Top = 12
      Width = 59
      Height = 22
      Flat = True
      Glyph.Data = {
        CA010000424DCA01000000000000760000002800000026000000110000000100
        040000000000540100000000000000000000100000001000000018BA5A0042AE
        390039C7730029962100FFFFFF0018BE6300FFFFFF0000000000000000000000
        0000000000000000000000000000000000000000000000000000666633333333
        3333333333333333333333666600663311111111111111111111111111111133
        6600632255000000000000000000000000000551360063255504444444444400
        0000004440055555360032555555555555555555445555555455555513003255
        5555544444445555454544445455555513003255555554555554555545554554
        5455555513003255555554444444555545554444545555551300325555544455
        5554545545554554545555551300325555555444444445544555455454555555
        1300325555555545455455555545444454555555130032555555555445455555
        5554555554555555130032555554444444444455545544444455555513006325
        5555555545555555455545555555555536006322555555555555555555555555
        5555555536006633222222222222222222222222222225336600666633333333
        3333333333333333333333666600}
    end
  end
  object dlAdoDataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    LockType = ltReadOnly
    CommandTimeout = 120
    Parameters = <>
    Left = 40
    Top = 200
  end
  object dlDataSource1: TDataSource
    DataSet = dlAdoDataSet1
    Left = 96
    Top = 200
  end
  object mtADODataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    CommandTimeout = 120
    Parameters = <>
    Left = 32
    Top = 40
    object mtADODataSet1IntegerField111: TIntegerField
      FieldKind = fkCalculated
      FieldName = '111'
      Calculated = True
    end
  end
  object mtDataSource1: TDataSource
    DataSet = mtADODataSet1
    Left = 96
    Top = 40
  end
end
