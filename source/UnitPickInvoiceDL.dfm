object FrmPickInvoiceDL: TFrmPickInvoiceDL
  Left = 272
  Top = 188
  Width = 841
  Height = 486
  Caption = 'FrmPickSLOrderDL'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    833
    459)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 56
    Width = 729
    Height = 377
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object BtnConfirm: TButton
    Left = 752
    Top = 56
    Width = 75
    Height = 25
    Caption = #30830#23450
    ModalResult = 1
    TabOrder = 1
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 833
    Height = 43
    Align = alTop
    AutoSize = True
    TabOrder = 2
    object ToolBar1: TToolBar
      Left = 11
      Top = 2
      Width = 326
      Height = 35
      AutoSize = True
      ButtonHeight = 35
      ButtonWidth = 33
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
        Action = ActSELALL
      end
      object ToolButton3: TToolButton
        Left = 33
        Top = 0
        Width = 8
        Caption = 'ToolButton3'
        ImageIndex = 9
        Style = tbsSeparator
      end
      object ToolButton1: TToolButton
        Left = 41
        Top = 0
        Action = CloseAction1
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 80
    Top = 96
  end
  object ADODataSet1: TADODataSet
    Parameters = <>
    Left = 48
    Top = 80
  end
  object ActionList1: TActionList
    Images = dmFrm.ImageList1
    Left = 136
    Top = 112
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
      ImageIndex = 8
      OnExecute = CloseAction1Execute
    end
    object ActSELALL: TAction
      Caption = #20840#36873
      ImageIndex = 10
    end
  end
end
