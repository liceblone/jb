object FrmActions: TFrmActions
  Left = 192
  Top = 133
  Width = 697
  Height = 556
  Caption = 'FrmActions'
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
  object btnCancel: TButton
    Left = 584
    Top = 468
    Width = 75
    Height = 25
    Caption = #21462#28040'(&C)'
    ModalResult = 2
    TabOrder = 0
  end
  object btnConfirm: TButton
    Left = 584
    Top = 408
    Width = 75
    Height = 25
    Caption = #30830#23450'(&Y)'
    ModalResult = 1
    TabOrder = 1
  end
  object F: TPageControl
    Left = 185
    Top = 0
    Width = 377
    Height = 529
    ActivePage = ts1
    Align = alLeft
    TabOrder = 2
    object ts1: TTabSheet
      Caption = 'Frm'
      object ActionGrid: TStringGrid
        Left = 0
        Top = 0
        Width = 369
        Height = 501
        Align = alClient
        DefaultColWidth = 90
        RowCount = 1
        FixedRows = 0
        TabOrder = 0
        OnClick = ActionGridClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'ImageList'
      ImageIndex = 1
      object TreeView1: TTreeView
        Left = 16
        Top = 24
        Width = 257
        Height = 441
        Images = dmFrm.ImageList1
        Indent = 19
        TabOrder = 0
      end
    end
  end
  object PnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 529
    Align = alLeft
    Caption = 'PnlLeft'
    TabOrder = 3
    object CombSelectMolde: TListBox
      Left = 1
      Top = 1
      Width = 183
      Height = 527
      Align = alClient
      ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
      ItemHeight = 13
      TabOrder = 0
      OnClick = CombSelectMoldeClick
    end
  end
end
