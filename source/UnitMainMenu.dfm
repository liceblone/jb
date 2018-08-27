object FrmMainMenu: TFrmMainMenu
  Left = 218
  Top = 184
  Width = 797
  Height = 366
  Caption = 'FrmMainMenu'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mmmain
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar: TToolBar
    Left = 0
    Top = 41
    Width = 789
    Height = 36
    ButtonHeight = 36
    ButtonWidth = 43
    Caption = 'ToolBar'
    EdgeBorders = []
    Flat = True
    Images = dmFrm.ImageList1
    ShowCaptions = True
    TabOrder = 0
    OnDblClick = ToolBarDblClick
    object PrintBtn: TToolButton
      Left = 0
      Top = 0
      Action = actPrintAction
    end
    object SavBtn: TToolButton
      Left = 43
      Top = 0
      Action = actSaveAction
      AutoSize = True
    end
    object CelBtn: TToolButton
      Left = 78
      Top = 0
      Action = actCancelAction
      AutoSize = True
    end
    object btn2: TToolButton
      Left = 113
      Top = 0
      Width = 8
      Caption = 'btn2'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object AddBtn: TToolButton
      Left = 121
      Top = 0
      Action = actAddAction
      AutoSize = True
    end
    object CpyBtn: TToolButton
      Left = 156
      Top = 0
      Action = actCopyAction
      AutoSize = True
    end
    object editBtn: TToolButton
      Left = 191
      Top = 0
      Action = actEditAction
      AutoSize = True
    end
    object DelBtn: TToolButton
      Left = 226
      Top = 0
      Action = actDeleteAction
      AutoSize = True
    end
    object btn3: TToolButton
      Left = 261
      Top = 0
      Width = 8
      Caption = 'btn3'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object FirstBtn: TToolButton
      Left = 269
      Top = 0
      Action = actFirstAction
      AutoSize = True
    end
    object PriorBtn: TToolButton
      Left = 304
      Top = 0
      Action = actPriorAction
      AutoSize = True
    end
    object NextBtn: TToolButton
      Left = 351
      Top = 0
      Action = actNextAction
      AutoSize = True
    end
    object LastBtn: TToolButton
      Left = 398
      Top = 0
      Action = actLastAction
      AutoSize = True
    end
    object btn4: TToolButton
      Left = 433
      Top = 0
      Width = 8
      Caption = 'btn4'
      ImageIndex = 9
      Style = tbsSeparator
    end
    object TbtnReflash: TToolButton
      Left = 441
      Top = 0
      Caption = #21047#26032
      ImageIndex = 16
      OnClick = TbtnReflashClick
    end
    object Frm: TToolButton
      Left = 484
      Top = 0
      Caption = ' Forms '
      ImageIndex = 20
      OnClick = FrmClick
    end
    object ExtBtn: TToolButton
      Left = 527
      Top = 0
      Action = actCloseAction
      AutoSize = True
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 77
    Width = 789
    Height = 243
    Align = alClient
    TabOrder = 1
  end
  object ToolBarMain: TToolBar
    Left = 0
    Top = 0
    Width = 789
    Height = 41
    ButtonHeight = 36
    ButtonWidth = 65
    Caption = 'ToolBarMain'
    Images = dmFrm.ImageList1
    ShowCaptions = True
    TabOrder = 2
    Wrapable = False
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Caption = 'ToolButton1'
      ImageIndex = 0
    end
  end
  object ADODataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    Parameters = <>
    Left = 72
    Top = 248
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 40
    Top = 245
  end
  object mmmain: TMainMenu
    Left = 104
    Top = 248
    object s1: TMenuItem
      Caption = 'sdffds'
    end
  end
  object ActionList1: TActionList
    Images = dmFrm.ImageList1
    Left = 8
    Top = 240
    object actAddAction: TAction
      Caption = #26032#22686
      ImageIndex = 7
      OnExecute = actAddActionExecute
    end
    object actCopyAction: TAction
      Caption = #22797#21046
      ImageIndex = 1
      OnExecute = actCopyActionExecute
    end
    object actEditAction: TAction
      Caption = #20462#25913
      ImageIndex = 21
      OnExecute = actEditActionExecute
    end
    object actDeleteAction: TAction
      Caption = #21024#38500
      ImageIndex = 2
      OnExecute = actDeleteActionExecute
    end
    object actSaveAction: TAction
      Caption = #20445#23384
      ImageIndex = 9
      OnExecute = actSaveActionExecute
    end
    object actCancelAction: TAction
      Caption = #25918#24323
      ImageIndex = 4
      OnExecute = actCancelActionExecute
    end
    object actFirstAction: TAction
      Caption = #39318#24352
      ImageIndex = 25
      OnExecute = actFirstActionExecute
    end
    object actPriorAction: TAction
      Caption = #19978#19968#24352
      ImageIndex = 22
      OnExecute = actPriorActionExecute
    end
    object actNextAction: TAction
      Caption = #19979#19968#24352
      ImageIndex = 24
      OnExecute = actNextActionExecute
    end
    object actLastAction: TAction
      Caption = #26411#24352
      ImageIndex = 23
      OnExecute = actLastActionExecute
    end
    object actCloseAction: TAction
      Caption = #20851#38381
      ImageIndex = 8
      OnExecute = actCloseActionExecute
    end
    object actPrintAction: TAction
      Caption = #25171#21360
      ImageIndex = 13
    end
    object actSetCaptionAction: TAction
      Caption = #26356#26032#26631#39064
      ImageIndex = 28
    end
    object actInputTaxAmt: TAction
      Caption = #31246#37329
      ImageIndex = 29
    end
    object SelectMenu: TAction
      Caption = 'SelectMenu'
      OnExecute = SelectMenuExecute
    end
  end
end
