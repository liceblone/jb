object MailerFrm: TMailerFrm
  Left = 183
  Top = 70
  Width = 582
  Height = 368
  Caption = #21457#36865#30005#23376#37038#20214
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  DesignSize = (
    574
    341)
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 8
    Top = 87
    Width = 42
    Height = 12
    Caption = #27491'  '#25991':'
  end
  object BodyMemo1: TMemo
    Left = 53
    Top = 82
    Width = 514
    Height = 144
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object ListBox1: TListBox
    Left = 52
    Top = 233
    Width = 517
    Height = 79
    Anchors = [akLeft, akRight, akBottom]
    ItemHeight = 12
    TabOrder = 1
  end
  object EdtSubject1: TLabeledEdit
    Left = 53
    Top = 59
    Width = 406
    Height = 20
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 42
    EditLabel.Height = 12
    EditLabel.Caption = #26631'  '#39064':'
    LabelPosition = lpLeft
    TabOrder = 2
    Text = 'jingbei'#37038#20214#27979#35797
  end
  object EdtTo1: TLabeledEdit
    Left = 53
    Top = 35
    Width = 406
    Height = 20
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 42
    EditLabel.Height = 12
    EditLabel.Caption = #25910#20214#20154':'
    LabelPosition = lpLeft
    TabOrder = 3
    Text = 'fangheling@hotmail.com'
  end
  object Button1: TButton
    Left = 1
    Top = 234
    Width = 50
    Height = 21
    Anchors = [akLeft, akBottom]
    Caption = #38468#20214
    TabOrder = 4
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 574
    Height = 26
    AutoSize = True
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 22
        Width = 570
      end>
    object ToolBar1: TToolBar
      Left = 9
      Top = 0
      Width = 557
      Height = 22
      AutoSize = True
      ButtonWidth = 75
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
        AutoSize = True
        Caption = #37038#31665#35774#32622
        ImageIndex = 30
      end
      object ToolButton4: TToolButton
        Left = 79
        Top = 0
        Width = 8
        Caption = 'ToolButton4'
        ImageIndex = 9
        Style = tbsSeparator
      end
      object ToolButton5: TToolButton
        Left = 87
        Top = 0
        AutoSize = True
        Caption = #28155#21152#38468#20214
        ImageIndex = 28
        OnClick = ToolButton5Click
      end
      object DelBtn1: TToolButton
        Left = 166
        Top = 0
        AutoSize = True
        Caption = #21024#38500#38468#20214
        ImageIndex = 11
        OnClick = DelBtn1Click
      end
      object ToolButton7: TToolButton
        Left = 245
        Top = 0
        Width = 8
        Caption = 'ToolButton7'
        ImageIndex = 9
        Style = tbsSeparator
      end
      object ToolButton2: TToolButton
        Left = 253
        Top = 0
        AutoSize = True
        Caption = #21457#36865#37038#20214
        ImageIndex = 36
        OnClick = ToolButton2Click
      end
      object ToolButton3: TToolButton
        Left = 332
        Top = 0
        AutoSize = True
        Caption = #20851#38381#36820#22238
        ImageIndex = 8
        OnClick = ToolButton3Click
      end
    end
  end
  object StatusMemo1: TMemo
    Left = 0
    Top = 323
    Width = 574
    Height = 18
    Align = alBottom
    BevelInner = bvSpace
    BevelKind = bkTile
    BorderStyle = bsNone
    Color = cl3DLight
    Lines.Strings = (
      'StatusMemo1')
    ScrollBars = ssVertical
    TabOrder = 6
  end
  object SMTP: TIdSMTP
    OnStatus = SMTPStatus
    MaxLineAction = maException
    ReadTimeout = 0
    Port = 25
    AuthenticationType = atNone
    Left = 232
    Top = 180
  end
  object MailMessage: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    Recipients = <>
    ReplyTo = <>
    Left = 296
    Top = 184
  end
  object AttachmentDialog: TOpenDialog
    Options = [ofReadOnly, ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 233
    Top = 236
  end
end
