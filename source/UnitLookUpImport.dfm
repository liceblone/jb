object FrmLoopUpImPortEx: TFrmLoopUpImPortEx
  Left = 424
  Top = 170
  Width = 836
  Height = 412
  Caption = 'FrmLoopUpImPortEx'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollTop: TScrollBox
    Left = 0
    Top = 0
    Width = 828
    Height = 24
    VertScrollBar.Visible = False
    Align = alTop
    BorderStyle = bsNone
    Color = clBtnHighlight
    ParentColor = False
    TabOrder = 0
    object Label3: TLabel
      Left = 0
      Top = 25
      Width = 828
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
    object CoolBar1: TCoolBar
      Left = 0
      Top = 0
      Width = 828
      Height = 25
      Bands = <
        item
          Control = ToolBar1
          ImageIndex = -1
          MinHeight = 20
          Width = 824
        end>
      Images = dmFrm.ImageList1
      object ToolBar1: TToolBar
        Left = 9
        Top = 0
        Width = 51
        Height = 20
        Align = alRight
        AutoSize = True
        ButtonWidth = 51
        Caption = 'ToolBar1'
        EdgeBorders = []
        Flat = True
        Images = dmFrm.ImageList1
        List = True
        ShowCaptions = True
        TabOrder = 0
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Caption = #23548#20837
          ImageIndex = 0
          Visible = False
        end
      end
    end
  end
  object TreeView1: TTreeView
    Left = 0
    Top = 56
    Width = 145
    Height = 329
    Align = alLeft
    BevelEdges = [beLeft, beTop]
    BevelInner = bvNone
    BevelKind = bkFlat
    BorderStyle = bsNone
    HideSelection = False
    Images = dmFrm.ImageList1
    Indent = 19
    ReadOnly = True
    ShowRoot = False
    TabOrder = 1
  end
  object pnlGd: TPanel
    Left = 465
    Top = 56
    Width = 363
    Height = 329
    Align = alClient
    Caption = 'pnlGd'
    TabOrder = 2
  end
  object GrpBarCode: TScrollBox
    Left = 145
    Top = 56
    Width = 320
    Height = 329
    Align = alLeft
    TabOrder = 3
    Visible = False
  end
  object ScrollBoxCtrlPanel: TScrollBox
    Left = 0
    Top = 24
    Width = 828
    Height = 32
    Align = alTop
    BorderStyle = bsNone
    TabOrder = 4
    OnDblClick = ScrollBoxCtrlPanelDblClick
    DesignSize = (
      828
      32)
    object OpnDlDsBtn1: TSpeedButton
      Left = 734
      Top = 8
      Width = 52
      Height = 19
      Anchors = [akRight]
      Flat = True
      Glyph.Data = {
        CA010000424DCA01000000000000760000002800000026000000110000000100
        040000000000540100000000000000000000100000001000000018BA5A0042AE
        390039C7730029962100FFFFFF0018BE6300FFFFFF0000000000000000000000
        0000000000000000000000000000000000000000000000000000666633333333
        3333333333333333333333666600663311111111111111111111111111111133
        6600632255000000000000000000000000000551360063255504444444444400
        0000004440055555360032555555555555555555445555555455555513003255
        5555544444445555454544445455555513003255555554555554555545554554
        5455555513003255555554444444555545554444545555551300325555544455
        5554545545554554545555551300325555555444444445544555455454555555
        1300325555555545455455555545444454555555130032555555555445455555
        5554555554555555130032555554444444444455545544444455555513006325
        5555555545555555455545555555555536006322555555555555555555555555
        5555555536006633222222222222222222222222222225336600666633333333
        3333333333333333333333666600}
      OnClick = OpnDlDsBtn1Click
    end
    object lblTitle: TLabel
      Left = 0
      Top = 0
      Width = 828
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = #20154
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #26999#20307'_GB2312'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object statLabel1: TLabel
      Left = 699
      Top = 0
      Width = 85
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = '0/0'
      Transparent = True
    end
  end
  object ActionList1: TActionList
    Images = dmFrm.ImageList1
    Left = 240
    Top = 120
    object ActClose: TAction
      Caption = 'ActClose'
      ImageIndex = 8
      OnExecute = ActCloseExecute
    end
    object ActFreeDeliveFee: TAction
      Caption = #20813#36153#36865#36135#27719#24635
    end
    object ActPick: TAction
      Caption = #23548#20837
      ImageIndex = 17
      OnExecute = ActPickExecute
    end
    object actPickALL: TAction
      Caption = #20840#36873
      ImageIndex = 28
      OnExecute = actPickALLExecute
    end
    object LocateAction: TAction
      Caption = #23450#20301
      ImageIndex = 3
    end
    object SortAction1: TAction
      Caption = 'SortAction1'
      ImageIndex = 15
      OnExecute = SortAction1Execute
    end
    object GetAction1: TAction
      Caption = 'GetAction1'
      ImageIndex = 12
    end
    object MoveAction1: TAction
      Caption = 'MoveAction1'
      ImageIndex = 21
      OnExecute = MoveAction1Execute
    end
    object YDWarePropAction1: TAction
      Caption = #24211#21442
      ImageIndex = 28
      OnExecute = YDWarePropAction1Execute
    end
    object GetActMultiSel: TAction
      Caption = 'GetActMultiSel'
      ImageIndex = 12
      OnExecute = GetActMultiSelExecute
    end
    object phQuoteAction1: TAction
      Caption = #20379#25253
      ImageIndex = 1
      OnExecute = phQuoteAction1Execute
    end
    object NewWareAction1: TAction
      Caption = #28155#21152
      ImageIndex = 7
      OnExecute = NewWareAction1Execute
    end
    object phOrderdlAction1: TAction
      Caption = #35746#21442
      ImageIndex = 14
      OnExecute = phOrderdlAction1Execute
    end
    object slPriceOutRfsAction1: TAction
      Caption = #21806#21442
      ImageIndex = 1
      OnExecute = slPriceOutRfsAction1Execute
    end
    object slPriceInRfsAction1: TAction
      Caption = #36827#21442
      ImageIndex = 1
      OnExecute = slPriceInRfsAction1Execute
    end
    object WarePropAction1: TAction
      Caption = #23646#24615
      ImageIndex = 28
      OnExecute = WarePropAction1Execute
    end
    object actPackPic: TAction
      Caption = #23553#35013
      ImageIndex = 7
      OnExecute = actPackPicExecute
    end
    object actBrandPic: TAction
      Caption = #21697#29260
      ImageIndex = 29
      OnExecute = actBrandPicExecute
    end
    object actShowPriceChange: TAction
      Caption = 'actShowPriceChange'
      ImageIndex = 18
      OnExecute = actShowPriceChangeExecute
    end
    object ActNewSaleRefs: TAction
      Caption = 'ActNewSaleRefs'
      ImageIndex = 1
      OnExecute = ActNewSaleRefsExecute
    end
    object ActNewInRefs: TAction
      Caption = 'ActNewInRefs'
      ImageIndex = 1
      OnExecute = ActNewInRefsExecute
    end
    object ActBarCodeSearch: TAction
      Tag = 21
      Caption = #26465#30721
      ImageIndex = 34
      OnExecute = ActBarCodeSearchExecute
    end
    object ActSaleQtyStatus: TAction
      Caption = #20986#24211#29366#20917#34920
      ImageIndex = 28
      OnExecute = ActSaleQtyStatusExecute
    end
  end
  object mtDataSource1: TDataSource
    DataSet = mtDataSet1
    Left = 72
    Top = 49
  end
  object mtDataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    LockType = ltBatchOptimistic
    CommandTimeout = 120
    Parameters = <>
    Left = 96
    Top = 48
  end
  object DlDataSource1: TDataSource
    DataSet = dlDataSet1
    Left = 288
    Top = 120
  end
  object dlDataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    LockType = ltBatchOptimistic
    AfterScroll = dlDataSet1AfterScroll
    CommandTimeout = 120
    Parameters = <>
    Left = 328
    Top = 120
  end
  object TreeDataSet: TADODataSet
    Parameters = <>
    Left = 40
    Top = 120
  end
  object tmrQry: TTimer
    Enabled = False
    Interval = 15
    OnTimer = tmrQryTimer
    Left = 209
    Top = 120
  end
end
