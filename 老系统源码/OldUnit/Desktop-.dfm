object DesktopFrm: TDesktopFrm
  Left = 208
  Top = 27
  Width = 682
  Height = 357
  AlphaBlend = True
  Caption = #25105#30340#26700#38754
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 674
    Height = 40
    AutoSize = True
    BandBorderStyle = bsNone
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 36
        Width = 670
      end>
    Color = clGradientActiveCaption
    ParentColor = False
    Bitmap.Data = {
      C6050000424DC605000000000000360400002800000014000000140000000100
      0800000000009001000000000000000000000200000002000000F2F2F200FFFF
      FF00000000000000000000000000000000000000000001010101010101010100
      0101010101010101010001010101010101010100010101010101010101000101
      0101010101010100010101010101010101000101010101010101010001010101
      0101010101000101010101010101010001010101010101010100010101010101
      0101010001010101010101010100010101010101010101000101010101010101
      0100010101010101010101000101010101010101010001010101010101010100
      0101010101010101010000000000000000000000000000000000000000000101
      0101010101010100010101010101010101000101010101010101010001010101
      0101010101000101010101010101010001010101010101010100010101010101
      0101010001010101010101010100010101010101010101000101010101010101
      0100010101010101010101000101010101010101010001010101010101010100
      0101010101010101010001010101010101010100010101010101010101000101
      010101010101010001010101010101010100}
    object ToolBar1: TToolBar
      Left = 9
      Top = 0
      Width = 657
      Height = 36
      AutoSize = True
      ButtonHeight = 36
      ButtonWidth = 84
      Caption = 'ToolBar1'
      Color = clSkyBlue
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      Images = dmFrm.ImageList1
      ParentColor = False
      ShowCaptions = True
      TabOrder = 0
      Transparent = True
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        ImageIndex = 0
      end
      object ToolButton2: TToolButton
        Left = 84
        Top = 0
        Caption = 'ToolButton2'
        ImageIndex = 1
      end
      object ToolButton3: TToolButton
        Left = 168
        Top = 0
        Caption = 'ToolButton3'
        ImageIndex = 2
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 40
    Width = 674
    Height = 290
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 1
    object Image1: TImage
      Left = 1
      Top = 1
      Width = 672
      Height = 288
      Align = alClient
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 40
    Width = 674
    Height = 290
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel2'
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 161
      Top = 0
      Width = 1
      Height = 290
      Color = clNavy
      ParentColor = False
    end
    object TreeView1: TTreeView
      Left = 0
      Top = 0
      Width = 161
      Height = 290
      Align = alLeft
      BorderStyle = bsNone
      Color = clCream
      Ctl3D = False
      HideSelection = False
      HotTrack = True
      Images = dmFrm.ImageList1
      Indent = 19
      ParentCtl3D = False
      ReadOnly = True
      ShowRoot = False
      TabOrder = 0
      OnChange = TreeView1Change
    end
    object Panel3: TPanel
      Left = 162
      Top = 0
      Width = 512
      Height = 290
      Align = alClient
      Caption = 'Panel3'
      TabOrder = 1
      object WebBrowser1: TWebBrowser
        Left = 1
        Top = 39
        Width = 510
        Height = 250
        Align = alClient
        TabOrder = 0
        OnBeforeNavigate2 = WebBrowser1BeforeNavigate2
        ControlData = {
          4C000000B6340000D71900000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
      object Panel4: TPanel
        Left = 1
        Top = 1
        Width = 510
        Height = 38
        Align = alTop
        BevelOuter = bvNone
        Color = clYellow
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 1
        DesignSize = (
          510
          38)
        object Label1: TLabel
          Left = 258
          Top = 14
          Width = 78
          Height = 13
          Anchors = [akRight, akBottom]
          Caption = #36755#20837#21151#33021#20195#30721
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -13
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object SpeedButton1: TSpeedButton
          Left = 468
          Top = 8
          Width = 23
          Height = 22
          Anchors = [akRight, akBottom]
          Flat = True
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000010000000FFFFFF00CCCC
            CC0099FF990099CC9900CC66990066CC66006699660099336600669933003366
            3300663333000033000000000000EEEEEE000000000000000000DDDDDDDDDDDD
            DDDDDDDD1DDDDDDDDDDDDD31DDDD1DDDDDDDDD61DDDD11DDDDDDD1611DDD911D
            DDDDD65611117B11DDDDD656911178B11DDDD6555977A58B11DDD62255555558
            911DD1622255555524DDDD16222225524DDDDDDD6977A524DDDDDDDDDDDD724D
            DDDDDDDDDDDD94DDDDDDDDDDDDDD4DDDDDDDDDDDDDDDDDDDDDDD}
          OnClick = SpeedButton1Click
        end
        object KeyEdit1: TEdit
          Left = 345
          Top = 10
          Width = 121
          Height = 19
          Anchors = [akRight, akBottom]
          TabOrder = 0
          OnKeyDown = KeyEdit1KeyDown
        end
      end
      object Button1: TButton
        Left = 144
        Top = 176
        Width = 75
        Height = 25
        Caption = 'Button1'
        TabOrder = 2
        OnClick = Button1Click
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 216
    Top = 80
  end
  object ActionList1: TActionList
    Left = 400
    Top = 136
    object OpenBill: TAction
      Caption = 'OpenBill'
      OnExecute = OpenBillExecute
    end
    object OpenTreeEditor: TAction
      Caption = 'OpenTreeEditor'
      OnExecute = OpenTreeEditorExecute
    end
    object OpenTreeGrid: TAction
      Caption = 'OpenTreeGrid'
      OnExecute = OpenTreeGridExecute
    end
    object OpenTabEditor: TAction
      Caption = 'OpenTabEditor'
      OnExecute = OpenTabEditorExecute
    end
    object OpenTreeMgr: TAction
      Caption = 'OpenTreeMgr'
      OnExecute = OpenTreeMgrExecute
    end
    object OpenMore2More: TAction
      Caption = 'OpenMore2More'
      OnExecute = OpenMore2MoreExecute
    end
    object Navigate: TAction
      Caption = 'Navigate'
      OnExecute = NavigateExecute
    end
    object OpenAnalyser: TAction
      Caption = 'OpenAnalyser'
      OnExecute = OpenAnalyserExecute
    end
    object OpenEditor: TAction
      Caption = 'OpenEditor'
      OnExecute = OpenEditorExecute
    end
    object LoginSystem: TAction
      Caption = 'LoginSystem'
      OnExecute = LoginSystemExecute
    end
    object CloseMainFrm: TAction
      Caption = 'CloseMainFrm'
      OnExecute = CloseMainFrmExecute
    end
    object ExecSql2: TAction
      Caption = 'ExecSql2'
      OnExecute = ExecSql2Execute
    end
    object WindowCloseAll1: TAction
      Category = 'Window'
      Caption = #20840#37096#20851#38381
      OnExecute = WindowCloseAll1Execute
    end
    object WindowClose1: TWindowClose
      Category = 'Window'
      Caption = #20851#38381
      Hint = 'Close'
      ShortCut = 115
    end
    object WindowCascade1: TWindowCascade
      Category = 'Window'
      Caption = #37325#21472
      Hint = 'Cascade'
    end
    object WindowTileHorizontal1: TWindowTileHorizontal
      Category = 'Window'
      Caption = #27178#34892#37325#25490
      Hint = 'Tile Horizontal'
    end
    object WindowTileVertical1: TWindowTileVertical
      Category = 'Window'
      Caption = #31446#21521#37325#25490
      Hint = 'Tile Vertical'
    end
    object WindowMinimizeAll1: TWindowMinimizeAll
      Category = 'Window'
      Caption = #20840#37096#26368#23567#21270
      Hint = 'Minimize All'
    end
    object WindowMaxmizeAll1: TAction
      Category = 'Window'
      Caption = #20840#37096#26368#22823#21270
      OnExecute = WindowMaxmizeAll1Execute
    end
    object WindowSwitch1: TAction
      Category = 'Window'
      Caption = #20999#25442
      ShortCut = 113
      OnExecute = WindowSwitch1Execute
    end
    object Action1: TAction
      Caption = 'Action1'
      OnExecute = Action1Execute
    end
  end
  object NodeDataSet1: TADODataSet
    Parameters = <>
    Left = 120
    Top = 152
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 282
    Top = 128
  end
  object TcpClient1: TTcpClient
    RemoteHost = 'fhl'
    RemotePort = '820600'
    Left = 40
    Top = 168
  end
  object TcpServer1: TTcpServer
    Active = True
    LocalPort = '820605'
    OnAccept = TcpServer1Accept
    Left = 96
    Top = 232
  end
end
