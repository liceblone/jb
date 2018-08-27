object TreeEditorFrm: TTreeEditorFrm
  Left = 278
  Top = 217
  Width = 710
  Height = 399
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  WindowState = wsMaximized
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 300
    Top = 40
    Height = 138
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 178
    Width = 702
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    Visible = False
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 702
    Height = 40
    AutoSize = True
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 36
        Width = 698
      end>
    object ToolBar1: TToolBar
      Left = 9
      Top = 0
      Width = 685
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
      object SetBtn: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
        Caption = #35774#32622
        ImageIndex = 14
      end
      object PrtBtn: TToolButton
        Left = 37
        Top = 0
        Caption = #25171#21360
        ImageIndex = 13
        OnClick = PrtBtnClick
      end
      object PreBtn: TToolButton
        Left = 83
        Top = 0
        Caption = #34920#26684
        ImageIndex = 26
        Style = tbsCheck
        OnClick = PreBtnClick
      end
      object expBtn: TToolButton
        Left = 129
        Top = 0
        Caption = #20840#23637
        ImageIndex = 17
        OnClick = expBtnClick
      end
      object rfsBtn: TToolButton
        Left = 175
        Top = 0
        Caption = #21047#26032
        ImageIndex = 16
        OnClick = rfsBtnClick
      end
      object ToolButton5: TToolButton
        Left = 221
        Top = 0
        Width = 8
        Caption = 'ToolButton5'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object Addbtn: TToolButton
        Left = 229
        Top = 0
        Caption = #22686#21152
        ImageIndex = 7
        OnClick = AddbtnClick
      end
      object btnSubAdd: TToolButton
        Left = 275
        Top = 0
        Caption = #23376#32467#28857
        ImageIndex = 35
        OnClick = btnSubAddClick
      end
      object ChgBtn: TToolButton
        Left = 321
        Top = 0
        Caption = #20462#25913
        ImageIndex = 21
        OnClick = ChgBtnClick
      end
      object DelBtn: TToolButton
        Left = 367
        Top = 0
        Caption = #21024#38500
        ImageIndex = 2
        OnClick = DelBtnClick
      end
      object ToolButton9: TToolButton
        Left = 413
        Top = 0
        Width = 8
        Caption = 'ToolButton9'
        ImageIndex = 7
        Style = tbsSeparator
      end
      object CleBtn: TToolButton
        Left = 421
        Top = 0
        Caption = #25918#24323
        ImageIndex = 4
        OnClick = CleBtnClick
      end
      object SavBtn: TToolButton
        Left = 467
        Top = 0
        Caption = #20445#23384
        ImageIndex = 9
        OnClick = SavBtnClick
      end
      object ToolButton12: TToolButton
        Left = 513
        Top = 0
        Width = 8
        Caption = 'ToolButton12'
        ImageIndex = 9
        Style = tbsSeparator
      end
      object hlpBtn: TToolButton
        Left = 521
        Top = 0
        Caption = #24110#21161
        ImageIndex = 5
      end
      object ExtBtn: TToolButton
        Left = 567
        Top = 0
        Caption = #20851#38381
        ImageIndex = 8
        OnClick = ExtBtnClick
      end
    end
  end
  object TreeView1: TTreeView
    Left = 0
    Top = 40
    Width = 300
    Height = 138
    Align = alLeft
    HideSelection = False
    Images = dmFrm.ImageList1
    Indent = 19
    ReadOnly = True
    ShowRoot = False
    TabOrder = 1
    ToolTips = False
    OnChange = TreeView1Change
    OnChanging = TreeView1Changing
  end
  object ScrollBox1: TScrollBox
    Left = 303
    Top = 40
    Width = 399
    Height = 138
    Align = alClient
    Color = cl3DLight
    ParentColor = False
    TabOrder = 2
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 181
    Width = 702
    Height = 191
    Align = alBottom
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    PopupMenu = dmFrm.DbGridPopupMenu1
    TabOrder = 3
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    Visible = False
    OnCellClick = DBGrid1CellClick
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 260
    Top = 109
  end
  object ADODataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    LockType = ltBatchOptimistic
    Parameters = <>
    Left = 168
    Top = 112
  end
end
