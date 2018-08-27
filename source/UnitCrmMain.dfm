object FrmCrm: TFrmCrm
  Left = 312
  Top = 215
  Width = 877
  Height = 480
  Caption = 'FrmCrm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object splTreeLeft: TSplitter
    Left = 193
    Top = 56
    Height = 397
  end
  object pgcTree: TPageControl
    Left = 0
    Top = 56
    Width = 193
    Height = 397
    Align = alLeft
    TabOrder = 0
    OnDragDrop = pgcTreeDragDrop
    OnDragOver = pgcTreeDragOver
  end
  object ctrlbr1: TControlBar
    Left = 0
    Top = 0
    Width = 869
    Height = 56
    Align = alTop
    AutoSize = True
    TabOrder = 1
    object tlb1: TToolBar
      Left = 11
      Top = 2
      Width = 262
      Height = 38
      AutoSize = True
      ButtonHeight = 36
      ButtonWidth = 43
      Caption = 'tlb1'
      Ctl3D = False
      Flat = True
      Images = dmFrm.ImageList1
      ShowCaptions = True
      TabOrder = 0
      object btnReflash: TToolButton
        Left = 0
        Top = 0
        Caption = #21047#26032
        ImageIndex = 16
      end
      object btnTreeVisiable: TToolButton
        Left = 43
        Top = 0
        Caption = #26641#25511
        Down = True
        ImageIndex = 6
        Style = tbsCheck
        OnClick = btnTreeVisiableClick
      end
      object btnQryScrollVisiable: TToolButton
        Left = 86
        Top = 0
        Caption = #26597#35810#26694
        Down = True
        ImageIndex = 17
        Style = tbsCheck
        OnClick = btnQryScrollVisiableClick
      end
      object btnSubVisiable: TToolButton
        Left = 129
        Top = 0
        Caption = #26126#32454
        Down = True
        ImageIndex = 4
        Style = tbsCheck
        OnClick = btnSubVisiableClick
      end
      object btnexit: TToolButton
        Left = 172
        Top = 0
        Caption = #36864#20986
        ImageIndex = 8
        OnClick = btnexitClick
      end
    end
    object tlbMain: TToolBar
      Left = 286
      Top = 2
      Width = 339
      Height = 48
      AutoSize = True
      ButtonHeight = 36
      ButtonWidth = 37
      Caption = 'tlbMain'
      Ctl3D = False
      Flat = True
      Images = dmFrm.ImageList1
      ShowCaptions = True
      TabOrder = 1
    end
  end
  object PnlRight: TPanel
    Left = 196
    Top = 56
    Width = 673
    Height = 397
    Align = alClient
    Caption = 'PnlRight'
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 1
      Top = 193
      Width = 671
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object MtPnl: TPanel
      Left = 1
      Top = 1
      Width = 671
      Height = 81
      Align = alTop
      AutoSize = True
      ParentColor = True
      TabOrder = 0
      object MtScrollBox: TScrollBox
        Left = 1
        Top = 1
        Width = 669
        Height = 79
        Align = alClient
        AutoSize = True
        Ctl3D = True
        ParentBackground = True
        ParentCtl3D = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        OnDblClick = MtScrollBoxDblClick
        object btnOpen: TSpeedButton
          Left = 555
          Top = 16
          Width = 59
          Height = 22
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
          OnClick = btnOpenClick
        end
        object Label1: TLabel
          Left = 488
          Top = 24
          Width = 3
          Height = 13
        end
      end
    end
    object pnlMainGrid: TPanel
      Left = 1
      Top = 82
      Width = 671
      Height = 111
      Align = alClient
      TabOrder = 1
      object ScrollBoxDbCtrl: TScrollBox
        Left = 1
        Top = 94
        Width = 669
        Height = 16
        Align = alBottom
        AutoSize = True
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
      end
      object pgcMainGrid: TPageControl
        Left = 1
        Top = 1
        Width = 669
        Height = 93
        Align = alClient
        TabOrder = 1
      end
    end
    object PnlItem: TPanel
      Left = 1
      Top = 196
      Width = 671
      Height = 200
      Align = alBottom
      Caption = 'PnlItem'
      TabOrder = 2
      object pgcSubInterface: TPageControl
        Left = 1
        Top = 1
        Width = 669
        Height = 198
        Align = alClient
        TabOrder = 0
        OnDragDrop = pgcSubInterfaceDragDrop
        OnDragOver = pgcSubInterfaceDragOver
      end
    end
  end
  object actlstCRM: TActionList
    Images = dmFrm.ImageList1
    Left = 456
    Top = 72
    object actEditMain: TAction
      Caption = #32534#36753
      ImageIndex = 21
      OnExecute = actEditMainExecute
    end
    object Filter: TAction
      Caption = #36807#28388
      ImageIndex = 19
      OnExecute = FilterExecute
    end
    object FavoriteM: TAction
      Caption = 'FavoriteM'
      ImageIndex = 23
      OnExecute = FavoriteMExecute
    end
    object FavoriteMgr: TAction
      Caption = 'FavoriteMgr'
      OnExecute = FavoriteMgrExecute
    end
    object FavoriteContentMgr: TAction
      Caption = #25972#25913#25910#34255#22841
      ImageIndex = 20
      OnExecute = FavoriteContentMgrExecute
    end
    object BatchUpdate: TAction
      Caption = #25209#37327#25913
      ImageIndex = 26
      OnExecute = BatchUpdateExecute
    end
    object Actsl_quote: TAction
      Caption = #25253#20215#21333
      ImageIndex = 28
      OnExecute = Actsl_quoteExecute
    end
    object ActFn_client_inout: TAction
      Caption = #24448#26469#26126#32454
      ImageIndex = 1
    end
  end
end
