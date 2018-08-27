object DesktopFrm: TDesktopFrm
  Left = 295
  Top = 164
  Width = 787
  Height = 410
  AlphaBlend = True
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = #25105#30340#26700#38754
  Color = clBlack
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
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
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 779
    Height = 40
    AutoSize = True
    BandBorderStyle = bsNone
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 36
        Width = 775
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
      Width = 762
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
      OnDblClick = ToolBar1DblClick
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Caption = 'ToolButton1'
        ImageIndex = 0
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 40
    Width = 779
    Height = 343
    Align = alClient
    BevelOuter = bvNone
    Color = 15838317
    TabOrder = 1
    object Image1: TImage
      Left = 0
      Top = 0
      Width = 779
      Height = 343
      Align = alClient
      Stretch = True
    end
    object Label1: TLabel
      Left = 64
      Top = 56
      Width = 614
      Height = 35
      Caption = #24403#21069#31995#32479#20026#32769#31995#32479'   '#19981#33021#20877#20462#25913#25968#25454#65281
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -35
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
  end
  object MainMenu1: TMainMenu
    Left = 128
    Top = 168
  end
  object ActionList1: TActionList
    Left = 224
    Top = 168
    object OpenBill: TAction
      Category = 'Frm'
      Caption = 'OpenBill'
      OnExecute = OpenBillExecute
    end
    object OpenTreeEditor: TAction
      Category = 'Frm'
      Caption = 'OpenTreeEditor'
      OnExecute = OpenTreeEditorExecute
    end
    object OpenTreeGrid: TAction
      Category = 'Frm'
      Caption = 'OpenTreeGrid'
      OnExecute = OpenTreeGridExecute
    end
    object OpenTabEditor: TAction
      Category = 'Frm'
      Caption = 'OpenTabEditor'
      OnExecute = OpenTabEditorExecute
    end
    object OpenTreeMgr: TAction
      Category = 'Frm'
      Caption = 'OpenTreeMgr'
      OnExecute = OpenTreeMgrExecute
    end
    object OpenMore2More: TAction
      Caption = 'OpenMore2More'
      OnExecute = OpenMore2MoreExecute
    end
    object Navigate: TAction
      Caption = 'Navigate'
    end
    object OpenAnalyser: TAction
      Category = 'Frm'
      Caption = 'OpenAnalyser'
      OnExecute = OpenAnalyserExecute
    end
    object OpenEditor: TAction
      Category = 'Frm'
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
    object actOpenPickWindow: TAction
      Caption = 'actOpenPickWindow'
      OnExecute = actOpenPickWindowExecute
    end
    object actLockSys: TAction
      Caption = 'actLockSys'
      OnExecute = actLockSysExecute
    end
    object OpenCrmForm: TAction
      Category = 'Frm'
      Caption = 'OpenCrmForm'
      OnExecute = OpenCrmFormExecute
    end
    object RunExe: TAction
      Category = 'Frm'
      Caption = 'RunExe'
    end
    object ActDemo: TAction
      Caption = 'ActDemo'
    end
    object OpenMainMenu: TAction
      Category = 'Frm'
      Caption = 'OpenMainMenu'
      OnExecute = OpenMainMenuExecute
    end
    object OpenInvoice: TAction
      Category = 'Frm'
      Caption = 'OpenInvoice'
      OnExecute = OpenInvoiceExecute
    end
    object OpenAnalyserProcedure: TAction
      Category = 'Frm'
      Caption = 'OpenAnalyserProcedure'
    end
    object ActOpenWrTransformBill: TAction
      Category = 'Frm'
      Caption = 'OpenWrTransformBill'
      OnExecute = ActOpenWrTransformBillExecute
    end
    object ActWhOutEx: TAction
      Caption = 'ActWhOutEx'
      OnExecute = ActWhOutExExecute
    end
  end
  object NodeDataSet1: TADODataSet
    Parameters = <>
    Left = 96
    Top = 168
  end
  object TcpClient1: TTcpClient
    RemoteHost = 'wzjbserver'
    RemotePort = '820600'
    Left = 32
    Top = 168
  end
  object TcpServer1: TTcpServer
    OnAccept = TcpServer1Accept
    Left = 64
    Top = 168
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 160
    Top = 168
  end
  object tmrLockSys: TTimer
    OnTimer = tmrLockSysTimer
    Left = 192
    Top = 168
  end
  object tmr1: TTimer
    Interval = 18000
    OnTimer = tmr1Timer
    Left = 288
    Top = 168
  end
  object dsMainMenu: TADODataSet
    Parameters = <>
    Left = 328
    Top = 168
    object dsMainMenuDBName: TStringField
      FieldKind = fkLookup
      FieldName = 'DBName'
      LookupKeyFields = 'F02'
      LookupResultField = 'F01'
      KeyFields = 'F01'
      Size = 30
      Lookup = True
    end
  end
end
