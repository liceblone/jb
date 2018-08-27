object FrmPrintBarCode: TFrmPrintBarCode
  Left = 310
  Top = 273
  Width = 1070
  Height = 621
  Caption = #25171#21360#26465#30721
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 1062
    Height = 36
    AutoSize = True
    ButtonHeight = 36
    ButtonWidth = 79
    Caption = 'ToolBar1'
    EdgeBorders = []
    Flat = True
    Images = dmFrm.ImageList1
    ShowCaptions = True
    TabOrder = 0
    object ToolButton7: TToolButton
      Left = 0
      Top = 0
      Width = 12
      Caption = 'ToolButton7'
      Enabled = False
      ImageIndex = 5
      Style = tbsSeparator
    end
    object FirstBtn: TToolButton
      Left = 12
      Top = 0
      Action = FirstAction
      AutoSize = True
    end
    object PriorBtn: TToolButton
      Left = 47
      Top = 0
      Action = PriorAction
      AutoSize = True
    end
    object NextBtn: TToolButton
      Left = 94
      Top = 0
      Action = NextAction
      AutoSize = True
    end
    object LastBtn: TToolButton
      Left = 141
      Top = 0
      Action = LastAction
      AutoSize = True
    end
    object ToolButton12: TToolButton
      Left = 176
      Top = 0
      Width = 10
      Caption = 'ToolButton12'
      ImageIndex = 9
      Style = tbsSeparator
    end
    object BtnCreateBarCode: TToolButton
      Left = 186
      Top = 0
      Caption = #29983#25104#26465#30721
      ImageIndex = 34
      OnClick = BtnCreateBarCodeClick
    end
    object ToolButton1: TToolButton
      Left = 265
      Top = 0
      Action = ActPrint
      AutoSize = True
      Caption = #39044#35272#25152#26377#26465#30721
      Visible = False
    end
    object btnPrintAllBarCode: TToolButton
      Left = 348
      Top = 0
      Caption = #25171#21360#25152#26377#26465#30721
      ImageIndex = 13
      OnClick = btnPrintAllBarCodeClick
    end
    object ToolButton6: TToolButton
      Left = 427
      Top = 0
      Width = 8
      Caption = 'ToolButton6'
      ImageIndex = 9
      Style = tbsSeparator
    end
    object btnPrintOneBarcode: TToolButton
      Left = 435
      Top = 0
      Caption = #39044#35272#21333#20010#26465#30721
      ImageIndex = 13
      OnClick = btnPrintOneBarcodeClick
    end
    object ToolButton2: TToolButton
      Left = 514
      Top = 0
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 9
      Style = tbsSeparator
    end
    object ToolButton3: TToolButton
      Left = 522
      Top = 0
      Caption = #21024#38500#26465#30721
      ImageIndex = 43
      OnClick = ToolButton3Click
    end
    object ToolButton4: TToolButton
      Left = 601
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 9
      Style = tbsSeparator
    end
    object ExtBtn: TToolButton
      Left = 609
      Top = 0
      Action = CloseAction
      AutoSize = True
    end
  end
  object GroupBox1: TGroupBox
    Left = 24
    Top = 64
    Width = 377
    Height = 89
    TabOrder = 1
    Visible = False
    object Label1: TLabel
      Left = 112
      Top = 8
      Width = 87
      Height = 13
      Caption = '2014-1-1 12:00:00'
    end
    object Label2: TLabel
      Left = 16
      Top = 8
      Width = 84
      Height = 13
      Caption = #26368#21518#25171#21360#26102#38388#65306
    end
    object Label3: TLabel
      Left = 64
      Top = 32
      Width = 36
      Height = 13
      Caption = #26465#30721#65306
    end
    object Label4: TLabel
      Left = 64
      Top = 56
      Width = 36
      Height = 13
      Caption = #25968#37327#65306
    end
    object Edit2: TEdit
      Left = 112
      Top = 32
      Width = 121
      Height = 21
      TabStop = False
      Color = clScrollBar
      ReadOnly = True
      TabOrder = 0
      Text = '2114102525282601'
    end
    object Button1: TButton
      Left = 272
      Top = 56
      Width = 75
      Height = 25
      Caption = #25171#21360
      TabOrder = 1
    end
    object Button2: TButton
      Left = 272
      Top = 24
      Width = 75
      Height = 25
      Caption = #39044#35272#25171#21360
      TabOrder = 2
    end
    object Edit1: TEdit
      Left = 112
      Top = 56
      Width = 121
      Height = 21
      TabOrder = 3
      Text = 'Edit1'
    end
  end
  object pnlContent: TPageControl
    Left = 0
    Top = 36
    Width = 1062
    Height = 558
    ActivePage = TabBarCodeInput
    Align = alClient
    TabOrder = 2
    object TabBarCodeInput: TTabSheet
      Caption = #26465#30721#29983#25104
      object ScrollTop: TScrollBox
        Left = 0
        Top = 0
        Width = 1054
        Height = 48
        Align = alTop
        BorderStyle = bsNone
        Color = clHighlightText
        ParentColor = False
        TabOrder = 0
        OnDblClick = ScrollTopDblClick
        DesignSize = (
          1054
          48)
        object Label5: TLabel
          Left = 0
          Top = 0
          Width = 1054
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
          Left = 1551
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
        object statLabel1: TLabel
          Left = 80
          Top = 0
          Width = 17
          Height = 13
          Alignment = taRightJustify
          Caption = '0/0'
        end
      end
      object PnlLeft: TPanel
        Left = 0
        Top = 48
        Width = 176
        Height = 482
        Align = alLeft
        AutoSize = True
        Caption = 'PnlLeft'
        TabOrder = 1
      end
      object PnlGrid: TPanel
        Left = 176
        Top = 48
        Width = 731
        Height = 482
        Align = alClient
        Caption = 'PnlGrid'
        TabOrder = 2
      end
      object PnlRight: TPanel
        Left = 907
        Top = 48
        Width = 147
        Height = 482
        Align = alRight
        AutoSize = True
        Caption = 'PnlRight'
        TabOrder = 3
      end
    end
  end
  object ActionList1: TActionList
    Images = dmFrm.ImageList1
    Left = 344
    Top = 64
    object AddAction: TAction
      Caption = #26032#22686
      ImageIndex = 7
    end
    object CopyAction: TAction
      Caption = #22797#21046
      ImageIndex = 1
    end
    object EditAction: TAction
      Caption = #20462#25913
      ImageIndex = 21
    end
    object DeleteAction: TAction
      Caption = #21024#38500
      ImageIndex = 2
    end
    object SaveAction: TAction
      Caption = #20445#23384
      ImageIndex = 9
    end
    object CancelAction: TAction
      Caption = #25918#24323
      ImageIndex = 4
    end
    object FirstAction: TAction
      Caption = #39318#24352
      ImageIndex = 25
      OnExecute = FirstActionExecute
    end
    object PriorAction: TAction
      Caption = #19978#19968#24352
      ImageIndex = 22
      OnExecute = PriorActionExecute
    end
    object NextAction: TAction
      Caption = #19979#19968#24352
      ImageIndex = 24
      OnExecute = NextActionExecute
    end
    object LastAction: TAction
      Caption = #26411#24352
      ImageIndex = 23
      OnExecute = LastActionExecute
    end
    object CloseAction: TAction
      Caption = #20851#38381
      ImageIndex = 8
      OnExecute = CloseActionExecute
    end
    object ActPrint: TAction
      Caption = #25171#21360#25152#26377#26465#30721
      ImageIndex = 13
      OnExecute = ActPrintExecute
    end
  end
  object DataSet: TADODataSet
    Connection = dmFrm.ADOConnection1
    Parameters = <>
    Left = 376
    Top = 64
  end
  object mtDataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    LockType = ltBatchOptimistic
    CommandTimeout = 120
    Parameters = <>
    Left = 56
    Top = 160
  end
  object mtDataSource1: TDataSource
    DataSet = mtDataSet1
    Left = 24
    Top = 161
  end
  object ActionList2: TActionList
    Images = dmFrm.ImageList1
    Left = 352
    Top = 224
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
    end
    object OpenAction1: TAction
      Caption = #25171#24320
      ImageIndex = 0
    end
    object NewAction1: TAction
      Caption = #26032#24314
      ImageIndex = 7
    end
    object RemoveAction1: TAction
      Tag = -600
      Caption = #24323#21333
      Enabled = False
      ImageIndex = 2
      Visible = False
    end
    object CancelAction1: TAction
      Tag = 200
      Caption = #25918#24323
      ImageIndex = 4
    end
    object SaveAction1: TAction
      Tag = 100
      Caption = #20445#23384'1'
      ImageIndex = 9
      Visible = False
    end
    object CheckAction1: TAction
      Tag = 400
      Caption = #23457#26680
      Enabled = False
      Hint = #23457#26680
      ImageIndex = 10
    end
    object ImportAction1: TAction
      Tag = 800
      Caption = #23548#20837
      Enabled = False
      ImageIndex = 32
    end
    object AppendAction1: TAction
      Tag = 600
      Caption = #22686#34892
      Enabled = False
      ImageIndex = 12
    end
    object DeleteAction1: TAction
      Tag = 700
      Caption = #21024#34892
      Enabled = False
      ImageIndex = 11
      Visible = False
    end
    object RefreshAction1: TAction
      Caption = #21047#26032
      Enabled = False
      ImageIndex = 16
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
    end
    object HelpAction1: TAction
      Caption = #24110#21161
      ImageIndex = 5
    end
    object FirstAction1: TAction
      Tag = -1000
      Caption = #39318#24352
      ImageIndex = 25
    end
    object PriorAction1: TAction
      Tag = -900
      Caption = #19978#19968#24352
      ImageIndex = 22
    end
    object NextAction1: TAction
      Tag = -800
      Caption = #19979#19968#24352
      ImageIndex = 24
    end
    object ActShowHead: TAction
      Caption = #34920#22836
      ImageIndex = 18
    end
    object LastAction1: TAction
      Tag = -700
      Caption = #26411#24352
      ImageIndex = 23
    end
    object FaxAction1: TAction
      Caption = #20256#30495
      Enabled = False
      ImageIndex = 1
    end
    object ActInfo: TAction
      Caption = #30456#20851#20449#24687
      ImageIndex = 32
    end
    object ActLocate: TAction
      Caption = #23450#20301
      ImageIndex = 17
    end
    object ActEdit: TAction
      Caption = #32534#36753
      ImageIndex = 21
      Visible = False
    end
    object ActSetBit: TAction
      Caption = #32622#36923#36753#26631#24535
      ImageIndex = 15
    end
    object ActSaveExecDLProc: TAction
      Caption = #29992#23384#20648#36807#31243#20445#23384
      ImageIndex = 9
    end
    object UserLog: TAction
      Caption = #26085#24535
      Hint = #25968#25454#20462#25913#21024#38500#35760#24405
      ImageIndex = 29
    end
    object ActUncheck: TAction
      Tag = 500
      Caption = #24323#23457
      ImageIndex = 37
    end
    object ActSaveHaveTextFomula: TAction
      Tag = 101
      Caption = #20445#23384
      ImageIndex = 9
      Visible = False
    end
    object ActChkChg: TAction
      Tag = 150
      Caption = #21464#26356
      ImageIndex = 38
    end
    object ActProperty: TAction
      Caption = #26448#26009#23646#24615
      ImageIndex = 42
    end
    object actMainLog: TAction
      Caption = #20027#26085#24535
      ImageIndex = 29
    end
    object InActiveBill: TAction
      Tag = 550
      Caption = #20851#38381
      ImageIndex = 47
    end
    object ActiveBill: TAction
      Tag = 551
      Caption = #25171#24320
      ImageIndex = 0
    end
    object actMDLookup: TAction
      Tag = 5000
      Caption = #24341#29992
      ImageIndex = 48
    end
    object Actlock: TAction
      Caption = 'Actlock'
      ImageIndex = 28
    end
    object Actunlock: TAction
      Caption = 'Actunlock'
      ImageIndex = 22
    end
    object ActPrintBarCode: TAction
      Tag = 1000
      Caption = #25171#21360#26465#30721
      ImageIndex = 34
    end
    object ActPrintBarCodeWhMove: TAction
      Caption = 'ActPrintBarCodeWhMove'
      ImageIndex = 34
    end
    object ActSLInvoiceCheck: TAction
      Caption = #23457#26680
      ImageIndex = 10
    end
    object ActSLPrint: TAction
      Tag = -2000
      Caption = #25171#21360
      ImageIndex = 13
    end
    object ActRemoveBill: TAction
      Tag = -600
      Caption = #24323#21333
      ImageIndex = 2
    end
    object ActSLPrint2: TAction
      Tag = -1500
      Caption = #25171#21360'2'
      ImageIndex = 13
    end
  end
  object dlDataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    LockType = ltBatchOptimistic
    AfterScroll = dlDataSet1AfterScroll
    OnCalcFields = dlDataSet1CalcFields
    CommandTimeout = 120
    Parameters = <>
    Left = 504
    Top = 216
  end
  object DlDataSource1: TDataSource
    DataSet = dlDataSet1
    Left = 472
    Top = 216
  end
  object MainMenu1: TMainMenu
    AutoMerge = True
    Images = dmFrm.ImageList1
    Left = 320
    Top = 224
  end
end
