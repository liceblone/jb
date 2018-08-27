object emailFrm: TemailFrm
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  Caption = 'Email '#37197#32622#24037#20855
  ClientHeight = 366
  ClientWidth = 401
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 401
    Height = 337
    ActivePage = TabSheet2
    Align = alTop
    TabIndex = 0
    TabOrder = 0
    object TabSheet2: TTabSheet
      Caption = 'E-mail'
      ImageIndex = 1
      object GroupBox2: TGroupBox
        Left = 8
        Top = 8
        Width = 217
        Height = 281
        Caption = 'Email-'#36830#25509#21442#25968
        TabOrder = 0
        object mail_name: TLabeledEdit
          Left = 8
          Top = 40
          Width = 200
          Height = 21
          BevelInner = bvNone
          BevelKind = bkFlat
          BorderStyle = bsNone
          EditLabel.Width = 59
          EditLabel.Height = 13
          EditLabel.Caption = #37038#31665#26631#31614':'
          LabelPosition = lpAbove
          LabelSpacing = 3
          TabOrder = 0
        end
        object mail_host: TLabeledEdit
          Left = 8
          Top = 80
          Width = 200
          Height = 21
          BevelInner = bvNone
          BevelKind = bkFlat
          BorderStyle = bsNone
          EditLabel.Width = 101
          EditLabel.Height = 13
          EditLabel.Caption = 'Email '#20027#26426#22320#22336':'
          LabelPosition = lpAbove
          LabelSpacing = 3
          TabOrder = 1
        end
        object mail_user: TLabeledEdit
          Left = 8
          Top = 120
          Width = 200
          Height = 21
          BevelInner = bvNone
          BevelKind = bkFlat
          BorderStyle = bsNone
          EditLabel.Width = 88
          EditLabel.Height = 13
          EditLabel.Caption = 'Email '#29992#25143#21517':'
          LabelPosition = lpAbove
          LabelSpacing = 3
          TabOrder = 2
        end
        object mail_password: TLabeledEdit
          Left = 8
          Top = 159
          Width = 200
          Height = 21
          BevelInner = bvNone
          BevelKind = bkFlat
          BorderStyle = bsNone
          EditLabel.Width = 127
          EditLabel.Height = 13
          EditLabel.Caption = 'Email '#20027#26426#36830#25509#23494#30721':'
          LabelPosition = lpAbove
          LabelSpacing = 3
          TabOrder = 3
        end
        object mail_port: TLabeledEdit
          Left = 8
          Top = 199
          Width = 200
          Height = 21
          BevelInner = bvNone
          BevelKind = bkFlat
          BorderStyle = bsNone
          EditLabel.Width = 127
          EditLabel.Height = 13
          EditLabel.Caption = 'Email '#20027#26426#36830#25509#31471#21475':'
          LabelPosition = lpAbove
          LabelSpacing = 3
          TabOrder = 4
        end
      end
      object GroupBox5: TGroupBox
        Left = 231
        Top = 174
        Width = 155
        Height = 88
        Caption = #25509#25910
        TabOrder = 1
        object mail_receiver: TLabeledEdit
          Left = 8
          Top = 33
          Width = 121
          Height = 21
          BevelInner = bvNone
          BevelKind = bkFlat
          BorderStyle = bsNone
          EditLabel.Width = 49
          EditLabel.Height = 13
          EditLabel.Caption = 'E-mail:'
          LabelPosition = lpAbove
          LabelSpacing = 3
          TabOrder = 0
        end
        object Button2: TButton
          Left = 6
          Top = 60
          Width = 144
          Height = 21
          Caption = #25163#24037#21457#36865'(&S)'
          TabOrder = 1
        end
      end
      object Button7: TButton
        Left = 237
        Top = 267
        Width = 144
        Height = 21
        Caption = #27979#35797#36830#25509'(&F)'
        TabOrder = 2
        OnClick = Button7Click
      end
    end
  end
  object Button1: TButton
    Left = 256
    Top = 344
    Width = 75
    Height = 21
    Caption = #20851#38381
    TabOrder = 1
  end
  object NMSMTP1: TNMSMTP
    Port = 25
    ReportLevel = 0
    EncodeType = uuMime
    ClearParams = True
    SubType = mtPlain
    Charset = 'us-ascii'
    Left = 280
    Top = 80
  end
end
