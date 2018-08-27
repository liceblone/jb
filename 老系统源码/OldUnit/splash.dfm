object splashFrm: TsplashFrm
  Left = 309
  Top = 201
  BorderStyle = bsNone
  Caption = 'splashFrm'
  ClientHeight = 249
  ClientWidth = 427
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 427
    Height = 249
  end
  object HintLabel1: TLabel
    Left = 7
    Top = 207
    Width = 114
    Height = 12
    Caption = #27491#22312#21019#24314#25968#25454#36830#25509'...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    Transparent = True
    OnDblClick = HintLabel1DblClick
  end
  object CancelLabel1: TLabel
    Left = 345
    Top = 224
    Width = 77
    Height = 13
    Caption = '           '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clSilver
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    Transparent = True
    OnClick = CancelLabel1Click
  end
  object Label1: TLabel
    Left = 3
    Top = 209
    Width = 420
    Height = 13
    Caption = '                                                            '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = [fsUnderline]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object xLabel1: TLabel
    Left = 400
    Top = 232
    Width = 42
    Height = 13
    Caption = '      '
    Transparent = True
    OnDblClick = xLabel1DblClick
  end
  object Label2: TLabel
    Left = 8
    Top = 168
    Width = 93
    Height = 13
    Caption = #21152#36733#32769#31995#32479'....'
  end
  object IdHTTP1: TIdHTTP
    MaxLineAction = maException
    ReadTimeout = 0
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 224
    Top = 16
  end
end
