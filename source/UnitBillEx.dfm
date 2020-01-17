object FrmBillEx: TFrmBillEx
  Left = 383
  Top = 197
  Width = 1215
  Height = 647
  Caption = 'FrmBillEx'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 43
    Width = 1207
    Height = 561
    Align = alClient
    BevelOuter = bvLowered
    Caption = 'Panel1'
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 421
      Width = 1205
      Height = 8
      Cursor = crVSplit
      Align = alTop
    end
    object Splitter2: TSplitter
      Left = 1
      Top = 49
      Width = 1205
      Height = 2
      Cursor = crVSplit
      Align = alTop
    end
    object ScrollBtm: TScrollBox
      Left = 1
      Top = 429
      Width = 1205
      Height = 131
      Align = alClient
      AutoSize = True
      BorderStyle = bsNone
      Color = clWhite
      ParentColor = False
      TabOrder = 4
      OnDblClick = ScrollBtmDblClick
    end
    object ScrollTop: TScrollBox
      Left = 1
      Top = 1
      Width = 1205
      Height = 48
      Align = alTop
      BorderStyle = bsNone
      Color = clHighlightText
      ParentColor = False
      TabOrder = 0
      OnDblClick = ScrollTopDblClick
      DesignSize = (
        1205
        48)
      object Label3: TLabel
        Left = 0
        Top = 21
        Width = 1205
        Height = 4
        Align = alTop
        Alignment = taRightJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -4
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object LblState: TLabel
        Left = 1100
        Top = 24
        Width = 24
        Height = 13
        Anchors = [akTop, akRight]
        Caption = #29366#24577
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object LblTitle: TLabel
        Left = 0
        Top = 0
        Width = 1205
        Height = 21
        Align = alTop
        Alignment = taCenter
        Caption = #26631#39064
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = #26999#20307'_GB2312'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object statLabel1: TLabel
        Left = 80
        Top = 0
        Width = 17
        Height = 13
        Alignment = taRightJustify
        Caption = '0/0'
      end
    end
    object PnlFunction: TPanel
      Left = 1
      Top = 51
      Width = 1205
      Height = 50
      Align = alTop
      TabOrder = 1
      Visible = False
      object GroupBox1: TGroupBox
        Left = 1
        Top = 1
        Width = 1203
        Height = 48
        Align = alClient
        Caption = #35760#24405#23450#20301
        TabOrder = 0
        object Label2: TLabel
          Left = 24
          Top = 19
          Width = 60
          Height = 13
          Caption = #36873#25321#23383#27573#21517
        end
        object Label1: TLabel
          Left = 224
          Top = 19
          Width = 12
          Height = 13
          Caption = #20540
        end
        object CmbFlds: TComboBox
          Left = 88
          Top = 16
          Width = 121
          Height = 21
          Style = csDropDownList
          ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
          ItemHeight = 13
          TabOrder = 0
          OnChange = CmbFldsChange
        end
        object EdtValues: TEdit
          Left = 240
          Top = 16
          Width = 89
          Height = 21
          Hint = #36755#20986#20540#20043#21518#22238#36710
          ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
          MaxLength = 200
          TabOrder = 1
          OnKeyUp = EdtValuesKeyUp
        end
      end
    end
    object PnlContent: TPanel
      Left = 1
      Top = 101
      Width = 1205
      Height = 320
      Align = alTop
      Caption = 'PnlContent'
      TabOrder = 2
      object SplitterLeft: TSplitter
        Left = 201
        Top = 1
        Width = 4
        Height = 318
      end
      object PnlLeft: TPanel
        Left = 1
        Top = 1
        Width = 200
        Height = 318
        Align = alLeft
        AutoSize = True
        Caption = 'PnlLeft'
        TabOrder = 0
      end
      object PnlGrid: TPanel
        Left = 205
        Top = 1
        Width = 852
        Height = 318
        Align = alClient
        Caption = 'PnlGrid'
        TabOrder = 1
      end
      object PnlRight: TPanel
        Left = 1057
        Top = 1
        Width = 147
        Height = 318
        Align = alRight
        AutoSize = True
        Caption = 'PnlRight'
        TabOrder = 2
      end
    end
    object PnlBtm: TPanel
      Left = 1
      Top = 429
      Width = 1205
      Height = 131
      Align = alClient
      TabOrder = 3
      OnDblClick = PnlBtmDblClick
    end
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 1207
    Height = 43
    Align = alTop
    AutoSize = True
    TabOrder = 1
    object ToolBar1: TToolBar
      Left = 11
      Top = 2
      Width = 326
      Height = 35
      AutoSize = True
      ButtonHeight = 35
      ButtonWidth = 40
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      Images = dmFrm.ImageList1
      ParentFont = False
      ShowCaptions = True
      TabOrder = 0
      object ToolButton2: TToolButton
        Left = 0
        Top = 0
        Action = OpenAction1
      end
      object ToolButton1: TToolButton
        Left = 40
        Top = 0
        Action = SaveAction1
      end
      object ToolButton3: TToolButton
        Left = 80
        Top = 0
        Action = CancelAction1
      end
      object ToolButton4: TToolButton
        Left = 120
        Top = 0
        Action = ImportAction1
      end
      object ToolButton8: TToolButton
        Left = 160
        Top = 0
        Action = HelpAction1
      end
    end
    object ToolBar2: TToolBar
      Left = 350
      Top = 2
      Width = 438
      Height = 35
      AutoSize = True
      ButtonHeight = 35
      ButtonWidth = 59
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      Images = dmFrm.ImageList1
      ParentFont = False
      ShowCaptions = True
      TabOrder = 1
      object btnCtrl: TToolButton
        Left = 0
        Top = 0
        Caption = #35774#32622#25511#38190
        ImageIndex = 45
        OnClick = btnCtrlClick
      end
      object ToolButton5: TToolButton
        Left = 59
        Top = 0
        Action = RefreshAction1
      end
      object ToolButton6: TToolButton
        Left = 118
        Top = 0
        Action = HelpAction1
        Visible = False
      end
      object BtnShowHead: TToolButton
        Left = 177
        Top = 0
        Action = ActShowHead
        Down = True
        Style = tbsCheck
      end
      object BtnRecLocate: TToolButton
        Left = 236
        Top = 0
        Action = ActLocate
        Style = tbsCheck
      end
      object ToolButton9: TToolButton
        Left = 295
        Top = 0
        Action = UserLog
      end
      object ToolButton7: TToolButton
        Left = 354
        Top = 0
        Action = CloseAction1
      end
    end
  end
  object PgBarSave: TProgressBar
    Left = 0
    Top = 604
    Width = 1207
    Height = 16
    Align = alBottom
    TabOrder = 2
    Visible = False
  end
  object mtDataSource1: TDataSource
    DataSet = mtDataSet1
    OnStateChange = mtDataSource1StateChange
    Left = 24
    Top = 161
  end
  object DlDataSource1: TDataSource
    DataSet = dlDataSet1
    OnStateChange = DlDataSource1StateChange
    Left = 472
    Top = 216
  end
  object dlDataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    LockType = ltBatchOptimistic
    AfterPost = dlDataSet1AfterPost
    AfterScroll = dlDataSet1AfterScroll
    OnCalcFields = dlDataSet1CalcFields
    CommandTimeout = 120
    Parameters = <>
    Left = 504
    Top = 216
  end
  object mtDataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    LockType = ltBatchOptimistic
    CommandTimeout = 120
    Parameters = <>
    Left = 56
    Top = 160
  end
  object ActionList1: TActionList
    Images = dmFrm.ImageList1
    Left = 352
    Top = 232
    object MailAction1: TAction
      Caption = #35774#32622
      Enabled = False
      ImageIndex = 36
    end
    object PrintAction1: TAction
      Tag = -2000
      Caption = #25171#21360
      Enabled = False
      ImageIndex = 13
      Visible = False
      OnExecute = PrintAction1Execute
    end
    object OpenAction1: TAction
      Caption = #25171#24320
      ImageIndex = 0
      OnExecute = OpenAction1Execute
    end
    object NewAction1: TAction
      Caption = #26032#24314
      ImageIndex = 7
      OnExecute = NewAction1Execute
    end
    object RemoveAction1: TAction
      Tag = -600
      Caption = #24323#21333
      Enabled = False
      ImageIndex = 2
      Visible = False
      OnExecute = RemoveAction1Execute
    end
    object CancelAction1: TAction
      Tag = 200
      Caption = #25918#24323
      ImageIndex = 4
      OnExecute = CancelAction1Execute
    end
    object SaveAction1: TAction
      Tag = 100
      Caption = #20445#23384'1'
      ImageIndex = 9
      Visible = False
      OnExecute = SaveAction1Execute
    end
    object CheckAction1: TAction
      Tag = 400
      Caption = #23457#26680
      Enabled = False
      Hint = #23457#26680
      ImageIndex = 10
      OnExecute = CheckAction1Execute
    end
    object ImportAction1: TAction
      Tag = 800
      Caption = #23548#20837
      Enabled = False
      ImageIndex = 32
      OnExecute = ImportAction1Execute
    end
    object AppendAction1: TAction
      Tag = 600
      Caption = #22686#34892
      Enabled = False
      ImageIndex = 12
      OnExecute = AppendAction1Execute
    end
    object DeleteAction1: TAction
      Tag = 700
      Caption = #21024#34892
      Enabled = False
      ImageIndex = 11
      Visible = False
      OnExecute = DeleteAction1Execute
    end
    object RefreshAction1: TAction
      Caption = #21047#26032
      Enabled = False
      ImageIndex = 16
      OnExecute = RefreshAction1Execute
    end
    object LocateAction1: TAction
      Caption = 'LocateAction1'
      Enabled = False
      ImageIndex = 3
    end
    object CloseAction1: TAction
      Caption = #36864#20986
      Enabled = False
      ImageIndex = 8
      OnExecute = CloseAction1Execute
    end
    object HelpAction1: TAction
      Caption = #24110#21161
      ImageIndex = 5
    end
    object FirstAction1: TAction
      Tag = -1000
      Caption = #39318#24352
      ImageIndex = 25
      OnExecute = FirstAction1Execute
    end
    object PriorAction1: TAction
      Tag = -900
      Caption = #19978#19968#24352
      ImageIndex = 22
      OnExecute = PriorAction1Execute
    end
    object NextAction1: TAction
      Tag = -800
      Caption = #19979#19968#24352
      ImageIndex = 24
      OnExecute = NextAction1Execute
    end
    object ActShowHead: TAction
      Caption = #34920#22836
      ImageIndex = 18
      OnExecute = ActShowHeadExecute
    end
    object LastAction1: TAction
      Tag = -700
      Caption = #26411#24352
      ImageIndex = 23
      OnExecute = LastAction1Execute
    end
    object FaxAction1: TAction
      Caption = #20256#30495
      Enabled = False
      ImageIndex = 1
    end
    object ActInfo: TAction
      Caption = #30456#20851#20449#24687
      ImageIndex = 32
      OnExecute = ActInfoExecute
    end
    object ActLocate: TAction
      Caption = #23450#20301
      ImageIndex = 17
      OnExecute = ActLocateExecute
    end
    object ActEdit: TAction
      Caption = #32534#36753
      ImageIndex = 21
      Visible = False
      OnExecute = ActEditExecute
    end
    object ActSetBit: TAction
      Caption = #32622#36923#36753#26631#24535
      ImageIndex = 15
      OnExecute = ActSetBitExecute
    end
    object ActSaveExecDLProc: TAction
      Caption = #29992#23384#20648#36807#31243#20445#23384
      ImageIndex = 9
      OnExecute = ActSaveExecDLProcExecute
    end
    object UserLog: TAction
      Caption = #26085#24535
      Hint = #25968#25454#20462#25913#21024#38500#35760#24405
      ImageIndex = 29
      OnExecute = UserLogExecute
    end
    object ActUncheck: TAction
      Tag = 500
      Caption = #24323#23457
      ImageIndex = 37
      OnExecute = ActUncheckExecute
    end
    object ActSaveHaveTextFomula: TAction
      Tag = 101
      Caption = #20445#23384
      ImageIndex = 9
      Visible = False
      OnExecute = ActSaveHaveTextFomulaExecute
    end
    object ActChkChg: TAction
      Tag = 150
      Caption = #21464#26356
      ImageIndex = 38
      OnExecute = ActChkChgExecute
    end
    object ActProperty: TAction
      Caption = #26448#26009#23646#24615
      ImageIndex = 42
      OnExecute = ActPropertyExecute
    end
    object actMainLog: TAction
      Caption = #20027#26085#24535
      ImageIndex = 29
    end
    object InActiveBill: TAction
      Tag = 550
      Caption = #20851#38381
      ImageIndex = 47
      OnExecute = InActiveBillExecute
    end
    object ActiveBill: TAction
      Tag = 551
      Caption = #25171#24320
      ImageIndex = 0
      OnExecute = ActiveBillExecute
    end
    object actMDLookup: TAction
      Tag = 5000
      Caption = #24341#29992
      ImageIndex = 48
      OnExecute = actMDLookupExecute
    end
    object Actlock: TAction
      Caption = 'Actlock'
      ImageIndex = 28
      OnExecute = ActlockExecute
    end
    object Actunlock: TAction
      Caption = 'Actunlock'
      ImageIndex = 22
      OnExecute = ActunlockExecute
    end
    object ActPrintBarCode: TAction
      Tag = 1000
      Caption = #25171#21360#26465#30721
      ImageIndex = 34
      OnExecute = ActPrintBarCodeExecute
    end
    object ActPrintBarCodeWhMove: TAction
      Caption = 'ActPrintBarCodeWhMove'
      ImageIndex = 34
      OnExecute = ActPrintBarCodeWhMoveExecute
    end
    object ActSLInvoiceCheck: TAction
      Caption = #23457#26680
      ImageIndex = 10
      OnExecute = ActSLInvoiceCheckExecute
    end
    object ActSLPrint: TAction
      Tag = -2000
      Caption = #25171#21360
      ImageIndex = 13
      OnExecute = ActSLPrintExecute
    end
    object ActRemoveBill: TAction
      Tag = -600
      Caption = #24323#21333
      ImageIndex = 2
      OnExecute = ActRemoveBillExecute
    end
    object ActSLPrint2: TAction
      Tag = -1500
      Caption = #25171#21360'2'
      ImageIndex = 13
      OnExecute = ActSLPrint2Execute
    end
    object ActCreateWhmove: TAction
      Caption = 'ActCreateWhmove'
      Enabled = False
      ImageIndex = 48
      OnExecute = ActCreateWhmoveExecute
    end
    object ActBarCodeInput: TAction
      Caption = #25195#26465#30721
      ImageIndex = 34
      OnExecute = ActBarCodeInputExecute
    end
    object ActChkSL_Invoice: TAction
      Tag = 100
      Caption = #21457#36135#21333#20445#23384
      ImageIndex = 39
      OnExecute = ActChkSL_InvoiceExecute
    end
    object ActTransBill: TAction
      Tag = 1000
      Caption = #36135#36816#21333
      ImageIndex = 1
      OnExecute = ActTransBillExecute
    end
    object ActSaveSl_invoice: TAction
      Caption = #20445#23384#21457#36135#21333
      ImageIndex = 9
      OnExecute = ActSaveSl_invoiceExecute
    end
    object ActOri: TAction
      Tag = 10000
      Caption = #21407#21333#25454
      ImageIndex = 32
      OnExecute = ActOriExecute
    end
    object ActCreateSLinvoice: TAction
      Tag = 2000
      Caption = #29983#25104#21457#36135#21333
      ImageIndex = 48
      OnExecute = ActCreateSLinvoiceExecute
    end
    object ActSort: TAction
      Caption = #25490#24207
      ImageIndex = 15
      OnExecute = ActSortExecute
    end
    object ActPrintLabelCfg: TAction
      Caption = #26631#31614#25171#21360#35774#32622
      ImageIndex = 13
      OnExecute = ActPrintLabelCfgExecute
    end
    object ActPlateLabelPreview: TAction
      Caption = #27599#30424#26631#31614#39044#35272
      ImageIndex = 13
      OnExecute = ActPlateLabelPreviewExecute
    end
    object ActSaveWoOwner: TAction
      Caption = #20445#23384
      ImageIndex = 9
      OnExecute = ActSaveWoOwnerExecute
    end
    object ActOutItemPrintLabel: TAction
      Caption = #21457#36135#22806#31665#24635#26631#31614#39044#35272
      ImageIndex = 13
      OnExecute = ActOutItemPrintLabelExecute
    end
    object ActPlatePrintLabel: TAction
      Caption = #27599#30424#26631#31614#25171#21360
      ImageIndex = 13
      OnExecute = ActPlatePrintLabelExecute
    end
    object ActPerPartNoPlateLabelPreview: TAction
      Caption = #21333#22411#21495#27599#30424#26631#31614#39044#35272
      ImageIndex = 13
      OnExecute = ActPerPartNoPlateLabelPreviewExecute
    end
    object ActPlateClientBarCodePreviewByWare: TAction
      Caption = #23458#25143#26465#30721#21333#22411#21495#39044#35272
      ImageIndex = 13
      OnExecute = ActPlateClientBarCodePreviewByWareExecute
    end
    object ActPlateClientBarCodePreviewWholeBill: TAction
      Caption = #23458#25143#26465#30721#25972#21333#39044#35272
      ImageIndex = 13
      OnExecute = ActPlateClientBarCodePreviewWholeBillExecute
    end
    object ActPlateClientBarCodePrintWholeBill: TAction
      Caption = #23458#25143#26465#30721#25972#21333#25171#21360
      ImageIndex = 13
      OnExecute = ActPlateClientBarCodePrintWholeBillExecute
    end
    object ActPrintBarCodePhOrd: TAction
      Caption = 'ActPrintBarCodePhOrd'
      ImageIndex = 34
      OnExecute = ActPrintBarCodePhOrdExecute
    end
    object ActPrintEveryPackageLabel: TAction
      Caption = #22806#31665#27599#20214#26631#31614
      ImageIndex = 13
      OnExecute = ActPrintEveryPackageLabelExecute
    end
    object ActPlateClientBarCodePreviewWholeBillV2: TAction
      Caption = #23458#25143#26465#30721#25972#21333#39044#35272
      ImageIndex = 13
      OnExecute = ActPlateClientBarCodePreviewWholeBillV2Execute
    end
    object ActCreateDeliveryLabel: TAction
      Caption = #29983#25104#24555#36882#26631#31614
      ImageIndex = 7
      OnExecute = ActCreateDeliveryLabelExecute
    end
    object ActDeliveryLabelPrint: TAction
      Caption = #25171#21360#24555#36958#27161#31805
      ImageIndex = 13
      OnExecute = ActDeliveryLabelPrintExecute
    end
    object ActMulFormatPrint: TAction
      Caption = #25171#21360
      ImageIndex = 13
      OnExecute = ActMulFormatPrintExecute
    end
    object ActExportExcel: TAction
      Caption = #23548#20986
      ImageIndex = 38
      OnExecute = ActExportExcelExecute
    end
    object ActSyncStickData: TAction
      Caption = #36148#26631
      ImageIndex = 34
      OnExecute = ActSyncStickDataExecute
    end
    object ActPkgCompleted: TAction
      Caption = 'ActPkgCompleted'
      ImageIndex = 21
      OnExecute = ActPkgCompletedExecute
    end
  end
  object MainMenu1: TMainMenu
    AutoMerge = True
    Images = dmFrm.ImageList1
    Left = 320
    Top = 224
  end
end
