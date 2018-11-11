object EditorFrm: TEditorFrm
  Left = 609
  Top = 102
  BorderStyle = bsDialog
  Caption = 'EditorFrm'
  ClientHeight = 286
  ClientWidth = 629
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 280
    Width = 629
    Height = 5
    Cursor = crVSplit
    Align = alBottom
    Visible = False
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 629
    Height = 40
    AutoSize = True
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 36
        Width = 625
      end>
    object ToolBar1: TToolBar
      Left = 9
      Top = 0
      Width = 612
      Height = 36
      AutoSize = True
      ButtonHeight = 36
      ButtonWidth = 46
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Images = dmFrm.ImageList1
      ShowCaptions = True
      TabOrder = 0
      OnDblClick = ToolBar1DblClick
      object PrintBtn: TToolButton
        Left = 0
        Top = 0
        Action = PrintAction
        AutoSize = True
      end
      object ToolButton2: TToolButton
        Left = 37
        Top = 0
        Width = 12
        Caption = 'ToolButton2'
        ImageIndex = 9
        Style = tbsSeparator
      end
      object SavBtn: TToolButton
        Left = 49
        Top = 0
        Action = SaveAction
        AutoSize = True
      end
      object CelBtn: TToolButton
        Left = 86
        Top = 0
        Action = CancelAction
        AutoSize = True
      end
      object ToolButton3: TToolButton
        Left = 123
        Top = 0
        Width = 14
        Caption = 'ToolButton3'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object AddBtn: TToolButton
        Left = 137
        Top = 0
        Action = AddAction
        AutoSize = True
      end
      object CpyBtn: TToolButton
        Left = 174
        Top = 0
        Action = CopyAction
        AutoSize = True
      end
      object ChgBtn: TToolButton
        Left = 211
        Top = 0
        Action = EditAction
        AutoSize = True
      end
      object DelBtn: TToolButton
        Left = 248
        Top = 0
        Action = DeleteAction
        AutoSize = True
      end
      object ToolButton7: TToolButton
        Left = 285
        Top = 0
        Width = 12
        Caption = 'ToolButton7'
        Enabled = False
        ImageIndex = 5
        Style = tbsSeparator
      end
      object FirstBtn: TToolButton
        Left = 297
        Top = 0
        Action = FirstAction
        AutoSize = True
      end
      object PriorBtn: TToolButton
        Left = 334
        Top = 0
        Action = PriorAction
        AutoSize = True
      end
      object NextBtn: TToolButton
        Left = 384
        Top = 0
        Action = NextAction
        AutoSize = True
      end
      object LastBtn: TToolButton
        Left = 434
        Top = 0
        Action = LastAction
        AutoSize = True
      end
      object ToolButton12: TToolButton
        Left = 471
        Top = 0
        Width = 10
        Caption = 'ToolButton12'
        Enabled = False
        ImageIndex = 9
        Style = tbsSeparator
      end
      object ExtBtn: TToolButton
        Left = 481
        Top = 0
        Action = CloseAction
        AutoSize = True
      end
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 40
    Width = 629
    Height = 240
    Align = alClient
    MultiLine = True
    TabOrder = 1
  end
  object PnlItem: TPanel
    Left = 0
    Top = 285
    Width = 629
    Height = 1
    Align = alBottom
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 128
    Top = 149
  end
  object ADODataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    BeforePost = ADODataSet1BeforePost
    Parameters = <>
    Left = 232
    Top = 144
  end
  object ActionList1: TActionList
    Images = dmFrm.ImageList1
    Left = 312
    Top = 144
    object AddAction: TAction
      Caption = #26032#22686
      ImageIndex = 7
      OnExecute = AddActionExecute
    end
    object CopyAction: TAction
      Caption = #22797#21046
      ImageIndex = 1
      OnExecute = CopyActionExecute
    end
    object EditAction: TAction
      Caption = #20462#25913
      ImageIndex = 21
      OnExecute = EditActionExecute
    end
    object DeleteAction: TAction
      Caption = #21024#38500
      ImageIndex = 2
      OnExecute = DeleteActionExecute
    end
    object SaveAction: TAction
      Caption = #20445#23384
      ImageIndex = 9
      OnExecute = SaveActionExecute
    end
    object CancelAction: TAction
      Caption = #25918#24323
      ImageIndex = 4
      OnExecute = CancelActionExecute
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
    object PrintAction: TAction
      Caption = #25171#21360
      ImageIndex = 13
      OnExecute = PrintActionExecute
    end
    object SetCaptionAction: TAction
      Caption = #26356#26032#26631#39064
      ImageIndex = 28
      OnExecute = SetCaptionActionExecute
    end
    object actInputTaxAmt: TAction
      Caption = #31246#37329
      ImageIndex = 29
      OnExecute = actInputTaxAmtExecute
    end
    object ActDeliveryCfg: TAction
      Tag = -10000
      Caption = #36135#36816#21333
      ImageIndex = 13
      OnExecute = ActDeliveryCfgExecute
    end
    object ActPrintDeliveryBill: TAction
      Tag = -10000
      Caption = #25171#21360
      ImageIndex = 13
      OnExecute = ActPrintDeliveryBillExecute
    end
    object ActHouShengLabel: TAction
      Caption = #21402#22768#26631#31614#25171#21360
      ImageIndex = 13
      OnExecute = ActHouShengLabelExecute
    end
    object ActShowBackgroundPic: TAction
      Caption = #26174#31034#25171#21360#32972#26223
      ImageIndex = 26
      OnExecute = ActShowBackgroundPicExecute
    end
    object ActHouShengLableQrpt: TAction
      Caption = 'ActHouShengLableQrpt'
      ImageIndex = 13
      OnExecute = ActHouShengLableQrptExecute
    end
  end
  object frReport1: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    Left = 70
    Top = 137
    ReportForm = {19000000}
  end
end
