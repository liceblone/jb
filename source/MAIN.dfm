object mainFrm: TmainFrm
  Left = 347
  Top = 215
  Width = 700
  Height = 400
  Caption = #26700#38754
  Color = 16761220
  DefaultMonitor = dmMainForm
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIForm
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 185
    Top = 0
    Width = 10
    Height = 335
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 335
    Width = 692
    Height = 19
    Panels = <>
    ParentShowHint = False
    ShowHint = False
  end
  object gpTree: TGroupBox
    Left = 0
    Top = 0
    Width = 185
    Height = 335
    Align = alLeft
    Caption = #26641#29366#23548#33322
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Visible = False
    object TreeViewMenu: TTreeView
      Left = 2
      Top = 15
      Width = 181
      Height = 318
      Align = alClient
      Images = dmFrm.ImageList1
      Indent = 19
      ReadOnly = True
      TabOrder = 0
      OnDblClick = TreeViewMenuDblClick
    end
  end
  object MainMenu1: TMainMenu
    Images = dmFrm.ImageList1
    Left = 144
    Top = 64
    object WindowMenu: TMenuItem
      Caption = #31383#21475'(&W)'
      GroupIndex = 10
      OnClick = WindowMenuClick
      object MenuShowTree: TMenuItem
        Caption = #26641#29366#23548#33322
        OnClick = MenuShowTreeClick
      end
      object ExchangeBtn: TMenuItem
        Action = DesktopFrm.WindowSwitch1
      end
      object N1: TMenuItem
        Action = DesktopFrm.WindowClose1
      end
      object CloseAllBtn: TMenuItem
        Action = DesktopFrm.WindowCloseAll1
      end
      object N37: TMenuItem
        Caption = '-'
      end
      object N2: TMenuItem
        Action = DesktopFrm.WindowCascade1
      end
      object N4: TMenuItem
        Action = DesktopFrm.WindowTileHorizontal1
      end
      object N5: TMenuItem
        Action = DesktopFrm.WindowTileVertical1
      end
      object N6: TMenuItem
        Action = DesktopFrm.WindowMinimizeAll1
      end
      object MaxAllBtn: TMenuItem
        Action = DesktopFrm.WindowMaxmizeAll1
      end
    end
    object TlMenu: TMenuItem
      Caption = #20854#23427'(&O)'
      GroupIndex = 10
      object bgBtn: TMenuItem
        Caption = #26700#38754#22270#20687
        object DefbgBtn: TMenuItem
          Caption = #20351#29992#40664#35748#26700#38754
          RadioItem = True
          OnClick = DefbgBtnClick
        end
        object WinBgBtn: TMenuItem
          Caption = #20351#29992'Windows'#26700#38754
          RadioItem = True
          OnClick = WinBgBtnClick
        end
        object MybgBtn: TMenuItem
          Caption = #33258#23450#20041#26700#38754'...'
          RadioItem = True
          OnClick = MybgBtnClick
        end
        object N7: TMenuItem
          Caption = #19981#20351#29992#32972#26223#22270#29255
          RadioItem = True
          OnClick = N7Click
        end
      end
      object NReflashMainMenu: TMenuItem
        Caption = #21047#26032#33756#21333
        OnClick = NReflashMainMenuClick
      end
      object N8: TMenuItem
        Caption = #21551#21160#32769#31995#32479
        OnClick = N8Click
      end
    end
    object H1: TMenuItem
      Caption = #24110#21161'(&H)'
      GroupIndex = 10
      object N3: TMenuItem
        Caption = #20851#20110'...'
        OnClick = N3Click
      end
    end
  end
end
