object frmGetGridID: TfrmGetGridID
  Left = 268
  Top = 166
  Width = 1017
  Height = 477
  Caption = #21462#24471'dlgridID'
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
    Top = 57
    Width = 1009
    Height = 393
    ActivePage = ts2
    Align = alClient
    TabOrder = 0
    object ts1: TTabSheet
      Caption = 'ts1'#21152'T504 '#21462#24471'dlgridID  '
      object lbl1: TLabel
        Left = 16
        Top = 45
        Width = 50
        Height = 13
        Caption = 'F01,id, pk '
        FocusControl = dbedt1
      end
      object lbl2: TLabel
        Left = 16
        Top = 85
        Width = 50
        Height = 13
        Caption = 'F02,name '
        FocusControl = dbedt2
      end
      object lbl3: TLabel
        Left = 8
        Top = 125
        Width = 114
        Height = 13
        Caption = 'F03,DataSetId ,t201.f01'
        FocusControl = dbedt3
      end
      object lbl4: TLabel
        Left = 128
        Top = 85
        Width = 44
        Height = 13
        Caption = 'F06,Note'
        FocusControl = dbedt4
      end
      object lbl5: TLabel
        Left = 128
        Top = 125
        Width = 43
        Height = 13
        Caption = 'F07,Tag '
        FocusControl = dbedt5
      end
      object dbedt1: TDBEdit
        Left = 16
        Top = 61
        Width = 100
        Height = 21
        DataField = 'F01'
        DataSource = ds2
        TabOrder = 0
      end
      object dbedt2: TDBEdit
        Left = 16
        Top = 101
        Width = 100
        Height = 21
        DataField = 'F02'
        DataSource = ds2
        TabOrder = 1
      end
      object dbedt3: TDBEdit
        Left = 16
        Top = 141
        Width = 100
        Height = 21
        DataField = 'F03'
        DataSource = ds2
        TabOrder = 2
        OnChange = dbedt3Change
      end
      object dbchk1: TDBCheckBox
        Left = 128
        Top = 61
        Width = 97
        Height = 18
        Caption = 'F04,ReadOnly '
        DataField = 'F04'
        DataSource = ds2
        TabOrder = 3
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbchk2: TDBCheckBox
        Left = 224
        Top = 61
        Width = 97
        Height = 18
        Caption = 'F05,dgEditing '
        DataField = 'F05'
        DataSource = ds2
        TabOrder = 4
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbedt4: TDBEdit
        Left = 128
        Top = 101
        Width = 185
        Height = 21
        DataField = 'F06'
        DataSource = ds2
        TabOrder = 5
      end
      object dbedt5: TDBEdit
        Left = 128
        Top = 141
        Width = 185
        Height = 21
        DataField = 'F07'
        DataSource = ds2
        TabOrder = 6
      end
      object dbchk3: TDBCheckBox
        Left = 360
        Top = 61
        Width = 97
        Height = 18
        Caption = 'F08,Sys '
        DataField = 'F08'
        DataSource = ds2
        TabOrder = 7
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbchk4: TDBCheckBox
        Left = 360
        Top = 101
        Width = 97
        Height = 18
        Caption = 'F09,dgMultiSelect '
        DataField = 'F09'
        DataSource = ds2
        TabOrder = 8
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbchk5: TDBCheckBox
        Left = 360
        Top = 141
        Width = 97
        Height = 18
        Caption = 'F10,dgRowSelect '
        DataField = 'F10'
        DataSource = ds2
        TabOrder = 9
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbchk6: TDBCheckBox
        Left = 480
        Top = 61
        Width = 97
        Height = 18
        Caption = 'F11,dgColLines'#13#10' '
        DataField = 'F11'
        DataSource = ds2
        TabOrder = 10
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbchk7: TDBCheckBox
        Left = 480
        Top = 101
        Width = 97
        Height = 18
        Caption = 'F12,dgRowLines '
        DataField = 'F12'
        DataSource = ds2
        TabOrder = 11
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbchk8: TDBCheckBox
        Left = 480
        Top = 138
        Width = 153
        Height = 18
        Caption = 'F13dgAlwaysShowEditor '
        DataField = 'F13'
        DataSource = ds2
        TabOrder = 12
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object edtgridID: TEdit
        Left = 16
        Top = 16
        Width = 105
        Height = 21
        TabOrder = 13
      end
    end
    object ts2: TTabSheet
      Caption = #21152't201 '#20889'commandtext  '
      ImageIndex = 1
      object lbl6: TLabel
        Left = 16
        Top = 64
        Width = 32
        Height = 13
        Caption = 'F01,id '
        FocusControl = dbedt6
      end
      object lbl7: TLabel
        Left = 16
        Top = 104
        Width = 50
        Height = 13
        Caption = 'F02,name '
        FocusControl = dbedt7
      end
      object lbl8: TLabel
        Left = 16
        Top = 184
        Width = 214
        Height = 13
        Caption = 'F03,cmdText   '#21442#25968#35821#21477#21518#35201#21152' where 1<>! '
        FocusControl = dbedt8
      end
      object lbl9: TLabel
        Left = 128
        Top = 16
        Width = 110
        Height = 13
        Caption = 'F04,cmdType 0,1=proc'
        FocusControl = dbedt9
      end
      object lbl10: TLabel
        Left = 128
        Top = 104
        Width = 68
        Height = 13
        Caption = 'F05,lockType '
        FocusControl = dbedt10
      end
      object lbl11: TLabel
        Left = 128
        Top = 144
        Width = 43
        Height = 13
        Caption = 'F06,filter '
        FocusControl = dbedt11
      end
      object lbl12: TLabel
        Left = 344
        Top = 24
        Width = 41
        Height = 13
        Caption = 'F07,sort '
        FocusControl = dbedt12
      end
      object lbl13: TLabel
        Left = 264
        Top = 64
        Width = 180
        Height = 13
        Caption = 'F09,BeforePostId  append triggered 4 '
        FocusControl = dbedt13
      end
      object lbl14: TLabel
        Left = 264
        Top = 104
        Width = 201
        Height = 13
        Caption = 'F10,AfterInsertId 2 '#20998#26512#27169#22359' '#21442#25968#36171#21021#20540
        FocusControl = dbedt14
      end
      object lbl15: TLabel
        Left = 264
        Top = 144
        Width = 104
        Height = 13
        Caption = 'F11,BeforeDeleteId 3 '
        FocusControl = dbedt15
      end
      object lbl16: TLabel
        Left = 472
        Top = 24
        Width = 88
        Height = 13
        Caption = 'F12,AfterPostId  5 '
        FocusControl = dbedt16
      end
      object lbl17: TLabel
        Left = 472
        Top = 64
        Width = 91
        Height = 13
        Caption = 'F13,SysParams '#65311' '
        FocusControl = dbedt17
      end
      object lbl18: TLabel
        Left = 472
        Top = 104
        Width = 111
        Height = 13
        Caption = 'F14,OnCalcFieldId  13  '
        FocusControl = dbedt18
      end
      object lbl19: TLabel
        Left = 472
        Top = 144
        Width = 178
        Height = 13
        Caption = 'F15,AfterOpenId ,(formid 85 '#32467#20313'  8 ) '
        FocusControl = dbedt19
      end
      object lbl20: TLabel
        Left = 128
        Top = 64
        Width = 90
        Height = 13
        Caption = '0:ltBatchOptimistic;'
      end
      object lbl30: TLabel
        Left = 128
        Top = 80
        Width = 126
        Height = 13
        Caption = '1:ltOptimistic;3:ltReadOnly;'
      end
      object Label1: TLabel
        Left = 24
        Top = 144
        Width = 70
        Height = 13
        Caption = 'F16 tablename'
      end
      object dbedt6: TDBEdit
        Left = 16
        Top = 80
        Width = 100
        Height = 21
        DataField = 'F01'
        DataSource = ds1
        TabOrder = 0
      end
      object dbedt7: TDBEdit
        Left = 16
        Top = 120
        Width = 100
        Height = 21
        DataField = 'F02'
        DataSource = ds1
        TabOrder = 1
      end
      object dbedt8: TDBEdit
        Left = 16
        Top = 200
        Width = 41
        Height = 21
        DataField = 'F03'
        DataSource = ds1
        TabOrder = 2
      end
      object dbedt9: TDBEdit
        Left = 128
        Top = 40
        Width = 100
        Height = 21
        DataField = 'F04'
        DataSource = ds1
        TabOrder = 3
      end
      object dbedt10: TDBEdit
        Left = 128
        Top = 120
        Width = 100
        Height = 21
        DataField = 'F05'
        DataSource = ds1
        TabOrder = 4
      end
      object dbedt11: TDBEdit
        Left = 128
        Top = 160
        Width = 100
        Height = 21
        DataField = 'F06'
        DataSource = ds1
        TabOrder = 5
      end
      object dbedt12: TDBEdit
        Left = 344
        Top = 40
        Width = 100
        Height = 21
        DataField = 'F07'
        DataSource = ds1
        TabOrder = 6
      end
      object dbchk9: TDBCheckBox
        Left = 264
        Top = 40
        Width = 73
        Height = 17
        Caption = 'F08,sys '
        DataField = 'F08'
        DataSource = ds1
        TabOrder = 7
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbedt13: TDBEdit
        Left = 264
        Top = 80
        Width = 185
        Height = 21
        DataField = 'F09'
        DataSource = ds1
        TabOrder = 8
      end
      object dbedt14: TDBEdit
        Left = 264
        Top = 120
        Width = 185
        Height = 21
        DataField = 'F10'
        DataSource = ds1
        TabOrder = 9
      end
      object dbedt15: TDBEdit
        Left = 264
        Top = 160
        Width = 185
        Height = 21
        DataField = 'F11'
        DataSource = ds1
        TabOrder = 10
      end
      object dbedt16: TDBEdit
        Left = 472
        Top = 40
        Width = 97
        Height = 21
        DataField = 'F12'
        DataSource = ds1
        TabOrder = 11
      end
      object dbedt17: TDBEdit
        Left = 472
        Top = 80
        Width = 100
        Height = 21
        DataField = 'F13'
        DataSource = ds1
        TabOrder = 12
      end
      object dbedt18: TDBEdit
        Left = 472
        Top = 120
        Width = 100
        Height = 21
        DataField = 'F14'
        DataSource = ds1
        TabOrder = 13
      end
      object dbedt19: TDBEdit
        Left = 472
        Top = 160
        Width = 100
        Height = 21
        DataField = 'F15'
        DataSource = ds1
        TabOrder = 14
      end
      object edtmtdatasetID: TEdit
        Left = 16
        Top = 40
        Width = 97
        Height = 21
        TabOrder = 15
      end
      object DBEdit1: TDBEdit
        Left = 16
        Top = 160
        Width = 97
        Height = 21
        DataField = 'F16'
        DataSource = ds1
        TabOrder = 16
      end
      object DBMemo1: TDBMemo
        Left = 80
        Top = 200
        Width = 497
        Height = 129
        DataField = 'F03'
        DataSource = ds1
        TabOrder = 17
      end
    end
    object tsGetTreeViewID: TTabSheet
      Caption = 'T507, tsGetTreeViewID'
      ImageIndex = 2
      object lbl21: TLabel
        Left = 16
        Top = 24
        Width = 30
        Height = 13
        Caption = 'F01,Id'
        FocusControl = dbedt20
      end
      object lbl22: TLabel
        Left = 16
        Top = 64
        Width = 49
        Height = 13
        Caption = 'F02,Name'
        FocusControl = dbedt21
      end
      object lbl23: TLabel
        Left = 16
        Top = 104
        Width = 44
        Height = 13
        Caption = 'F03,Note'
        FocusControl = dbedt22
      end
      object lbl24: TLabel
        Left = 264
        Top = 24
        Width = 62
        Height = 13
        Caption = 'F05,RootTxt '
        FocusControl = dbedt23
      end
      object lbl25: TLabel
        Left = 136
        Top = 64
        Width = 75
        Height = 13
        Caption = 'F06,RootImgIdx'
        FocusControl = dbedt24
      end
      object lbl26: TLabel
        Left = 144
        Top = 104
        Width = 69
        Height = 13
        Caption = 'F07,DataSetId'
        FocusControl = dbedt25
      end
      object lbl27: TLabel
        Left = 416
        Top = 24
        Width = 82
        Height = 13
        Caption = 'F08,NodeTextFld'
        FocusControl = dbedt26
      end
      object lbl28: TLabel
        Left = 416
        Top = 64
        Width = 84
        Height = 13
        Caption = 'F09,NodeDataFld'
        FocusControl = dbedt27
      end
      object lbl29: TLabel
        Left = 416
        Top = 104
        Width = 52
        Height = 13
        Caption = 'F10,Width '
        FocusControl = dbedt28
      end
      object dbedt20: TDBEdit
        Left = 16
        Top = 40
        Width = 100
        Height = 21
        DataField = 'F01'
        DataSource = ds3
        TabOrder = 0
      end
      object dbedt21: TDBEdit
        Left = 16
        Top = 80
        Width = 100
        Height = 21
        DataField = 'F02'
        DataSource = ds3
        TabOrder = 1
      end
      object dbedt22: TDBEdit
        Left = 16
        Top = 120
        Width = 100
        Height = 21
        DataField = 'F03'
        DataSource = ds3
        TabOrder = 2
      end
      object dbchk10: TDBCheckBox
        Left = 136
        Top = 40
        Width = 121
        Height = 17
        Caption = 'F04,Sys'#13#10
        DataField = 'F04'
        DataSource = ds3
        TabOrder = 3
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbedt23: TDBEdit
        Left = 264
        Top = 40
        Width = 131
        Height = 21
        DataField = 'F05'
        DataSource = ds3
        TabOrder = 4
      end
      object dbedt24: TDBEdit
        Left = 136
        Top = 80
        Width = 129
        Height = 21
        DataField = 'F06'
        DataSource = ds3
        TabOrder = 5
        OnChange = dbedt24Change
      end
      object dbedt25: TDBEdit
        Left = 136
        Top = 120
        Width = 259
        Height = 21
        DataField = 'F07'
        DataSource = ds3
        TabOrder = 6
      end
      object dbedt26: TDBEdit
        Left = 416
        Top = 40
        Width = 100
        Height = 21
        DataField = 'F08'
        DataSource = ds3
        TabOrder = 7
      end
      object dbedt27: TDBEdit
        Left = 416
        Top = 80
        Width = 100
        Height = 21
        DataField = 'F09'
        DataSource = ds3
        TabOrder = 8
      end
      object dbedt28: TDBEdit
        Left = 416
        Top = 120
        Width = 100
        Height = 21
        DataField = 'F10'
        DataSource = ds3
        TabOrder = 9
      end
      object cbbImageID: TComboBoxEx
        Left = 264
        Top = 80
        Width = 129
        Height = 22
        ItemsEx = <>
        ItemHeight = 16
        TabOrder = 10
        Text = 'cbbImageID'
        OnClick = cbbImageIDClick
        Images = dmFrm.ImageList1
        DropDownCount = 8
      end
    end
    object ts3: TTabSheet
      Caption = 'T402 Bill '#24323#21333#23384#20648#36807#31243
      ImageIndex = 3
      object lbl31: TLabel
        Left = 32
        Top = 16
        Width = 138
        Height = 13
        Caption = 'F01,pk,mtdaatasetID '#25163#21160#22635
        FocusControl = dbedt29
      end
      object lbl32: TLabel
        Left = 64
        Top = 56
        Width = 74
        Height = 13
        Caption = 'F02,ProcName '
        FocusControl = dbedt30
      end
      object lbl33: TLabel
        Left = 200
        Top = 16
        Width = 79
        Height = 13
        Caption = 'F03 ,SysParams '
        FocusControl = dbedt31
      end
      object lbl34: TLabel
        Left = 200
        Top = 56
        Width = 78
        Height = 13
        Caption = 'F04 ,UsrParams '
        FocusControl = dbedt32
      end
      object lbl35: TLabel
        Left = 336
        Top = 16
        Width = 61
        Height = 13
        Caption = 'F05 ,RightId '
        FocusControl = dbedt33
      end
      object dbedt29: TDBEdit
        Left = 64
        Top = 32
        Width = 100
        Height = 21
        DataField = 'F01'
        DataSource = ds4
        TabOrder = 0
      end
      object dbedt30: TDBEdit
        Left = 64
        Top = 72
        Width = 100
        Height = 21
        DataField = 'F02'
        DataSource = ds4
        TabOrder = 1
      end
      object dbedt31: TDBEdit
        Left = 200
        Top = 32
        Width = 100
        Height = 21
        DataField = 'F03'
        DataSource = ds4
        TabOrder = 2
      end
      object dbedt32: TDBEdit
        Left = 200
        Top = 72
        Width = 100
        Height = 21
        DataField = 'F04'
        DataSource = ds4
        TabOrder = 3
      end
      object dbedt33: TDBEdit
        Left = 336
        Top = 32
        Width = 100
        Height = 21
        DataField = 'F05'
        DataSource = ds4
        TabOrder = 4
      end
      object dbnvgr2: TDBNavigator
        Left = 192
        Top = 184
        Width = 240
        Height = 25
        DataSource = ds4
        TabOrder = 5
      end
    end
    object ts4: TTabSheet
      Caption = 'ts4 T202 '#32500#25252#24314#31435#30340#23383#27573
      ImageIndex = 4
      object lbl36: TLabel
        Left = 184
        Top = 16
        Width = 57
        Height = 13
        Caption = 'F01,auto pk'
        FocusControl = dbedt34
      end
      object lbl37: TLabel
        Left = 184
        Top = 56
        Width = 64
        Height = 13
        Caption = 'F02,datasetid'
        FocusControl = dbedt35
      end
      object lbl38: TLabel
        Left = 184
        Top = 96
        Width = 40
        Height = 13
        Caption = 'F03,fldid'
        FocusControl = dbedt36
      end
      object lbl39: TLabel
        Left = 336
        Top = 16
        Width = 79
        Height = 13
        Caption = 'F04  ,DefaultVal '
      end
      object lbl40: TLabel
        Left = 336
        Top = 96
        Width = 58
        Height = 13
        Caption = 'F06 ,OrdIdx '
        FocusControl = dbedt38
      end
      object lbl41: TLabel
        Left = 496
        Top = 16
        Width = 117
        Height = 13
        Caption = 'F07, 7-26add   fieldname'
        FocusControl = dbedt39
      end
      object lblfieldname: TLabel
        Left = 224
        Top = 216
        Width = 55
        Height = 13
        Caption = 'lblfieldname'
      end
      object lbl83: TLabel
        Left = 192
        Top = 216
        Width = 18
        Height = 13
        Caption = 'F02'
        FocusControl = dbedt78
      end
      object lbl90: TLabel
        Left = 376
        Top = 208
        Width = 20
        Height = 13
        Caption = 'type'
      end
      object lbl91: TLabel
        Left = 192
        Top = 264
        Width = 18
        Height = 13
        Caption = 'size'
      end
      object lbl92: TLabel
        Left = 496
        Top = 56
        Width = 18
        Height = 13
        Caption = 'F08'
        FocusControl = dbedt87
      end
      object lbl93: TLabel
        Left = 496
        Top = 96
        Width = 18
        Height = 13
        Caption = 'F09'
        FocusControl = dbedt88
      end
      object lbl94: TLabel
        Left = 352
        Top = 152
        Width = 52
        Height = 13
        Caption = 'T202 Edit  '
      end
      object dbedt34: TDBEdit
        Left = 184
        Top = 32
        Width = 134
        Height = 21
        DataField = 'F01'
        DataSource = ds6
        TabOrder = 0
      end
      object dbedt35: TDBEdit
        Left = 184
        Top = 72
        Width = 134
        Height = 21
        DataField = 'F02'
        DataSource = ds6
        TabOrder = 1
      end
      object dbedt36: TDBEdit
        Left = 184
        Top = 112
        Width = 134
        Height = 21
        DataField = 'F03'
        DataSource = ds6
        TabOrder = 2
      end
      object dbchk11: TDBCheckBox
        Left = 336
        Top = 72
        Width = 97
        Height = 17
        Caption = 'F05  ,Required'
        DataField = 'F05'
        DataSource = ds6
        TabOrder = 3
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbedt38: TDBEdit
        Left = 336
        Top = 112
        Width = 134
        Height = 21
        DataField = 'F06'
        DataSource = ds6
        TabOrder = 4
      end
      object dbedt39: TDBEdit
        Left = 496
        Top = 32
        Width = 134
        Height = 21
        DataField = 'F07'
        DataSource = ds6
        TabOrder = 5
      end
      object dbcbb1: TDBComboBox
        Left = 336
        Top = 32
        Width = 145
        Height = 21
        DataField = 'F04'
        DataSource = ds6
        ItemHeight = 13
        Items.Strings = (
          '0'
          '000'
          '060101'
          '1'
          '1.1'
          '15'
          '30'
          'DIP'
          'sClientKey'
          'sEmpId'
          'sEmpty'
          'sLoginId'
          'sNow'
          'sToday'
          'sToday-30'
          'sToday-31'
          'sToday-365'
          'sToday-5'
          'sWhId'
          'sYdId'
          #21040#26399
          #30007
          #20840#37096
          #23454#38469#24211#23384
          #24448#26469
          #21482
          #21046#21333#26085#26399)
        TabOrder = 6
      end
      object grp1: TGroupBox
        Left = 16
        Top = 24
        Width = 145
        Height = 281
        Caption = 'grp1 exist fields'
        DragKind = dkDock
        DragMode = dmAutomatic
        TabOrder = 7
        object lstFields: TListBox
          Left = 2
          Top = 15
          Width = 141
          Height = 264
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
          OnClick = lstFieldsClick
        end
      end
      object dbedt78: TDBEdit
        Left = 192
        Top = 232
        Width = 100
        Height = 21
        DataField = 'F02'
        DataSource = ds5
        TabOrder = 8
      end
      object dbedt85: TDBEdit
        Left = 360
        Top = 232
        Width = 121
        Height = 21
        DataField = 'F04'
        DataSource = ds5
        TabOrder = 9
        OnChange = dbedt85Change
      end
      object dbedt86: TDBEdit
        Left = 192
        Top = 280
        Width = 105
        Height = 21
        DataField = 'F06'
        DataSource = ds5
        TabOrder = 10
      end
      object lstfieldtype: TListBox
        Left = 736
        Top = 56
        Width = 169
        Height = 185
        ItemHeight = 13
        Items.Strings = (
          'cftString:   0         '
          'cftDate:     1         '
          'cftDateTime: 2         '
          'cftBoolean:  3         '
          'cftFloat:    4         '
          'cftCurrency: 5         '
          'cftMemo:     6         '
          'cftBlob:     7         '
          'cftBytes:    8         '
          'cftAutoInc:  9         '
          'cftInteger: 10        '
          'cftImage:   11        '
          '')
        TabOrder = 11
      end
      object dbedt87: TDBEdit
        Left = 496
        Top = 72
        Width = 150
        Height = 21
        DataField = 'F08'
        DataSource = ds6
        TabOrder = 12
      end
      object dbedt88: TDBEdit
        Left = 496
        Top = 112
        Width = 150
        Height = 21
        DataField = 'F09'
        DataSource = ds6
        TabOrder = 13
      end
      object dbnvgr3: TDBNavigator
        Left = 408
        Top = 144
        Width = 240
        Height = 25
        DataSource = ds6
        TabOrder = 14
      end
    end
    object ts5: TTabSheet
      Caption = 'ts5 102'
      ImageIndex = 5
      object lbl43: TLabel
        Left = 280
        Top = 56
        Width = 86
        Height = 13
        Caption = 'F14 lkp dstaset id '
        FocusControl = dbedt37
      end
      object lbl44: TLabel
        Left = 16
        Top = 24
        Width = 30
        Height = 13
        Caption = 'F01,Id'
        FocusControl = dbedt40
      end
      object lbl45: TLabel
        Left = 16
        Top = 64
        Width = 49
        Height = 13
        Caption = 'F02,Name'
        FocusControl = dbedt41
      end
      object lbl46: TLabel
        Left = 16
        Top = 104
        Width = 45
        Height = 13
        Caption = 'F03 TblId'
        FocusControl = dbedt42
      end
      object lbl47: TLabel
        Left = 16
        Top = 144
        Width = 54
        Height = 13
        Caption = 'F04 TypeId'
        FocusControl = dbedt43
      end
      object lbl48: TLabel
        Left = 16
        Top = 184
        Width = 51
        Height = 26
        Caption = 'F05 KindId'#13#10
        FocusControl = dbedt44
      end
      object lbl49: TLabel
        Left = 16
        Top = 224
        Width = 41
        Height = 13
        Caption = 'F06 Size'
        FocusControl = dbedt45
      end
      object lbl50: TLabel
        Left = 136
        Top = 24
        Width = 53
        Height = 13
        Caption = 'F07 Format'
        FocusControl = dbedt46
      end
      object lbl51: TLabel
        Left = 136
        Top = 64
        Width = 56
        Height = 13
        Caption = 'F08a  Label'
        FocusControl = dbedt47
      end
      object lbl52: TLabel
        Left = 136
        Top = 104
        Width = 70
        Height = 13
        Caption = 'F09 DefaultVal'
        FocusControl = dbedt48
      end
      object lbl53: TLabel
        Left = 136
        Top = 144
        Width = 58
        Height = 13
        Caption = 'F10 PickList'
        FocusControl = dbedt49
      end
      object lbl54: TLabel
        Left = 136
        Top = 184
        Width = 63
        Height = 13
        Caption = 'F11 OnlyPick'
        FocusControl = dbedt50
      end
      object lbl55: TLabel
        Left = 280
        Top = 104
        Width = 53
        Height = 13
        Caption = 'F15 KeyFld'
        FocusControl = dbedt51
      end
      object lbl56: TLabel
        Left = 280
        Top = 144
        Width = 71
        Height = 13
        Caption = 'F16 LkpKeyFld'
        FocusControl = dbedt52
      end
      object lbl57: TLabel
        Left = 280
        Top = 184
        Width = 86
        Height = 13
        Caption = 'F17  LkpResultFld'
        FocusControl = dbedt53
      end
      object lbl58: TLabel
        Left = 280
        Top = 224
        Width = 74
        Height = 26
        Caption = 'F18 LkpListFlds'#13#10
        FocusControl = dbedt54
      end
      object lbl59: TLabel
        Left = 408
        Top = 24
        Width = 79
        Height = 13
        Caption = 'F19 CalcFormula'
        FocusControl = dbedt55
      end
      object dbedt37: TDBEdit
        Left = 280
        Top = 72
        Width = 100
        Height = 21
        DataField = 'F14'
        DataSource = ds5
        TabOrder = 0
      end
      object dbedt40: TDBEdit
        Left = 16
        Top = 40
        Width = 100
        Height = 21
        DataField = 'F01'
        DataSource = ds5
        TabOrder = 1
      end
      object dbedt41: TDBEdit
        Left = 16
        Top = 80
        Width = 100
        Height = 21
        DataField = 'F02'
        DataSource = ds5
        TabOrder = 2
      end
      object dbedt42: TDBEdit
        Left = 16
        Top = 120
        Width = 100
        Height = 21
        DataField = 'F03'
        DataSource = ds5
        TabOrder = 3
      end
      object dbedt43: TDBEdit
        Left = 16
        Top = 160
        Width = 100
        Height = 21
        DataField = 'F04'
        DataSource = ds5
        TabOrder = 4
      end
      object dbedt44: TDBEdit
        Left = 16
        Top = 200
        Width = 97
        Height = 21
        DataField = 'F05'
        DataSource = ds5
        TabOrder = 5
      end
      object dbedt45: TDBEdit
        Left = 16
        Top = 240
        Width = 100
        Height = 21
        DataField = 'F06'
        DataSource = ds5
        TabOrder = 6
      end
      object dbedt46: TDBEdit
        Left = 136
        Top = 40
        Width = 100
        Height = 21
        DataField = 'F07'
        DataSource = ds5
        TabOrder = 7
      end
      object dbedt47: TDBEdit
        Left = 136
        Top = 80
        Width = 100
        Height = 21
        DataField = 'F08a'
        DataSource = ds5
        TabOrder = 8
      end
      object dbedt48: TDBEdit
        Left = 136
        Top = 120
        Width = 100
        Height = 21
        DataField = 'F09'
        DataSource = ds5
        TabOrder = 9
      end
      object dbedt49: TDBEdit
        Left = 136
        Top = 160
        Width = 100
        Height = 21
        DataField = 'F10'
        DataSource = ds5
        TabOrder = 10
      end
      object dbedt50: TDBEdit
        Left = 136
        Top = 200
        Width = 100
        Height = 21
        DataField = 'F11'
        DataSource = ds5
        TabOrder = 11
      end
      object dbchk12: TDBCheckBox
        Left = 136
        Top = 240
        Width = 97
        Height = 17
        Caption = 'F12  Required'
        DataField = 'F12'
        DataSource = ds5
        TabOrder = 12
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbchk13: TDBCheckBox
        Left = 280
        Top = 32
        Width = 97
        Height = 17
        Caption = 'F13  LkpDataSetId'
        DataField = 'F13'
        DataSource = ds5
        TabOrder = 13
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbedt51: TDBEdit
        Left = 280
        Top = 120
        Width = 100
        Height = 21
        DataField = 'F15'
        DataSource = ds5
        TabOrder = 14
      end
      object dbedt52: TDBEdit
        Left = 280
        Top = 160
        Width = 100
        Height = 21
        DataField = 'F16'
        DataSource = ds5
        TabOrder = 15
      end
      object dbedt53: TDBEdit
        Left = 280
        Top = 200
        Width = 100
        Height = 21
        DataField = 'F17'
        DataSource = ds5
        TabOrder = 16
      end
      object dbedt54: TDBEdit
        Left = 280
        Top = 240
        Width = 100
        Height = 21
        DataField = 'F18'
        DataSource = ds5
        TabOrder = 17
      end
      object dbedt55: TDBEdit
        Left = 408
        Top = 40
        Width = 100
        Height = 21
        DataField = 'F19'
        DataSource = ds5
        TabOrder = 18
      end
    end
    object ts6: TTabSheet
      Caption = 'ts6 T204before post '
      ImageIndex = 6
      object lbl60: TLabel
        Left = 48
        Top = 16
        Width = 156
        Height = 13
        Caption = #21442#25968'datasetID           dataset.tag'
      end
      object lbl61: TLabel
        Left = 32
        Top = 56
        Width = 72
        Height = 13
        Caption = 'F01  DataSetId'
        FocusControl = dbedt56
      end
      object lbl62: TLabel
        Left = 32
        Top = 96
        Width = 49
        Height = 13
        Caption = 'F02 Name'
        FocusControl = dbedt57
      end
      object lbl63: TLabel
        Left = 32
        Top = 136
        Width = 75
        Height = 13
        Caption = 'F05 AutoKeyFld'
        FocusControl = dbedt58
      end
      object lbl64: TLabel
        Left = 32
        Top = 176
        Width = 70
        Height = 13
        Caption = 'F06 AutoKeyId'
        FocusControl = dbedt59
      end
      object lbl65: TLabel
        Left = 176
        Top = 56
        Width = 82
        Height = 13
        Caption = 'F09 SameValFlds'
        FocusControl = dbedt60
      end
      object lbl66: TLabel
        Left = 176
        Top = 96
        Width = 85
        Height = 13
        Caption = 'F10  SameValHint'
        FocusControl = dbedt61
      end
      object lbl67: TLabel
        Left = 176
        Top = 136
        Width = 65
        Height = 13
        Caption = 'F11  AddRitId'
        FocusControl = dbedt62
      end
      object lbl68: TLabel
        Left = 176
        Top = 176
        Width = 64
        Height = 13
        Caption = 'F12, EditRitId'
        FocusControl = dbedt63
      end
      object lbl69: TLabel
        Left = 304
        Top = 48
        Width = 62
        Height = 13
        Caption = 'F13,EdtProc '
        FocusControl = dbedt64
      end
      object lbl70: TLabel
        Left = 304
        Top = 88
        Width = 95
        Height = 13
        Caption = 'F14, EdtSysParams '
        FocusControl = dbedt65
      end
      object lbl71: TLabel
        Left = 304
        Top = 128
        Width = 91
        Height = 13
        Caption = 'F15 EdtUsrParams '
        FocusControl = dbedt66
      end
      object lbl72: TLabel
        Left = 304
        Top = 168
        Width = 64
        Height = 13
        Caption = 'F17 PostHint '
        FocusControl = dbedt67
      end
      object lbl73: TLabel
        Left = 424
        Top = 48
        Width = 94
        Height = 13
        Caption = 'F18 PostSysParams'
        FocusControl = dbedt68
      end
      object lbl74: TLabel
        Left = 424
        Top = 88
        Width = 96
        Height = 13
        Caption = 'F19  PostUsrParams'
        FocusControl = dbedt69
      end
      object dbedt56: TDBEdit
        Left = 32
        Top = 72
        Width = 100
        Height = 21
        DataField = 'F01'
        DataSource = ds7
        TabOrder = 0
      end
      object dbedt57: TDBEdit
        Left = 32
        Top = 112
        Width = 100
        Height = 21
        DataField = 'F02'
        DataSource = ds7
        TabOrder = 1
      end
      object dbedt58: TDBEdit
        Left = 32
        Top = 152
        Width = 100
        Height = 21
        DataField = 'F05'
        DataSource = ds7
        TabOrder = 2
      end
      object dbedt59: TDBEdit
        Left = 32
        Top = 192
        Width = 100
        Height = 21
        DataField = 'F06'
        DataSource = ds7
        TabOrder = 3
      end
      object dbedt60: TDBEdit
        Left = 176
        Top = 72
        Width = 100
        Height = 21
        DataField = 'F09'
        DataSource = ds7
        TabOrder = 4
      end
      object dbedt61: TDBEdit
        Left = 176
        Top = 112
        Width = 100
        Height = 21
        DataField = 'F10'
        DataSource = ds7
        TabOrder = 5
      end
      object dbedt62: TDBEdit
        Left = 176
        Top = 152
        Width = 100
        Height = 21
        DataField = 'F11'
        DataSource = ds7
        TabOrder = 6
      end
      object dbedt63: TDBEdit
        Left = 176
        Top = 192
        Width = 100
        Height = 21
        DataField = 'F12'
        DataSource = ds7
        TabOrder = 7
      end
      object dbedt64: TDBEdit
        Left = 304
        Top = 64
        Width = 100
        Height = 21
        DataField = 'F13'
        DataSource = ds7
        TabOrder = 8
      end
      object dbedt65: TDBEdit
        Left = 304
        Top = 104
        Width = 100
        Height = 21
        DataField = 'F14'
        DataSource = ds7
        TabOrder = 9
      end
      object dbedt66: TDBEdit
        Left = 304
        Top = 144
        Width = 100
        Height = 21
        DataField = 'F15'
        DataSource = ds7
        TabOrder = 10
      end
      object dbedt67: TDBEdit
        Left = 304
        Top = 184
        Width = 100
        Height = 21
        DataField = 'F17'
        DataSource = ds7
        TabOrder = 11
      end
      object dbedt68: TDBEdit
        Left = 424
        Top = 64
        Width = 100
        Height = 21
        DataField = 'F18'
        DataSource = ds7
        TabOrder = 12
      end
      object dbedt69: TDBEdit
        Left = 424
        Top = 104
        Width = 100
        Height = 21
        DataField = 'F19'
        DataSource = ds7
        TabOrder = 13
      end
    end
    object ts7: TTabSheet
      Caption = 'T203 BeforeDelete'
      ImageIndex = 7
      object lbl75: TLabel
        Left = 32
        Top = 48
        Width = 72
        Height = 13
        Caption = 'F01  DataSetId'
        FocusControl = dbedt70
      end
      object lbl76: TLabel
        Left = 32
        Top = 88
        Width = 52
        Height = 13
        Caption = 'F02  Name'
        FocusControl = dbedt71
      end
      object lbl77: TLabel
        Left = 32
        Top = 128
        Width = 43
        Height = 13
        Caption = 'F03  Hint'
        FocusControl = dbedt72
      end
      object lbl78: TLabel
        Left = 192
        Top = 48
        Width = 49
        Height = 13
        Caption = 'F04   Proc'
        FocusControl = dbedt73
      end
      object lbl79: TLabel
        Left = 192
        Top = 88
        Width = 76
        Height = 13
        Caption = 'F05  SysParams'
        FocusControl = dbedt74
      end
      object lbl80: TLabel
        Left = 192
        Top = 128
        Width = 85
        Height = 26
        Caption = 'F06   DataParams'#13#10
        FocusControl = dbedt75
      end
      object lbl81: TLabel
        Left = 320
        Top = 48
        Width = 62
        Height = 26
        Caption = 'F07 ErrorHint'#13#10
        FocusControl = dbedt76
      end
      object lbl82: TLabel
        Left = 320
        Top = 88
        Width = 62
        Height = 13
        Caption = 'F08  DelRitId'
        FocusControl = dbedt77
      end
      object dbedt70: TDBEdit
        Left = 32
        Top = 64
        Width = 100
        Height = 21
        DataField = 'F01'
        DataSource = ds8
        TabOrder = 0
      end
      object dbedt71: TDBEdit
        Left = 32
        Top = 104
        Width = 100
        Height = 21
        DataField = 'F02'
        DataSource = ds8
        TabOrder = 1
      end
      object dbedt72: TDBEdit
        Left = 32
        Top = 144
        Width = 100
        Height = 21
        DataField = 'F03'
        DataSource = ds8
        TabOrder = 2
      end
      object dbedt73: TDBEdit
        Left = 192
        Top = 64
        Width = 100
        Height = 21
        DataField = 'F04'
        DataSource = ds8
        TabOrder = 3
      end
      object dbedt74: TDBEdit
        Left = 192
        Top = 104
        Width = 100
        Height = 21
        DataField = 'F05'
        DataSource = ds8
        TabOrder = 4
      end
      object dbedt75: TDBEdit
        Left = 192
        Top = 144
        Width = 100
        Height = 21
        DataField = 'F06'
        DataSource = ds8
        TabOrder = 5
      end
      object dbedt76: TDBEdit
        Left = 320
        Top = 64
        Width = 100
        Height = 21
        DataField = 'F07'
        DataSource = ds8
        TabOrder = 6
      end
      object dbedt77: TDBEdit
        Left = 320
        Top = 104
        Width = 100
        Height = 21
        DataField = 'F08'
        DataSource = ds8
        TabOrder = 7
      end
    end
    object ts8: TTabSheet
      Caption = 'after post T205'
      ImageIndex = 8
      object lbl84: TLabel
        Left = 48
        Top = 88
        Width = 72
        Height = 13
        Caption = 'F01 DataSetId '
        FocusControl = dbedt79
      end
      object lbl85: TLabel
        Left = 48
        Top = 128
        Width = 52
        Height = 13
        Caption = 'F02 Name '
        FocusControl = dbedt80
      end
      object lbl86: TLabel
        Left = 48
        Top = 168
        Width = 49
        Height = 13
        Caption = 'F03  Proc '
        FocusControl = dbedt81
      end
      object lbl87: TLabel
        Left = 176
        Top = 88
        Width = 73
        Height = 13
        Caption = 'F04 SysParams'
        FocusControl = dbedt82
      end
      object lbl88: TLabel
        Left = 176
        Top = 128
        Width = 79
        Height = 13
        Caption = 'F05 DataParams'
        FocusControl = dbedt83
      end
      object lbl89: TLabel
        Left = 176
        Top = 168
        Width = 65
        Height = 13
        Caption = 'F06 ErrorHint '
        FocusControl = dbedt84
      end
      object dbedt79: TDBEdit
        Left = 48
        Top = 104
        Width = 100
        Height = 21
        DataField = 'F01'
        DataSource = dsdsT205
        TabOrder = 0
      end
      object dbedt80: TDBEdit
        Left = 48
        Top = 144
        Width = 100
        Height = 21
        DataField = 'F02'
        DataSource = dsdsT205
        TabOrder = 1
      end
      object dbedt81: TDBEdit
        Left = 48
        Top = 184
        Width = 100
        Height = 21
        DataField = 'F03'
        DataSource = dsdsT205
        TabOrder = 2
      end
      object dbedt82: TDBEdit
        Left = 176
        Top = 104
        Width = 100
        Height = 21
        DataField = 'F04'
        DataSource = dsdsT205
        TabOrder = 3
      end
      object dbedt83: TDBEdit
        Left = 176
        Top = 144
        Width = 100
        Height = 21
        DataField = 'F05'
        DataSource = dsdsT205
        TabOrder = 4
      end
      object dbedt84: TDBEdit
        Left = 176
        Top = 184
        Width = 100
        Height = 21
        DataField = 'F06'
        DataSource = dsdsT205
        TabOrder = 5
      end
      object btnT205: TButton
        Left = 48
        Top = 232
        Width = 75
        Height = 25
        Caption = 'btnT205'
        TabOrder = 6
        OnClick = btnT205Click
      end
      object dbnvgr1: TDBNavigator
        Left = 136
        Top = 232
        Width = 240
        Height = 25
        DataSource = dsdsT205
        TabOrder = 7
      end
    end
  end
  object tlb1: TToolBar
    Left = 0
    Top = 0
    Width = 1009
    Height = 57
    ButtonHeight = 21
    ButtonWidth = 46
    Caption = 'tlb1'
    ShowCaptions = True
    TabOrder = 1
    object btnopen: TToolButton
      Left = 0
      Top = 2
      Caption = 'btnopen'
      ImageIndex = 0
      OnClick = btnopenClick
    end
    object btnadd: TButton
      Left = 46
      Top = 2
      Width = 75
      Height = 21
      Caption = 'btnadd'
      TabOrder = 0
      OnClick = btnaddClick
    end
    object btncancel: TButton
      Left = 121
      Top = 2
      Width = 75
      Height = 21
      Caption = 'btncancel'
      TabOrder = 1
      OnClick = btncancelClick
    end
    object btndelete: TButton
      Left = 196
      Top = 2
      Width = 75
      Height = 21
      Caption = 'btndelete'
      TabOrder = 2
      OnClick = btndeleteClick
    end
    object btnsave: TButton
      Left = 271
      Top = 2
      Width = 75
      Height = 21
      Caption = 'btnsave'
      TabOrder = 3
      OnClick = btnsaveClick
    end
    object lbl42: TLabel
      Left = 346
      Top = 2
      Width = 130
      Height = 21
      Caption = #27880#24847'dataset '#30340'connection '
    end
  end
  object dsT201: TADODataSet
    CursorType = ctStatic
    CommandText = 'select * from t201 where f01=:f01'
    Parameters = <
      item
        Name = 'Param1'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 156
    Top = 32
    object dsT201F01: TAutoIncField
      FieldName = 'F01'
      ReadOnly = True
    end
    object dsT201F02: TStringField
      FieldName = 'F02'
      Size = 50
    end
    object dsT201F03: TStringField
      FieldName = 'F03'
      Size = 1000
    end
    object dsT201F04: TIntegerField
      FieldName = 'F04'
    end
    object dsT201F05: TIntegerField
      FieldName = 'F05'
    end
    object dsT201F06: TStringField
      FieldName = 'F06'
      Size = 300
    end
    object dsT201F07: TStringField
      FieldName = 'F07'
      Size = 100
    end
    object dsT201F08: TBooleanField
      FieldName = 'F08'
    end
    object dsT201F09: TIntegerField
      FieldName = 'F09'
    end
    object dsT201F10: TIntegerField
      FieldName = 'F10'
    end
    object dsT201F11: TIntegerField
      FieldName = 'F11'
    end
    object dsT201F12: TIntegerField
      FieldName = 'F12'
    end
    object dsT201F13: TStringField
      FieldName = 'F13'
      Size = 50
    end
    object dsT201F14: TIntegerField
      FieldName = 'F14'
    end
    object dsT201F15: TIntegerField
      FieldName = 'F15'
    end
    object dsT201F16: TStringField
      FieldName = 'F16'
      Size = 30
    end
    object dsT201F17: TIntegerField
      FieldName = 'F17'
    end
  end
  object dsT504: TADODataSet
    CommandText = 'select * from T504 where f01=:f01'#13#10
    Parameters = <>
    Left = 40
    Top = 40
    object dsT504F01: TAutoIncField
      FieldName = 'F01'
      ReadOnly = True
    end
    object dsT504F02: TStringField
      FieldName = 'F02'
      Size = 50
    end
    object dsT504F03: TIntegerField
      FieldName = 'F03'
    end
    object dsT504F04: TBooleanField
      FieldName = 'F04'
    end
    object dsT504F05: TBooleanField
      FieldName = 'F05'
    end
    object dsT504F06: TStringField
      FieldName = 'F06'
      Size = 50
    end
    object dsT504F07: TIntegerField
      FieldName = 'F07'
    end
    object dsT504F08: TBooleanField
      FieldName = 'F08'
    end
    object dsT504F09: TBooleanField
      FieldName = 'F09'
    end
    object dsT504F10: TBooleanField
      FieldName = 'F10'
    end
    object dsT504F11: TBooleanField
      FieldName = 'F11'
    end
    object dsT504F12: TBooleanField
      FieldName = 'F12'
    end
    object dsT504F13: TBooleanField
      FieldName = 'F13'
    end
  end
  object ds1: TDataSource
    DataSet = dsT201
    Left = 184
    Top = 32
  end
  object ds2: TDataSource
    DataSet = dsT504
    Left = 64
    Top = 40
  end
  object dsGetTreeIDT507: TADODataSet
    CommandText = 'select  * from T507  where f01=:f01'#13#10
    Parameters = <
      item
        Name = 'f01'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 304
    Top = 40
    object dsGetTreeIDT507F01: TIntegerField
      FieldName = 'F01'
    end
    object dsGetTreeIDT507F02: TStringField
      FieldName = 'F02'
      Size = 50
    end
    object dsGetTreeIDT507F03: TStringField
      FieldName = 'F03'
      Size = 50
    end
    object dsGetTreeIDT507F04: TBooleanField
      FieldName = 'F04'
    end
    object dsGetTreeIDT507F05: TStringField
      FieldName = 'F05'
      Size = 50
    end
    object dsGetTreeIDT507F06: TIntegerField
      FieldName = 'F06'
    end
    object dsGetTreeIDT507F07: TIntegerField
      FieldName = 'F07'
    end
    object dsGetTreeIDT507F08: TStringField
      FieldName = 'F08'
      Size = 50
    end
    object dsGetTreeIDT507F09: TStringField
      FieldName = 'F09'
      Size = 50
    end
    object dsGetTreeIDT507F10: TIntegerField
      FieldName = 'F10'
    end
  end
  object ds3: TDataSource
    DataSet = dsGetTreeIDT507
    Left = 328
    Top = 40
  end
  object dsT402: TADODataSet
    CommandText = 'select *from t402 where f01=:f01'
    Parameters = <>
    Left = 432
    Top = 32
    object dsT402F01: TIntegerField
      FieldName = 'F01'
    end
    object dsT402F02: TStringField
      FieldName = 'F02'
      Size = 50
    end
    object dsT402F03: TStringField
      FieldName = 'F03'
      Size = 100
    end
    object dsT402F04: TStringField
      FieldName = 'F04'
      Size = 300
    end
    object dsT402F05: TStringField
      FieldName = 'F05'
      Size = 50
    end
  end
  object ds4: TDataSource
    DataSet = dsT402
    Left = 456
    Top = 32
  end
  object dsT202: TADODataSet
    CommandText = 'select * from t202  where f02=:f02  and f03=:f03'
    Parameters = <
      item
        Name = 'f02'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'f03'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 544
    Top = 40
    object dsT202F01: TAutoIncField
      FieldName = 'F01'
      ReadOnly = True
    end
    object dsT202F02: TIntegerField
      FieldName = 'F02'
    end
    object dsT202F03: TIntegerField
      FieldName = 'F03'
    end
    object dsT202F04: TStringField
      FieldName = 'F04'
      Size = 50
    end
    object dsT202F05: TBooleanField
      FieldName = 'F05'
    end
    object dsT202F06: TIntegerField
      FieldName = 'F06'
    end
    object dsT202F07: TStringField
      FieldName = 'F07'
      Size = 50
    end
    object dsT202F08: TStringField
      FieldName = 'F08'
      Size = 200
    end
    object dsT202F09: TStringField
      FieldName = 'F09'
      Size = 200
    end
  end
  object ds6: TDataSource
    DataSet = dsT202
    Left = 568
    Top = 40
  end
  object dsT102: TADODataSet
    CommandText = 'select * from t102  where f01=:f01'
    Parameters = <
      item
        Name = '=f01'
        Size = -1
        Value = Null
      end>
    Left = 664
    Top = 32
    object dsT102F01: TAutoIncField
      FieldName = 'F01'
      ReadOnly = True
    end
    object dsT102F02: TStringField
      FieldName = 'F02'
      Size = 50
    end
    object dsT102F03: TIntegerField
      FieldName = 'F03'
    end
    object dsT102F04: TIntegerField
      FieldName = 'F04'
    end
    object dsT102F05: TStringField
      FieldName = 'F05'
      FixedChar = True
      Size = 1
    end
    object dsT102F06: TIntegerField
      FieldName = 'F06'
    end
    object dsT102F07: TStringField
      FieldName = 'F07'
      Size = 50
    end
    object dsT102F08a: TIntegerField
      FieldName = 'F08a'
    end
    object dsT102F09: TStringField
      FieldName = 'F09'
      Size = 50
    end
    object dsT102F10: TStringField
      FieldName = 'F10'
      Size = 50
    end
    object dsT102F11: TStringField
      FieldName = 'F11'
      Size = 300
    end
    object dsT102F12: TBooleanField
      FieldName = 'F12'
    end
    object dsT102F13: TBooleanField
      FieldName = 'F13'
    end
    object dsT102F14: TIntegerField
      FieldName = 'F14'
    end
    object dsT102F15: TStringField
      FieldName = 'F15'
      Size = 50
    end
    object dsT102F16: TStringField
      FieldName = 'F16'
      Size = 50
    end
    object dsT102F17: TStringField
      FieldName = 'F17'
      Size = 50
    end
    object dsT102F18: TStringField
      FieldName = 'F18'
      Size = 50
    end
    object dsT102F19: TStringField
      FieldName = 'F19'
      Size = 200
    end
  end
  object ds5: TDataSource
    DataSet = dsT102
    Left = 672
    Top = 40
  end
  object dsT204: TADODataSet
    CommandText = 'select * from t204 where f01=:f01'
    Parameters = <>
    Left = 736
    Top = 32
    object dsT204F01: TIntegerField
      FieldName = 'F01'
    end
    object dsT204F02: TStringField
      FieldName = 'F02'
      Size = 50
    end
    object dsT204F05: TStringField
      FieldName = 'F05'
      Size = 50
    end
    object dsT204F06: TIntegerField
      FieldName = 'F06'
    end
    object dsT204F09: TStringField
      FieldName = 'F09'
      Size = 255
    end
    object dsT204F10: TStringField
      FieldName = 'F10'
      Size = 255
    end
    object dsT204F11: TStringField
      FieldName = 'F11'
      Size = 50
    end
    object dsT204F12: TStringField
      FieldName = 'F12'
      Size = 50
    end
    object dsT204F13: TStringField
      FieldName = 'F13'
      Size = 50
    end
    object dsT204F14: TStringField
      FieldName = 'F14'
      Size = 50
    end
    object dsT204F15: TStringField
      FieldName = 'F15'
      Size = 100
    end
    object dsT204F17: TStringField
      FieldName = 'F17'
      Size = 255
    end
    object dsT204F18: TStringField
      FieldName = 'F18'
      Size = 50
    end
    object dsT204F19: TStringField
      FieldName = 'F19'
      Size = 50
    end
  end
  object ds7: TDataSource
    DataSet = dsT204
    Left = 760
    Top = 32
  end
  object dsT203: TADODataSet
    CommandText = 'select * From t203   where f01=:f01'
    Parameters = <
      item
        Name = 'f01'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 832
    Top = 32
    object dsT203F01: TIntegerField
      FieldName = 'F01'
    end
    object dsT203F02: TStringField
      FieldName = 'F02'
      Size = 50
    end
    object dsT203F03: TStringField
      FieldName = 'F03'
      Size = 255
    end
    object dsT203F04: TStringField
      FieldName = 'F04'
      Size = 50
    end
    object dsT203F05: TStringField
      FieldName = 'F05'
      Size = 50
    end
    object dsT203F06: TStringField
      FieldName = 'F06'
      Size = 50
    end
    object dsT203F07: TStringField
      FieldName = 'F07'
      Size = 255
    end
    object dsT203F08: TStringField
      FieldName = 'F08'
      Size = 50
    end
  end
  object ds8: TDataSource
    DataSet = dsT203
    Left = 856
    Top = 32
  end
  object dsT205: TADODataSet
    CommandText = 'select * from t205 where f01=:f01'#13#10
    Parameters = <
      item
        Name = 'f01'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 924
    Top = 41
    object dsT205F01: TIntegerField
      FieldName = 'F01'
    end
    object dsT205F02: TStringField
      FieldName = 'F02'
      Size = 50
    end
    object dsT205F03: TStringField
      FieldName = 'F03'
      Size = 50
    end
    object dsT205F04: TStringField
      FieldName = 'F04'
      Size = 50
    end
    object dsT205F05: TStringField
      FieldName = 'F05'
      Size = 50
    end
    object dsT205F06: TStringField
      FieldName = 'F06'
      Size = 255
    end
  end
  object dsdsT205: TDataSource
    DataSet = dsT205
    Left = 944
    Top = 40
  end
end
