object PickFrm: TPickFrm
  Left = 432
  Top = 386
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderStyle = bsToolWindow
  ClientHeight = 221
  ClientWidth = 1100
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SplitterRight: TSplitter
    Left = 246
    Top = 0
    Width = 4
    Height = 221
  end
  object PnlRight: TPanel
    Left = 250
    Top = 0
    Width = 850
    Height = 221
    Align = alClient
    Caption = 'PnlRight'
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 1
      Top = 30
      Width = 848
      Height = 190
      Align = alClient
      Ctl3D = False
      DataSource = DataSource1
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      ParentCtl3D = False
      PopupMenu = dmFrm.DbGridPopupMenu1
      TabOrder = 0
      TitleFont.Charset = GB2312_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
      OnDrawColumnCell = DBGrid1DrawColumnCell
    end
    object CoolBar1: TCoolBar
      Left = 1
      Top = 1
      Width = 848
      Height = 29
      AutoSize = True
      Bands = <
        item
          Break = False
          Control = ToolBar3
          ImageIndex = -1
          Width = 329
        end
        item
          Break = False
          Control = ToolBar2
          ImageIndex = -1
          Width = 66
        end
        item
          Break = False
          Control = ToolBar1
          ImageIndex = -1
          MinHeight = 22
          Width = 445
        end>
      Images = dmFrm.ImageList1
      object ToolBar2: TToolBar
        Left = 340
        Top = 0
        Width = 53
        Height = 25
        Align = alLeft
        AutoSize = True
        ButtonWidth = 53
        Caption = 'ToolBar2'
        EdgeBorders = []
        Flat = True
        Images = dmFrm.ImageList1
        List = True
        ShowCaptions = True
        TabOrder = 0
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Action = WarePropAction1
        end
      end
      object ToolBar3: TToolBar
        Left = 9
        Top = 0
        Width = 316
        Height = 25
        Align = alClient
        AutoSize = True
        ButtonHeight = 13
        Caption = 'ToolBar3'
        TabOrder = 1
        object Label1: TLabel
          Left = 0
          Top = 2
          Width = 73
          Height = 13
          Caption = ' '#25628#32034#22411#21495': '
        end
        object ComboBox1: TComboBox
          Left = 73
          Top = 2
          Width = 96
          Height = 21
          Hint = #25353#22411#21495#25628#32034','#36755#20837#22411#21495#25970#22238#36710
          ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
          ItemHeight = 13
          TabOrder = 0
          OnEnter = ComboBox1Enter
        end
        object lbl1: TLabel
          Left = 169
          Top = 2
          Width = 46
          Height = 13
          Caption = ' '#35268#26684#65306
        end
        object cbbPartNo: TComboBox
          Left = 215
          Top = 2
          Width = 90
          Height = 21
          ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
          ItemHeight = 13
          TabOrder = 1
          OnEnter = cbbPartNoEnter
        end
      end
      object ToolBar1: TToolBar
        Left = 408
        Top = 1
        Width = 432
        Height = 22
        Align = alClient
        AutoSize = True
        ButtonWidth = 55
        Caption = 'ToolBar1'
        EdgeBorders = []
        Flat = True
        Images = dmFrm.ImageList1
        List = True
        ShowCaptions = True
        TabOrder = 2
        OnDblClick = ToolBar1DblClick
      end
    end
  end
  object GrpBarCode: TScrollBox
    Left = 0
    Top = 0
    Width = 246
    Height = 221
    Align = alLeft
    TabOrder = 1
    Visible = False
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 376
    Top = 104
  end
  object ADODataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    CommandTimeout = 300
    Parameters = <>
    Left = 264
    Top = 104
  end
  object ActionList1: TActionList
    Images = dmFrm.ImageList1
    Left = 344
    Top = 104
    object GetAction1: TAction
      Caption = #24341#20837
      ImageIndex = 12
      OnExecute = GetAction1Execute
    end
    object SelectAction1: TAction
      Caption = #21453#36873
      ImageIndex = 26
      OnExecute = SelectAction1Execute
    end
    object CloseAction1: TAction
      Caption = #20851#38381
      ImageIndex = 8
      OnExecute = CloseAction1Execute
    end
    object FilterAction1: TAction
      Caption = #36807#28388
      ImageIndex = 19
    end
    object LocateAction1: TAction
      Caption = #23450#20301
      ImageIndex = 3
    end
    object SortAction1: TAction
      Caption = #25490#24207
      ImageIndex = 15
      OnExecute = SortAction1Execute
    end
    object GetAction2: TAction
      Caption = #24341#20837
      ImageIndex = 12
      OnExecute = GetAction2Execute
    end
    object MoveAction1: TAction
      Caption = #35843#35814
      ImageIndex = 21
      OnExecute = MoveAction1Execute
    end
    object YdWarePropAction1: TAction
      Caption = #24211#21442
      ImageIndex = 28
      OnExecute = YdWarePropAction1Execute
    end
    object GetAction3: TAction
      Caption = #36873#20837
      ImageIndex = 12
      OnExecute = GetAction3Execute
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
      Caption = #20215#26684#21464#21270
      ImageIndex = 18
      OnExecute = actShowPriceChangeExecute
    end
    object ActNewSaleRefs: TAction
      Caption = #21806#21442
      ImageIndex = 1
      OnExecute = ActNewSaleRefsExecute
    end
    object ActNewInRefs: TAction
      Caption = #36827#21442
      ImageIndex = 1
      OnExecute = ActNewInRefsExecute
    end
    object ActUseBarCode: TAction
      Caption = #26465#30721
      ImageIndex = 34
      OnExecute = ActUseBarCodeExecute
    end
    object ActImportAll: TAction
      Caption = #20840#36873
      ImageIndex = 12
      OnExecute = ActImportAllExecute
    end
  end
  object AdoDataSet2: TADODataSet
    Parameters = <>
    Left = 304
    Top = 104
  end
end
