object frmCreateComponent: TfrmCreateComponent
  Left = 413
  Top = 54
  Width = 842
  Height = 611
  Caption = 'frmCreateComponent'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mm1
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  PixelsPerInch = 96
  TextHeight = 13
  object pgc1: TPageControl
    Left = 0
    Top = 29
    Width = 834
    Height = 536
    ActivePage = ts2
    Align = alClient
    TabOrder = 0
    object ts1: TTabSheet
      Caption = #35774#32622#23383#27573
      object lbl2: TLabel
        Left = 104
        Top = 104
        Width = 60
        Height = 13
        Caption = #24050#26377#23383#27573'    '
      end
      object lbl3: TLabel
        Left = 408
        Top = 56
        Width = 48
        Height = 13
        Caption = ' ('#23383#27573#21517') '
      end
      object lbl44: TLabel
        Left = 24
        Top = 8
        Width = 51
        Height = 13
        Caption = 'MtDataSet'
      end
      object lbl45: TLabel
        Left = 0
        Top = 32
        Width = 73
        Height = 13
        Caption = 'Proc Parameter'
      end
      object lbl46: TLabel
        Left = 8
        Top = 408
        Width = 83
        Height = 13
        Caption = 'MTDATASETID  '
      end
      object Label1: TLabel
        Left = 560
        Top = 56
        Width = 30
        Height = 13
        Caption = 'fieldID'
      end
      object lbl1: TLabel
        Left = 8
        Top = 96
        Width = 48
        Height = 13
        Caption = #35201#24314#23383#27573
      end
      object lbl73: TLabel
        Left = 8
        Top = 56
        Width = 29
        Height = 13
        Caption = 'length'
        FocusControl = dbedt53
      end
      object lbl74: TLabel
        Left = 104
        Top = 56
        Width = 50
        Height = 13
        Caption = 'Typename'
        FocusControl = dbedt54
      end
      object lbl75: TLabel
        Left = 272
        Top = 56
        Width = 55
        Height = 13
        Caption = 'TableName'
      end
      object lbl76: TLabel
        Left = 184
        Top = 56
        Width = 38
        Height = 13
        Caption = 'TableID'
      end
      object grp1: TGroupBox
        Left = 0
        Top = 451
        Width = 826
        Height = 57
        Align = alBottom
        Caption = 'grp1'
        TabOrder = 0
        object btn1: TButton
          Left = 24
          Top = 16
          Width = 129
          Height = 25
          Caption = #26174#31034#25152#26377#24314#31435#30340#23383#27573#21517
          TabOrder = 0
          OnClick = btn1Click
        end
        object btn3: TButton
          Left = 168
          Top = 16
          Width = 121
          Height = 25
          Caption = #26174#31034#24050#32463#24314#31435#30340#23383#27573#21517
          TabOrder = 1
          OnClick = btn3Click
        end
        object btndeleteRecord: TButton
          Left = 424
          Top = 16
          Width = 105
          Height = 25
          Caption = 'btndeleteRecord'
          TabOrder = 2
          OnClick = btndeleteRecordClick
        end
        object BtnBatchCreate: TButton
          Left = 312
          Top = 16
          Width = 75
          Height = 25
          Caption = #25209#37327#24314#31435
          TabOrder = 3
          OnClick = BtnBatchCreateClick
        end
      end
      object edt1: TEdit
        Left = 88
        Top = 8
        Width = 609
        Height = 21
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 1
        Text = 'edt1'
        OnChange = edt1Change
      end
      object lstExistFields: TListBox
        Left = 104
        Top = 120
        Width = 145
        Height = 265
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        ItemHeight = 13
        TabOrder = 2
        OnClick = lstExistFieldsClick
        OnDblClick = lstExistFieldsDblClick
        OnDragDrop = lstExistFieldsDragDrop
        OnDragOver = lstExistFieldsDragOver
      end
      object pgc2: TPageControl
        Left = 247
        Top = 80
        Width = 634
        Height = 393
        ActivePage = ts4
        TabOrder = 3
        object ts4: TTabSheet
          Caption = #23383#27573#20540#36755#20837#23383#27573
          object grp3: TGroupBox
            Left = 8
            Top = 224
            Width = 609
            Height = 137
            Caption = #34920'T202'
            TabOrder = 0
            object lbl4: TLabel
              Left = 8
              Top = 19
              Width = 57
              Height = 13
              Caption = #40664#35748#20540'(f04)'
            end
            object lbl6: TLabel
              Left = 392
              Top = 19
              Width = 52
              Height = 26
              Caption = 'F06 OrdIdx'#13#10
            end
            object lbl13: TLabel
              Left = 208
              Top = 48
              Width = 50
              Height = 13
              Caption = 'F03 FLDId'
            end
            object lbl23: TLabel
              Left = 16
              Top = 48
              Width = 64
              Height = 13
              Caption = 'DATASETID '
            end
            object lbl48: TLabel
              Left = 400
              Top = 56
              Width = 66
              Height = 13
              Caption = 'F07 fieldname'
            end
            object lbl63: TLabel
              Left = 8
              Top = 72
              Width = 79
              Height = 26
              Caption = 'F08 CalcFormula'#13#10
              FocusControl = dbedt42
            end
            object lbl64: TLabel
              Left = 248
              Top = 72
              Width = 129
              Height = 13
              Caption = 'F09 Fields  in CalcFormula  '
              FocusControl = dbedt44
            end
            object dbchkChecked: TDBCheckBox
              Left = 192
              Top = 16
              Width = 97
              Height = 17
              Caption = #19981#20801#35768#20026#31354
              DataField = 'f05'
              DataSource = dsT202
              TabOrder = 0
              ValueChecked = 'True'
              ValueUnchecked = 'False'
            end
            object dbedtT202_f06: TDBEdit
              Left = 488
              Top = 16
              Width = 73
              Height = 21
              DataField = 'F06'
              DataSource = dsT202
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              TabOrder = 1
            end
            object btn2: TButton
              Left = 280
              Top = 104
              Width = 75
              Height = 25
              Caption = #36861#21152
              TabOrder = 2
              OnClick = btn2Click
            end
            object btnSaveT202: TButton
              Left = 504
              Top = 104
              Width = 75
              Height = 25
              Caption = #20445#23384
              TabOrder = 3
              OnClick = btnSaveT202Click
            end
            object dbedt5: TDBEdit
              Left = 272
              Top = 48
              Width = 121
              Height = 21
              DataField = 'F03'
              DataSource = dsT202
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              TabOrder = 4
            end
            object dbedt6: TDBEdit
              Left = 96
              Top = 48
              Width = 81
              Height = 21
              DataField = 'F02'
              DataSource = dsT202
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              TabOrder = 5
            end
            object dbcbb2: TDBComboBox
              Left = 96
              Top = 16
              Width = 81
              Height = 21
              DataField = 'F04'
              DataSource = dsT202
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              ItemHeight = 13
              Items.Strings = (
                'sEmpId'
                'sEmpty'
                'sLoginId'
                'sNow'
                'sToday'
                'sToday-30'
                'sToday-31'
                'sToday-365'
                'sToday-5'
                'sYear'
                'sMonth'
                'sWhId'
                'sYdId'
                'sLocalOldUserDB'
                'sLocalUserDB'
                'sClientKey'
                'sGUID'
                'sFirstDayofMonth'
                #21040#26399
                #30007
                #20840#37096
                #23454#38469#24211#23384
                #24448#26469
                #21482
                #21046#21333#26085#26399)
              TabOrder = 6
            end
            object btn7: TButton
              Left = 352
              Top = 104
              Width = 81
              Height = 25
              Caption = #21462#28040
              TabOrder = 7
              OnClick = btn7Click
            end
            object btnT202Del: TButton
              Left = 432
              Top = 104
              Width = 75
              Height = 25
              Caption = 'btnT202Del'
              TabOrder = 8
              OnClick = btnT202DelClick
            end
            object btnOpen: TButton
              Left = 64
              Top = 104
              Width = 75
              Height = 25
              Caption = 'open'
              TabOrder = 9
              OnClick = btnOpenClick
            end
            object btnNext: TButton
              Left = 136
              Top = 104
              Width = 75
              Height = 25
              Caption = 'btnNext'
              TabOrder = 10
              OnClick = btnNextClick
            end
            object btnPrior: TButton
              Left = 208
              Top = 104
              Width = 75
              Height = 25
              Caption = 'btnPrior'
              TabOrder = 11
              OnClick = btnPriorClick
            end
            object dbedt30: TDBEdit
              Left = 488
              Top = 48
              Width = 73
              Height = 21
              DataField = 'f07'
              DataSource = dsT202
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              TabOrder = 12
            end
            object dbedt42: TDBEdit
              Left = 96
              Top = 72
              Width = 145
              Height = 21
              DataField = 'F08'
              DataSource = dsT202
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              TabOrder = 13
            end
            object dbedt44: TDBEdit
              Left = 376
              Top = 72
              Width = 185
              Height = 21
              DataField = 'F09'
              DataSource = dsT202
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              TabOrder = 14
            end
            object DBCheckBox1: TDBCheckBox
              Left = 296
              Top = 16
              Width = 57
              Height = 17
              Caption = 'unique'
              DataField = 'F10'
              DataSource = dsT202
              TabOrder = 15
              ValueChecked = 'True'
              ValueUnchecked = 'False'
            end
          end
          object grp4: TGroupBox
            Left = 8
            Top = 0
            Width = 609
            Height = 225
            Caption = 'T102'
            TabOrder = 1
            object lbl7: TLabel
              Left = 8
              Top = 24
              Width = 78
              Height = 13
              Caption = #23383#27573#20540#31867#22411'F04'
            end
            object lbl8: TLabel
              Left = 264
              Top = 16
              Width = 209
              Height = 13
              Caption = #23383#27573#31867#21035'(L=fkLookup/C=fkCalculated) F05'
            end
            object lbl9: TLabel
              Left = 8
              Top = 47
              Width = 78
              Height = 13
              Caption = #23383#27573#20540#38271#24230'F06'
            end
            object lbl10: TLabel
              Left = 200
              Top = 47
              Width = 78
              Height = 13
              Caption = #23383#27573#20540#26684#24335'F07'
            end
            object lbl11: TLabel
              Left = 400
              Top = 47
              Width = 78
              Height = 13
              Caption = #23383#27573#20013#25991#21517'F09'
            end
            object lbl12: TLabel
              Left = 8
              Top = 80
              Width = 68
              Height = 13
              Caption = 'PICKLIST(f11)'
            end
            object lbl14: TLabel
              Left = 408
              Top = 80
              Width = 67
              Height = 13
              Caption = 'LKPDSID(f14)'
            end
            object lbl15: TLabel
              Left = 8
              Top = 113
              Width = 62
              Height = 13
              Caption = 'KEYFLD(f15)'
            end
            object lbl16: TLabel
              Left = 200
              Top = 113
              Width = 74
              Height = 13
              Caption = 'LkpKeyFld (f16)'
            end
            object lbl17: TLabel
              Left = 400
              Top = 113
              Width = 83
              Height = 13
              Caption = 'LkpResultFld(f17)'
            end
            object dbtxt2: TDBText
              Left = 88
              Top = 144
              Width = 65
              Height = 17
              DataField = 'F01'
              DataSource = dsT102
            end
            object lbl24: TLabel
              Left = 16
              Top = 144
              Width = 54
              Height = 13
              Caption = 'DataFieldId'
            end
            object lbl47: TLabel
              Left = 192
              Top = 144
              Width = 80
              Height = 13
              Caption = 'LkpListFlds( F18)'
              FocusControl = dbedt29
            end
            object lbl60: TLabel
              Left = 8
              Top = 168
              Width = 62
              Height = 13
              Caption = 'MinValue f20'
            end
            object lbl61: TLabel
              Left = 200
              Top = 168
              Width = 73
              Height = 13
              Caption = 'MaxValues  f21'
              FocusControl = dbedt43
            end
            object lbl62: TLabel
              Left = 8
              Top = 192
              Width = 180
              Height = 13
              Caption = 'Float PZero=0.000000001;   integer  1'
            end
            object dblkcbbFType: TDBLookupComboBox
              Left = 88
              Top = 16
              Width = 161
              Height = 21
              DataField = 'F04'
              DataSource = dsT102
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              TabOrder = 0
              OnClick = dblkcbbFTypeClick
            end
            object dbedtFsize: TDBEdit
              Left = 88
              Top = 47
              Width = 105
              Height = 21
              DataField = 'F06'
              DataSource = dsT102
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              TabOrder = 1
            end
            object dbedtCaption: TDBEdit
              Left = 488
              Top = 47
              Width = 97
              Height = 21
              DataField = 'F09'
              DataSource = dsT102
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              TabOrder = 2
            end
            object dbedtPICKLIST: TDBEdit
              Left = 88
              Top = 80
              Width = 105
              Height = 21
              DataField = 'F11'
              DataSource = dsT102
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              TabOrder = 3
            end
            object dbchk1: TDBCheckBox
              Left = 280
              Top = 80
              Width = 97
              Height = 17
              Caption = 'ONLYPICK(f12)'
              DataField = 'F12'
              DataSource = dsT102
              TabOrder = 4
              ValueChecked = 'True'
              ValueUnchecked = 'False'
            end
            object dbedt1: TDBEdit
              Left = 488
              Top = 80
              Width = 97
              Height = 21
              DataField = 'F14'
              DataSource = dsT102
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              TabOrder = 5
            end
            object dbedt2: TDBEdit
              Left = 88
              Top = 113
              Width = 105
              Height = 21
              DataField = 'F15'
              DataSource = dsT102
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              TabOrder = 6
            end
            object dbedt3: TDBEdit
              Left = 280
              Top = 113
              Width = 105
              Height = 21
              DataField = 'F16'
              DataSource = dsT102
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              TabOrder = 7
            end
            object dbedt4: TDBEdit
              Left = 488
              Top = 113
              Width = 97
              Height = 21
              DataField = 'F17'
              DataSource = dsT102
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              TabOrder = 8
            end
            object btnAddT102: TButton
              Left = 280
              Top = 200
              Width = 75
              Height = 25
              Caption = #36861#21152
              TabOrder = 9
              OnClick = btnAddT102Click
            end
            object btnSaveT102: TButton
              Left = 440
              Top = 200
              Width = 75
              Height = 25
              Caption = #20445#23384
              TabOrder = 10
              OnClick = btnSaveT102Click
            end
            object dblkcbbKind: TDBLookupComboBox
              Left = 488
              Top = 16
              Width = 96
              Height = 21
              DataField = 'F05'
              DataSource = dsT102
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              TabOrder = 11
              OnClick = dblkcbbKindClick
            end
            object dbcbb1: TDBComboBox
              Left = 280
              Top = 47
              Width = 97
              Height = 21
              DataField = 'F07'
              DataSource = dsT102
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              ItemHeight = 13
              Items.Strings = (
                'yyyy"'#24180'"mm"'#26376'"dd"'#26085'"'
                '"'#65509'"0.00'
                '('#21547#31246'); '
                #8730'; '
                #65509'0.00'
                '0.00'
                '0.0000'
                '1;0'
                #25104#21151';'#22833#36133
                #26159';'#21542
                #25910';'#21457
                #24050';'#26410)
              TabOrder = 12
            end
            object btn8: TButton
              Left = 360
              Top = 200
              Width = 75
              Height = 25
              Caption = #21462#28040
              TabOrder = 13
              OnClick = btn8Click
            end
            object btnOpenT102: TButton
              Left = 200
              Top = 200
              Width = 75
              Height = 25
              Caption = 'btnOpenT102'
              TabOrder = 14
              OnClick = btnOpenT102Click
            end
            object dbedt29: TDBEdit
              Left = 280
              Top = 144
              Width = 105
              Height = 21
              DataField = 'F18'
              DataSource = dsT102
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              TabOrder = 15
            end
            object dbedt43: TDBEdit
              Left = 280
              Top = 168
              Width = 105
              Height = 21
              DataField = 'f21'
              DataSource = dsT102
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              TabOrder = 16
            end
            object dbcbb5: TDBComboBox
              Left = 88
              Top = 168
              Width = 100
              Height = 21
              DataField = 'f20'
              DataSource = dsT102
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              ItemHeight = 13
              Items.Strings = (
                '0.00001'
                '0.000000001'
                '1')
              TabOrder = 17
            end
          end
        end
        object ts5: TTabSheet
          Caption = #23383#27573#20540#20026#19979#25289#21487#36873#23383#27573' (T102.F05=L)'
          ImageIndex = 1
          object grp5: TGroupBox
            Left = 80
            Top = 32
            Width = 513
            Height = 249
            Caption = #34920'T201   '#22635#20914#19979#25289#26694' ('#38656#35201#30693#36947'   LKPDSID(f14))'
            TabOrder = 0
            object lbl18: TLabel
              Left = 32
              Top = 56
              Width = 76
              Height = 13
              Caption = 'F03  CMDTEXT'
            end
            object lbl19: TLabel
              Left = 48
              Top = 128
              Width = 61
              Height = 13
              Caption = 'F06  FILTER'
            end
            object lbl20: TLabel
              Left = 32
              Top = 80
              Width = 201
              Height = 13
              Caption = 'F04 CMDTYPE 0 cmdtext 1cmdstroedproc'
            end
            object lbl21: TLabel
              Left = 56
              Top = 144
              Width = 54
              Height = 13
              Caption = 'F07  SORT'
            end
            object lbl22: TLabel
              Left = 32
              Top = 104
              Width = 296
              Height = 13
              Caption = 'F05  LOCKTYPE 0 ltBatchOptimistic 1 ltOptimistic 3 ltReadOnly'
            end
            object dbtxt1: TDBText
              Left = 120
              Top = 24
              Width = 65
              Height = 17
              DataField = 'F01'
              DataSource = dsT201
            end
            object lbl25: TLabel
              Left = 64
              Top = 32
              Width = 35
              Height = 13
              Caption = 'F01 PK'
            end
            object dbedt8: TDBEdit
              Left = 120
              Top = 48
              Width = 361
              Height = 21
              DataField = 'F03'
              DataSource = dsT201
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              TabOrder = 0
            end
            object dbcbb3: TDBComboBox
              Left = 256
              Top = 72
              Width = 225
              Height = 21
              DataField = 'F04'
              DataSource = dsT201
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              ItemHeight = 13
              TabOrder = 1
            end
            object dbcbb4: TDBComboBox
              Left = 336
              Top = 96
              Width = 145
              Height = 21
              DataField = 'F05'
              DataSource = dsT201
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              ItemHeight = 13
              TabOrder = 2
            end
            object dbedt9: TDBEdit
              Left = 128
              Top = 120
              Width = 353
              Height = 21
              DataField = 'F06'
              DataSource = dsT201
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              TabOrder = 3
            end
            object dbedt10: TDBEdit
              Left = 128
              Top = 144
              Width = 353
              Height = 21
              DataField = 'F07'
              DataSource = dsT201
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              TabOrder = 4
            end
            object btn12: TButton
              Left = 232
              Top = 192
              Width = 75
              Height = 25
              Caption = #36861#21152
              TabOrder = 5
              OnClick = btn12Click
            end
            object btn13: TButton
              Left = 312
              Top = 192
              Width = 75
              Height = 25
              Caption = #21462#28040
              TabOrder = 6
              OnClick = btn13Click
            end
            object btn14: TButton
              Left = 392
              Top = 192
              Width = 75
              Height = 25
              Caption = #20445#23384
              TabOrder = 7
              OnClick = btn14Click
            end
          end
        end
        object ts6: TTabSheet
          Caption = 'ts T607  LookupField'
          ImageIndex = 2
          object lbl50: TLabel
            Left = 40
            Top = 24
            Width = 33
            Height = 13
            Caption = 'F01 Id '
            FocusControl = dbedt32
          end
          object lbl51: TLabel
            Left = 40
            Top = 64
            Width = 52
            Height = 13
            Caption = 'F02 Name '
            FocusControl = dbedt33
          end
          object lbl52: TLabel
            Left = 40
            Top = 104
            Width = 67
            Height = 13
            Caption = 'F03 LkpGridId'
            FocusControl = dbedt34
          end
          object lbl53: TLabel
            Left = 176
            Top = 24
            Width = 94
            Height = 13
            Caption = 'F08 ChgFlds  DEST'
            FocusControl = dbedt35
          end
          object lbl54: TLabel
            Left = 160
            Top = 64
            Width = 120
            Height = 13
            Caption = 'F09  LkpChgFlds  Source'
            FocusControl = dbedt36
          end
          object lbl55: TLabel
            Left = 296
            Top = 112
            Width = 44
            Height = 13
            Caption = 'F12 FldId'
            FocusControl = dbedt37
          end
          object lbl56: TLabel
            Left = 296
            Top = 152
            Width = 57
            Height = 13
            Caption = 'F13 Caption'
            FocusControl = dbedt38
          end
          object lbl57: TLabel
            Left = 296
            Top = 192
            Width = 57
            Height = 13
            Caption = 'F14 FilterFld'
            FocusControl = dbedt39
          end
          object lbl58: TLabel
            Left = 416
            Top = 112
            Width = 53
            Height = 13
            Caption = 'F15 LkpFld'
            FocusControl = dbedt40
          end
          object lbl59: TLabel
            Left = 416
            Top = 152
            Width = 52
            Height = 26
            Caption = 'F16 DefIdx'#13#10
            FocusControl = dbedt41
          end
          object Label6: TLabel
            Left = 184
            Top = 152
            Width = 57
            Height = 13
            Caption = 'ParamFields'
          end
          object dbedt32: TDBEdit
            Left = 40
            Top = 40
            Width = 100
            Height = 21
            DataField = 'F01'
            DataSource = dsST607
            ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
            TabOrder = 0
          end
          object dbedt33: TDBEdit
            Left = 40
            Top = 80
            Width = 100
            Height = 21
            DataField = 'F02'
            DataSource = dsST607
            ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
            TabOrder = 1
          end
          object dbedt34: TDBEdit
            Left = 40
            Top = 120
            Width = 100
            Height = 21
            DataField = 'F03'
            DataSource = dsST607
            ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
            TabOrder = 2
            OnDblClick = dbedt34DblClick
          end
          object dbedt35: TDBEdit
            Left = 176
            Top = 40
            Width = 337
            Height = 21
            DataField = 'F08'
            DataSource = dsST607
            ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
            TabOrder = 3
          end
          object dbedt36: TDBEdit
            Left = 176
            Top = 80
            Width = 337
            Height = 21
            DataField = 'F09'
            DataSource = dsST607
            ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
            TabOrder = 4
          end
          object dbchk7: TDBCheckBox
            Left = 184
            Top = 128
            Width = 97
            Height = 17
            Caption = 'F11  Sys'
            DataField = 'F11'
            DataSource = dsST607
            TabOrder = 5
            ValueChecked = 'True'
            ValueUnchecked = 'False'
          end
          object dbedt37: TDBEdit
            Left = 296
            Top = 128
            Width = 100
            Height = 21
            DataField = 'F12'
            DataSource = dsST607
            ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
            TabOrder = 6
          end
          object dbedt38: TDBEdit
            Left = 296
            Top = 168
            Width = 100
            Height = 21
            DataField = 'F13'
            DataSource = dsST607
            ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
            TabOrder = 7
          end
          object dbedt39: TDBEdit
            Left = 296
            Top = 208
            Width = 100
            Height = 21
            DataField = 'F14'
            DataSource = dsST607
            ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
            TabOrder = 8
          end
          object dbedt40: TDBEdit
            Left = 416
            Top = 128
            Width = 100
            Height = 21
            DataField = 'F15'
            DataSource = dsST607
            ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
            TabOrder = 9
          end
          object dbedt41: TDBEdit
            Left = 416
            Top = 168
            Width = 100
            Height = 21
            DataField = 'F16'
            DataSource = dsST607
            ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
            TabOrder = 10
          end
          object dbnvgr1: TDBNavigator
            Left = 312
            Top = 280
            Width = 240
            Height = 25
            DataSource = dsST607
            TabOrder = 11
          end
          object btnOpenT607: TButton
            Left = 240
            Top = 280
            Width = 75
            Height = 25
            Caption = 'btnOpenT607'
            TabOrder = 12
            OnClick = btnOpenT607Click
          end
          object DBCheckBox2: TDBCheckBox
            Left = 40
            Top = 144
            Width = 145
            Height = 17
            Caption = 'RefreshWhenPopup'
            DataField = 'RefreshWhenPopup'
            DataSource = dsST607
            TabOrder = 13
            ValueChecked = 'True'
            ValueUnchecked = 'False'
          end
          object DBEdit3: TDBEdit
            Left = 184
            Top = 168
            Width = 100
            Height = 21
            DataField = 'ParamFields'
            DataSource = dsST607
            ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
            TabOrder = 14
          end
        end
        object ts7: TTabSheet
          Caption = 'Tree lookup T610'
          ImageIndex = 3
          object lbl65: TLabel
            Left = 32
            Top = 40
            Width = 33
            Height = 26
            Caption = 'F01  Id'#13#10
            FocusControl = dbedt45
          end
          object lbl66: TLabel
            Left = 32
            Top = 80
            Width = 60
            Height = 13
            Caption = 'F02  Caption'
            FocusControl = dbedt46
          end
          object lbl67: TLabel
            Left = 32
            Top = 120
            Width = 44
            Height = 13
            Caption = 'F03 FldId'
            FocusControl = dbedt47
          end
          object lbl68: TLabel
            Left = 184
            Top = 40
            Width = 85
            Height = 13
            Caption = 'F04  ChgFlds dest'
            FocusControl = dbedt48
          end
          object lbl69: TLabel
            Left = 184
            Top = 80
            Width = 115
            Height = 13
            Caption = 'F05  LkpChgFlds source'
            FocusControl = dbedt49
          end
          object lbl70: TLabel
            Left = 184
            Top = 120
            Width = 68
            Height = 13
            Caption = 'F06  RootText'
            FocusControl = dbedt50
          end
          object lbl71: TLabel
            Left = 320
            Top = 40
            Width = 60
            Height = 13
            Caption = 'F07 CodeFld'
            FocusControl = dbedt51
          end
          object lbl72: TLabel
            Left = 320
            Top = 80
            Width = 66
            Height = 13
            Caption = 'F08  NameFld'
            FocusControl = dbedt52
          end
          object dbedt45: TDBEdit
            Left = 32
            Top = 56
            Width = 100
            Height = 21
            DataField = 'F01'
            DataSource = dsds610
            ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
            TabOrder = 0
          end
          object dbedt46: TDBEdit
            Left = 32
            Top = 96
            Width = 100
            Height = 21
            DataField = 'F02'
            DataSource = dsds610
            ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
            TabOrder = 1
          end
          object dbedt47: TDBEdit
            Left = 32
            Top = 136
            Width = 100
            Height = 21
            DataField = 'F03'
            DataSource = dsds610
            ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
            TabOrder = 2
          end
          object dbedt48: TDBEdit
            Left = 184
            Top = 56
            Width = 100
            Height = 21
            DataField = 'F04'
            DataSource = dsds610
            ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
            TabOrder = 3
          end
          object dbedt49: TDBEdit
            Left = 184
            Top = 96
            Width = 100
            Height = 21
            DataField = 'F05'
            DataSource = dsds610
            ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
            TabOrder = 4
          end
          object dbedt50: TDBEdit
            Left = 184
            Top = 136
            Width = 100
            Height = 21
            DataField = 'F06'
            DataSource = dsds610
            ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
            TabOrder = 5
          end
          object dbedt51: TDBEdit
            Left = 320
            Top = 56
            Width = 100
            Height = 21
            DataField = 'F07'
            DataSource = dsds610
            ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
            TabOrder = 6
          end
          object dbedt52: TDBEdit
            Left = 320
            Top = 96
            Width = 100
            Height = 21
            DataField = 'F08'
            DataSource = dsds610
            ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
            TabOrder = 7
          end
          object dbchk8: TDBCheckBox
            Left = 320
            Top = 120
            Width = 97
            Height = 17
            Caption = 'F09  IsExpand'
            DataField = 'F09'
            DataSource = dsds610
            TabOrder = 8
            ValueChecked = 'True'
            ValueUnchecked = 'False'
          end
          object dbchk9: TDBCheckBox
            Left = 320
            Top = 136
            Width = 97
            Height = 17
            Caption = 'F10  ParentSelect'
            DataField = 'F10'
            DataSource = dsds610
            TabOrder = 9
            ValueChecked = 'True'
            ValueUnchecked = 'False'
          end
          object dbnvgr2: TDBNavigator
            Left = 288
            Top = 184
            Width = 240
            Height = 25
            DataSource = dsds610
            TabOrder = 10
          end
          object btnT610: TButton
            Left = 216
            Top = 184
            Width = 75
            Height = 25
            Caption = 'btnT610'
            TabOrder = 11
            OnClick = btnT610Click
          end
        end
        object ts8: TTabSheet
          Caption = 'fieldinfo'
          ImageIndex = 4
          object dbgrdFieldInfo: TDBGrid
            Left = 0
            Top = 0
            Width = 321
            Height = 365
            Align = alLeft
            ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'name'
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Typename'
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'length'
                Width = 100
                Visible = True
              end>
          end
        end
      end
      object dbedt7: TDBEdit
        Left = 464
        Top = 56
        Width = 89
        Height = 21
        DataField = 'F02'
        DataSource = dsT102
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 4
      end
      object btnUpdate: TButton
        Left = 707
        Top = 6
        Width = 78
        Height = 21
        Caption = #26356#26032
        Enabled = False
        TabOrder = 5
        OnClick = btnUpdateClick
      end
      object EdtProc_Parameter: TEdit
        Left = 88
        Top = 32
        Width = 609
        Height = 21
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 6
        Text = 'EdtProc_Parameter'
      end
      object btnProcParameter: TButton
        Left = 709
        Top = 31
        Width = 75
        Height = 22
        Caption = #26356#26032#23384#20648#36807#31243#21442#25968
        TabOrder = 7
        OnClick = btnProcParameterClick
      end
      object edtMtDataSetID: TEdit
        Left = 8
        Top = 424
        Width = 81
        Height = 21
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 8
        OnDblClick = edtMtDataSetIDDblClick
      end
      object edtFieldID: TEdit
        Left = 592
        Top = 56
        Width = 121
        Height = 21
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 9
      end
      object lstParaFields: TListBox
        Left = 8
        Top = 120
        Width = 89
        Height = 265
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        ItemHeight = 13
        TabOrder = 10
        OnClick = lstParaFieldsClick
        OnMouseMove = lstParaFieldsMouseMove
      end
      object dbedt53: TDBEdit
        Left = 8
        Top = 72
        Width = 89
        Height = 21
        DataField = 'length'
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 11
      end
      object dbedt54: TDBEdit
        Left = 104
        Top = 72
        Width = 81
        Height = 21
        DataField = 'Typename'
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 12
      end
      object edtTable: TEdit
        Left = 328
        Top = 56
        Width = 57
        Height = 21
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 13
        OnDblClick = edtTableDblClick
      end
      object edtTableID: TEdit
        Left = 224
        Top = 56
        Width = 49
        Height = 21
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 14
      end
      object btnQAddField: TButton
        Left = 104
        Top = 408
        Width = 75
        Height = 25
        Caption = 'btnQAddField'
        TabOrder = 15
        OnClick = btnQAddFieldClick
      end
    end
    object ts2: TTabSheet
      Caption = #35774#32622#25511#38190
      DragMode = dmAutomatic
      ImageIndex = 1
      object Splitter1: TSplitter
        Left = 0
        Top = 425
        Width = 826
        Height = 8
        Cursor = crVSplit
        Align = alTop
      end
      object grpGrpParent: TGroupBox
        Left = 0
        Top = 0
        Width = 826
        Height = 425
        Align = alTop
        Caption = 'grpGrpParent'
        DragCursor = crSizeAll
        DragMode = dmAutomatic
        TabOrder = 1
        OnClick = grpGrpParentClick
        OnDragDrop = grpGrpParentDragDrop
        OnDragOver = grpGrpParentDragOver
        object imgtop: TImage
          Left = 2
          Top = 15
          Width = 822
          Height = 408
          Align = alClient
          OnDragDrop = imgtopDragDrop
          OnDragOver = imgtopDragOver
          OnMouseDown = imgtopMouseDown
          OnMouseMove = imgtopMouseMove
          OnMouseUp = imgtopMouseUp
        end
      end
      object grp2: TGroupBox
        Left = 0
        Top = 453
        Width = 826
        Height = 55
        Align = alBottom
        Caption = 'grp2'
        TabOrder = 2
        object btnCreateComponent: TButton
          Left = 40
          Top = 24
          Width = 129
          Height = 25
          Caption = 'btnCreateComponent'
          TabOrder = 0
          OnClick = btnCreateComponentClick
        end
        object btnSavetoDataBase: TButton
          Left = 168
          Top = 24
          Width = 121
          Height = 25
          Caption = 'btnSavetoDataBase'
          TabOrder = 1
          OnClick = btnSavetoDataBaseClick
        end
        object btnDisplayExistsFields: TButton
          Left = 288
          Top = 24
          Width = 121
          Height = 25
          Caption = #35774#32622#25511#38190#23545#24212#30340#23383#27573
          TabOrder = 2
          OnClick = btnDisplayExistsFieldsClick
        end
        object lbledtFontSize: TLabeledEdit
          Left = 803
          Top = 24
          Width = 30
          Height = 21
          EditLabel.Width = 67
          EditLabel.Height = 13
          EditLabel.Caption = 'LabelFontSize'
          ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
          TabOrder = 3
          Text = '10'
        end
        object lbledtGapY: TLabeledEdit
          Left = 800
          Top = 24
          Width = 33
          Height = 21
          EditLabel.Width = 27
          EditLabel.Height = 13
          EditLabel.Caption = 'GapY'
          ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
          TabOrder = 4
          Text = '30'
        end
        object lbledtCtrlGap: TLabeledEdit
          Left = 744
          Top = 24
          Width = 33
          Height = 21
          EditLabel.Width = 67
          EditLabel.Height = 13
          EditLabel.Caption = 'lbledtCtrlGapX'
          ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
          TabOrder = 5
          Text = '5'
        end
        object lbledtgap: TLabeledEdit
          Left = 680
          Top = 24
          Width = 41
          Height = 21
          EditLabel.Width = 27
          EditLabel.Height = 13
          EditLabel.Caption = 'GapX'
          ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
          TabOrder = 6
          Text = '30'
        end
        object lbledtPosy: TLabeledEdit
          Left = 616
          Top = 24
          Width = 41
          Height = 21
          EditLabel.Width = 48
          EditLabel.Height = 13
          EditLabel.Caption = 'lbledtPosy'
          ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
          TabOrder = 7
          Text = '40'
        end
        object lbledtPosX: TLabeledEdit
          Left = 560
          Top = 24
          Width = 33
          Height = 21
          EditLabel.Width = 50
          EditLabel.Height = 13
          EditLabel.Caption = 'lbledtPosX'
          ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
          TabOrder = 8
          Text = '40'
        end
        object lbledtLintCnt: TLabeledEdit
          Left = 488
          Top = 24
          Width = 49
          Height = 21
          EditLabel.Width = 44
          EditLabel.Height = 13
          EditLabel.Caption = 'Cnt /Line'
          ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
          TabOrder = 9
          Text = '3'
        end
        object btnCreateCtrl: TButton
          Left = 408
          Top = 24
          Width = 75
          Height = 25
          Caption = 'btnCreateCtrl'
          TabOrder = 10
          OnClick = btnCreateCtrlClick
        end
      end
      object grpGrpParent_Btm: TGroupBox
        Left = 0
        Top = 433
        Width = 826
        Height = 56
        Align = alTop
        Caption = 'grpGrpParent_Btm'
        TabOrder = 3
        OnDragDrop = grpGrpParent_BtmDragDrop
        OnDragOver = grpGrpParent_BtmDragOver
      end
      object grp_FieldNeedToConfig: TGroupBox
        Left = 536
        Top = 248
        Width = 209
        Height = 169
        Caption = #38656#35201#19982#25511#38190#23545#24212#30340#23383#27573
        DragKind = dkDock
        DragMode = dmAutomatic
        TabOrder = 4
        Visible = False
        object lstFields: TListBox
          Left = 2
          Top = 15
          Width = 205
          Height = 152
          Align = alClient
          DragMode = dmAutomatic
          ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
          ItemHeight = 13
          TabOrder = 0
          OnClick = lstFieldsClick
          OnDblClick = lstFieldsDblClick
          OnMouseDown = lstFieldsMouseDown
          OnMouseMove = lstFieldsMouseMove
        end
      end
      object rg1: TRadioGroup
        Left = 576
        Top = 16
        Width = 169
        Height = 369
        Caption = 'ComponnetType'
        DragCursor = crSizeAll
        DragKind = dkDock
        DragMode = dmAutomatic
        Items.Strings = (
          'TLabel=0  '
          'TFhlDbEdit =1 *'
          'TDBEdit =2'
          'TDBLookupListBox=3'
          'TDBRichEdit=4'
          'TFhlDbLookupComboBox =5*'
          'TDBMemo     =6*'
          'TDBCheckBox=7*'
          'TDBText  =8*'
          'TFhlDbDatePicker =9*'
          'TDBRadioGroup  =10*'
          'TDBListBox =11'
          'TDBComboBox  =12*       '
          'TDBImage =13'
          'TDBBarCode=14')
        TabOrder = 0
      end
    end
    object TabEditorReport: TTabSheet
      Caption = 'EditorReport'
      ImageIndex = 3
      object GrpReportControls: TGroupBox
        Left = 0
        Top = 0
        Width = 826
        Height = 403
        Align = alClient
        Caption = 'GrpReportControls'
        TabOrder = 1
        object Image1: TImage
          Left = 2
          Top = 15
          Width = 822
          Height = 386
          Align = alClient
          OnDragDrop = Image1DragDrop
          OnDragOver = imgtopDragOver
          OnMouseDown = imgtopMouseDown
          OnMouseMove = imgtopMouseMove
          OnMouseUp = imgtopMouseUp
        end
      end
      object grpBoxSaveReport: TGroupBox
        Left = 0
        Top = 403
        Width = 826
        Height = 105
        Align = alBottom
        Caption = 'grpBoxSaveReport'
        TabOrder = 0
        object btnSaveReportCfg: TButton
          Left = 360
          Top = 40
          Width = 161
          Height = 25
          Caption = 'Save Report Config'
          TabOrder = 0
          OnClick = btnSaveReportCfgClick
        end
        object edtPrintID: TEdit
          Left = 64
          Top = 44
          Width = 281
          Height = 21
          TabOrder = 1
        end
      end
    end
    object ts3: TTabSheet
      Caption = #35774#32622#25968#25454#26694
      ImageIndex = 2
      DesignSize = (
        826
        508)
      object lbl26: TLabel
        Left = 8
        Top = 8
        Width = 66
        Height = 13
        Caption = 'F02  DbGridId'
        FocusControl = dbedtGridid
      end
      object lbl27: TLabel
        Left = 8
        Top = 48
        Width = 103
        Height = 13
        Caption = 'F03  FldId  T102.f01 *'
      end
      object lbl28: TLabel
        Left = 160
        Top = 8
        Width = 72
        Height = 13
        Caption = 'F04  col.Width '
        FocusControl = dbedt13
      end
      object lbl29: TLabel
        Left = 8
        Top = 88
        Width = 102
        Height = 13
        Caption = 'F09 col.Color   (string)'
        FocusControl = dbedt14
      end
      object lbl30: TLabel
        Left = 160
        Top = 88
        Width = 120
        Height = 13
        Caption = 'F11 PickList.CommaText'#9
        FocusControl = dbedt15
      end
      object lbl31: TLabel
        Left = 160
        Top = 128
        Width = 111
        Height = 13
        Caption = 'F12 DropDownRows=7'
        FocusControl = dbedt16
      end
      object lbl32: TLabel
        Left = 312
        Top = 88
        Width = 67
        Height = 13
        Caption = 'F13 Alignment'
        FocusControl = dbedt17
      end
      object lbl33: TLabel
        Left = 312
        Top = 128
        Width = 120
        Height = 13
        Caption = 'F14 Title.Caption'#9
        FocusControl = dbedt18
      end
      object lbl34: TLabel
        Left = 8
        Top = 168
        Width = 80
        Height = 13
        Caption = 'F15 Title.Color'#9
        FocusControl = dbedt19
      end
      object lbl35: TLabel
        Left = 8
        Top = 216
        Width = 87
        Height = 13
        Caption = 'F16 TitleAlignment'
        FocusControl = dbedt20
      end
      object lbl36: TLabel
        Left = 160
        Top = 176
        Width = 96
        Height = 13
        Caption = 'F17 Title.Font.Name'
        FocusControl = dbedt21
      end
      object lbl37: TLabel
        Left = 160
        Top = 224
        Width = 88
        Height = 13
        Caption = 'F18 Title.Font.Size'
        FocusControl = dbedt22
      end
      object lbl38: TLabel
        Left = 312
        Top = 176
        Width = 143
        Height = 13
        Caption = 'F19 col.Title.Font.Color (string)'
        FocusControl = dbedt23
      end
      object lbl39: TLabel
        Left = 312
        Top = 224
        Width = 85
        Height = 13
        Caption = 'F20   Font.Name3'
        FocusControl = dbedt24
      end
      object lbl40: TLabel
        Left = 8
        Top = 264
        Width = 65
        Height = 13
        Caption = 'F21 Font.Size'
        FocusControl = dbedt25
      end
      object lbl41: TLabel
        Left = 160
        Top = 264
        Width = 69
        Height = 13
        Caption = 'F22 Font.Color'
        FocusControl = dbedt26
      end
      object lbl42: TLabel
        Left = 312
        Top = 264
        Width = 62
        Height = 13
        Caption = 'F23  order ID'
        FocusControl = dbedt27
      end
      object lbl43: TLabel
        Left = 160
        Top = 8
        Width = 66
        Height = 13
        Caption = 'F04 col.Width'
        FocusControl = dbedt28
      end
      object lbl49: TLabel
        Left = 8
        Top = 312
        Width = 110
        Height = 13
        Caption = 'F24 ,OnEditButtonClick'
        FocusControl = dbedt31
      end
      object Label3: TLabel
        Left = 248
        Top = 312
        Width = 45
        Height = 13
        Caption = 'fieldname'
        FocusControl = DBLookupComboBox1
      end
      object Label4: TLabel
        Left = 504
        Top = 24
        Width = 18
        Height = 13
        Caption = 'F27'
        FocusControl = DBEdit1
      end
      object Label5: TLabel
        Left = 640
        Top = 0
        Width = 31
        Height = 13
        Caption = 'rightID'
        FocusControl = DBEdit2
      end
      object dbgrd1: TDBGrid
        Left = 112
        Top = 336
        Width = 353
        Height = 153
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dsGrid
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object grp6: TGroupBox
        Left = 0
        Top = 442
        Width = 826
        Height = 66
        Align = alBottom
        Caption = 'grp6'
        TabOrder = 1
        object btn_saveAddCol: TButton
          Left = 496
          Top = 24
          Width = 89
          Height = 25
          Caption = 'btn_saveAddCol'
          TabOrder = 0
          OnClick = btn_saveAddColClick
        end
        object btnCol1: TButton
          Left = 584
          Top = 24
          Width = 75
          Height = 25
          Caption = 'btnCol1'
          TabOrder = 1
          OnClick = btnCol1Click
        end
        object btncancel: TButton
          Left = 336
          Top = 24
          Width = 75
          Height = 25
          Caption = 'btncancel'
          TabOrder = 2
          OnClick = btncancelClick
        end
        object btncolAdd: TButton
          Left = 192
          Top = 24
          Width = 75
          Height = 25
          Caption = 'btncolAdd'
          TabOrder = 3
          OnClick = btncolAddClick
        end
        object btnOpenDsGridExistCol: TButton
          Left = 64
          Top = 24
          Width = 129
          Height = 25
          Caption = 'btnOpenDsGridExistCol'
          TabOrder = 4
          OnClick = btnOpenDsGridExistColClick
        end
        object btnedit: TButton
          Left = 264
          Top = 24
          Width = 75
          Height = 25
          Caption = 'btnedit'
          TabOrder = 5
          OnClick = btneditClick
        end
        object btnGridDelete: TButton
          Left = 416
          Top = 24
          Width = 75
          Height = 25
          Caption = 'btnGridDelete'
          TabOrder = 6
          OnClick = btnGridDeleteClick
        end
      end
      object dbedtGridid: TDBEdit
        Left = 8
        Top = 24
        Width = 134
        Height = 21
        DataField = 'F02'
        DataSource = dsGrid
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 2
        OnDblClick = dbedtGrididDblClick
      end
      object dbedt13: TDBEdit
        Left = 160
        Top = 24
        Width = 134
        Height = 21
        DataField = 'F04'
        DataSource = dsGrid
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 3
      end
      object dbchk2: TDBCheckBox
        Left = 160
        Top = 64
        Width = 145
        Height = 17
        Caption = 'F05 =0  ReadOnly '#27809#29992#21040
        DataField = 'F05'
        DataSource = dsGrid
        TabOrder = 4
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbedt14: TDBEdit
        Left = 8
        Top = 104
        Width = 97
        Height = 21
        DataField = 'F09'
        DataSource = dsGrid
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 5
      end
      object dbchk3: TDBCheckBox
        Left = 8
        Top = 144
        Width = 121
        Height = 17
        Caption = 'F10 cbsEllipsis =0'
        DataField = 'F10'
        DataSource = dsGrid
        TabOrder = 6
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbedt15: TDBEdit
        Left = 160
        Top = 104
        Width = 129
        Height = 21
        DataField = 'F11'
        DataSource = dsGrid
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 7
      end
      object dbedt16: TDBEdit
        Left = 160
        Top = 144
        Width = 129
        Height = 21
        DataField = 'F12'
        DataSource = dsGrid
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 8
      end
      object dbedt17: TDBEdit
        Left = 312
        Top = 104
        Width = 137
        Height = 21
        DataField = 'F13'
        DataSource = dsGrid
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 9
      end
      object dbedt18: TDBEdit
        Left = 312
        Top = 144
        Width = 137
        Height = 21
        DataField = 'F14'
        DataSource = dsGrid
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 10
      end
      object dbedt19: TDBEdit
        Left = 8
        Top = 184
        Width = 129
        Height = 21
        DataField = 'F15'
        DataSource = dsGrid
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 11
      end
      object dbedt20: TDBEdit
        Left = 8
        Top = 232
        Width = 49
        Height = 21
        DataField = 'F16'
        DataSource = dsGrid
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 12
      end
      object dbedt21: TDBEdit
        Left = 160
        Top = 192
        Width = 129
        Height = 21
        DataField = 'F17'
        DataSource = dsGrid
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 13
      end
      object dbedt22: TDBEdit
        Left = 160
        Top = 240
        Width = 129
        Height = 21
        DataField = 'F18'
        DataSource = dsGrid
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 14
      end
      object dbedt23: TDBEdit
        Left = 312
        Top = 192
        Width = 137
        Height = 21
        DataField = 'F19'
        DataSource = dsGrid
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 15
      end
      object dbedt24: TDBEdit
        Left = 312
        Top = 240
        Width = 137
        Height = 21
        DataField = 'F20'
        DataSource = dsGrid
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 16
      end
      object dbedt25: TDBEdit
        Left = 8
        Top = 280
        Width = 134
        Height = 21
        DataField = 'F21'
        DataSource = dsGrid
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 17
      end
      object dbedt26: TDBEdit
        Left = 160
        Top = 280
        Width = 134
        Height = 21
        DataField = 'F22'
        DataSource = dsGrid
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 18
      end
      object dbedt27: TDBEdit
        Left = 312
        Top = 280
        Width = 137
        Height = 21
        DataField = 'F23'
        DataSource = dsGrid
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 19
      end
      object dbchkReadOnly: TDBCheckBox
        Left = 312
        Top = 24
        Width = 97
        Height = 17
        Caption = 'F06 colreadonly'
        DataField = 'F06'
        DataSource = dsGrid
        TabOrder = 20
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        OnClick = dbchkReadOnlyClick
      end
      object dbchk5: TDBCheckBox
        Left = 312
        Top = 64
        Width = 177
        Height = 17
        Caption = 'F07  c.F07 & c.F08 AS F07 Visible'
        DataField = 'F07'
        DataSource = dsGrid
        TabOrder = 21
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbchk6: TDBCheckBox
        Left = 416
        Top = 24
        Width = 57
        Height = 17
        Caption = 'F08 =1'
        DataField = 'F08'
        DataSource = dsGrid
        TabOrder = 22
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbedt28: TDBEdit
        Left = 160
        Top = 24
        Width = 134
        Height = 21
        DataField = 'F04'
        DataSource = dsGrid
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 23
      end
      object dbedt12: TDBEdit
        Left = 8
        Top = 64
        Width = 137
        Height = 21
        DataField = 'F03'
        DataSource = dsGrid
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 24
        OnDragDrop = dbedt12DragDrop
        OnDragOver = dbedt12DragOver
        OnExit = dbedt12Exit
      end
      object grp7: TGroupBox
        Left = 496
        Top = 64
        Width = 361
        Height = 353
        Caption = 'fieldName'
        DragKind = dkDock
        DragMode = dmAutomatic
        TabOrder = 25
        object pgc3: TPageControl
          Left = 2
          Top = 15
          Width = 357
          Height = 336
          ActivePage = ts9
          Align = alClient
          TabOrder = 0
          object ts9: TTabSheet
            Caption = 'ts9'
            object grp8: TGroupBox
              Left = 0
              Top = 0
              Width = 121
              Height = 308
              Align = alLeft
              TabOrder = 0
              object lblFieldName: TLabel
                Left = 5
                Top = 8
                Width = 60
                Height = 13
                Caption = 'lblFieldName'
              end
              object lstGridField: TListBox
                Left = 2
                Top = 80
                Width = 117
                Height = 226
                Align = alBottom
                ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
                ItemHeight = 13
                TabOrder = 0
                OnClick = lstGridFieldClick
                OnDblClick = lstGridFieldDblClick
                OnMouseMove = lstGridFieldMouseMove
              end
              object btnshowFields: TButton
                Left = 6
                Top = 48
                Width = 91
                Height = 25
                Caption = 'btnGetFieldName'
                TabOrder = 1
                OnClick = btnshowFieldsClick
              end
              object edtFieldname: TEdit
                Left = 0
                Top = 24
                Width = 121
                Height = 21
                ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
                TabOrder = 2
                Text = 'edtFieldname'
              end
            end
            object GroupBox1: TGroupBox
              Left = 144
              Top = 0
              Width = 205
              Height = 308
              Align = alRight
              Caption = 'GroupBox1'
              TabOrder = 1
              object lstGridCols: TListBox
                Left = 2
                Top = 15
                Width = 95
                Height = 291
                Align = alLeft
                ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
                ItemHeight = 13
                TabOrder = 0
                OnClick = lstGridColsClick
              end
              object btnShowGirdCols: TButton
                Left = 102
                Top = 48
                Width = 75
                Height = 25
                Caption = 'btnShowGirdCols'
                TabOrder = 1
                OnClick = btnShowGirdColsClick
              end
              object btnBatchCreateCols: TButton
                Left = 102
                Top = 112
                Width = 75
                Height = 25
                Caption = 'btnBatchCreateCols'
                TabOrder = 2
                OnClick = btnBatchCreateColsClick
              end
            end
          end
          object ts10: TTabSheet
            Caption = 'ts10'
            ImageIndex = 1
            object lstGridFieldsName: TListBox
              Left = 0
              Top = 0
              Width = 161
              Height = 308
              Align = alLeft
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              ItemHeight = 13
              TabOrder = 0
            end
            object btnAddT202: TButton
              Left = 168
              Top = 72
              Width = 65
              Height = 25
              Caption = 'btnAddT202'
              TabOrder = 1
              OnClick = btnAddT202Click
            end
          end
          object TabSheet1: TTabSheet
            Caption = 'TabSheet1'
            ImageIndex = 2
          end
        end
      end
      object dbedt31: TDBEdit
        Left = 120
        Top = 304
        Width = 65
        Height = 21
        DataField = 'F24'
        DataSource = dsGrid
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 26
      end
      object edtGridID: TEdit
        Left = 0
        Top = 352
        Width = 105
        Height = 21
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 27
        Text = '0'
        OnDblClick = edtGridIDDblClick
      end
      object DBLookupComboBox1: TDBLookupComboBox
        Left = 312
        Top = 312
        Width = 137
        Height = 21
        DataField = 'fieldname'
        DataSource = dsGrid
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 28
      end
      object DBEdit1: TDBEdit
        Left = 528
        Top = 24
        Width = 97
        Height = 21
        DataField = 'F27'
        DataSource = dsGrid
        TabOrder = 29
      end
      object DBEdit2: TDBEdit
        Left = 640
        Top = 24
        Width = 144
        Height = 21
        DataField = 'rightID'
        DataSource = dsGrid
        TabOrder = 30
      end
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 834
    Height = 29
    ButtonHeight = 21
    ButtonWidth = 75
    Caption = 'ToolBar1'
    ShowCaptions = True
    TabOrder = 1
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Caption = 'IncHeight'
      ImageIndex = 0
      OnClick = ToolButton1Click
    end
    object tbALLeft: TToolButton
      Left = 75
      Top = 2
      Caption = 'tbALLeft'
      ImageIndex = 1
      OnClick = tbALLeftClick
    end
    object TbALRight: TToolButton
      Left = 150
      Top = 2
      Caption = 'TbALRight'
      ImageIndex = 2
      OnClick = TbALRightClick
    end
    object TbALTop: TToolButton
      Left = 225
      Top = 2
      Caption = 'TbALTop'
      ImageIndex = 3
      OnClick = TbALTopClick
    end
    object TBVESpan: TToolButton
      Left = 300
      Top = 2
      Caption = 'TBVESpan'
      ImageIndex = 4
      OnClick = TBVESpanClick
    end
    object TbHEspan: TToolButton
      Left = 375
      Top = 2
      Caption = 'TbHEspan'
      ImageIndex = 5
      Wrap = True
      OnClick = TbHEspanClick
    end
    object TbMoveLeft: TToolButton
      Left = 0
      Top = 23
      Caption = 'TbMoveLeft'
      ImageIndex = 6
      OnClick = TbMoveLeftClick
    end
    object TbMoveRight: TToolButton
      Left = 75
      Top = 23
      Caption = 'TbMoveRight'
      ImageIndex = 7
      OnClick = TbMoveRightClick
    end
    object TbMoveUP: TToolButton
      Left = 150
      Top = 23
      Caption = 'TbMoveUP'
      ImageIndex = 8
      OnClick = TbMoveUPClick
    end
    object TbMoveDown: TToolButton
      Left = 225
      Top = 23
      Caption = 'TbMoveDown'
      ImageIndex = 9
      OnClick = TbMoveDownClick
    end
    object Label2: TLabel
      Left = 300
      Top = 23
      Width = 48
      Height = 21
      Caption = #31227#21160#27493#38271
    end
    object edMoveSpan: TEdit
      Left = 348
      Top = 23
      Width = 48
      Height = 21
      ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
      TabOrder = 0
      Text = '3'
    end
  end
  object mm1: TMainMenu
    Left = 36
    Top = 376
    object r1: TMenuItem
      Caption = #25511#38190#31867#22411
      ShortCut = 16472
      OnClick = r1Click
    end
    object ControlConfig: TMenuItem
      Caption = #35774#32622#25511#38190
      ShortCut = 16455
      object LoadControl: TMenuItem
        Caption = #21152#36733#25511#38190
        ShortCut = 16474
        OnClick = LoadControlClick
      end
      object btnReportControls: TMenuItem
        Caption = #21152#36733#25253#34920#25511#38190
        OnClick = btnReportControlsClick
      end
    end
    object operate: TMenuItem
      Caption = 'operate'
      object clare: TMenuItem
        Caption = 'clear'
        OnClick = clareClick
      end
      object LabelFont: TMenuItem
        Caption = 'LabelFont'
        OnClick = LabelFontClick
      end
      object LblColor: TMenuItem
        Caption = 'LblColor'
        OnClick = LblColorClick
      end
      object N1: TMenuItem
        Caption = #20998#26512#30028#38754#24213#33394
        OnClick = N1Click
      end
    end
  end
  object qryT202: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'select *From t202')
    Left = 271
    Top = 448
    object qryT202F01: TAutoIncField
      FieldName = 'F01'
      ReadOnly = True
    end
    object qryT202F02: TIntegerField
      FieldName = 'F02'
    end
    object qryT202F03: TIntegerField
      FieldName = 'F03'
    end
    object qryT202F04: TStringField
      FieldName = 'F04'
      Size = 50
    end
    object qryT202F05: TBooleanField
      FieldName = 'F05'
    end
    object qryT202F06: TIntegerField
      FieldName = 'F06'
    end
    object qryT202F07: TStringField
      FieldName = 'F07'
      Size = 50
    end
    object qryT202F08: TStringField
      FieldName = 'F08'
      Size = 200
    end
    object qryT202F09: TStringField
      FieldName = 'F09'
      Size = 200
    end
    object qryT202F10: TBooleanField
      FieldName = 'F10'
    end
  end
  object dsT202: TDataSource
    DataSet = qryT202
    Left = 247
    Top = 448
  end
  object qryT102: TADOQuery
    AfterOpen = qryT102AfterOpen
    Parameters = <>
    SQL.Strings = (
      'select * From T102')
    Left = 288
    Top = 336
    object qryT102F01: TAutoIncField
      FieldName = 'F01'
      ReadOnly = True
    end
    object qryT102F02: TStringField
      FieldName = 'F02'
      Size = 50
    end
    object qryT102F03: TIntegerField
      FieldName = 'F03'
    end
    object qryT102F04: TIntegerField
      FieldName = 'F04'
    end
    object qryT102F05: TStringField
      FieldName = 'F05'
      FixedChar = True
      Size = 1
    end
    object qryT102F06: TIntegerField
      FieldName = 'F06'
    end
    object qryT102F07: TStringField
      FieldName = 'F07'
      Size = 50
    end
    object qryT102F08a: TIntegerField
      FieldName = 'F08a'
    end
    object qryT102F09: TStringField
      FieldName = 'F09'
      Size = 50
    end
    object qryT102F10: TStringField
      FieldName = 'F10'
      Size = 50
    end
    object qryT102F11: TStringField
      FieldName = 'F11'
      Size = 300
    end
    object qryT102F12: TBooleanField
      FieldName = 'F12'
    end
    object qryT102F13: TBooleanField
      FieldName = 'F13'
    end
    object qryT102F14: TIntegerField
      FieldName = 'F14'
    end
    object qryT102F15: TStringField
      FieldName = 'F15'
      Size = 50
    end
    object qryT102F16: TStringField
      FieldName = 'F16'
      Size = 50
    end
    object qryT102F17: TStringField
      FieldName = 'F17'
      Size = 50
    end
    object qryT102F18: TStringField
      FieldName = 'F18'
      Size = 50
    end
    object qryT102F19: TStringField
      FieldName = 'F19'
      Size = 200
    end
    object qryT102f20: TStringField
      FieldName = 'f20'
    end
    object qryT102f21: TStringField
      FieldName = 'f21'
    end
  end
  object dsT102: TDataSource
    DataSet = qryT102
    OnDataChange = dsT102DataChange
    Left = 263
    Top = 336
  end
  object qryT201: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'select *From T201 where 2=1')
    Left = 743
    Top = 144
  end
  object dsT201: TDataSource
    DataSet = qryT201
    Left = 719
    Top = 144
  end
  object qryGrid: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=Jbdata1;Persist Security Info=True;' +
      'User ID=sa;Initial Catalog=jingbeiNewsys;Data Source=jb99999.xic' +
      'p.net,7709'
    Parameters = <>
    SQL.Strings = (
      'select *From T505 where 1=2')
    Left = 220
    Top = 32
    object qryGridF01: TAutoIncField
      FieldName = 'F01'
      ReadOnly = True
    end
    object ifdGridF2: TIntegerField
      FieldName = 'F02'
    end
    object ifdGridF3: TIntegerField
      FieldName = 'F03'
    end
    object ifdGridF4: TIntegerField
      FieldName = 'F04'
    end
    object qryGridF05: TBooleanField
      FieldName = 'F05'
    end
    object qryGridF06: TBooleanField
      FieldName = 'F06'
    end
    object qryGridF07: TBooleanField
      DefaultExpression = '1'
      FieldName = 'F07'
    end
    object qryGridF08: TBooleanField
      FieldName = 'F08'
    end
    object qryGridF09: TStringField
      FieldName = 'F09'
      Size = 50
    end
    object qryGridF10: TBooleanField
      FieldName = 'F10'
    end
    object qryGridF11: TStringField
      FieldName = 'F11'
      Size = 300
    end
    object ifdGridF12: TIntegerField
      FieldName = 'F12'
    end
    object qryGridF13: TStringField
      FieldName = 'F13'
      FixedChar = True
      Size = 1
    end
    object qryGridF14: TStringField
      FieldName = 'F14'
      Size = 50
    end
    object qryGridF15: TStringField
      FieldName = 'F15'
      Size = 50
    end
    object qryGridF16: TStringField
      FieldName = 'F16'
      FixedChar = True
      Size = 1
    end
    object qryGridF17: TStringField
      FieldName = 'F17'
      Size = 50
    end
    object ifdGridF18: TIntegerField
      FieldName = 'F18'
    end
    object qryGridF19: TStringField
      FieldName = 'F19'
      Size = 50
    end
    object qryGridF20: TStringField
      FieldName = 'F20'
      Size = 50
    end
    object ifdGridF21: TIntegerField
      FieldName = 'F21'
    end
    object qryGridF22: TStringField
      FieldName = 'F22'
      Size = 50
    end
    object ifdGridF23: TIntegerField
      FieldName = 'F23'
    end
    object ifdGridF24: TIntegerField
      FieldName = 'F24'
    end
    object qryGridfieldname: TStringField
      FieldKind = fkLookup
      FieldName = 'fieldname'
      LookupDataSet = qryT102
      LookupKeyFields = 'f01'
      LookupResultField = 'f02'
      KeyFields = 'f03'
      Lookup = True
    end
    object qryGridF27: TStringField
      FieldName = 'F27'
    end
    object qryGridrightID: TStringField
      FieldName = 'rightID'
    end
  end
  object dsGrid: TDataSource
    DataSet = qryGrid
    Left = 252
    Top = 32
  end
  object pm_DelControl: TPopupMenu
    Left = 4
    Top = 376
    object del_control: TMenuItem
      Caption = #21024#38500#25511#38190
    end
  end
  object dsT607: TADODataSet
    CommandText = 'select * from t607 where f12=:f12'#13#10
    Parameters = <
      item
        Name = 'f12'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 548
    Top = 112
  end
  object dsST607: TDataSource
    DataSet = dsT607
    Left = 576
    Top = 112
  end
  object dsT610: TADODataSet
    CommandText = 'select * from T610 where f03=:f03'#13#10
    Parameters = <
      item
        Name = 'f03'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 628
    Top = 112
    object dsT610F01: TAutoIncField
      FieldName = 'F01'
      ReadOnly = True
    end
    object dsT610F02: TStringField
      FieldName = 'F02'
      Size = 50
    end
    object dsT610F03: TIntegerField
      FieldName = 'F03'
    end
    object dsT610F04: TStringField
      FieldName = 'F04'
      Size = 50
    end
    object dsT610F05: TStringField
      FieldName = 'F05'
      Size = 50
    end
    object dsT610F06: TStringField
      FieldName = 'F06'
    end
    object dsT610F07: TStringField
      FieldName = 'F07'
      Size = 50
    end
    object dsT610F08: TStringField
      FieldName = 'F08'
      Size = 50
    end
    object dsT610F09: TBooleanField
      FieldName = 'F09'
    end
    object dsT610F10: TBooleanField
      FieldName = 'F10'
    end
  end
  object dsds610: TDataSource
    DataSet = dsT610
    Left = 656
    Top = 112
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 288
    Top = 32
  end
  object ColorDialog1: TColorDialog
    Left = 320
    Top = 32
  end
end
