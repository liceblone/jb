object FrmUpdateProperty: TFrmUpdateProperty
  Left = 254
  Top = 134
  Width = 811
  Height = 635
  Caption = 'FrmUpdateProperty'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GrpLabel: TGroupBox
    Left = -8
    Top = 0
    Width = 265
    Height = 217
    Caption = 'GrpLabel'
    TabOrder = 0
    Visible = False
    object lbl1: TLabel
      Left = 168
      Top = 72
      Width = 73
      Height = 13
      AutoSize = False
      Caption = 'caption'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnMouseDown = lbl1MouseDown
    end
    object btnRemove: TButton
      Left = 112
      Top = 152
      Width = 75
      Height = 25
      Caption = 'btnRemove'
      TabOrder = 0
      OnClick = btnRemoveClick
    end
    object btnUpdate: TButton
      Left = 40
      Top = 152
      Width = 75
      Height = 25
      Caption = 'btnUpdate'
      TabOrder = 1
      OnClick = btnUpdateClick
    end
    object edtCaption: TEdit
      Left = 40
      Top = 72
      Width = 121
      Height = 21
      TabOrder = 2
      Text = 'edtCaption'
      OnChange = edtCaptionChange
    end
  end
  object GrpCTRL: TGroupBox
    Left = 264
    Top = 8
    Width = 521
    Height = 529
    Caption = 'GrpCTRL'
    TabOrder = 1
    Visible = False
    object Label1: TLabel
      Left = 8
      Top = 80
      Width = 37
      Height = 13
      Caption = 'onclick '
    end
    object Label3: TLabel
      Left = 16
      Top = 160
      Width = 31
      Height = 13
      Caption = 'onexit '
    end
    object Label2: TLabel
      Left = 0
      Top = 120
      Width = 49
      Height = 13
      Caption = 'ondbclick '
    end
    object chkreadonly: TCheckBox
      Left = 32
      Top = 280
      Width = 97
      Height = 17
      Caption = 'chkreadonly'
      TabOrder = 0
      OnClick = chkreadonlyClick
    end
    object rg1: TRadioGroup
      Left = 318
      Top = 16
      Width = 169
      Height = 369
      Caption = 'ComponnetType'
      DragCursor = crSizeAll
      DragKind = dkDock
      DragMode = dmAutomatic
      Items.Strings = (
        'TLabel=0  '
        'TFhlDbEdit =1 *'
        'TDBEdit =2'
        'TDBLookupListBox=3'
        'TDBRichEdit=4'
        'TFhlDbLookupComboBox =5*'
        'TDBMemo     =6*'
        'TDBCheckBox=7*'
        'TDBText  =8*'
        'TFhlDbDatePicker =9*'
        'TDBRadioGroup  =10*'
        'TDBListBox =11'
        'TDBComboBox  =12*       '
        'TDBImage =13'
        'TDBFile=14'
        'TdbBarCode=15'
        'TdbQrCode=16')
      TabOrder = 1
      OnClick = rg1Click
    end
    object btnRemoveCtrl: TButton
      Left = 192
      Top = 224
      Width = 75
      Height = 25
      Caption = 'btnRemoveCtrl'
      TabOrder = 2
      OnClick = btnRemoveCtrlClick
    end
    object BtnClearhint: TButton
      Left = 120
      Top = 224
      Width = 75
      Height = 25
      Caption = 'BtnClearhint'
      TabOrder = 3
      OnClick = BtnClearhintClick
    end
    object edtUpdateAction: TButton
      Left = 32
      Top = 224
      Width = 89
      Height = 25
      Caption = 'edtUpdateAction'
      TabOrder = 4
      OnClick = edtUpdateActionClick
    end
    object cmbexit: TComboBox
      Left = 120
      Top = 152
      Width = 185
      Height = 21
      ItemHeight = 13
      TabOrder = 5
      OnClick = cmbexitClick
    end
    object cmbdbclick: TComboBox
      Left = 120
      Top = 112
      Width = 185
      Height = 21
      ItemHeight = 13
      TabOrder = 6
      OnClick = cmbdbclickClick
    end
    object cmbclick: TComboBox
      Left = 120
      Top = 72
      Width = 185
      Height = 21
      ItemHeight = 13
      TabOrder = 7
      OnClick = cmbclickClick
    end
    object Editexit: TEdit
      Left = 48
      Top = 152
      Width = 73
      Height = 21
      TabOrder = 8
      Text = '-1'
    end
    object Editdbclick: TEdit
      Left = 48
      Top = 112
      Width = 73
      Height = 21
      TabOrder = 9
      Text = '-1'
    end
    object Editclick: TEdit
      Left = 48
      Top = 72
      Width = 73
      Height = 21
      TabOrder = 10
      Text = '-1'
    end
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 76
    Top = 272
  end
  object pm1: TPopupMenu
    Left = 44
    Top = 272
    object F1: TMenuItem
      Caption = 'Font'
      OnClick = F1Click
    end
    object B1: TMenuItem
      Caption = 'BackColor'
      OnClick = B1Click
    end
    object P1: TMenuItem
      Caption = 'ParentBackColor'
      OnClick = P1Click
    end
    object a1: TMenuItem
      Caption = #20998#26512#30028#38754#24213#33394
      OnClick = a1Click
    end
  end
  object dlgColor1: TColorDialog
    Left = 108
    Top = 272
  end
end
