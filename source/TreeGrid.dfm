object TreeGridFrm: TTreeGridFrm
  Left = 342
  Top = 289
  Width = 982
  Height = 377
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 180
    Top = 54
    Height = 296
  end
  object Panel1: TPanel
    Left = 183
    Top = 54
    Width = 791
    Height = 296
    Align = alClient
    Alignment = taLeftJustify
    BevelOuter = bvNone
    TabOrder = 0
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 791
      Height = 22
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = '\\'
      TabOrder = 0
      object statLabel1: TLabel
        Left = 705
        Top = 1
        Width = 85
        Height = 20
        Align = alRight
        Alignment = taCenter
        AutoSize = False
        Caption = '0/0'
        Transparent = True
      end
    end
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 974
    Height = 54
    Align = alTop
    AutoSize = True
    BevelInner = bvNone
    BevelKind = bkSoft
    TabOrder = 1
    OnDblClick = ControlBar1DblClick
    object myBar1: TToolBar
      Left = 271
      Top = 2
      Width = 699
      Height = 48
      Align = alClient
      AutoSize = True
      ButtonHeight = 36
      ButtonWidth = 33
      Caption = 'EditBar1'
      EdgeBorders = []
      Flat = True
      Images = dmFrm.ImageList1
      ShowCaptions = True
      TabOrder = 0
      OnDblClick = myBar1DblClick
    end
    object ToolBar2: TToolBar
      Left = 11
      Top = 2
      Width = 247
      Height = 36
      AutoSize = True
      ButtonHeight = 36
      ButtonWidth = 33
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Images = dmFrm.ImageList1
      ShowCaptions = True
      TabOrder = 1
      object setBtn: TToolButton
        Left = 0
        Top = 0
        Caption = #35774#32622
        ImageIndex = 14
      end
      object prtBtn: TToolButton
        Left = 33
        Top = 0
        AutoSize = True
        Caption = #25171#21360
        ImageIndex = 13
        OnClick = prtBtnClick
      end
      object TreeBtn: TToolButton
        Left = 70
        Top = 0
        Caption = #26641#25511
        Down = True
        ImageIndex = 6
        Style = tbsCheck
        OnClick = TreeBtnClick
      end
      object expbtn: TToolButton
        Left = 103
        Top = 0
        Caption = #25910#23637
        ImageIndex = 17
        OnClick = expbtnClick
      end
      object upBtn: TToolButton
        Left = 136
        Top = 0
        Caption = #21521#19978
        ImageIndex = 20
        OnClick = upBtnClick
      end
      object refreshBtn: TToolButton
        Left = 169
        Top = 0
        AutoSize = True
        Caption = #21047#26032
        ImageIndex = 16
        OnClick = refreshBtnClick
      end
      object ExtBtn: TToolButton
        Left = 206
        Top = 0
        Caption = #20851#38381
        ImageIndex = 8
        OnClick = ExtBtnClick
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 54
    Width = 180
    Height = 296
    Align = alLeft
    Caption = #26641
    TabOrder = 2
    object TreeView1: TTreeView
      Left = 2
      Top = 15
      Width = 176
      Height = 279
      Align = alClient
      BevelEdges = [beLeft, beTop]
      BevelInner = bvNone
      BevelKind = bkFlat
      BorderStyle = bsNone
      HideSelection = False
      Images = dmFrm.ImageList1
      Indent = 19
      ReadOnly = True
      ShowRoot = False
      TabOrder = 0
      OnChange = TreeView1Change
    end
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 304
    Top = 160
  end
  object ADODataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    AfterScroll = ADODataSet1AfterScroll
    Parameters = <>
    Left = 264
    Top = 160
  end
  object ActionList1: TActionList
    Images = dmFrm.ImageList1
    Left = 456
    Top = 168
    object WarePropAction1: TAction
      Caption = #23646#24615
      ImageIndex = 28
      OnExecute = WarePropAction1Execute
    end
    object EditorAction1: TAction
      Caption = #32534#36753
      ImageIndex = 21
      OnExecute = EditorAction1Execute
    end
    object DeleteAction1: TAction
      Caption = #21024#38500
      ImageIndex = 2
      OnExecute = DeleteAction1Execute
    end
    object fnCaAction1: TAction
      Caption = #23545#24080
      ImageIndex = 1
    end
    object fnCaDlAction1: TAction
      Caption = #26126#32454
      ImageIndex = 28
    end
    object SortAction1: TAction
      Caption = #25490#24207
      ImageIndex = 15
      OnExecute = SortAction1Execute
    end
    object ClientPropAction1: TAction
      Caption = #23646#24615
      ImageIndex = 28
      OnExecute = ClientPropAction1Execute
    end
    object ClientEmpAction1: TAction
      Caption = #25480#26435
      ImageIndex = 33
      OnExecute = ClientEmpAction1Execute
    end
    object LocateAction1: TAction
      Caption = #23450#20301
      ImageIndex = 12
      OnExecute = LocateAction1Execute
    end
    object fnOriginalAction1: TAction
      Caption = #26399#21021
      ImageIndex = 4
      OnExecute = fnOriginalAction1Execute
    end
    object FilterAction1: TAction
      Caption = #36807#28388
      ImageIndex = 19
      OnExecute = FilterAction1Execute
    end
    object ClntOwnerAction1: TAction
      Caption = #31649#29702
      ImageIndex = 27
      OnExecute = ClntOwnerAction1Execute
    end
    object ClntPubAction1: TAction
      Caption = #20849#20139
      ImageIndex = 28
      OnExecute = ClntPubAction1Execute
    end
    object actUpdateImage: TAction
      Caption = #26356#26032#22270#29255
      ImageIndex = 21
      OnExecute = actUpdateImageExecute
    end
    object ActMergeStock: TAction
      Caption = #24211#23384#21512#24182
      ImageIndex = 18
      OnExecute = ActMergeStockExecute
    end
    object ActBachUpdate: TAction
      Caption = #25209#25913
      ImageIndex = 26
      OnExecute = ActBachUpdateExecute
    end
    object ActUpLoad: TAction
      Caption = #26356#26032#32593#31449#36164#26009
      ImageIndex = 35
      OnExecute = ActUpLoadExecute
    end
    object ActUpdateStok: TAction
      Caption = #26356#26032#24211#23384
      ImageIndex = 33
      OnExecute = ActUpdateStokExecute
    end
    object ActClientRgt: TAction
      Caption = #23458#25143#25480#26435
      ImageIndex = 33
      OnExecute = ActClientRgtExecute
    end
  end
  object MainMenu1: TMainMenu
    Left = 295
    Top = 110
  end
end
