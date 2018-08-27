object WrTransformBillFrm: TWrTransformBillFrm
  Left = 346
  Top = 327
  Width = 840
  Height = 517
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefaultPosOnly
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 39
    Width = 832
    Height = 451
    Align = alClient
    BevelOuter = bvLowered
    Caption = 'Panel1'
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 1
      Top = 357
      Width = 830
      Height = 2
      Cursor = crVSplit
      Align = alBottom
    end
    object Splitter2: TSplitter
      Left = 1
      Top = 121
      Width = 830
      Height = 2
      Cursor = crVSplit
      Align = alTop
    end
    object ScrollBox1: TScrollBox
      Left = 1
      Top = 1
      Width = 830
      Height = 120
      Align = alTop
      BorderStyle = bsNone
      TabOrder = 0
      OnCanResize = ScrollBox1CanResize
      OnDblClick = ScrollBox1DblClick
      DesignSize = (
        830
        120)
      object Label2: TLabel
        Left = 0
        Top = 24
        Width = 830
        Height = 7
        Align = alTop
        Caption = 
          '................................................................' +
          '................................................................' +
          '................................................................' +
          '.......'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -7
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 0
        Top = 20
        Width = 830
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
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 830
        Height = 20
        Align = alTop
        Alignment = taCenter
        Caption = '          '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -20
        Font.Name = #23435#20307
        Font.Style = [fsBold, fsUnderline]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Image1: TImage
        Left = 708
        Top = 8
        Width = 33
        Height = 17
        Anchors = [akTop, akRight]
        AutoSize = True
        Picture.Data = {
          07544269746D61709A060000424D9A0600000000000036040000280000002100
          0000110000000100080000000000640200000000000000000000000100000000
          0000000000004000000080000000FF000000002000004020000080200000FF20
          0000004000004040000080400000FF400000006000004060000080600000FF60
          0000008000004080000080800000FF80000000A0000040A0000080A00000FFA0
          000000C0000040C0000080C00000FFC0000000FF000040FF000080FF0000FFFF
          0000000020004000200080002000FF002000002020004020200080202000FF20
          2000004020004040200080402000FF402000006020004060200080602000FF60
          2000008020004080200080802000FF80200000A0200040A0200080A02000FFA0
          200000C0200040C0200080C02000FFC0200000FF200040FF200080FF2000FFFF
          2000000040004000400080004000FF004000002040004020400080204000FF20
          4000004040004040400080404000FF404000006040004060400080604000FF60
          4000008040004080400080804000FF80400000A0400040A0400080A04000FFA0
          400000C0400040C0400080C04000FFC0400000FF400040FF400080FF4000FFFF
          4000000060004000600080006000FF006000002060004020600080206000FF20
          6000004060004040600080406000FF406000006060004060600080606000FF60
          6000008060004080600080806000FF80600000A0600040A0600080A06000FFA0
          600000C0600040C0600080C06000FFC0600000FF600040FF600080FF6000FFFF
          6000000080004000800080008000FF008000002080004020800080208000FF20
          8000004080004040800080408000FF408000006080004060800080608000FF60
          8000008080004080800080808000FF80800000A0800040A0800080A08000FFA0
          800000C0800040C0800080C08000FFC0800000FF800040FF800080FF8000FFFF
          80000000A0004000A0008000A000FF00A0000020A0004020A0008020A000FF20
          A0000040A0004040A0008040A000FF40A0000060A0004060A0008060A000FF60
          A0000080A0004080A0008080A000FF80A00000A0A00040A0A00080A0A000FFA0
          A00000C0A00040C0A00080C0A000FFC0A00000FFA00040FFA00080FFA000FFFF
          A0000000C0004000C0008000C000FF00C0000020C0004020C0008020C000FF20
          C0000040C0004040C0008040C000FF40C0000060C0004060C0008060C000FF60
          C0000080C0004080C0008080C000FF80C00000A0C00040A0C00080A0C000FFA0
          C00000C0C00040C0C00080C0C000FFC0C00000FFC00040FFC00080FFC000FFFF
          C0000000FF004000FF008000FF00FF00FF000020FF004020FF008020FF00FF20
          FF000040FF004040FF008040FF00FF40FF000060FF004060FF008060FF00FF60
          FF000080FF004080FF008080FF00FF80FF0000A0FF0040A0FF0080A0FF00FFA0
          FF0000C0FF0040C0FF0080C0FF00FFC0FF0000FFFF0040FFFF0080FFFF00FFFF
          FF00E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
          E0E0E0000000E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFE0000000E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFE0000000E0FFFFFFE0E0E0E0E0E0E0E0E0E0FFFFFFFF
          FFFFFFFFFFE0FFFFFFFFFFFFFFFFE0000000E0FFFFFFE0FFFFFFFFFFFFFFFFE0
          FFFFFFFFFFFFFFFFFFE0FFFFFFFFFFFFFFFFE0000000E0FFFFFFE0FFFFFFFFFF
          FFFFFFE0FFFFFFFFFFE0E0E0E0E0E0E0E0E0FFFFFFFFE0000000E0FFFFFFE0FF
          FFFFFFFFFFFFFFE0FFFFFFFFFFE0FFFFFFE0FFFFFFE0FFFFFFFFE0000000E0FF
          FFFFE0FFFFFFFFFFFFFFFFFFFFFFFFFFFFE0E0E0E0E0E0E0E0E0FFFFFFFFE000
          0000E0FFFFFFE0FFFFFFFFFFFFFFFFFFFFFFFFFFFFE0FFFFFFE0FFFFFFE0FFFF
          FFFFE0000000E0FFFFFFE0E0E0E0E0E0E0E0FFFFFFFFFFFFFFE0E0E0E0E0E0E0
          E0E0FFFFFFFFE0000000E0FFFFFFE0FFFFFFFFFFFFE0FFFFFFFFFFFFFFFFFFFF
          FFE0FFFFFFFFFFFFFFFFE0000000E0FFFFFFFFFFFFFFFFFFFFE0FFFFFFFFFFFF
          E0FFFFFFFFFFFFFFFFFFE0FFFFFFE0000000E0FFFFFFE0E0E0E0E0E0E0E0E0FF
          FFFFFFFFE0E0E0E0E0E0E0E0E0E0E0FFFFFFE0000000E0FFFFFFFFFFFFFFFFFF
          FFE0FFFFFFFFFFFFFFFFFFFFFFE0FFFFFFFFFFFFFFFFE0000000E0FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0000000E0FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE000
          0000E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
          E0E0E0000000}
        Visible = False
      end
      object Image2: TImage
        Left = 708
        Top = 8
        Width = 33
        Height = 17
        Anchors = [akTop, akRight]
        AutoSize = True
        Picture.Data = {
          07544269746D61709A060000424D9A0600000000000036040000280000002100
          0000110000000100080000000000640200000000000000000000000100000000
          0000000000004000000080000000FF000000002000004020000080200000FF20
          0000004000004040000080400000FF400000006000004060000080600000FF60
          0000008000004080000080800000FF80000000A0000040A0000080A00000FFA0
          000000C0000040C0000080C00000FFC0000000FF000040FF000080FF0000FFFF
          0000000020004000200080002000FF002000002020004020200080202000FF20
          2000004020004040200080402000FF402000006020004060200080602000FF60
          2000008020004080200080802000FF80200000A0200040A0200080A02000FFA0
          200000C0200040C0200080C02000FFC0200000FF200040FF200080FF2000FFFF
          2000000040004000400080004000FF004000002040004020400080204000FF20
          4000004040004040400080404000FF404000006040004060400080604000FF60
          4000008040004080400080804000FF80400000A0400040A0400080A04000FFA0
          400000C0400040C0400080C04000FFC0400000FF400040FF400080FF4000FFFF
          4000000060004000600080006000FF006000002060004020600080206000FF20
          6000004060004040600080406000FF406000006060004060600080606000FF60
          6000008060004080600080806000FF80600000A0600040A0600080A06000FFA0
          600000C0600040C0600080C06000FFC0600000FF600040FF600080FF6000FFFF
          6000000080004000800080008000FF008000002080004020800080208000FF20
          8000004080004040800080408000FF408000006080004060800080608000FF60
          8000008080004080800080808000FF80800000A0800040A0800080A08000FFA0
          800000C0800040C0800080C08000FFC0800000FF800040FF800080FF8000FFFF
          80000000A0004000A0008000A000FF00A0000020A0004020A0008020A000FF20
          A0000040A0004040A0008040A000FF40A0000060A0004060A0008060A000FF60
          A0000080A0004080A0008080A000FF80A00000A0A00040A0A00080A0A000FFA0
          A00000C0A00040C0A00080C0A000FFC0A00000FFA00040FFA00080FFA000FFFF
          A0000000C0004000C0008000C000FF00C0000020C0004020C0008020C000FF20
          C0000040C0004040C0008040C000FF40C0000060C0004060C0008060C000FF60
          C0000080C0004080C0008080C000FF80C00000A0C00040A0C00080A0C000FFA0
          C00000C0C00040C0C00080C0C000FFC0C00000FFC00040FFC00080FFC000FFFF
          C0000000FF004000FF008000FF00FF00FF000020FF004020FF008020FF00FF20
          FF000040FF004040FF008040FF00FF40FF000060FF004060FF008060FF00FF60
          FF000080FF004080FF008080FF00FF80FF0000A0FF0040A0FF0080A0FF00FFA0
          FF0000C0FF0040C0FF0080C0FF00FFC0FF0000FFFF0040FFFF0080FFFF00FFFF
          FF00E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
          E0E0E0000000E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFE0000000E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFE0000000E0FFFFFFFFFFFFFFFFE0FFFFFFFFFFFFFFFF
          FFFFFFFFFFE0FFFFFFFFFFFFFFFFE0000000E0FFFFFFE0E0FFFFFFE0FFFFFFE0
          E0FFFFFFFFFFFFFFFFE0FFFFFFFFFFFFFFFFE0000000E0FFFFFFFFFFE0FFFFE0
          FFFFE0FFFFFFFFFFFFE0E0E0E0E0E0E0E0E0FFFFFFFFE0000000E0FFFFFFFFFF
          FFE0FFE0FFE0FFFFFFFFFFFFFFE0FFFFFFE0FFFFFFE0FFFFFFFFE0000000E0FF
          FFFFFFFFFFFFE0E0E0FFFFFFFFFFFFFFFFE0E0E0E0E0E0E0E0E0FFFFFFFFE000
          0000E0FFFFFFE0E0E0E0E0E0E0E0E0E0E0FFFFFFFFE0FFFFFFE0FFFFFFE0FFFF
          FFFFE0000000E0FFFFFFFFFFFFFFFFE0FFFFFFFFFFFFFFFFFFE0E0E0E0E0E0E0
          E0E0FFFFFFFFE0000000E0FFFFFFFFFFFFFFFFE0FFFFFFFFFFFFFFFFFFFFFFFF
          FFE0FFFFFFFFFFFFFFFFE0000000E0FFFFFFFFE0E0E0E0E0E0E0E0E0FFFFFFFF
          E0FFFFFFFFFFFFFFFFFFE0FFFFFFE0000000E0FFFFFFFFFFFFFFFFE0FFFFE0FF
          FFFFFFFFE0E0E0E0E0E0E0E0E0E0E0FFFFFFE0000000E0FFFFFFFFFFFFFFFFE0
          FFFFFFFFFFFFFFFFFFFFFFFFFFE0FFFFFFFFFFFFFFFFE0000000E0FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0000000E0FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE000
          0000E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
          E0E0E0000000}
      end
    end
    object ScrollBox2: TScrollBox
      Left = 1
      Top = 359
      Width = 830
      Height = 91
      Align = alBottom
      BorderStyle = bsNone
      TabOrder = 1
      OnDblClick = ScrollBox2DblClick
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 123
      Width = 830
      Height = 234
      TabStop = False
      Align = alClient
      Color = clWhite
      Ctl3D = False
      DataSource = DlDataSource1
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
      ParentCtl3D = False
      ParentFont = False
      PopupMenu = dmFrm.DbGridPopupMenu1
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      Columns = <
        item
          Expanded = False
          Visible = True
        end>
    end
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 832
    Height = 39
    AutoSize = True
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 35
        Width = 828
      end>
    object ToolBar1: TToolBar
      Left = 9
      Top = 0
      Width = 815
      Height = 35
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
      Indent = 3
      ParentFont = False
      ShowCaptions = True
      TabOrder = 0
      object DownBtn: TToolButton
        Left = 3
        Top = 0
        Action = DownAction1
      end
      object MailBtn: TToolButton
        Left = 36
        Top = 0
        Action = MailAction1
        Caption = #37038#20214
      end
      object FaxBtn: TToolButton
        Left = 69
        Top = 0
        Action = FaxAction1
      end
      object PrintBtn: TToolButton
        Left = 102
        Top = 0
        Action = PrintAction1
      end
      object ToolButton3: TToolButton
        Left = 135
        Top = 0
        Width = 8
        Caption = 'ToolButton3'
        Enabled = False
        ImageIndex = 6
        Style = tbsSeparator
      end
      object OpenBtn: TToolButton
        Left = 143
        Top = 0
        Action = OpenAction1
        Style = tbsDropDown
      end
      object NewBtn: TToolButton
        Left = 189
        Top = 0
        Action = NewAction1
        AutoSize = True
      end
      object RemoveBtn: TToolButton
        Left = 226
        Top = 0
        Action = RemoveAction1
      end
      object ToolButton4: TToolButton
        Left = 259
        Top = 0
        Width = 8
        Caption = 'ToolButton4'
        Enabled = False
        ImageIndex = 14
        Style = tbsSeparator
      end
      object CelBtn: TToolButton
        Left = 267
        Top = 0
        Action = CancelAction1
      end
      object ToolButton2: TToolButton
        Left = 300
        Top = 0
        Width = 9
        Caption = 'ToolButton2'
        ImageIndex = 6
        Style = tbsSeparator
      end
      object SavBtn: TToolButton
        Left = 309
        Top = 0
        Action = SaveAction1
      end
      object BtnLock: TToolButton
        Left = 342
        Top = 0
        Action = ActIsLock
      end
      object chkBtn: TToolButton
        Left = 375
        Top = 0
        Action = CheckAction1
      end
      object Refreshbtn: TToolButton
        Left = 408
        Top = 0
        Action = RefreshAction1
      end
      object ToolButton1: TToolButton
        Left = 441
        Top = 0
        Width = 8
        Caption = 'ToolButton1'
        Enabled = False
        ImageIndex = 7
        Style = tbsSeparator
      end
      object linkBtn: TToolButton
        Left = 449
        Top = 0
        Action = LinkAction1
      end
      object importBtn: TToolButton
        Left = 482
        Top = 0
        Action = ImportAction1
      end
      object AddBtn: TToolButton
        Left = 515
        Top = 0
        Action = AppendAction1
      end
      object DelBtn: TToolButton
        Left = 548
        Top = 0
        Action = DeleteAction1
      end
      object ToolButton5: TToolButton
        Left = 581
        Top = 0
        Width = 8
        Caption = 'ToolButton5'
        Enabled = False
        ImageIndex = 15
        Style = tbsSeparator
      end
      object ExtBtn: TToolButton
        Left = 589
        Top = 0
        Action = CloseAction1
      end
      object btn2: TToolButton
        Left = 622
        Top = 0
        Width = 8
        Caption = 'btn2'
        Enabled = False
        ImageIndex = 6
        Style = tbsSeparator
      end
      object HelpBtn: TToolButton
        Left = 630
        Top = 0
        Action = HelpAction1
      end
    end
  end
  object mtDataSource1: TDataSource
    DataSet = mtDataSet1
    OnStateChange = mtDataSource1StateChange
    Left = 264
    Top = 73
  end
  object DlDataSource1: TDataSource
    DataSet = dlDataSet1
    OnStateChange = DlDataSource1StateChange
    Left = 456
    Top = 200
  end
  object dlDataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    LockType = ltBatchOptimistic
    AfterPost = dlDataSet1AfterPost
    OnCalcFields = dlDataSet1CalcFields
    CommandTimeout = 120
    Parameters = <>
    Left = 504
    Top = 200
  end
  object mtDataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    LockType = ltBatchOptimistic
    CommandTimeout = 120
    Parameters = <>
    Left = 312
    Top = 72
  end
  object ActionList1: TActionList
    Images = dmFrm.ImageList1
    Left = 240
    Top = 208
    object MailAction1: TAction
      Caption = #35774#32622
      Enabled = False
      ImageIndex = 36
      OnExecute = MailAction1Execute
    end
    object PrintAction1: TAction
      Caption = #25171#21360
      Enabled = False
      ImageIndex = 13
      OnExecute = PrintAction1Execute
    end
    object OpenAction1: TAction
      Caption = #25171#24320
      ImageIndex = 0
      OnExecute = OpenAction1Execute
    end
    object NewAction1: TAction
      Caption = #26032#24314
      ImageIndex = 7
      OnExecute = NewAction1Execute
    end
    object CopyAction1: TAction
      Caption = #22797#21046
      Enabled = False
      ImageIndex = 1
    end
    object RemoveAction1: TAction
      Caption = #24323#21333
      Enabled = False
      ImageIndex = 2
      OnExecute = RemoveAction1Execute
    end
    object CancelAction1: TAction
      Caption = #25918#24323
      Enabled = False
      ImageIndex = 4
      OnExecute = CancelAction1Execute
    end
    object SaveAction1: TAction
      Caption = #20445#23384
      Enabled = False
      ImageIndex = 9
      OnExecute = SaveAction1Execute
    end
    object CheckAction1: TAction
      Caption = #23457#26680
      Enabled = False
      ImageIndex = 10
      OnExecute = CheckAction1Execute
    end
    object LinkAction1: TAction
      Caption = #24341#29992
      Enabled = False
      ImageIndex = 17
      OnExecute = LinkAction1Execute
    end
    object ImportAction1: TAction
      Caption = #23548#20837
      Enabled = False
      ImageIndex = 32
      OnExecute = ImportAction1Execute
    end
    object AppendAction1: TAction
      Caption = #22686#34892
      Enabled = False
      ImageIndex = 12
      OnExecute = AppendAction1Execute
    end
    object DeleteAction1: TAction
      Caption = #21024#34892
      Enabled = False
      ImageIndex = 11
      OnExecute = DeleteAction1Execute
    end
    object RefreshAction1: TAction
      Caption = #21047#26032
      Enabled = False
      ImageIndex = 16
      OnExecute = RefreshAction1Execute
    end
    object LocateAction1: TAction
      Caption = 'LocateAction1'
      Enabled = False
      ImageIndex = 3
    end
    object DownAction1: TAction
      Caption = #19979#36733
      Enabled = False
      ImageIndex = 15
      Visible = False
      OnExecute = DownAction1Execute
    end
    object CloseAction1: TAction
      Caption = #20851#38381
      Enabled = False
      ImageIndex = 8
      OnExecute = CloseAction1Execute
    end
    object HelpAction1: TAction
      Caption = #24110#21161
      ImageIndex = 5
    end
    object FirstAction1: TAction
      Caption = #39318#24352
      ImageIndex = 25
    end
    object PriorAction1: TAction
      Caption = #19978#19968#24352
      ImageIndex = 22
    end
    object NextAction1: TAction
      Caption = #19979#19968#24352
      ImageIndex = 24
    end
    object LastAction1: TAction
      Caption = #26368#21518#19968#24352
      ImageIndex = 23
    end
    object FaxAction1: TAction
      Caption = #20256#30495
      Enabled = False
      ImageIndex = 1
      Visible = False
      OnExecute = FaxAction1Execute
    end
    object actAftSaveBill: TAction
      Caption = 'After Save Bill'
      OnExecute = actAftSaveBillExecute
    end
    object ActFormalInvoice: TAction
      Caption = #24320#31080
      Hint = 'id 24'
      ImageIndex = 29
      OnExecute = ActFormalInvoiceExecute
    end
    object ActInvAdjfnshldin: TAction
      Caption = #24212#25910
      Hint = #21457#31080#24212#25910#35843#25972
      ImageIndex = 28
      OnExecute = ActInvAdjfnshldinExecute
    end
    object ActInvAdjfnshldout: TAction
      Caption = #24212#20184
      Hint = #21457#31080#24212#20184#35843#25972
      ImageIndex = 35
      OnExecute = ActInvAdjfnshldoutExecute
    end
    object ActFnShldIn: TAction
      Caption = #24212#25910
      ImageIndex = 28
      OnExecute = ActFnShldInExecute
    end
    object ActFnShldOut: TAction
      Caption = #24212#20184
      ImageIndex = 35
      OnExecute = ActFnShldOutExecute
    end
    object ActIsLock: TAction
      Caption = #38145#23450
      ImageIndex = 28
      OnExecute = ActIsLockExecute
    end
  end
  object MainMenu1: TMainMenu
    AutoMerge = True
    Images = dmFrm.ImageList1
    Left = 200
    Top = 208
  end
end
